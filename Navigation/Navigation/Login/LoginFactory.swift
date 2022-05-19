import Foundation

protocol LoginFactoryProtocol {
    func makeLoginInpector() -> LoginInspector
}

class LoginFactory: LoginFactoryProtocol{
    
    static let share: LoginFactory = LoginFactory()
    
    private init() {}

    func makeLoginInpector() -> LoginInspector {
        return LoginInspector()
    }
}
