//
//  OptionCell.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class OptionCell : UITableViewCell, UITextFieldDelegate {
    
    static let HEIGHT : CGFloat = 40
    var option: String?
    
    //MARK:- Globals
    var optionImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(imageLiteralResourceName: "Unselected")
        img.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return img
    }()
    
    var optionEntry : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        tv.placeholder = "Enter an option here"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.giveBorder(color: .lightGray)
        tv.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tv.curveView()
        return tv
    }()
    
    var deleteButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(imageLiteralResourceName: "DeleteOption"), for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return btn
    }()
    //MARK:- Internal Globals
    
    
    private var cellStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:- Overriden Functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.optionImage.widthConstaint = self.optionImage.heightConstaint
        self.cellStack.addArrangedSubview(self.optionImage)
        self.cellStack.addArrangedSubview(self.spacingView)
        self.cellStack.addArrangedSubview(self.optionEntry)
        //self.optionEntry.delegate = self
        self.cellStack.addArrangedSubview(self.deleteButton)
        self.contentView.addSubview(self.cellStack)
        self.cellStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.cellStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.cellStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.cellStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil {
            self.option = textField.text
        }
        
    }
    
    
    
}
