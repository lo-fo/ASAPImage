//
//  ASAPImageView.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import UIKit

public class ASAPImageView: UIImageView {

    private var token: CancellationToken?

    override public var image: UIImage? {
        willSet {
            token?.cancel()
            token = nil
        }
    }

    /**
     Downloads an image over network and sets it as UIImageView's image property.

     - parameters:
        - url: the image url
        - completion: an optional callback called upon resolution of the download.
     */
    public func load(imageAt url: URL, completion: ((Result<Void>) -> Void)? = nil) {
        token?.cancel()
        token = ASAPImageLoader.shared.load(imageAt: url) { [weak self] result in
            self?.token = nil
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
                completion?(.success(()))
            }
        }
    }

    /**
     Cancels the ongoing download request.
     */
    public func cancel() {
        token?.cancel()
        token = nil
    }

    deinit {
        token?.cancel()
    }
}
