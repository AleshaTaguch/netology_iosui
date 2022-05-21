import Foundation

final class FeedViewModel {
    
    enum Action {
        case checkWord(String)
        // может что-то еще.....
    }

    let feedModel: FeedModel = FeedModel()
    
    var onEventCheckWord: ((Bool,String) -> Void)?
    
    func doEventAction(type action: Action) {
        switch action {
        case .checkWord(let word):
            if let valueOnEventCheckWord = onEventCheckWord {
                let modelCheck = feedModel.check(word: word)
                valueOnEventCheckWord(modelCheck.isValid,modelCheck.resultText)
            }
        }
    }
    
}
