//
//  JournalingVC.swift
//  Journaling
//
//  Created by Lisa Sam Wang on 10/23/21.
//

import UIKit
import CoreData

class JournalDetailVC: UIViewController
{
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
        var selectedJournal: Journal? = nil
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            if(selectedJournal != nil)
            {
                titleTF.text = selectedJournal?.title
                descTV.text = selectedJournal?.desc
            }
        }
    @IBAction func saveAction(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedJournal == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Journal", in: context)
            let newJournal = Journal(entity: entity!, insertInto: context)
            newJournal.id = journalList.count as NSNumber
            newJournal.title = titleTF.text
            newJournal.desc = descTV.text
            do
            {
                try context.save()
                journalList.append(newJournal)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
        }
        else //edit
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let journal = result as! Journal
                    if(journal == selectedJournal)
                    {
                        journal.title = titleTF.text
                        journal.desc = descTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    

    @IBAction func DeleteJournal(_ sender: Any) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let journal = result as! Journal
                    if(journal == selectedJournal)
                    {
                        journal.deletedDate = Date()
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
}
