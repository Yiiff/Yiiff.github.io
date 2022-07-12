---
layout: post
title: iOS CoreData - Remove duplicate entity before insert it
date: 2018-04-13 11:52:0.000000000 +09:00
---

> Here is the situation, When I fetched mails from server, I do insert command. But that cause duplicate in my folders. So that should be fixed otherwise there are lots of duplicate mail in my INBOX.

## Duplicate data base on CoreData

When receiving new data, I just do *insertNewObjectForEntityForName* function, Here is a wrong code:

```
- (NSManagedObject *)createManagedObjectOfClass:(Class)clazz{
    if(![clazz isSubclassOfClass:NSManagedObject.self]){
        return nil;
    }
    
    NSString *className = NSStringFromClass(clazz);
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:self.context];
    
    return object;
}

// ...

- (CYMail *)createMailWithMessage:(MCOIMAPMessage *)message folder:(CYFolder *)folder{
	CYMail *mail = (CYMail *)[self createManagedObjectOfClass:CYMail.self];
	// ...
}
```



And that is the reason why I always get duplicate data. So I fixed it:

```
- (CYMail *)createMailWithMessage:(MCOIMAPMessage *)message folder:(CYFolder *)folder{
	CYMail *mail;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CYMail"];
    request.predicate = [NSPredicate predicateWithFormat:@"uid = %@", @(message.uid)];
    
    NSError *error;
    NSArray *matches = [self.context executeFetchRequest:request error:&error];
    if (!matches || [matches count] > 1) {
        NSLog(@"Multiple copies of unique item detected in the document");
    } else if (![matches count]){
        mail = (CYMail *)[self createManagedObjectOfClass:CYMail.self];
        // ...
    } else {
        mail = [matches lastObject];
    }
    return mail;
}
```





