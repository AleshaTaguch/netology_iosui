import Foundation

protocol CheckerServiceProtocol {
    func checkCredentials(loginEntry: String, passwordEntry: String, completion: @escaping ((User?, Error?) -> Void )) 
    func signUp(loginEntry: String, passwordEntry: String, completion: @escaping ((Error?) -> Void )) -> Void
}
