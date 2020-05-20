//
//  ViewController.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import UIKit

protocol SaveFormDel {
    func didSaveForm(form: Form)
}

struct FormInfoToPass {
    var _saveFormDel : SaveFormDel!
    var _formSaved : Form?
    
    init(saveFormDel: SaveFormDel!, formSaved: Form?) {
        self._saveFormDel = saveFormDel
        self._formSaved = formSaved
    }
}

class ViewController: UIViewController {
    
    // MARK:- Globals
    var formInfoToPass : FormInfoToPass!
    
    // MARK:- Internal Globals
    private var questionTV : QuestionTableView = QuestionTableView(frame: .zero)
    private var questions : [Question]? = [Question()]
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
    
    // MARK:- Overriden Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    init(info: FormInfoToPass) {
        super.init(nibName: nil, bundle: nil)
        self.formInfoToPass = info
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helper Functions
    private func setUp() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem.getCancelButton(target: self, selector: #selector(self.cancel))]
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem.getDoneButton(target: self, selector: #selector(self.save))]
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
        
        self.questionTV.scrollToRow(at: IndexPath(row: self.questions!.count - 1, section: 0), at: .bottom, animated: true)
    }
    
    @objc private func deleteQuestion(_ sender: DeleteOptionButton) {
        if self.questions!.count > 1 {
            self.questions?.remove(at: sender.rowNumber! - 1)
            self.questionTV.reloadData()
        }
    }
    
    @objc private func cancel() {
        self.questions = [Question()]
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc private func save() {
        for row in 0..<self.questions!.count {
            print("row", row)
            let indexPath = IndexPath(row: row, section: 0)
            let cell = self.questionTV.cellForRow(at: indexPath) as! QuestionCell
            self.questions![row].setBody(body: cell.questionEntry.text ?? "")
            var options : [String] = []
            for i in 0..<cell.options!.count {
                let optionCell = cell.optionTV.cellForRow(at: IndexPath(row: i, section: 0)) as! OptionCell
                print("option: ", optionCell.optionEntry.text!)
                options.append(optionCell.optionEntry.text!)
            }
            self.questions![row].setChoices(choices: options)
            if cell.allowMultipleSelectionButton.isOn {
                self.questions![row].allowMultipleSelection = true
            } else {
                self.questions![row].allowMultipleSelection = false
            }
            
            if cell.requiredSwitch.isOn {
                self.questions![row].required = true
            } else {
                self.questions![row].required = false
            }
        }
        
        for question in self.questions! {
            print("question: ", question.body, question.choices)
            if question.body!.count < 2 {
                let alert = UIAlertController.init(title: "Alert", message: "Question should be at least 2 characters long", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            let temp = question.choices?.removeDuplicates()
            if temp!.count < question.choices!.count {
                print("set", Set(arrayLiteral: question.choices), Set(arrayLiteral: question.choices).count)
                print("array", question.choices, question.choices!.count)
                let alert = UIAlertController.init(title: "Alert", message: "Answer cannot be duplicate", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
        }
        
        print("questions", self.questions)
        self.formInfoToPass._saveFormDel.didSaveForm(form: Form(questions: self.questions))
        self.dismiss(animated: true) {
            
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userinfo = notification.userInfo else { return }
        guard let keyboardSize = userinfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue
        self.keyboardHeight = keyboardFrame.height
        self.keyboardWidth = keyboardFrame.width
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
        return self.questions!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.QUESTION_CELL, for: indexPath) as! QuestionCell
        cell.deleteButton.setRowNumber(number: indexPath.row)
        cell.deleteButton.addTarget(self, action: #selector(self.deleteQuestion(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return QuestionCell.HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionCell
        self.questions![indexPath.row].setBody(body: cell.question)
        var options : [String] = []
        for i in 0..<cell.options!.count {
            let optionCell = cell.optionTV.cellForRow(at: IndexPath(row: i, section: 0)) as! OptionCell
            options.append(optionCell.optionEntry.text ?? "Empty Option")
        }
        self.questions![indexPath.row].setChoices(choices: options)
    }
}


