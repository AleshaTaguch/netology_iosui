enum AvailableURL: String, CaseIterable {
    
    static var allCases: [AvailableURL] {
        return [.people, .starships, .planets, .films, .species, .vehicles]
    }
    
    case people = "https://swapi.dev/api/people/1"
    case starships = "https://swapi.dev/api/starships/1"
    case planets = "https://swapi.dev/api/planets/1"
    case films = "https://swapi.dev/api/films/1"
    case species = "https://swapi.dev/api/species/1"
    case vehicles = "https://swapi.dev/api/vehicles/1"
    
    case user = "https://jsonplaceholder.typicode.com/todos/13"
    
    static var randomURL: String {
        return (allCases.randomElement() ?? people).rawValue
    }
}


enum AppConfiguration {

    case singeUrl(availableURL: AvailableURL)
    case randomURL
    case user
    case planet
    case resident(url: String)
    
    var urlString: String {
        switch self {
        case .singeUrl(availableURL: let availableURL):
            return availableURL.rawValue
        case .randomURL:
            return AvailableURL.randomURL
        case .user:
            return AvailableURL.user.rawValue
        case .planet:
            return AvailableURL.planets.rawValue
        case .resident(url: let url):
            return url
        }
    }
    
}
