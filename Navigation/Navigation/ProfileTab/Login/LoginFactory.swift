import Foundation

protocol LoginFactoryProtocol {
    func makeLoginInpector() -> LoginInspector
}

class LoginFactory: LoginFactoryProtocol{
    
    static let share: LoginFactoryProtocol = LoginFactory()
    
    private init() {}

    func makeLoginInpector() -> LoginInspector {
        return LoginInspector()
    }
}
