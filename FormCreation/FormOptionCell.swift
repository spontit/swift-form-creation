//
//  FormOptionCell.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 5/1/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class FormOptionCell : UITableViewCell {
    //MARK:- Globals
    
    var optionText : UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.numberOfLines = 0
        return tv
    }()
    
    var optionButton : DeleteOptionButton = {
        let btn = DeleteOptionButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(imageLiteralResourceName: "Unselected"), for: .normal)
        btn.setImage(UIImage(imageLiteralResourceName: "Selected"), for: .selected)
        return btn
    }()
    
    //MARK:- Internal Globals
    private let overallStack : UIStackView = {
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
    
    //MARK:- Overriden functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.contentView.giveBorder(color: .black)
        self.overallStack.addArrangedSubview(self.optionButton)
        self.overallStack.addArrangedSubview(self.optionText)
        self.overallStack.addArrangedSubview(self.spacingView)
        self.contentView.addSubview(self.overallStack)
        self.overallStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.overallStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.overallStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.overallStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
}
