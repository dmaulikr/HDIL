//
//  HomeVC.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/26/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
  @IBOutlet var HDILButton: UIButton!
  @IBOutlet var refreshButton: UIBarButtonItem!
  @IBOutlet var imageView: UIImageView!
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var chooseImageButton: UIButton!
  var imagePicker : UIImagePickerController!
  
  override func viewDidLoad() {
    self.refreshButton.enabled = false
    self.refreshButton.tintColor = UIColor.clearColor()
    self.activityIndicator.hidesWhenStopped = true
    self.activityIndicator.hidden = true
  }
  
 
  @IBAction func ChoosePicture(sender: UIButton) {
    
    self.imagePicker = UIImagePickerController()
    self.imagePicker.delegate = self
    self.imagePicker.sourceType = .SavedPhotosAlbum
    
    self.presentViewController(self.imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func onHDILPressed(sender: UIButton) {
  self.imagePicker = UIImagePickerController()
  self.imagePicker.delegate = self
  self.imagePicker.sourceType = .Camera
  self.imagePicker.cameraDevice = .Front
    
  self.presentViewController(self.imagePicker, animated: true, completion: nil)
    
  }
  
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    self.activityIndicator.hidden = false
    self.activityIndicator.startAnimating()
    picker.dismissViewControllerAnimated(true, completion: nil)
    imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    let data = UIImageJPEGRepresentation((info[UIImagePickerControllerOriginalImage] as? UIImage)!, 0.8)
    DataService.returnImageAnalysisDataUsingData(data) { (result) in
      if result == "male" {
        self.presentPictureReslts("You need a shave", resultDescription: "Make sure to shave before heading out")
      } else if result == "female" {
        self.presentPictureReslts("Let's add some mascara", resultDescription: "Make sure to put on some mascara before heading out")
      } else if result == "Too many faces" {
        self.presentPictureReslts("You guys look awesome!", resultDescription: "Now take an individual picture so we can tell you how you look")
      } else if result == "No faces" {
        self.presentPictureReslts("Hmm...", resultDescription: "We don't see anyone here. Try again with a different picture")
      } else {
        self.presentPictureReslts("Something went wrong", resultDescription: result)
      }
    self.activityIndicator.stopAnimating()
    }
    self.HDILButton.setTitle("Try Again", forState: .Normal)
    self.chooseImageButton.setTitle("Choose from Camera Roll", forState: .Normal)
  }
  
  func presentPictureReslts (resultTitle : String, resultDescription : String) {
    let alert = UIAlertController(title: resultTitle, message: resultDescription, preferredStyle: .Alert)
    let gotIT = UIAlertAction(title: "Got It", style: .Cancel) { (action) in
      self.dismissViewControllerAnimated(true, completion: nil)
    }
    alert.addAction(gotIT)
    self.presentViewController(alert, animated: true) {
    }
  }
  
  
//bridge works
//  let ref = DataService.checkingBridge(string as String)
//  if ref == true {
//  print("true")
//  } else {
//  print("false")
//  }
  
  
  
}