import Foundation

enum FeedModelError: Error {
    case wordIsEmpty(textError: String)
    case incorrect(textError: String)
}

class FeedModel {
    
    var defaultWord: String
    
    init() {
        self.defaultWord = Constants.Users.userReleace.name
    }
    
    public func doCheck(word: String) throws {
        if word == "" {
            throw FeedModelError.wordIsEmpty(textError: "Слово пустое. Заведите что-нибудь")
        } else if word == defaultWord {
            return
        } else {
            throw FeedModelError.incorrect(textError: "Слово неверно! Жду \(self.defaultWord)")
        }
        
    }
}
