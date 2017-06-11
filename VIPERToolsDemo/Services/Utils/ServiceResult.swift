//
//  ServiceResult.swift
//  Services
//
//  Created by ANDREY KLADOV on 11/06/2017.
//  Copyright © 2017 Budgeteer. All rights reserved.
//

import Foundation

public enum ServiceResult<T, E> where E: Error {
    case success(T)
    case fail(E)
}
