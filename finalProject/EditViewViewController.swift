//
//  EditViewViewController.swift
//  finalProject
//
//  Created by Alex Bringuel on 4/28/25.
//

import UIKit
import CoreData

class EditViewViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var currentAddress : Address?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var viewEditSwitch: UISegmentedControl!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBAction func buttonSave(_ sender: Any)
    {
        appDelegate.saveContext()
        viewEditSwitch.selectedSegmentIndex = 1
        changeEditMode(viewEditSwitch)
    }
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    
    
    @IBAction func openCameraRoll(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func openCamera(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
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
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if currentAddress == nil {
            let context = appDelegate.persistentContainer.viewContext
            currentAddress = Address(context: context)
        }
        
        switch textField {
        case nameField:
            currentAddress?.name = textField.text
        case latitudeField:
            currentAddress?.latitude = textField.text
        case longitudeField:
            currentAddress?.longititude = textField.text
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFields: [UITextField] = [nameField, longitudeField, latitudeField]
        for textfield in textFields {
            textfield.addTarget(self, action: #selector(self.textFieldDidEndEditing(_:)), for: .editingDidEnd)
        }

        if currentAddress != nil {
            nameField.text = currentAddress!.name
            latitudeField.text = currentAddress!.latitude
            longitudeField.text = currentAddress!.longititude
            if let imageDataStored = currentAddress?.image {
                imageData.image = UIImage(data: imageDataStored)
            }
        }

        changeEditMode(viewEditSwitch)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageData.contentMode = .scaleAspectFit
            if currentAddress == nil {
                let context = appDelegate.persistentContainer.viewContext
                currentAddress = Address(context: context)
            }
            currentAddress?.image = image.jpegData(compressionQuality: 0.8)
            imageData.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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

