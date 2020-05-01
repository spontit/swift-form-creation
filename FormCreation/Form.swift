//
//  Form.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation

struct Question {
    var body : String?
    var choices : [String]?
    var allowMultipleSelection : Bool?
    var selectedChoices : [String]?
    var required : Bool?
    
    init() {
        self.body = ""
        self.choices = []
    }
    
    init(body: String?, choices: [String]?, allowMultipleSelection: Bool?) {
        self.body = body
        self.choices = choices
        self.allowMultipleSelection = allowMultipleSelection
    }
    
    mutating func didSelectChoice(choice: String) {
        self.selectedChoices?.append(choice)
    }
    
    mutating func setBody(body: String?) {
        self.body = body
    }
    
    mutating func setChoices(choices: [String]?) {
        self.choices = choices
    }
}

struct Form {
    var questions : [Question]?
    
    init(questions: [Question]?) {
        self.questions = questions
    }
}
