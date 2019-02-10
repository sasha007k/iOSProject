//
//  SetInfoVC.swift
//  PetrolManager
//
//  Created by Sasha Kryklyvets on 1/29/19.
//  Copyright © 2019 Sasha Kryklyvets. All rights reserved.
//

import UIKit
import Foundation

class SetInfoVC: UIViewController {
    
    var previousVC = PMTableViewController()
    
    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var litresTextField: UITextField!
    
    @IBOutlet weak var fullPriceTextfield: UITextField!
    
    @IBOutlet weak var kilometregeTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonAction(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newOne = PetrolManagerCoreData(entity: PetrolManagerCoreData.entity(),
                                               insertInto: context)
            newOne.date = dateTextField.text!
            newOne.litres = litresTextField.text!
            newOne.price = fullPriceTextfield.text!
            newOne.kilometrage = kilometregeTextField.text!
            try? context.save()
            navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        addButton.isEnabled = false
        dateTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        litresTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        fullPriceTextfield.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        kilometregeTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text!.count == 1 {
            if textField.text!.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let date = dateTextField.text, !date.isEmpty,
            let litres = litresTextField.text, !litres.isEmpty,
            let price = fullPriceTextfield.text, !price.isEmpty,
            let kilom = kilometregeTextField.text, !kilom.isEmpty
            else {
                addButton.isEnabled = false
                return
        }
        addButton.isEnabled = true
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//            let newOne = PetrolManagerCoreData(entity: PetrolManagerCoreData.entity(),
//                                               insertInto: context)
//            newOne.date = dateTextField.text!
//            newOne.litres = litresTextField.text!
//            newOne.price = fullPriceTextfield.text!
//            newOne.kilometrage = kilometregeTextField.text!
//            try? context.save()
//            navigationController?.popViewController(animated: true)
//        }
    }
    
//    @IBAction func addButton(_ sender: UIButton) {
//        let newOne = PetrolManager()
//        newOne.date = dateTextField.text!
//        newOne.litres = litresTextField.text!
//        newOne.price = fullPriceTextfield.text!
//        newOne.kilometrage = kilometregeTextField.text!
//        previousVC.list.append(newOne)
//        previousVC.tableView.reloadData()
//
//        navigationController?.popViewController(animated: true)
        
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//            let newOne = PetrolManagerCoreData(entity: PetrolManagerCoreData.entity(),
//                                               insertInto: context)
//            newOne.date = dateTextField.text!
//            newOne.litres = litresTextField.text!
//            newOne.price = fullPriceTextfield.text!
//            newOne.kilometrage = kilometregeTextField.text!
//            try? context.save()
//            navigationController?.popViewController(animated: true)
//        }
        
        
//    }
    
    
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
