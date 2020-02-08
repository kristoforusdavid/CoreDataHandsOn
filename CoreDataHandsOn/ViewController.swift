//
//  ViewController.swift
//  CoreDataHandsOn
//
//  Created by Kristoforus David on 07/01/20.
//  Copyright © 2020 Kristoforus David. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var contactData : [Contact]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    @IBAction func addBtn(_ sender: Any) {
        let data = Contact(context: context)
        
        data.name = nameTF.text
        data.phoneNumber = phoneNumberTF.text
        
        contactData?.append(data)
        saveItems()
    }
    
    func saveItems(){
        do {
            try context.save()
            print("sukses")
        } catch {
            print("error", error)
        }
        updateLayout()
    }
    
    func loadItems(){
        let request: NSFetchRequest = Contact.fetchRequest()
        
        do {
            contactData = try context.fetch(request)
        } catch {
            print("error", error)
        }
        
        updateLayout()
    }
    
    func updateLayout(){
        nameLabel.text = contactData?.last?.name
        phoneNumberLabel.text = contactData?.last?.phoneNumber
    }
}

