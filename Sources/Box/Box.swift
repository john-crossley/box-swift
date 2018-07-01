//
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

public final class Box {

    private var items = [String: String]()

    public init() {
        let contents = try! loadContents()

        for line in contents {
            let groups = line.capturedGroups(regex: "([\\w\\_\\-]+)+(?:=)(.+)+")
            items[groups[0]] = groups[1]
        }
    }

    public func get(key: String) -> String? {
        if let item = items[key] { return item }
        return ProcessInfo.processInfo.environment[key]
    }

    private func loadContents() throws -> [String] {
        let contents = try! String(contentsOf: URL(fileURLWithPath: envPath()))
        return contents.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }

    private func envPath() -> String {
        if let path = ProcessInfo.processInfo.environment["ENV_FILE_PATH"] {
            return path
        }

        return "/Users/jonno/dev/opensource/github/john-crossley/Box/.env"
    }
}
