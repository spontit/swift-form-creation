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
    
    //MARK:- Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.getCancelButton(target: self, selector: #selector(self.cancel))]
        self.view.backgroundColor = .white
        self.questions.append(Question(body: "When do you buy coffee ajsfdkj asjfkjsak fsajfks fjsa fksfjsda fsjk?", choices: ["8am jfaskjfkwjkfjksfjkjfiwjfkjskjfwifji jsifjskfjwkjfk", "9am", "10am"], allowMultipleSelection: true, required: true))
        self.questions.append(Question(body: "What coffee do you like?", choices: ["Latte", "Mocha", "Black", "I'm not sure"], allowMultipleSelection: false, required: false))
        self.formTV.dataSource = self
        self.formTV.delegate = self
        self.formTV.reloadData()
        self.view.addSubview(self.formTV)
        self.formTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        self.formTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        self.formTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.formTV.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    
    //MARK:- @objc exposed functions
    @objc private func cancel() {
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
        print("height,", cell.questionText.contentSize.height)
        let numLines = cell.questionText.contentSize.height / cell.questionText.font!.lineHeight
        
        cell.questionText.layoutIfNeeded()
        if cell.question.required == true {
            cell.requiredLabel.isHidden = false
        } else {
            cell.requiredLabel.textColor = .white
        }
        cell.optionTV.reloadData()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //return CGFloat(self.questions[indexPath.row].choices!.count * 40 + 80)
        //return 200
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FORM_QUESTION_CELL, for: indexPath) as! FormQuestionCell
//        let height = cell.optionTV.heightConstaint?.constant

        return UITableView.automaticDimension + 200
    }
    
}
