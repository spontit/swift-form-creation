//
//  FormQuestionCell.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 5/1/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class FormQuestionCell : UITableViewCell {
    
    //MARK:- Globals
    var question = Question()
    var choices : [String]?
    
    var questionText : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isEditable = false
        tv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tv
    }()
    
    var requiredLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "(*Required)"
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    var optionTV = FormOptionTableView(frame: .zero)
    
    //MARK:- Internal Globals
    
    private let spacingView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let overallStack : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.contentView.giveBorder(color: .lightGray)
        self.optionTV.dataSource = self
        self.optionTV.delegate = self
        self.questionText.text = self.question.body
        self.overallStack.addArrangedSubview(self.questionText)
        self.overallStack.addArrangedSubview(self.requiredLabel)
        self.overallStack.addArrangedSubview(self.spacingView)
        self.overallStack.addArrangedSubview(self.optionTV)
        self.contentView.addSubview(self.overallStack)
        self.overallStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.overallStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.overallStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.overallStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    //MARK:- @objc exposed functions
    
    @objc private func selectOption(_ sender: DeleteOptionButton) {
        sender.isSelected.toggle()
        print("row numer", sender.rowNumber)
        if sender.isSelected == true {
            if self.question.allowMultipleSelection == false {
                for i in 0 ..< self.question.choices!.count {
                    let cell = self.optionTV.cellForRow(at: IndexPath(row: i, section: 0)) as! FormOptionCell
                    if i != sender.rowNumber {
                        cell.optionButton.isSelected = false
                    } else {
                        cell.optionButton.isSelected = true
                    }
                }
            } else {
                self.question.selectedChoices?.append(self.question.choices![sender.rowNumber!])
            }
        } else {
            self.question.selectedChoices?.remove(at: (self.question.selectedChoices?.firstIndex(of: self.question.choices![sender.rowNumber!]))!)
        }
    }
}

extension FormQuestionCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.question.choices!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORM_OPTION_CELL, for: indexPath) as! FormOptionCell
        cell.optionText.text = self.question.choices?[indexPath.row]
        cell.selectionStyle = .none
        if self.question.allowMultipleSelection == true {
            cell.optionButton.setImage(UIImage(imageLiteralResourceName: "CheckBoxUnselected"), for: .normal)
            cell.optionButton.setImage(UIImage(imageLiteralResourceName: "CheckBoxSelected"), for: .selected)
        }
        cell.optionButton.setRowNumber(number: indexPath.row)
        cell.optionButton.addTarget(self, action: #selector(self.selectOption(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
