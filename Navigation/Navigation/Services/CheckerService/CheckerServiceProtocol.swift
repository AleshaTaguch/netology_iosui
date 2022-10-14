import Foundation

protocol CheckerServiceProtocol {
    func checkCredentials(loginEntry: String, passwordEntry: String, completion: @escaping ((User?, Error?) -> Void )) 
}
