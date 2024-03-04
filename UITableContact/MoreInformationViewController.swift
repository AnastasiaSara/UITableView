//
//  MoreInformationViewController.swift
//  UITableContact
//
//  Created by Настя Сарамуд on 03.03.2024.
//

import UIKit

class MoreInformationViewController: UIViewController {

    
    @IBOutlet var saveName: UILabel!
    @IBOutlet var saveSurname: UILabel!
    @IBOutlet var saveAge: UILabel!
    @IBOutlet var saveNumber: UILabel!
    @IBOutlet var saveMail: UILabel!
    @IBOutlet var saveWorkOrStudy: UILabel!
    @IBOutlet var saveGender: UILabel!
    
    var delegateTwo: NewContactViewControllerDelegate?
    
    var contact: Contact!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = contact?.fullName
        saveName.text = "Name: \(contact.name)"
        saveSurname.text = "Surname: \(contact.surname)"
        saveNumber.text = "Number: \(contact.number)"
        saveAge.text = "Age: \(contact.age)"
        saveMail.text = "Mail: \(contact.mail)"
        saveWorkOrStudy.text = "Place work or study: \(contact.workOrStudy)"
        saveGender.text = "Gender: \(contact.gender)"
     
    }
}
