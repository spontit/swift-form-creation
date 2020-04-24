//
//  Constants.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let QUESTION_CELL = "QuestionCell"
    static let OPTION_CELL = "OptionCell"
    
    static let CORNER_RADIUS : CGFloat = 5.0
}

extension UIView {
    
    func removeBorder() {
        self.layer.borderWidth = 0
    }
    
    func giveBorder(color: UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func giveBorder(color: UIColor, withWidth width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
//    func giveShadow() {
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = self.layer.cornerRadius
//        self.layer.masksToBounds = false
//    }
    
    func curveView() {
        self.layer.cornerRadius = Constants.CORNER_RADIUS
        self.layer.masksToBounds = true
    }
    
    func circleView(for dim: CGFloat) {
        self.layer.cornerRadius = dim / 2
        self.layer.masksToBounds = true
    }
    
    var heightConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }

    var widthConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }

    
}

extension UIFont
{
    var isBold: Bool
    {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool
    {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
    
    func setBoldFnc() -> UIFont
    {
        if(isBold)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func setItalicFnc()-> UIFont
    {
        if(isItalic)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.insert([.traitItalic])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func setBoldItalicFnc()-> UIFont
    {
        return setBoldFnc().setItalicFnc()
    }
    
    func detBoldFnc() -> UIFont
    {
        if(!isBold)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitBold])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func detItalicFnc()-> UIFont
    {
        if(!isItalic)
        {
            return self
        }
        else
        {
            var fontAtrAry = fontDescriptor.symbolicTraits
            fontAtrAry.remove([.traitItalic])
            let fontAtrDetails = fontDescriptor.withSymbolicTraits(fontAtrAry)
            guard fontAtrDetails != nil else {
                return self
            }
            return UIFont(descriptor: fontAtrDetails!, size: 0)
        }
    }
    
    func SetNormalFnc()-> UIFont
    {
        return detBoldFnc().detItalicFnc()
    }
    
    func toggleBoldFnc()-> UIFont
    {
        if(isBold)
        {
            return detBoldFnc()
        }
        else
        {
            return setBoldFnc()
        }
    }
    
    func toggleItalicFnc()-> UIFont
    {
        if(isItalic)
        {
            return detItalicFnc()
        }
        else
        {
            return setItalicFnc()
        }
    }
}

