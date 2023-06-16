//
//  CTView.swift
//  Login_Register
//
//

import Foundation
import UIKit

class CTViewOne: UIView {
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
    }
  }
  @IBInspectable var style: Int = 0 {
    didSet {
    }
  }
  
  var shadowLayer: CAShapeLayer!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    //self.backgroundColor = UIColor.white
    // updateViewOne()
    
    dropShadow()
    
  }
  
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize(width: 1, height: 1)
    layer.shadowRadius = 5
    layer.shadowOffset = CGSize.zero
    layer.shadowColor = UIColor.lightGray.cgColor
    //shadowLayer.shadowOpacity = 0.5
    
    //layer.borderWidth = 1
    layer.cornerRadius = 8
    
    
    
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
  
}




class CTViewTWO: UIView {
  
  
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
    }
  }
  @IBInspectable var style: Int = 0 {
    didSet {
    }
  }
  
  
  
  var shadowLayer: CAShapeLayer!
  
  override func layoutSubviews() {
    super.layoutSubviews()
    //self.backgroundColor = UIColor.white
    // updateViewOne()
    
    dropShadow()
    
  }
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 1
    layer.shadowOffset = CGSize(width: 5, height: 5)
    layer.shadowRadius = 5
    layer.shadowOffset = CGSize.zero
    layer.shadowColor = UIColor.lightGray.cgColor
    
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}





