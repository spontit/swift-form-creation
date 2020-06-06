//
//  FormInfoToPass.swift
//  FormCreation
//
//  Created by Zhang Qiuhao on 6/5/20.
//  Copyright © 2020 Zhang Qiuhao. All rights reserved.
//

import Foundation

struct FormInfoToPass {
    var _saveFormDel : SaveFormDel!
    var _formSaved : Form?
    
    init(saveFormDel: SaveFormDel!, formSaved: Form?) {
        self._saveFormDel = saveFormDel
        self._formSaved = formSaved
    }
}
