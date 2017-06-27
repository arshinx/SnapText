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
    
    // Actions
    @IBAction func pickImage(_ sender: Any) {
        
        // Use Image Picker Controller
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// Image Picker Controller

extension ViewController {
    
    // Cancelled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
}
