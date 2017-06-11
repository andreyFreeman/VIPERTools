//
//  ServicesPrepare.swift
//  Services
//
//  Created by ANDREY KLADOV on 09/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

public protocol ServicesPrepare: class {
    func prepare(handler: @escaping () -> Void)
}
