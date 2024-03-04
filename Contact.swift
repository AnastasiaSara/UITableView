////
////  Contact.swift
////  UITableContact
////
////  Created by Настя Сарамуд on 03.03.2024.
////
import Foundation

struct Contact {
    let name: String
    let surname: String
    let age: String
    let number: String
    let mail: String
    let workOrStudy: String
    let gender: String
    
    var fullName: String {
        "\(name) \(surname)"
    }
    static func getContact() -> [Contact] {
        [
            Contact(name: "Nastya", surname: "Saramud", age: "21", number: "+8 (999) 99-99-99", 
                    mail: "hsuiduj@mail.ru", workOrStudy: "LETI", gender: "female")
        ]
    }
}
