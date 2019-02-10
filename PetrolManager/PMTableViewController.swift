//
//  PMTableViewController.swift
//  PetrolManager
//
//  Created by Sasha Kryklyvets on 1/29/19.
//  Copyright © 2019 Sasha Kryklyvets. All rights reserved.
//

import UIKit
import CoreData

var selectedCell: IndexPath?

class PMTableViewController: UITableViewController {

    var list : [PetrolManagerCoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        getPM()
    }
    
    func getPM() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDatePM = try? context.fetch(PetrolManagerCoreData.fetchRequest()) as? [PetrolManagerCoreData] {
                if let thePM = coreDatePM {
                    list =  thePM
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let newList = list[indexPath.row]
//        cell.textLabel?.text = "\(indexPath.row + 1).  " + newList.date!
        cell.textLabel?.text = newList.date

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newList = list[indexPath.row]
        performSegue(withIdentifier: "goToInfo", sender: newList)
        selectedCell = indexPath
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let lst = list[indexPath.row]
        
        context!.delete(lst)
        list.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        do {
            try context?.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
        if let addVC = segue.destination as? SetInfoVC {
            addVC.previousVC = self
        }
    }

}
