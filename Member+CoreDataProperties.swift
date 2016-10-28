//
//  Member+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by Sau Chung Loh on 10/27/16.
//  Copyright © 2016 Matthew Loh. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member");
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var house: House?

}
