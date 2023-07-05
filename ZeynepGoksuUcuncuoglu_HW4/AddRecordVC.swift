//
//  AddRecordVC.swift
//  ZeynepGoksuUcuncuoglu_HW4
//
//  Created by Zeynep Üçüncüoğlu on 21.12.2022.
//

import UIKit

protocol AddRecordControllerDelegate {
    func obtainData(controller: AddRecordVC, data: (name: String, surname: String, midterm: Double, final: Double))
}

class AddRecordVC: UIViewController {
    
    
    @IBOutlet weak var finalTextField: UITextField!
    @IBOutlet weak var midtermTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: AddRecordControllerDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func getData() -> (String, String, Double, Double) {
        var midterm = 1.0
        var final = 1.0
        var name = "ccc"
        var surname = "dddd"
        
        name = String(nameTextField.text!)
        surname = String(surnameTextField.text!)
        midterm = Double(midtermTextField.text!)!
        final = Double(finalTextField.text!)!
       
        
        return (name, surname, midterm, final)
    }
    
    @IBAction func onClick(_ sender: UIBarButtonItem) {
        
        delegate?.obtainData(controller: self, data: getData())
        
        //print(getData())
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do odany additional setup after loading the view.
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
