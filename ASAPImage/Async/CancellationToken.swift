//
//  CancellationToken.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import Foundation

/**
 Wraps conveniently an URLSessionDataTask.
 - Todo: make it generic enough to handle any URLSessionTask. Then any asynchronous task.
 */
public class CancellationToken {
    private weak var task: URLSessionDataTask?

    /**
     Instanciates a CancellationToken

     - parameters:
        - task: the associated URLSessionDataTask
     */
    init(with task: URLSessionDataTask) {
        self.task = task
    }

    /**
     Cancels the associated task.
     */
    public func cancel() {
        task?.cancel()
    }
}
