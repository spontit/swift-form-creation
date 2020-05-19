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
    static let FORM_OPTION_CELL = "FormOptionCell"
    static let FORM_QUESTION_CELL = "FormQuestionCell"
    
    static let START_CONTROLLER = "StartController"
    
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

extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
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

extension UIBarButtonItem {
    static func getCancelButton(target: Any, selector: Selector) -> UIBarButtonItem {
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: target, action: selector)
        cancelBtn.tintColor = UIColor.gray
        return cancelBtn
    }
    
    static func getSaveButton(target: Any, selector: Selector) -> UIBarButtonItem {
        let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: target, action: selector)
        saveButton.tintColor = .blue
        return saveButton
    }
    
    static func getDoneButton(target: Any, selector: Selector) -> UIBarButtonItem {
        let saveButton = UIBarButtonItem.init(title: "Done", style: .plain, target: target, action: selector)
        saveButton.tintColor = .blue
        return saveButton
    }
}

class DeleteOptionButton : UIButton {
    // MARK:- Data
    
    //var username: String?
    var rowNumber: Int?
    
    // MARK:- Initialization
    
    init() {
        super.init(frame: .zero)
    }
    
    init(row: Int) {
        super.init(frame: .zero)
        self.rowNumber = row
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRowNumber(number: Int?) {
        self.rowNumber = number
    }
    
    // MARK:- Deinit
    
    deinit {
        print("Deinitializating \("Constants.REPLY_BUTTON").")
    }
}

class RequiredSwitch : UISwitch {
    // MARK:- Data
    
    //var username: String?
    var rowNumber: Int?
    
    // MARK:- Initialization
    
    init() {
        super.init(frame: .zero)
    }
    
    init(row: Int) {
        super.init(frame: .zero)
        self.rowNumber = row
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRowNumber(number: Int?) {
        self.rowNumber = number
    }
    
    // MARK:- Deinit
    
    deinit {
        print("Deinitializating \("Constants.REQUIRED_SWITCH").")
    }
}

