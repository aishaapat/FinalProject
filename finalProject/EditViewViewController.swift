//
//  EditViewViewController.swift
//  finalProject
//
//  Created by Alex Bringuel on 4/28/25.
//

import UIKit

class EditViewViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var viewEditSwitch: UISegmentedControl!
    
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    
    
    @IBAction func changeEditMode(_ sender: UISegmentedControl) {
        let textFields: [UITextField] = [nameField, latitudeField, longitudeField]
        
        let buttons: [UIButton] = [
            selectButton,
            takePhotoButton
        ]
        
        if viewEditSwitch.selectedSegmentIndex == 1 {
            for textField in textFields {
                textField.isEnabled = false
                textField.borderStyle = UITextField.BorderStyle.none
            }
            for button in buttons {
                button.isHidden = true
                button.isEnabled = false
            }
        } else if viewEditSwitch.selectedSegmentIndex == 0 {
            for textField in textFields {
                textField.isEnabled = true
                textField.borderStyle = UITextField.BorderStyle.roundedRect
            }
            for button in buttons {
                button.isHidden = false
                button.isEnabled = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
