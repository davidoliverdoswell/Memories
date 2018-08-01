//
//  MemoryDetailViewController.swift
//  Memories
//
//  Created by David Oliver Doswell on 8/1/18.
//  Copyright © 2018 David Oliver Doswell. All rights reserved.
//

import UIKit
import Photos

private let addMemory = "Add Memory"
private let editMemory = "Edit Memory"

private let alertTitle = "Oh, no! ☹️"
private let alertMessage = "You need authorize Memories to access your photos to create a cool memory. You may update this permission in your settings."
private let actionTitle = "Okay"

class MemoryDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memory : Memory?
    var memoryController = MemoryController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func addPhotoButton(_ sender: Any) {
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        if authorizationStatus == .authorized {
            presentImagePickerController()
        } else if authorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if authorizationStatus == .authorized {
                    self.presentImagePickerController()
                } else if authorizationStatus == .denied {
                     let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action) in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func savePhotoButton(_ sender: Any) {
        memoryController.saveToPersistentStore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews() {
        guard let memory = memory else {
            self.title = addMemory
            return
        }
        self.title = editMemory
        textField.text = memory.title
        textView.text = memory.bodyText
        imageView.image = UIImage(data: memory.imageData)
    }
    
    func presentImagePickerController() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            present(picker, animated: true, completion: nil)
        } else {
            return
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
