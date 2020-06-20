//
//  QuestionCell.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class QuestionCell : UITableViewCell, UITextFieldDelegate {
    
    static let HEIGHT : CGFloat = 300
    
    //MARK:- Globals
    var optionTV: OptionTableView = OptionTableView(frame: .zero)
    var question: String?
    var options: [String]? = [""]
    
    var questionEntry : UITextField = {
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
    
    var deleteButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(imageLiteralResourceName: "DeleteQuestion"), for: .normal)
        btn.giveBorder(color: .black)
        btn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return btn
    }()
    
    var allowMultipleSelectionButton : RequiredSwitch = {
        let swc = RequiredSwitch()
        swc.translatesAutoresizingMaskIntoConstraints = false
        return swc
    }()
    
    let requiredSwitch = RequiredSwitch()
    
    //MARK:- Internal Globals
    
    
    
    //private let allowMultipleSelectionSwitch = UISwitch()
    private var optionTVConstraint1 : NSLayoutConstraint!
    private var optionTVConstraint2 : NSLayoutConstraint!
    
    private let allowMultipleSelectionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Multiple Selection"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let addOptionButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add Option", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        return btn
    }()
    
    private let spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        stack.spacing = 10
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.contentView.giveBorder(color: .lightGray)
        self.questionEntry.delegate = self
        self.optionTV.delegate = self
        self.optionTV.dataSource = self
        self.addOptionButton.addTarget(self, action: #selector(self.addOption), for: .touchUpInside)
        
        self.topStack.addArrangedSubview(self.questionEntry)
        
        self.middleStack.addArrangedSubview(self.optionTV)
        self.buttonStack.addArrangedSubview(self.addOptionButton)
        self.bottomStack.addArrangedSubview(self.spacingView)
        self.bottomStack.addArrangedSubview(self.requiredSwitch)
        self.bottomStack.addArrangedSubview(self.requiredLabel)
        self.bottomStack.addArrangedSubview(self.allowMultipleSelectionButton)
        self.bottomStack.addArrangedSubview(self.allowMultipleSelectionLabel)
        self.bottomStack.addArrangedSubview(self.deleteButton)
        self.overallStack.addArrangedSubview(self.topStack)
        self.overallStack.addArrangedSubview(self.middleStack)
        self.overallStack.addArrangedSubview(self.buttonStack)
        self.overallStack.addArrangedSubview(self.bottomStack)
        self.contentView.addSubview(self.overallStack)
        
        
        self.optionTVConstraint1 = self.optionTV.heightAnchor.constraint(equalToConstant: 160)
        self.optionTVConstraint1.isActive = true
        self.optionTVConstraint2 = self.optionTV.heightAnchor.constraint(equalToConstant: 40 * CGFloat(self.options!.count + 1))
        self.optionTVConstraint2.isActive = false
        
        self.overallStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.overallStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
        self.overallStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.overallStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField != self.questionEntry {
            if textField.tag < self.options!.count - 1 {
                let cell = self.optionTV.cellForRow(at: IndexPath(row: textField.tag + 1, section: 0)) as! OptionCell
                cell.optionEntry.becomeFirstResponder()
            } else {
                self.addOptionButton.sendActions(for: .touchUpInside)
            }
            
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.questionEntry && textField.text != nil {
            self.question = textField.text
        }
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        guard textField != self.questionEntry else { return }
        if textField.text!.count > 50 {
            print(">50")
            textField.giveBorder(color: .red)
        } else {
            textField.giveBorder(color: .lightGray)
        }
    }
    
    
    //MARK:- @objc exposed functions
    @objc private func addOption(_ sender: UIButton) {
        self.options?.append("")
        self.optionTV.reloadData()
        if self.options!.count > 4 {
            self.optionTV.scrollToRow(at: IndexPath(row: self.options!.count - 1, section: 0), at: .bottom, animated: true)
            self.optionTV.flashScrollIndicators()
        }
        self.optionTV.reloadData()
        let cell = self.optionTV.cellForRow(at: IndexPath(row: self.options!.count - 1, section: 0)) as? OptionCell
        print("self.options.count", self.options!.count - 1)
        if cell != nil {
            cell!.optionEntry.becomeFirstResponder()
        }
        
    }
    
    @objc private func deleteOption(_ sender: UIButton) {
        guard self.options!.count > 1 else { return }
        self.options?.remove(at: sender.tag - 1)
        let cell = self.optionTV.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! OptionCell
        cell.optionEntry.text = ""
        self.optionTV.reloadData()
    }
    
    
}

extension QuestionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.OPTION_CELL, for: indexPath) as! OptionCell
        cell.selectionStyle = .none
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(self.deleteOption(_:)), for: .touchUpInside)
        cell.optionEntry.delegate = self
        cell.optionEntry.addTarget(self, action: #selector(self.textFieldDidBeginEditing(_:)), for: .editingChanged)
        cell.optionEntry.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OptionCell.HEIGHT
    }
}
