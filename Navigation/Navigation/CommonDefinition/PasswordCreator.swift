import Foundation

enum PasswordCreatorError: Error {
    case failed(String)
    case randomErrorTry
}

struct PasswordCreator {
    private let passwordCharSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
   
    private func enumerationPassword(prefix: String, level: Int, maxLavel: Int, checker: ((String) -> Bool) ) -> String?  {
        var nextPrefix: String
        
        for chr in passwordCharSet {
            nextPrefix = prefix + String(chr)
            if level < maxLavel {
                if let valuePassword = enumerationPassword(prefix: nextPrefix, level: level + 1, maxLavel: maxLavel, checker: checker) {
                    return valuePassword
                }
            } else if level == maxLavel {
                if checker (nextPrefix) {
                    return nextPrefix
                }
            }
        }
        return nil
    }

    public func randomPassword(length: Int) -> String {
        return String((0..<length).map{ _ in passwordCharSet.randomElement()! })
    }
    
    public func bruteForcePassword(length: Int, cheker: ((String) -> Bool) ) -> String? {
        return enumerationPassword(prefix: "", level: 1, maxLavel: length, checker: cheker )
    }
    
    public func bruteForcePassword(length: Int,
                                   cheker: ((String) -> Bool),
                                   complition: @escaping (Result<String, Error>) -> Void ) {
        if Bool.random() {
            complition(.failure(PasswordCreatorError.randomErrorTry))
        } else {
            if let word = enumerationPassword(prefix: "", level: 1, maxLavel: length, checker: cheker ) {
                complition(.success(word))
            } else {
                complition(.failure(PasswordCreatorError.failed("не получилось!")))
            }
        }
    }
    
}
