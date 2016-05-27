//
//  Selfie.swift
//  HDIL
//
//  Created by Richard Velazquez on 5/27/16.
//  Copyright © 2016 Ricky. All rights reserved.
//

import Foundation

@objc class Selfie: NSObject {
  public var gender : String?
  public var isOneFace : Bool?
  public var facesInPic : Int?
  
  
  public init(gender: String, amountOfFaces : Int) {
    self.gender = gender
    if amountOfFaces == 1 {
      self.isOneFace = true
      self.facesInPic = 1
    } else {
      self.isOneFace = false
      self.facesInPic = amountOfFaces
    }
  }
  
  class func newInstanceNamed(name: String) -> Selfie {
    return Selfie(gender: "Male", amountOfFaces: 3)
  }
  
}
