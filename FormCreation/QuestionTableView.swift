//
//  QuestionTableView.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/23/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class QuestionTableView : UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setUp()
    }
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.register(QuestionCell.self, forCellReuseIdentifier: Constants.QUESTION_CELL)
        self.insetsContentViewsToSafeArea = true
        self.contentInsetAdjustmentBehavior = .scrollableAxes
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.isEditing = false
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = self.rowHeight
        
        self.allowsSelection = false
        self.allowsMultipleSelection = false
    }
}
