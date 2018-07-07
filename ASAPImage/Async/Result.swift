//
//  Result.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
