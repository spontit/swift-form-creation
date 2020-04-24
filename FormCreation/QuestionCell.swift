//
//  QuestionCell.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class QuestionCell : UITableViewCell, UITextFieldDelegate {
    
    static let HEIGHT : CGFloat = 250
    
    //MARK:- Internal Globals
    private var options: [String]? = []
    var optionTV: OptionTableView = OptionTableView(frame: .zero)
    private let requiredSwitch = UISwitch()
    private let allowMultipleSelectionSwitch = UISwitch()
    private var optionTVConstraint1 : NSLayoutConstraint!
    private var optionTVConstraint2 : NSLayoutConstraint!
    
    private var questionEntry : UITextField = {
        let tv = UITextField()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tv.backgroundColor = .lightText
        tv.textColor = .black
        tv.placeholder = "Enter the question here"
        tv.giveBorder(color: .black)
        tv.curveView()
        return tv
    }()
    
    private let addOptionButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
//        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
//        let underlineAttributedString = NSMutableAttributedString(string: "add option", attributes: underlineAttribute)
        btn.setTitle("add option", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    private let deleteOptionButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("delete last option", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    
    private let spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.giveBorder(color: .black)
        return view
    }()
    
    private let requiredLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Required"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let allowMultipleSelectionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Allow Multiple Selection"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let deleteButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    
    private let topStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let buttonStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let bottomStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private let middleStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private let overallStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    
    //MARK:- Overriden functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.questionEntry.delegate = self
        self.optionTV.delegate = self
        self.optionTV.dataSource = self
        self.addOptionButton.addTarget(self, action: #selector(self.addOption), for: .touchUpInside)
        self.deleteOptionButton.addTarget(self, action: #selector(self.deleteOption(_:)), for: .touchUpInside)
        
        self.topStack.addArrangedSubview(self.questionEntry)
        self.topStack.addArrangedSubview(self.requiredSwitch)
        self.topStack.addArrangedSubview(self.requiredLabel)
        self.requiredLabel.bottomAnchor.constraint(equalTo: self.requiredSwitch.bottomAnchor, constant: -15).isActive = true
        self.middleStack.addArrangedSubview(self.optionTV)
        self.buttonStack.addArrangedSubview(self.addOptionButton)
        self.buttonStack.addArrangedSubview(self.deleteOptionButton)
        self.bottomStack.addArrangedSubview(self.allowMultipleSelectionSwitch)
        self.bottomStack.addArrangedSubview(self.allowMultipleSelectionLabel)
        self.bottomStack.addArrangedSubview(self.deleteButton)
        self.overallStack.addArrangedSubview(self.topStack)
        self.overallStack.addArrangedSubview(self.middleStack)
        //self.overallStack.addArrangedSubview(self.spacingView)
        self.overallStack.addArrangedSubview(self.buttonStack)
        self.overallStack.addArrangedSubview(self.bottomStack)
        self.contentView.addSubview(self.overallStack)
        
        
        self.optionTVConstraint1 = self.optionTV.heightAnchor.constraint(equalToConstant: 120)
        self.optionTVConstraint1.isActive = true
        self.optionTVConstraint2 = self.optionTV.heightAnchor.constraint(equalToConstant: 40 * CGFloat(self.options!.count + 1))
        self.optionTVConstraint2.isActive = false
        
        self.overallStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.overallStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.overallStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.overallStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
    }
    
    //MARK:- @objc exposed functions
    @objc private func addOption(_ sender: Any) {
        print("added")
        self.options?.append("")
        print(self.options!.count)
        self.optionTV.reloadData()
    }
    
    @objc private func deleteOption(_ sender: Any) {
        if self.options!.count >= 1 {
            self.options?.removeLast()
            self.optionTV.reloadData()
        }
    }
    
    
}

extension QuestionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.options?.count == 0 {
            return 1
        } else {
            return self.options!.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.OPTION_CELL, for: indexPath) as! OptionCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
