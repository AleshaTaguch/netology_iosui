import Foundation


class FeedModel {
    
    var defaultWord: String
    
    init() {
        self.defaultWord = Constants.Users.userReleace.name
    }
    
    public func check(word: String) -> (isValid: Bool , resultText: String) {
        if defaultWord == word {
            return (true, "Все верно!!!")
        } else {
            return (false, "Слово неверно! Жду \(self.defaultWord)")
        }
        
    }
}
