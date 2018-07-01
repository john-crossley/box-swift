//
//  Created by John Crossley on 01/07/2018.
//

import Foundation

extension String {
    func capturedGroups(regex pattern: String) -> [String] {
        var results = [String]()
        var regex: NSRegularExpression

        do {
            regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        } catch {
            return results
        }

        let matches = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
        guard let match = matches.first else { return results }

        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }

        for index in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: index)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            if matchedString.isEmpty { continue }
            results.append(matchedString)
        }

        return results
    }
}
