//
//  ASAPImageView.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import UIKit

class ASAPImageView: UIImageView {

    private var token: CancellationToken?

    override var image: UIImage? {
        willSet {
            token?.cancel()
            token = nil
        }
    }

    func load(imageAt url: URL, completion: ((Result<Void>) -> Void)? = nil) {
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

    func cancel() {
        token?.cancel()
        token = nil
    }

    deinit {
        token?.cancel()
    }
}
