//
//  Result.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import Foundation

/**
 Represents the two possible end states of any asynchronous task.

 + .success : has an associated value that can carry the result of the asynchronous task.
 + .failure : has an associated value of type Error
 */
public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
