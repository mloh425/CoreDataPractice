//
//  House+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by Sau Chung Loh on 10/27/16.
//  Copyright © 2016 Matthew Loh. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension House {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<House> {
        return NSFetchRequest<House>(entityName: "House");
    }

    @NSManaged public var location: String?
    @NSManaged public var motto: String?
    @NSManaged public var name: String?
    @NSManaged public var members: NSSet?

}

// MARK: Generated accessors for members
extension House {

    @objc(addMembersObject:)
    @NSManaged public func addToMembers(_ value: Member)

    @objc(removeMembersObject:)
    @NSManaged public func removeFromMembers(_ value: Member)

    @objc(addMembers:)
    @NSManaged public func addToMembers(_ values: NSSet)

    @objc(removeMembers:)
    @NSManaged public func removeFromMembers(_ values: NSSet)

}
