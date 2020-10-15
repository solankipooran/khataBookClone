//
//  CoreDataManager.swift
//  KhataBook
//
//  Created by POORAN SUTHAR on 27/04/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static func savedata (dict : [String:Any] , entityName : String){
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newuser = NSManagedObject(entity: entity!, insertInto: context)
        for (key,value) in dict{
            newuser.setValue(value, forKey: key)
        }
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func fetchdata(predicate: NSPredicate? = nil , entityname : String) -> [Any]? {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityname)
        request.predicate = predicate
        do {
            let results = try context.fetch(request)
            return results
        }catch{
            print("error")
        }
        return nil
    }
    
}
