//
//  FormController.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 5/1/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class FormController : UIViewController {
    
    //MARK:- Test Data
    private var questions : [Question] = []
    
    //MARK:- Internal Globals
    private var formTV = FormTableView(frame: .zero)
    private var windowWidth : CGFloat!
    private var donePressed : Bool = false
    
    //MARK:- Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.donePressed == true {
            let alert = UIAlertController.init(title: "Alert", message: "Your answer has saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.view.window?.rootViewController!.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.windowWidth = self.view.frame.width
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.getCancelButton(target: self, selector: #selector(self.cancel))]
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.getDoneButton(target: self, selector: #selector(self.done))]
        self.view.backgroundColor = .white
        self.questions.append(Question(body: "When do you buy coffee ajsfdkj asjfkjsak fsajfks fjsa fksfjsda fsjk?", choices: ["8am sfkjsfkjkw sjkffj sk jkfwkfjnsahfhshj hsajfhjwh hsjfhsjfhwuhu", "9am", "10am"], allowMultipleSelection: true, required: true))
        self.questions.append(Question(body: "What coffee do you like?", choices: ["Latte", "Mocha", "Black", "I'm not sure"], allowMultipleSelection: false, required: false))
        self.formTV.dataSource = self
        self.formTV.delegate = self
        self.formTV.reloadData()
        self.formTV.beginUpdates()
        self.formTV.endUpdates()
        self.view.addSubview(self.formTV)
        self.formTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        self.formTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        self.formTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.formTV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    func getHeight(text:  NSString, width:CGFloat, font: UIFont) -> CGFloat
    {
        let rect = text.boundingRect(with: CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude), options: ([NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading]), attributes: [NSAttributedString.Key.font:font], context: nil)
        return rect.size.height
    }
    
    //MARK:- @objc exposed functions
    @objc private func cancel() {
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc private func done() {
        self.donePressed = true
        self.dismiss(animated: true) {
            
        }
    }
    
}

extension FormController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORM_QUESTION_CELL, for: indexPath) as! FormQuestionCell
        cell.question = self.questions[indexPath.row]
        cell.questionText.text = self.questions[indexPath.row].body
        let numLines = self.getHeight(text: NSString(string: cell.questionText.text), width: self.windowWidth - 20, font: UIFont.systemFont(ofSize: 16))
        cell.questionText.heightAnchor.constraint(equalToConstant: numLines + 20).isActive = true
        cell.questionText.layoutIfNeeded()
        var maxLine : Float = 0
        var choiceLine : CGFloat = 0
        for choice in cell.question.choices! {
            choiceLine = self.getHeight(text: NSString(string: choice), width: self.windowWidth - 40, font: UIFont.systemFont(ofSize: 16))
            if Float(choiceLine) > maxLine {
                maxLine = Float(choiceLine)
            }
        }
        cell.optionTV.rowHeight = CGFloat(maxLine * 2)
        if cell.question.required == true {
            cell.requiredLabel.isHidden = false
        } else {
            cell.requiredLabel.textColor = .white
        }
        cell.optionTV.reloadData()
        cell.optionTV.heightAnchor.constraint(equalToConstant: CGFloat(CGFloat(self.questions[indexPath.row].choices!.count) * (cell.optionTV.rowHeight + 10))).isActive = true
        cell.optionTV.beginUpdates()
        cell.optionTV.endUpdates()
        cell.optionTV.layoutIfNeeded()
        cell.selectionStyle = .none
        return cell
    }
    
}
