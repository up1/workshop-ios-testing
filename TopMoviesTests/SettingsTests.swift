import XCTest
@testable import TopMovies

class SettingsTests: XCTestCase {
    func settingsViewController() -> SettingsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        _ = vc.view
        return vc
    }
    
    func test_title_is_Settings() {
        let vc = settingsViewController()
        XCTAssertEqual(vc.navigationItem.title, "Settings")
    }
    
    func test_label_text_is_Number_of_results_to_display() {
        let vc = settingsViewController()
        XCTAssertEqual(vc.label.text!, "Number of results to display")
    }
    
    func test_number_placeholder_is_50() {
        let vc = settingsViewController()
        XCTAssertEqual(vc.number.placeholder!, "50")
    }
    
    func test_error_text_is_Please_enter_a_number_between_2_and_200() {
        let vc = settingsViewController()
        XCTAssertEqual(vc.error.text!,
                       "Please enter a number between 2 and 200")
    }
    
    func test_number_allows_2() {
        let vc = settingsViewController()
        let _ = vc.textField(vc.number,
            shouldChangeCharactersIn: NSRange(location: 0, length: 0),
            replacementString: "2")
        XCTAssertTrue(vc.error.isHidden)
    }
    
    func test_number_allows_200() {
        let vc = settingsViewController()
        let _ = vc.textField(vc.number,
            shouldChangeCharactersIn: NSRange(location: 0, length: 0),
            replacementString: "200")
        XCTAssertTrue(vc.error.isHidden)
    }
    
    func test_number_does_not_allow_1() {
        let vc = settingsViewController()
        vc.enterText("1")
        XCTAssertFalse(vc.error.isHidden)
    }
    
    func test_number_does_not_allow_201() {
        let vc = settingsViewController()
        vc.enterText("201")
        XCTAssertFalse(vc.error.isHidden)
    }
    
    func test_number_does_not_allow_z2() {
        let vc = settingsViewController()
        vc.enterText("z2")
        XCTAssertFalse(vc.error.isHidden)
    }
    
}

extension SettingsViewController {
    func enterText(_ text: String) {
        _ = textField(number, shouldChangeCharactersIn: NSRange(location: number.text!.count, length: 0), replacementString: text)
    }
}
