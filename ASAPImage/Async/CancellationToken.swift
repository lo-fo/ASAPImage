//
//  CancellationToken.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import Foundation

public class CancellationToken {
    private weak var task: URLSessionDataTask?

    init(with task: URLSessionDataTask) {
        self.task = task
    }

    public func cancel() {
        task?.cancel()
    }
}
