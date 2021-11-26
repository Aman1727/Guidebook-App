//
//  Note+CoreDataProperties.swift
//  Guidebook App
//
//  Created by Aman on 27/11/21.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var place: Place?

}

extension Note : Identifiable {

}
