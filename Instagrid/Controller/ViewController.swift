//
//  ViewController.swift
//  Instagrid
//
//  Created by rochdi ben abdeljelil on 25.12.2019.
//  Copyright © 2019 rochdi ben abdeljelil. All rights reserved.
//

import UIKit

     

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
              
    let imagePicker = UIImagePickerController()
       var currentButton : UIButton?
       var layoutIsEmpty = true // This Boolean will permit to check wether the grid is empty or not before sharing
    
    
    
   @IBOutlet weak var stackviewUp: UIStackView!
    
    @IBOutlet weak var stackviewBottom: UIStackView!
   
    @IBOutlet weak var centralView: UIView!
    
    @IBOutlet weak var topLeft: UIStackView!
    
    @IBOutlet weak var topRight: UIStackView!
    
    @IBOutlet weak var TopCenter: UIStackView!
    
    @IBOutlet weak var bottomRight: UIStackView!
    
    @IBOutlet weak var BottomCenter: UIStackView!
    
    @IBOutlet weak var bottomLeft: UIStackView!
    
    
    @IBOutlet weak var upView: UIView!
    
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var squareView: UIView!
    
    
   
    @IBOutlet weak var layout1: UIImageView!
    
    
    @IBOutlet weak var layout2: UIImageView!
    
    
    @IBOutlet weak var layout3: UIImageView!
    
    
   

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
     imagePicker.delegate = self
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }

  private var tag: Int?
    
    @IBAction func layout1Button(_ sender: UIButton) {
              self.upView.isHidden = false
              self.downView.isHidden = true
              self.squareView.isHidden = true
              self.topLeft.isHidden = true
              self.TopCenter.isHidden = false
              self.topRight.isHidden = true
              self.BottomCenter.isHidden = true
              self.bottomLeft.isHidden = false
              self.bottomRight.isHidden = false
    }
    
    
    
    @IBAction func layout2Button(_ sender: UIButton) {
              self.upView.isHidden = true
              self.downView.isHidden = false
              self.squareView.isHidden = true
              self.topLeft.isHidden = false
              self.TopCenter.isHidden = true
              self.topRight.isHidden = false
              self.bottomLeft.isHidden = true
              self.BottomCenter.isHidden = false
              self.bottomRight.isHidden = true
    }
    
    
    @IBAction func layout3Button(_ sender: UIButton) {
               self.upView.isHidden = true
               self.downView.isHidden = true
               self.squareView.isHidden = false
               self.topLeft.isHidden = false
               self.TopCenter.isHidden = true
               self.topRight.isHidden = false
               self.bottomLeft.isHidden = false
               self.BottomCenter.isHidden = true
               self.bottomRight.isHidden = false
        }
    
    
    @IBAction func topLeftButton(_ sender: Any) {
        self.currentButton = sender as? UIButton
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func topCenterButton(_ sender: Any) {
        self.currentButton = sender as? UIButton
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func BLeftButton(_ sender: Any) {
        self.currentButton = sender as? UIButton
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
        
    }
   
           // METHOD FOR THE DELEGATE: when the user picks up an image from the photo library, image is set to the button
           func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
               if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.currentButton?.setImage(pickedImage, for: UIControl.State.normal)
                   layoutIsEmpty = false
                   
               }
               dismiss(animated: true, completion: nil)
           }
           // METHOD FOR THE DELEGATE: when the user cancels image picking
           func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
               dismiss(animated: true, completion: nil)
           }
    
          
           
           
}



    


