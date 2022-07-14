import Foundation


enum AppConfiguration : CaseIterable {

    static var allCases: [AppConfiguration] {
        return [.urlPeople(urlString: "https://swapi.dev/api/people/8"),
                .urlStarships(urlString: "https://swapi.dev/api/starships/3"),
                .urlPlanets(urlString: "https://swapi.dev/api/planets/5")
               ]
    }
    
    case urlPeople(urlString: String)
    case urlStarships(urlString: String)
    case urlPlanets(urlString: String)
    
    var urlString: String {
        switch self {
        case .urlPeople(urlString: let url):
            return url
        case .urlStarships(urlString: let url):
            return url
        case .urlPlanets(urlString: let url):
            return url
        }
    }
    
    static func randomElement() -> AppConfiguration {
        return AppConfiguration.allCases.randomElement() ?? AppConfiguration.allCases[0]
    }
    
}

struct NetworkManager {
    
    static func URLSessionDataTask(appConfig: AppConfiguration) {

        guard let urlApp = URL(string: appConfig.urlString) else {
            return
        }
        
        print("urlApp: \(urlApp) ")
        let urlRequest = URLRequest(url: urlApp)
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, responce, error in
        
            print("Ответ A: data ---------------------")
            if let data = data {
                if let dataString = String(data: data, encoding: .windowsCP1251) {
                    print("\(dataString)")
                }
            }
            print("Ответ B: allHeaderFields и statusCode ---------------------")
            if let responce = responce as? HTTPURLResponse {
                print("statusCode = \(responce.statusCode)")
                print("-----")
                if let fieldsArray = responce.allHeaderFields as? [String : String] {
                    fieldsArray.forEach{
                        print("\($0.key) = \($0.value) ")
                    }
                }
            }
            print("Ответ с: error.debugDescription ---------------------")
            if let error = error {
                print("responce: \(error.localizedDescription)")
            }
        }
        urlTask.resume()

    }
    
}
