//
//  SettingsWithUserDefaultsTests.swift
//  TopMoviesTests
//
//  Created by Somkiat Puisungnoen on 28/6/2562 BE.
//

import XCTest
@testable import TopMovies

class SettingsWithUserDefaultsTests: SettingsTests {
    
    func test_save_number_from_UserDefaults() {
        // Arrange
        let vc = settingsViewController()
        let defaults = FakeUserDefaults()
        vc.userDefaults = defaults
        
        // Act = Save
        vc.enterText("2")
        XCTAssertEqual(2, defaults.value(forKey: UserDefaultsKeys.numberOfResults.rawValue) as! Int)
    }
    
    func test_remove_number_from_UserDefaults() {
        // Arrange
        let vc = settingsViewController()
        let defaults = FakeUserDefaults()
        vc.userDefaults = defaults
        
        // Act = Remove
        vc.number.text = ""
        vc.enterText("")
        XCTAssertNil(defaults.value(forKey: UserDefaultsKeys.numberOfResults.rawValue))
    }

    func test_save_and_remove_number_from_UserDefaults() {
        // Arrange
        let vc = settingsViewController()
        let defaults = FakeUserDefaults()
        vc.userDefaults = defaults
        
        // Act = Save
        vc.enterText("2")
        XCTAssertEqual(2, defaults.value(forKey: UserDefaultsKeys.numberOfResults.rawValue) as! Int)
        
        // Act = Remove
        vc.number.text = ""
        vc.enterText("")
        XCTAssertNil(defaults.value(forKey: UserDefaultsKeys.numberOfResults.rawValue))
    }

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
