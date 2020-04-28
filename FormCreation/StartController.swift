//
//  StartController.Swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 4/27/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation
import UIKit

class StartController : UIViewController {
    
    //MARK:- Internal Globals
    private var startButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Create Form", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.giveBorder(color: .black)
        return btn
    }()
    
    //MARK:- Overriden functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    //MARK:- Helper functions
    private func setUp() {
        self.view.addSubview(self.startButton)
        self.startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.startButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.startButton.addTarget(self, action: #selector(self.startPressed(_:)), for: .touchUpInside)
    }
    
    //MARK:- @objc exposed functions
    @objc private func startPressed(_ sender: Any) {
        let createFormVC = ViewController()
        let navVC = UINavigationController(rootViewController: createFormVC)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
}