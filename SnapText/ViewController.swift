//
//  ViewController.swift
//  SnapText
//
//  Created by Arshin Jain on 6/27/17.
//  Copyright © 2017 Arshin Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Actions
    @IBAction func pickImage(_ sender: Any) {
        
        // Pick Image
        getImage(source: .photoLibrary)
        
    }
    
    @IBAction func captureImage(_ sender: Any) {
        
        // Capture Image
        getImage(source: .camera)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Disable Camera button if camera not available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Style Text Fields
    }
}

// MARK: Image Picker Controller (Functions)

extension ViewController {
    
    // Select image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Capture Image Selected
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            // Display Image
            imagePickerView.image = image
        }
        
        // Dismiss View after image is displayed
        dismiss(animated: true, completion: nil)
    }
    
    // Cancelled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil) // Dismiss Picker
    }
}


// MARK: Helpers

extension ViewController {
    
    // Pick or Take a Photo
    func getImage(source: UIImagePickerControllerSourceType) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        self.present(pickerController, animated: true, completion: nil)
    }
    
    // Style Text
    func styleText(strokeColor: UIColor, foregroundColor: UIColor, fontAttribute: UIColor,
                   strokeWidth: Float, textFields: [UITextField]) {
        
        // Text Attributes
        let textAttributes:[String:Any] = [
            NSStrokeColorAttributeName: strokeColor,
            NSForegroundColorAttributeName: foregroundColor,
            NSFontAttributeName: fontAttribute,
            NSStrokeWidthAttributeName: strokeWidth]
        
        // Assign attributes to all fields
        for field in textFields {
            field.defaultTextAttributes = textAttributes
        }
    }
    
}













