//
//  NewContactViewController.swift
//  UITableContact
//
//  Created by Настя Сарамуд on 03.03.2024.
//

import UIKit

class NewContactViewController: UIViewController {
    

    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var genderControl: UISegmentedControl!
    @IBOutlet var workOrStudyTextField: UITextField!
    
    var delegate: NewContactViewControllerDelegate!
    
    var gender: String = ""
    
    
    private let maxNumberCount = 11
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.delegate = self
        
        numberTextField.keyboardType = .numberPad
        ageTextField.keyboardType = .numberPad
        mailTextField.keyboardType = .emailAddress
    
    }
    
    
    // MARK: - Format Phone Number
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard let regex = try? makeRegularExpression() else {
            return ""
        }
        
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        
        return  "+\(number)"
    }
    
    
    private func makeRegularExpression() throws -> NSRegularExpression {
        try NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    }
    
    
    
    // MARK: - Button Pressed
    @IBAction func doneButtonPressed() {
        
        saveAndExit()
    }
    
    
    private func saveAndExit() {
        
        let contact = Contact(name: nameTextField.text ?? "", surname: surnameTextField.text ?? "",age: ageTextField.text ?? "", number: numberTextField.text ?? "" , mail: mailTextField.text ?? "", workOrStudy: workOrStudyTextField.text ?? "", gender: gender)
        
        
        if nameTextField.text == "" || ageTextField.text == "" || numberTextField.text == "" {
            showAlert(with: "The main fields are filled", and: "Enter the data")
        } else {
            delegate.saveContact(contact)
            dismiss(animated: true)
        }
        
        
        if nameTextField.text == "" {
            nameTextField.backgroundColor = .red.withAlphaComponent(0.1)
        } else {
            nameTextField.backgroundColor = .clear
        }
        
        
        if ageTextField.text == "" {
            ageTextField.backgroundColor = .red.withAlphaComponent(0.1)
        } else {
            ageTextField.backgroundColor = .clear
        }
        
        
        if numberTextField.text == "" {
            numberTextField.backgroundColor = .red.withAlphaComponent(0.1)
        } else {
            numberTextField.backgroundColor = .clear
        }
        
    }
    
    
    @IBAction func genderAction(_ sender: Any) {
        switch genderControl.selectedSegmentIndex{
        case 0:
            gender = "famele"
        default:
            gender = "male"
            
        }
    }
}



// MARK: - UITextFieldDelegate
extension NewContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
    
}



// MARK: - Show Alert
extension NewContactViewController {
    private func showAlert(with title: String, and message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
