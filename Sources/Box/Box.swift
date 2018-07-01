//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation
import Files

public final class Box {

    private var items = [String: String]()
    private let environmentsFile: String

    public convenience init() {
        self.init(envFile: ProcessInfo.processInfo.environment["ENV_FILE_PATH"] ?? "")
    }

    public init(envFile: String) {

        self.environmentsFile = envFile

        do {
            let contents = try loadContents()

            for line in contents {
                let groups = line.capturedGroups(regex: "([\\w\\_\\-]+)+(?:=)(.+)+")
                items[groups[0]] = groups[1]
            }
        } catch let error {
            print("Unable to load environment file: \(error.localizedDescription)")
        }
    }

    public func get(key: String) -> String? {
        if let item = items[key] { return item }
        return ProcessInfo.processInfo.environment[key]
    }

    private func loadContents() throws -> [String] {
        let contents = try String(contentsOf: URL(fileURLWithPath: self.environmentsFile))
        return contents.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }
}
