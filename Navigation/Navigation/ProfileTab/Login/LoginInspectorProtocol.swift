import Foundation

protocol LoginInspectorProtocol: AnyObject {
    func checkCorrectLoginPassword(loginEntry: String, passwordEntry: String) throws
    func checkCredentials(loginEntry: String, passwordEntry: String, completion: @escaping ((UserService?, Error?) -> Void ) )
    func SignUp(loginEntry: String, passwordEntry: String, completion: @escaping ((Error?) -> Void ))
}
