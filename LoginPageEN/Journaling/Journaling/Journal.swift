//
//  Journal.swift
//  Journaling
//
//  Created by Lisa Sam Wang on 10/23/21.
//

import CoreData

@objc(Journal)
class Journal: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
