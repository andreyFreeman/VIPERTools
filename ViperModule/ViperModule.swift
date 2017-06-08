//
//  ViperModule.swift
//  Jobok
//
//  Created by ANDREY KLADOV on 06/06/2017.
//  Copyright © 2017 VIDERTools. All rights reserved.
//

import UIKit

class ViperModule<View, Input> {
    let view: View
    let input: Input
    
    init(view: View, input: Input) {
        self.view = view
        self.input = input
    }
}
