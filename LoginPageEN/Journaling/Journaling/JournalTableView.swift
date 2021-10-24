//
//  JournalTableView.swift
//  Journaling
//
//  Created by Lisa Sam Wang on 10/23/21.
//

import UIKit
import CoreData

var journalList = [Journal]()

class JournalTableView: UITableViewController
{
    var firstLoad = true
    
    func nonDeletedJournals() -> [Journal]
    {
        var noDeleteJournalList = [Journal]()
        for journal in journalList
        {
            if(journal.deletedDate == nil)
            {
                noDeleteJournalList.append(journal)
            }
        }
        return noDeleteJournalList
    }
    
    override func viewDidLoad()
    {
        if(firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let journal = result as! Journal
                    journalList.append(journal)
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let journalCell = tableView.dequeueReusableCell(withIdentifier: "journalCellID", for: indexPath) as! JournalCell
        
        let thisJournal: Journal!
        thisJournal = nonDeletedJournals()[indexPath.row]
        
        journalCell.titleLabel.text = thisJournal.title
        journalCell.descLabel.text = thisJournal.desc
        
        return journalCell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nonDeletedJournals().count
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: "editJournal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "editJournal")
        {
            if let indexPath = tableView.indexPathForSelectedRow {
                let journalDetail = segue.destination as? JournalDetailVC
                
                let selectedJournal : Journal!
                selectedJournal = nonDeletedJournals()[indexPath.row]
                journalDetail!.selectedJournal = selectedJournal
                
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    
}
