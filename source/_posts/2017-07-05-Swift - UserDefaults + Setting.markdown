---
layout: post
title: Swift - UserDefaults + Setting
date: 2017-07-05 15:15:18.000000000 +09:00
---

> 项目中有很多需要设定的地方, 是否开启通知或者自动登录一类, 对此类的值一般会写入UserDefault中, 下面则是对UserDefault和设置的一点封装

取经自`Apple ARKitExample`:

```
import UIKit

// 一些设置的枚举 和 默认值
enum Setting: String {
    // Bool settings with SettingsViewController switches
    case debugMode
    case scaleWithPinchGesture
    case ambientLightEstimation
    case dragOnInfinitePlanes
    case showHitTestAPI
    case use3DOFTracking
    case use3DOFFallback
	case useOcclusionPlanes

    // Integer state used in virtual object picker
    case selectedObjectID

    static func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            Setting.ambientLightEstimation.rawValue: true,
            Setting.dragOnInfinitePlanes.rawValue: true,
            Setting.selectedObjectID.rawValue: -1
        ])
    }
}

extension UserDefaults {
    // 获取 bool 值
    func bool(for setting: Setting) -> Bool {
        return bool(forKey: setting.rawValue)
    }
    
    // 设置 bool 值
    func set(_ bool: Bool, for setting: Setting) {
        set(bool, forKey: setting.rawValue)
    }
    
    func integer(for setting: Setting) -> Int {
        return integer(forKey: setting.rawValue)
    }
    
    func set(_ integer: Int, for setting: Setting) {
        set(integer, forKey: setting.rawValue)
    }
}

class SettingsViewController: UITableViewController {
	
	@IBOutlet weak var debugModeSwitch: UISwitch!
	@IBOutlet weak var scaleWithPinchGestureSwitch: UISwitch!
	@IBOutlet weak var ambientLightEstimateSwitch: UISwitch!
	@IBOutlet weak var dragOnInfinitePlanesSwitch: UISwitch!
	@IBOutlet weak var showHitTestAPISwitch: UISwitch!
	@IBOutlet weak var use3DOFTrackingSwitch: UISwitch!
	@IBOutlet weak var useAuto3DOFFallbackSwitch: UISwitch!
	@IBOutlet weak var useOcclusionPlanesSwitch: UISwitch!
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateSettings()
    }

	@IBAction func didChangeSetting(_ sender: UISwitch) {
		let defaults = UserDefaults.standard
		switch sender {
            case debugModeSwitch:
                defaults.set(sender.isOn, for: .debugMode)
            case scaleWithPinchGestureSwitch:
                defaults.set(sender.isOn, for: .scaleWithPinchGesture)
            case ambientLightEstimateSwitch:
                defaults.set(sender.isOn, for: .ambientLightEstimation)
            case dragOnInfinitePlanesSwitch:
                defaults.set(sender.isOn, for: .dragOnInfinitePlanes)
            case showHitTestAPISwitch:
                defaults.set(sender.isOn, for: .showHitTestAPI)
            case use3DOFTrackingSwitch:
                defaults.set(sender.isOn, for: .use3DOFTracking)
            case useAuto3DOFFallbackSwitch:
                defaults.set(sender.isOn, for: .use3DOFFallback)
			case useOcclusionPlanesSwitch:
				defaults.set(sender.isOn, for: .useOcclusionPlanes)
            default: break
		}
	}
	
	private func populateSettings() {
		let defaults = UserDefaults.standard

		debugModeSwitch.isOn = defaults.bool(for: Setting.debugMode)
		scaleWithPinchGestureSwitch.isOn = defaults.bool(for: .scaleWithPinchGesture)
		ambientLightEstimateSwitch.isOn = defaults.bool(for: .ambientLightEstimation)
		dragOnInfinitePlanesSwitch.isOn = defaults.bool(for: .dragOnInfinitePlanes)
		showHitTestAPISwitch.isOn = defaults.bool(for: .showHitTestAPI)
		use3DOFTrackingSwitch.isOn = defaults.bool(for: .use3DOFTracking)
		useAuto3DOFFallbackSwitch.isOn = defaults.bool(for: .use3DOFFallback)
		useOcclusionPlanesSwitch.isOn = defaults.bool(for: .useOcclusionPlanes)
	}
}
```


