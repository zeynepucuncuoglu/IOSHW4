//
//  Student+CoreDataClass.swift
//  ZeynepGoksuUcuncuoglu_HW4
//
//  Created by Zeynep Üçüncüoğlu on 20.12.2022.
//
//

import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {
    // Static method (class keyword)
    class func createInManagedObjectContext(_ context: NSManagedObjectContext, name: String, surname: String, midterm: NSNumber, final: NSNumber) -> Student {
        let studentObject = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        studentObject.name = name
        studentObject.surname = surname
        studentObject.midterm = Double(truncating: midterm)
        studentObject.final = Double(truncating: final)
        
        return studentObject
    }
}
