import Foundation

protocol LoginFactory {
    func makeLoginInpector() -> LoginInspector
}

class myLoginFactory: LoginFactory{
    
    static let share: myLoginFactory = myLoginFactory()
    
    private init() {}

    func makeLoginInpector() -> LoginInspector {
        return LoginInspector()
    }
}
