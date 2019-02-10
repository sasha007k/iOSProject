//
//  GetInfoViewController.swift
//  PetrolManager
//
//  Created by Sasha Kryklyvets on 1/31/19.
//  Copyright © 2019 Sasha Kryklyvets. All rights reserved.
//

import UIKit
import CoreData

class GetInfoViewController: UIViewController {
    
    
    @IBOutlet weak var infoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        infoTextView.text = fetchPetrolManager()
    }
    
    func fetchPetrolManager() -> String {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let request = NSFetchRequest<PetrolManagerCoreData>(entityName: "PetrolManagerCoreData")
        request.returnsObjectsAsFaults = false
        let objects = try? context!.fetch(request)
        let obj = objects![(selectedCell?.row)!]
        var str = "Date: "
        str += obj.date!
        str += "\nLitres: "
        str += obj.litres!
        str += "\nPrice: "
        str += obj.price!
        str += "\nKilometrage: "
        str += obj.kilometrage!
        return str
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
