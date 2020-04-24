//
//  ViewController.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- Internal Globals
    private var questionTV : QuestionTableView = QuestionTableView(frame: .zero)
    private var questions : [Question]? = []
    
    private let addQuestionButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSMutableAttributedString(string: "add question", attributes: underlineAttribute)
        btn.setAttributedTitle(underlineAttributedString, for: .normal)
        return btn
    }()
    
    //MARK:- Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
    }

    //MARK:- Helper Functions
    private func setUp() {
        self.questionTV.dataSource = self
        self.questionTV.delegate = self
        self.addQuestionButton.addTarget(self, action: #selector(self.addQuestion(_:)), for: .touchUpInside)
        self.view.addSubview(self.questionTV)
        self.questionTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.questionTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        self.questionTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        self.questionTV.heightAnchor.constraint(equalToConstant: QuestionCell.HEIGHT * CGFloat((self.questions!.count + 1))).isActive = true
//        } else {
//            self.questionTV.heightAnchor.constraint(equalToConstant: QuestionCell.HEIGHT * CGFloat(self.questions!.count)).isActive = true
//        }
        self.view.addSubview(self.addQuestionButton)
        self.addQuestionButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        self.addQuestionButton.topAnchor.constraint(equalTo: self.questionTV.bottomAnchor, constant: 5).isActive = true
    }
    
    //MARK:- @Objc Exposed Functions
    @objc func addQuestion(_ sender: Any) {
        self.questions?.append(Question())
        self.questionTV.reloadData()
        self.questionTV.heightConstaint?.constant = QuestionCell.HEIGHT * CGFloat((self.questions!.count + 1))
        self.questionTV.layoutIfNeeded()
    }
    
    @objc private func deleteQuestion(_ sender: Any) {
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.questions!.isEmpty {
            return 1
        } else {
            return self.questions!.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.QUESTION_CELL, for: indexPath) as! QuestionCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return QuestionCell.HEIGHT
    }
}

