//
//  updateRecordVC.swift
//  ZeynepGoksuUcuncuoglu_HW4
//
//  Created by Zeynep Üçüncüoğlu on 23.12.2022.
//

import UIKit

protocol updateRecordControllerDelegate {
    func obtainData(controller: updateRecordVC, data: (name: String, surname: String, midterm: Double, final: Double))
}

class updateRecordVC: UIViewController {
    
    
    var mStudent = Student()
    
    var name = ""
    var surname = ""
    var midterm = ""
    var final = ""
    

    @IBOutlet weak var nameInp: UITextField!
    @IBOutlet weak var surnameInp: UITextField!
    @IBOutlet weak var finalInp: UITextField!
    @IBOutlet weak var midtermInp: UITextField!
    
    var delegate: updateRecordControllerDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func getData() -> (String, String, Double, Double) {
        var name = ""
        var surname = ""
        var midterm = 1.0
        var final = 1.0
        
        name = String(nameInp.text!)
        surname = String(surnameInp.text!)
        midterm = Double(midtermInp.text!)!
        final = Double(finalInp.text!)!
        
        return (name, surname, midterm, final)
    }
    
    func displayAlert (header: String, msg: String) {
        // Creating an Alert and display the result
        let mAlert = UIAlertController(title: header, message: msg, preferredStyle: .alert)
        // Event Handler for the button
        mAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        // Displaying the Alert
        self.present(mAlert, animated: true, completion: nil)
    }
    
    @IBAction func onClick(_ sender: UIBarButtonItem) {
        if nameInp.text!.isEmpty {
            displayAlert(header: "Error", msg: "Name cannot be empty")
        }else if surnameInp.text!.isEmpty {
            displayAlert(header: "Error", msg: "Surname cannot be empty")
        }else if midtermInp.text!.isEmpty{
            displayAlert(header: "Error", msg: "Midterm cannot be empty")
        }else if finalInp.text!.isEmpty{
            displayAlert(header: "Error", msg: "Final cannot be empty")
        }else{
            print("all fields filled")
            delegate?.obtainData(controller: self, data: getData())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameInp.text = name
        surnameInp.text = surname
        midtermInp.text = midterm
        finalInp.text = final
  
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
