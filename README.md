# Workshop :: Automated testing for iOS app with Swift
* Unit testing
* UI testing
* Fastlane

## Code for Testing in Settings page

SettingsTests.swift
```
class SettingsTests: XCTestCase {
    func settingsViewController() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        _ = vc.view
        return vc
    }
    
    // Your test cases
     
}

extension SettingsViewController {
    func enterText(_ text: String) {
        _ = textField(number, shouldChangeCharactersIn: NSRange(location: number.text!.count, length: 0), replacementString: text)
    }
}
```

SettingsWithUserDefaultsTests
```
class SettingsWithUserDefaultsTests: SettingsTests {
    // Your test cases
}


class FakeUserDefaults: UserDefaults {
    var store = [String: Any?]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        store[key] = value
    }
    
    override func value(forKey key: String) -> Any? {
        if let value = store[key] {
            return value
        }
        return nil
    }
}
```

## Code for Testing in Top moview page
