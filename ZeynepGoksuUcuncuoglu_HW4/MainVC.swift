//
//  ViewController.swift
//  ZeynepGoksuUcuncuoglu_HW4
//
//  Created by Zeynep Üçüncüoğlu on 20.12.2022.
//

import UIKit
import CoreData

class MainVC: UIViewController,UITableViewDataSource, UITableViewDelegate ,AddRecordControllerDelegate, updateRecordControllerDelegate {
    
    
    func obtainData(controller: AddRecordVC, data: (name: String, surname: String, midterm: Double, final: Double)) {
        controller.navigationController?.popViewController(animated: true)
        
        print(data)
  
        
        saveNewItem(data.name, surname: data.surname, midterm: String(data.midterm), final: String(data.final))
        
        self.mTableview.reloadData()
    }
    
    func obtainData(controller:updateRecordVC, data: (name: String, surname: String, midterm: Double, final: Double)) {
        controller.navigationController?.popViewController(animated: true)
        
        print(data)
        
        updateItem(data.name, surname: data.surname, midterm: String(data.midterm), final: String(data.final))
        
        self.mTableview.reloadData()
    }
    
    @IBOutlet weak var mTableview: UITableView!
    var mStudent = [Student]()
    var mName = ""
    var mSurname = ""
    var mFinal = ""
    var mMidterm = ""
    var indexrow = -1


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            if let vc = segue.destination as? AddRecordVC {
                vc.delegate = self
            }
        }else if segue.identifier == "update"{
            if let vc = segue.destination as? updateRecordVC {
                print("update segue")
                
                vc.name = mName
                vc.surname = mSurname
                vc.midterm = mMidterm
                vc.final = mFinal
                
                vc.delegate = self
            }
        }

    }
    
    // Our function to fetch data from Core Data
    func fetchData() {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "surname", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        do {
            let results = try context.fetch(fetchRequest)
            mStudent = results as! [Student]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func saveNewItem(_ name : String, surname : String, midterm: String, final: String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Create the new Student item
        let newStudentItem = Student.createInManagedObjectContext(context,
                                                                  name: name, surname: surname, midterm: NumberFormatter().number(from: midterm)!, final: NumberFormatter().number(from: final)!)
        
        // Update the array containing the table view row data
        self.fetchData()
        
        // Use Swift's FirstIndex function for Arrays to figure out the index of the newStudentItem
        // after it's been added and sorted in our mStudent array
        if let newStudentIndex = mStudent.firstIndex(of: newStudentItem) {
            // Create an NSIndexPath from the newStudentIndex
            let newStudentItemIndexPath = IndexPath(row: newStudentIndex, section: 0)
            // Animate in the insertion of this row
            mTableview.insertRows(at: [ newStudentItemIndexPath ], with: .automatic)
            
            save()
        }
    }
    
    func updateItem(_ name : String, surname : String, midterm: String, final: String) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        // Create a sort descriptor object that sorts on the "surname"
        // property of the Core Data object
        let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "surname", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        request.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
       
        do {
            let results =
                try context.fetch(request)
            
            let objectUpdate = results[indexrow] as! NSManagedObject
            objectUpdate.setValue("\(name)", forKey: "name")
            objectUpdate.setValue("\(surname)", forKey: "surname")
            objectUpdate.setValue(Double(midterm), forKey: "midterm")
            objectUpdate.setValue(Double(final), forKey: "final")
        }
        catch let error as NSError {
            print(error)
        }
        
        
        // Update the array containing the table view row data
        self.fetchData()
        
        save()
    }
    
    // Method to save the Data in Core Data
    func save() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mStudent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Recommended way
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        // Get the Student for this index
        let student = mStudent[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.row)"
        cell.textLabel?.text = student.name! + " " + student.surname!
        cell.detailTextLabel?.text = "\(indexPath.row)"
        cell.detailTextLabel?.text = "Midterm: " + String(student.midterm) + " Final: " + String(student.final)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
      
        // Create a sort descriptor object that sorts on the "surname"
        // property of the Core Data object
        let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "surname", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        
        do {
            let fetchResults = try context.fetch(fetchRequest)
            mStudent = fetchResults as! [Student]
            
            indexrow = indexPath.row
            mName = mStudent[indexPath.row].name!
            mSurname = mStudent[indexPath.row].surname!
            mMidterm = String(mStudent[indexPath.row].midterm)
            mFinal = String(mStudent[indexPath.row].final)
            
            performSegue(withIdentifier: "update", sender: mTableview)
            // Create an Alert, and set it's message to whatever the itemText i
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if(editingStyle == .delete ) {
            // Find the Student object the user is trying to delete
            let studentToDelete = mStudent[indexPath.row]
            
            // Delete it from the managedObjectContext
            context.delete(studentToDelete)
            
            // Delete it from mStudent Array
            mStudent.remove(at: indexPath.row)
            
            // Tell the table view to animate out that row
            mTableview.deleteRows(at: [indexPath], with: .automatic)
            
            save()
        }
    }
  
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         self.fetchData()
    }


}

