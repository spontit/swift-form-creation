//
//  OptionCell.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class OptionCell : UITableViewCell {
    
    static let WIDTH = 100
    
    //MARK:- Internal Globals
    var optionEntry : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        tv.placeholder = "Enter an option here"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.giveBorder(color: .lightGray)
        tv.curveView()
        return tv
    }()
    
    var optionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.isHidden = true
        return label
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
        self.contentView.addSubview(self.optionEntry)
        self.contentView.addSubview(self.optionLabel)
        self.optionEntry.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.optionEntry.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.optionEntry.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.optionEntry.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.optionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.optionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.optionLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.optionLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.optionLabel.isHidden = true
    }
    
    
}
