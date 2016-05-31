//
//  HomeVC.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/26/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import UIKit
import CoreData

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  
  @IBOutlet var HDILButton: UIButton!
  @IBOutlet var imageView: UIImageView!
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var chooseImageButton: UIButton!
  
  @IBOutlet var chooseFromPreviousImagesButton: UIButton!
  var imagePicker : UIImagePickerController!
  var moc : NSManagedObjectContext?
  var pictures : NSMutableArray?
  var selectedImage : UIImage?
  var didSelectImage : Bool?
  
  
  
  override func viewDidLoad() {
  
    self.activityIndicator.hidesWhenStopped = true
    self.activityIndicator.hidden = true
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    self.moc = appDelegate.managedObjectContext;
    self.chooseFromPreviousImagesButton.hidden = true
    self.chooseFromPreviousImagesButton.enabled = false
    self.loadImages()
  }
  
  override func viewWillAppear(animated: Bool) {
    if self.selectedImage != nil && self.didSelectImage == true {
      self.analyzeImage(self.selectedImage!)
      self.imageView.image = selectedImage
      self.didSelectImage = false
    }
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
    
    picker.dismissViewControllerAnimated(true, completion: nil)
    let image = info[UIImagePickerControllerOriginalImage] as? UIImage
    imageView.image = image
    self.saveImage(image!)
    self.analyzeImage(image!)

  }
  
  func analyzeImage (image : UIImage) {
    self.activityIndicator.hidden = false
    self.activityIndicator.startAnimating()
    self.HDILButton.enabled = false
    self.chooseImageButton.enabled = false
    self.chooseFromPreviousImagesButton.enabled = false
    let data = UIImageJPEGRepresentation(image, 0.8)
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
      self.HDILButton.enabled = true
      self.chooseFromPreviousImagesButton.enabled = true
      self.chooseImageButton.enabled = true
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
  
  func saveImage(image : UIImage){
    let picture = NSEntityDescription.insertNewObjectForEntityForName("Picture", inManagedObjectContext: self.moc!) as! Picture
    let imageData = UIImageJPEGRepresentation(image, 1)
    picture.binary = imageData
    do {
      try self.moc?.save()
    } catch {
      fatalError("Failure to save context: \(error)")
    }
    moc?.refreshAllObjects()
    self.loadImages()
  }
  
  func loadImages() {
    let fetchRequest = NSFetchRequest(entityName: "Picture")

    do {
      let results = try self.moc!.executeFetchRequest(fetchRequest) as! [Picture]
      if results.count > 0 {
        self.chooseFromPreviousImagesButton.hidden = false
        self.chooseFromPreviousImagesButton.enabled = true
        self.pictures = NSMutableArray()
        for picture : Picture in results {
          self.pictures?.addObject(picture)
        }
      }
    } catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
      return
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "savedPictures" {
      let destVC = segue.destinationViewController as! SavedPicturesVC
      destVC.pictures = self.pictures
      
    }
  }
  
  @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
    
  }
  
   
  
  
}