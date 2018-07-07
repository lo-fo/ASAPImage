//
//  ASAPImageLoader.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import UIKit

public enum ASAPError: Error {
    case cantBuildImageFromData
}

public class ASAPImageLoader: NSObject {

    public static let shared = ASAPImageLoader()

    private var taskAttributes: [Int:(data: Data, callback: (Result<UIImage>) -> Void)] = [:]
    private var urlSession: URLSession? = nil

    private override init() {
        super.init()
        self.urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }

    @discardableResult
    public func load(imageAt url: URL, completion: @escaping (Result<UIImage>) -> Void) -> CancellationToken {
        let task = urlSession!.dataTask(with: url)
        taskAttributes[task.taskIdentifier] = (Data(), completion)
        task.resume()
        return CancellationToken(with: task)
    }
}

extension ASAPImageLoader: URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            taskAttributes[task.taskIdentifier]?.callback(.failure(error))
        } else if let data = taskAttributes[task.taskIdentifier]?.data, let image = UIImage(data: data) {
            taskAttributes[task.taskIdentifier]?.callback(.success(image))
        } else {
            taskAttributes[task.taskIdentifier]?.callback(.failure(ASAPError.cantBuildImageFromData))
        }
        taskAttributes.removeValue(forKey: task.taskIdentifier)
    }
}

extension ASAPImageLoader: URLSessionDataDelegate {
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        guard let response = response as? HTTPURLResponse
            , 200 == response.statusCode
            , let mimeType = response.mimeType
            , mimeType.hasPrefix("image/", caseSensitive: false) else {
                completionHandler(.cancel)
                return
        }
        completionHandler(.allow)
    }

    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        taskAttributes[dataTask.taskIdentifier]?.data.append(data)
    }
}
