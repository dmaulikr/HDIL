//
//  HomeVC.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/26/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

  
  @IBOutlet var refreshButton: UIBarButtonItem!
  @IBOutlet weak var hdilButton: NSLayoutConstraint!
  
  override func viewDidLoad() {
    self.refreshButton.enabled = false
    self.refreshButton.tintColor = UIColor.clearColor()
  }
  


  
  
  
  
}