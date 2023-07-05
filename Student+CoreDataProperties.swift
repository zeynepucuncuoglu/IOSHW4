//
//  Student+CoreDataProperties.swift
//  ZeynepGoksuUcuncuoglu_HW4
//
//  Created by Zeynep Üçüncüoğlu on 20.12.2022.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var final: Double
    @NSManaged public var midterm: Double
    @NSManaged public var name: String?
    @NSManaged public var surname: String?

}


