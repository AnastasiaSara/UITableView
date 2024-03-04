//
//  ContactListTableViewController.swift
//  UITableContact
//
//  Created by Настя Сарамуд on 03.03.2024.
//

import UIKit


protocol NewContactViewControllerDelegate {
    func saveContact( _ contact: Contact)
}

class ContactListTableViewController: UITableViewController {
    
    private var contactList = Contact.getContact()
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contact", for: indexPath)
        let contact = contactList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = contact.name
        content.secondaryText = contact.age
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let newContactVC = segue.destination as? NewContactViewController {
            newContactVC.delegate = self
        } else if let infoVC = segue.destination as? MoreInformationViewController {
            infoVC.contact = sender as? Contact
        }
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactList[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: contact)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let currentContact = contactList.remove(at: sourceIndexPath.row)
        contactList.insert(currentContact, at: destinationIndexPath.row)
    }
    
}
// MARK: - NewPersonViewControllerDelegate

extension ContactListTableViewController: NewContactViewControllerDelegate {
    func saveContact(_ contact: Contact) {
        contactList.append(contact)
        tableView.reloadData()
    }
    
}

