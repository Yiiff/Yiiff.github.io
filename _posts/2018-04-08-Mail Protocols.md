---
layout: post
title: Mail Protocols
date: 2018-04-08 12:58:0.000000000 +09:00
---

> About develop mail type App, we have to understand some necessary protocol, like POP3, SMTP and IMAP.

## POP3

POP3 is Post Office Protocol 3 for short. It's the third version of Post Office Protocol(POP). It's an electronic agreement that provisions how to connect to the mail server and download e-mail by using personal internet device. It's the first Offline protocol standard of e-mail.

POP3 allow user to save e-mail from server to local, and delete the mail which was saved on the e-mail server.

POP3 server is a server that follow the POP3 protocol. This server is used to receive mail.

## SMTP

The full name of SMTP is Simple Mail Transfer Protocol. It is a group for sending emails from the source to the destination address of the specification, mail transfer is controlled by it. The SMTP protocol is TCP/IP protocol suite, it helps to each computer on the sending or transit letters to find the next destination. SMTP server is follow the SMTP protocol to send mail server.

SMTP authentication, simply is required to provide the account name and password to login to SMTP server, which makes the spread of spam without an opportunity.

The purpose of SMTP authentication is added to the user to avoid spam.

## IMAP

The full name of IMAP is Internet Mail Access Protocol. It is similar to POP3 email access to one of the standard agreement. Is different, open the IMAP, in your E-mail client charge remains on the server, at the same time on the client's operations will feedback to the server, such as: delete email, tag has been read, mail servers will also do the corresponding action.



## Different between POP3 and IMAP

POP3 can download e-mail from server, but can't synchronous all your behavior on your device. IMAP is Similar to the POP3, and this protocol can synchronous.

| Operating position | Operating content                                  | IMAP                                                | POP3                |
| ------------------ | -------------------------------------------------- | :-------------------------------------------------- | :------------------ |
| Inbox              | Read,Mark,Move,Delete, etc.                        | Synchronization between client-side and server-side | Only in client-side |
| Outbox             | Save to sent                                       | Synchronization between client-side and server-side | Only in client-side |
| Create Folder      | Creat custom folder                                | Synchronization between client-side and server-side | Only in client-side |
| The Draft          | Save draft                                         | Synchronization between client-side and server-side | Only in client-side |
| The Spam Folder    | Receive mistakenly moved into junk mail folders    | Support                                             | Unsupported         |
| Advertising Mail   | Receiving were moved into mail advertising folders | Support                                             | Unsupported         |
