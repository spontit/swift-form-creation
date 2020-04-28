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
    private var keyboardHeight : CGFloat?
    private var keyboardWidth : CGFloat?
    
    private let addQuestionButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("add question", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .blue
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return btn
    }()
    
    //MARK:- Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    //MARK:- Helper Functions
    private func setUp() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.getCancelButton(target: self, selector: #selector(self.cancel))]
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.getDoneButton(target: self, selector: #selector(self.cancel))]
        self.questionTV.dataSource = self
        self.questionTV.delegate = self
        self.addQuestionButton.addTarget(self, action: #selector(self.addQuestion(_:)), for: .touchUpInside)
        self.view.addSubview(self.questionTV)
        self.questionTV.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.questionTV.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        self.questionTV.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        self.questionTV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        self.view.addSubview(self.addQuestionButton)
        self.addQuestionButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        self.addQuestionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
    }
    
    
    //MARK:- @Objc Exposed Functions
    @objc func addQuestion(_ sender: Any) {
        self.questions?.append(Question())
        self.questionTV.reloadData()
        
        
    }
    
    @objc private func deleteQuestion(_ sender: DeleteOptionButton) {
        if self.questions!.count >= 1 {
            self.questions?.remove(at: sender.rowNumber! - 1)
            self.questionTV.reloadData()
        }
    }
    
    @objc private func cancel() {
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userinfo = notification.userInfo else { return }
        guard let keyboardSize = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.keyboardHeight = keyboardFrame.height
        self.keyboardWidth = keyboardFrame.width
//        self.replyTVBottomConstraint2 = self.replyTV.bottomAnchor.constraint(equalTo: self.textFieldEmbeddedView.topAnchor, constant: -5)
        if self.questions!.count > 1 {
            self.questionTV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardHeight ?? 0, right: 0)
        }
        self.view.setNeedsLayout()
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.questionTV.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        cell.deleteButton.setRowNumber(number: indexPath.row)
        cell.deleteButton.addTarget(self, action: #selector(self.deleteQuestion(_:)), for: .touchUpInside)
        cell.optionTV.setRowNumber(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return QuestionCell.HEIGHT
    }
}

