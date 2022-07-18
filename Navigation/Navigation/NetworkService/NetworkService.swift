import Foundation

enum TypeDataExtract {
    case title
    case rotationPeriod
    case residents
    case name
}

struct NetworkManager {
    
    static func URLSessionDataTask(appConfig: AppConfiguration, completion: ((TypeDataExtract,[String]) -> Void)?) {
        
        guard let urlApp = URL(string: appConfig.urlString) else {
            return
        }
        
        print("urlApp = \(urlApp)")
        
        let urlRequest = URLRequest(url: urlApp)
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in

            if let valueData = data {
                if let dataString = String(data: valueData, encoding: .windowsCP1251) {
                    print("Data Description:")
                    print("\(dataString)")
                }
                
                switch appConfig {
                case .user:
                    do {
                        let serialData = try JSONSerialization.jsonObject(with: valueData, options: [])
                        if let dictionaryData = serialData as? [String: Any],
                           let vlueTitle = dictionaryData["title"] as? String {
                            if let valueComplition = completion {
                                valueComplition(.title,[vlueTitle])
                            }
                        }
                        
                    } catch {
                        print(error)
                    }
                case .planet:
                    do {
                        
                        let decodeData = try JSONDecoder().decode(Planet.self, from: valueData )
                        if let valueComplition = completion {
                            valueComplition(.rotationPeriod ,[decodeData.rotationPeriod])
                            valueComplition(.residents ,decodeData.residents)
                        }
                        
                    } catch {
                        print(error)
                    }
                case .resident:
                    do {
                        
                        let decodeData = try JSONDecoder().decode(People.self, from: valueData )
                        if let valueComplition = completion {
                            valueComplition(.name ,[decodeData.name])
                        }
                        
                    } catch {
                        print(error)
                    }
                default:
                    print("")
                }
            }
            
           
            if let response = response as? HTTPURLResponse {
                print("Response Description:")
                print("statusCode = \(response.statusCode)")
                if let fieldsArray = response.allHeaderFields as? [String : String] {
                    fieldsArray.forEach{
                        print("\($0.key) = \($0.value) ")
                    }
                }
            }
            
            
            if let error = error {
                print("Error Description:")
                print("error: \(error.localizedDescription)")
            }
            
            
        }
        urlTask.resume()

    }
    
}
