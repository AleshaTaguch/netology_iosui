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
                do {
                    try feedModel.doCheck(word: word)
                } catch FeedModelError.wordIsEmpty(let textError),FeedModelError.incorrect(let  textError)  {
                    valueOnEventCheckWord(false,textError)
                    return
                } catch {
                    valueOnEventCheckWord(false,"Неивестная ошибка")
                    return
                }
                valueOnEventCheckWord(true,"Правильное слово!")
            }
        }
    }
    
}
