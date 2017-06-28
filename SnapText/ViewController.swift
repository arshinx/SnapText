//
//  ViewController.swift
//  SnapText
//
//  Created by Arshin Jain on 6/27/17.
//  Copyright © 2017 Arshin Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var toolBar: UIToolbar!
    
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
        super.viewWillAppear(animated)
        
        // Disable Camera button if camera not available
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Style Text Fields
        let fontAttribute = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)
        let borderSize: Float = 5
        styleText(strokeColor: UIColor.black, foregroundColor: UIColor.white, fontAttribute: fontAttribute!, strokeWidth: borderSize, textFields: [topTextField, bottomTextField])
        
        // Keyboard Notifications Subscription
        subscribeToKeyboardNotifications(selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow)
        subscribeToKeyboardNotifications(selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide)
        
    }
    
    @IBAction func shareSnap(_ sender: Any) {
        
        let activityViewController = UIActivityViewController(activityItems: [createSnap()],
                                                              applicationActivities: nil)
        self.present(activityViewController, animated: true) { 
            self.saveSnap()
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Keyboard Notifications unsubscribe
        unsubscribeFromKeyboardNotifications(name: .UIKeyboardWillShow)
        unsubscribeFromKeyboardNotifications(name: .UIKeyboardWillHide)
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

// MARK: Notifications
extension ViewController {
    
    // Subscribe
    func subscribeToKeyboardNotifications(selector: Selector, name: NSNotification.Name?) {
        
        NotificationCenter.default.addObserver(self, selector: selector, name: name, object: nil)
    }
    
    // Unsubscribe
    func unsubscribeFromKeyboardNotifications(name: NSNotification.Name?) {
        
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
}

// MARK: Text Field
extension ViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// MARK: Snap
extension ViewController {
    
    func createSnap() -> UIImage {
        
        // Hide toolbar and navbar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let snap:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        return snap
    }
    
    func saveSnap() {
        // Create the snap
        let snap = Snap(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, snap: createSnap())
        print(snap)
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
    func styleText(strokeColor: UIColor, foregroundColor: UIColor, fontAttribute: UIFont,
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
            field.textAlignment = .center
            field.delegate = self
        }
    }
    
    // Keyboard Move Up - Helper
    func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification) // Move View up
    }
    
    // Keyboard Move Up - Helper
    func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0 // Reset View's Vertical Position
    }
    
    // Get Keyboard Height
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}













