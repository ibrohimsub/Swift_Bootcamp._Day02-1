import Foundation

//let path = FileManager.default.currentDirectoryPath + "/"
let path = "/Users/coffeeta/Desktop/swift/Sources/files/"

let resumeFile = "resume.txt"
let exportFile = "export.txt"


guard let resumeText = try? String(contentsOfFile: path + resumeFile),
      let exportText = try? String(contentsOfFile: path + exportFile) else {
    print("Error reading")
    exit(1)
}

// Сравнение содержимого файлов
if resumeText == exportText {
    print("Text comparator: resumes are identical")
} else {
    print("Text comparator: resumes are different")
}
