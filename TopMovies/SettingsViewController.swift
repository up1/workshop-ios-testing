import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var label: UILabel!
    @IBOutlet var number: UITextField!
    @IBOutlet var error: UILabel!

    var userDefaults = UserDefaults.standard

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let limit = userDefaults.value(forKey: UserDefaultsKeys.numberOfResults.rawValue) as? Int {
            let text = String(describing: limit)
            number.text = text
        } else {
            number.text = nil
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text!
        let swiftRange = Range(range, in: text)!
        let newString = text.replacingCharacters(in: swiftRange, with: string)

        if newString == "" {
            userDefaults.setValue(nil, forKey: UserDefaultsKeys.numberOfResults.rawValue)
            error.isHidden = true
            return true
        }

        guard let value = Int(newString),
            value >= 2,
            value <= 200 else {
                error.isHidden = false
                return true
        }

        userDefaults.setValue(value, forKey: UserDefaultsKeys.numberOfResults.rawValue)
        error.isHidden = true
        return true
    }
}
