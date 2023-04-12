import Foundation

let resumeFile = "resume.txt"

//let path = FileManager.default.currentDirectoryPath + "/"
let path = "/Users/coffeeta/Desktop/swift/Sources/files/"
let resumeContent = try String(contentsOfFile: path + resumeFile, encoding: .utf8)

let exportFile = "export.txt"
try resumeContent.write(toFile: path + exportFile, atomically: true, encoding: .utf8)

var wordsCount = [String: Int]()
var sections = [String]()

let lines = resumeContent.components(separatedBy: .newlines)

for line in lines {
    if line.starts(with: "#") {
        sections.append(line)
    } else {
        let words = line.components(separatedBy: .whitespacesAndNewlines)
        for word in words {
            if word.isEmpty { continue }
            if let count = wordsCount[word] {
                wordsCount[word] = count + 1
            } else {
                wordsCount[word] = 1
            }
        }
    }
}

let sortedWords = wordsCount.sorted(by: { $0.value > $1.value })

let analysisFile = "analysis.txt"
var analysisContent = "# Words\n"
analysisContent += sortedWords.map({ "\($0.key) - \($0.value)" }).joined(separator: "\n")
analysisContent += "\n\n# Matched tags\n"
analysisContent += sections
    .flatMap({ $0.components(separatedBy: .whitespacesAndNewlines) })
    .filter({ !$0.isEmpty })
    .compactMap { tag -> String? in
        do {
            let tagFileContent = try String(contentsOfFile: path + "tags.txt", encoding: .utf8)
            if tagFileContent.contains(tag) {
                return tag
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    .sorted()
    .joined(separator: "\n")
analysisContent += "\n\n# Possible tags\n"
analysisContent += wordsCount.keys
    .compactMap { tag -> String? in
        do {
            let tagFileContent = try String(contentsOfFile: path + "tags.txt", encoding: .utf8)
            if tagFileContent.contains(tag) {
                return tag
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    .sorted()
    .joined(separator: "\n")

try analysisContent.write(toFile: path + analysisFile, atomically: true, encoding: .utf8)
