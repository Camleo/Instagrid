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
    var viewIsEmpty = true // This Boolean will permit to check wether the grid is empty or not before sharing
    
    
    
    
    
   //MARK: - Outlet
    
    
    @IBOutlet weak var swipeImageView: UIImageView!
    
    @IBOutlet weak var stackviewUp: UIStackView!
    
    @IBOutlet weak var stackviewBottom: UIStackView!
    
    
    @IBOutlet weak var mainView: UIStackView!
    
    
    @IBOutlet weak var TLeft: UIView!
    
    
    @IBOutlet weak var TRight: UIView!
    
    
    @IBOutlet weak var BLeft: UIView!
    
    @IBOutlet weak var upView: UIView!
    
    @IBOutlet weak var downView: UIView!
    
    @IBOutlet weak var squareView: UIView!
    
    @IBOutlet weak var BRight: UIView!
    
    
    @IBOutlet weak var layout1: UIImageView!
    
    
    @IBOutlet weak var layout2: UIImageView!
    
    
    @IBOutlet weak var layout3: UIImageView!
    
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    
    
    //MARK: - ViewDidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(holdSwipe(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        mainView.addGestureRecognizer(swipeUp)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(holdSwipe(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        mainView.addGestureRecognizer(swipeLeft)
        
    }
    
    
    
    //MARK: - Action , Button and Swipe
    
    
    @IBAction func holdSwipe(_ sender: UISwipeGestureRecognizer?) {
        if let gesture = sender {
            if UIDevice.current.orientation.isPortrait && gesture.direction == .up {
                moveMainViewUp()
            } else if UIDevice.current.orientation.isLandscape && gesture.direction == .left {
                moveMainViewLeft()
            }
        }
    }
    
    
    
    
    @IBAction func layout1Button(_ sender: UIButton) {
        self.upView.isHidden = false
        self.downView.isHidden = true
        self.squareView.isHidden = true
        self.TLeft.isHidden = true
        self.TRight.isHidden = false
        self.BLeft.isHidden = false
        self.BRight.isHidden = false
        
    }
    
    @IBAction func layout2Button(_ sender: Any) {
        self.upView.isHidden = true
        self.downView.isHidden = false
        self.squareView.isHidden = true
        self.TLeft.isHidden = false
        self.TRight.isHidden = false
        self.BLeft.isHidden = true
        self.BRight.isHidden = false
        
    }
    
    
    @IBAction func layout3Button(_ sender: UIButton) {
        self.upView.isHidden = true
        self.downView.isHidden = true
        self.squareView.isHidden = false
        self.TLeft.isHidden = false
        self.TRight.isHidden = false
        self.BLeft.isHidden = false
        self.BRight.isHidden = false
        
    }
    
    
    
    
    
    @IBAction func didTapeButton(_ sender: Any) {
        self.currentButton = sender as? UIButton
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
  //MARK: - Animation text

    
    @objc func orientationChanged() {
        if UIDevice.current.orientation.isLandscape {
            
            swipeLabel.text = "Swipe Left to share"
            swipeImageView.image = UIImage(named: "ArrowLeft")
        } else {
            
            swipeLabel.text = "Swipe Up to share"
            swipeImageView.image = UIImage(named: "ArrowUp")
        }
    }
    
    
    
    //MARK: - ImagePicker
    
    
    // METHOD FOR THE DELEGATE: when the user picks up an image from the photo library, image is set to the button
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.currentButton?.setImage(pickedImage, for: UIControl.State.normal)
            viewIsEmpty = false
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // METHOD FOR THE DELEGATE: when the user cancels image picking
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Animation View
    
    
    func moveMainViewUp() {
        UIView.animate(withDuration: 2, animations: {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        }, completion: {
            (true) in
            self.checkMainView()
        })
    }
    
    
    
    func moveMainViewLeft() {
        UIView.animate(withDuration: 2, animations: {
            self.mainView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }, completion: {
            (true) in
            self.checkMainView()
        })
    }
    
    
    //MARK: - MainView Action
    
    
    func checkMainView() {
        let alert = UIAlertController(title: "Empty View", message: "Are you sure you want to share an empty view ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.shareMainView() } ))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            self.mainView.transform = .identity
        }))
        if viewIsEmpty == true {
            self.present(alert, animated: true)
        } else {
            shareMainView()
        }
    }
    
    
    
    func shareMainView() {
        let content = mainView.asImage()
        let activityController = UIActivityViewController(activityItems: [content], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        // We use the completion handler to move back the mainView when the activityController is closed
        activityController.completionWithItemsHandler = {  (activity, success, items, error) in
            UIView.animate(withDuration: 1, animations: {
                self.mainView.transform = .identity
            }, completion: nil)
        }
    }
    
}


//MARK: - Convert MainView


// This UIView extension will permit to convert our MainView to an image file

extension UIView {
    


    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
                let image = renderer.image { ctx in
                    self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
                }
                return image
            }
        }
        


