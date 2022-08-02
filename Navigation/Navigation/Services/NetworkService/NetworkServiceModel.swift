import Foundation

struct UserJSON: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
}

struct Planet: Codable {
    let name: String
    let rotationPeriod: String
    let residents: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case residents
    }
}

struct People: Codable {
    let name: String

}


