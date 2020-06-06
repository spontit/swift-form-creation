//
//  FilledFormToPass.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 6/5/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation

struct FilledFormToPass {
    var _fillFormDel : FillFormDel!
    var form : Form?
    
    init(fillFormDel: FillFormDel!, form: Form?) {
        self._fillFormDel = fillFormDel
        self.form = form
    }
}
