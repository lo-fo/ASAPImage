//
//  String+hasPrefix.swift
//  ASAPImage
//
//  Created by Louis Fournier on 04/07/2018.
//  Copyright © 2018 Louis Fournier. All rights reserved.
//

import Foundation

extension String {
    func hasPrefix(_ prefix: String, caseSensitive: Bool) -> Bool {
        if (caseSensitive) {
            return self.hasPrefix(prefix)
        }
        guard let prefixRange = self.range(of: prefix, options: [.caseInsensitive, .anchored]) else { return false }
        return prefixRange.lowerBound == self.startIndex
    }
}
