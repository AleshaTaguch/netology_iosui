import Foundation
import KeychainAccess

enum PinCodeServiceError: Error {
    case incorrectPinCode
}

extension PinCodeServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .incorrectPinCode:
            return NSLocalizedString("PinCode does not match the pattern", comment: "Enter correct PinCode")
        }
    }
}

class PinCodeService {
    
    public static let shared: PinCodeService = PinCodeService()
    
    private var keychainPinCode: Keychain?
    
    private let pinCodeKey: String = "pinCode"
    private var countWrongTry: Int = 0
    
    private init() {
        if let bundleID = Bundle.main.bundleIdentifier {
            self.keychainPinCode = Keychain(service: bundleID)
        }
    }
    
    public func existPinCode() -> Bool {
        do {
            if let _ = try keychainPinCode?.getString(pinCodeKey) {
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    public func setPinCode(_ enterPinCode: String) {
        if validatePinCodeString(enterPinCode) {
            do {
                try keychainPinCode?.set(enterPinCode, key: pinCodeKey)
                print("setPinCode OK!")
            }  catch {
                print(error.localizedDescription)
            }
        } else {
            print("not validatePinCodeString") //throw PinCodeServiceError.incorrectPinCode
        }

    }
    
    public func checkPinCode(_ enterPinCode: String) -> Bool {
        do {
            let pinCode = try keychainPinCode?.getString(pinCodeKey)
            if enterPinCode == pinCode {
                countWrongTry = 0
                return true
            } else {
                countWrongTry += 1
                print("countWrongTry = \(countWrongTry)")
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        
    }
    
    public func remotePinCodeByTry(countTry: Int) -> Bool {
        if countWrongTry >= countTry {
            do {
                try keychainPinCode?.remove(pinCodeKey)
                countWrongTry = 0
                return true
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
        
    }
    
    public func validatePinCodeString(_ pinCode: String) -> Bool {
        let regex =  "^([0-9]){4,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@",regex)
        let result = predicate.evaluate(with: pinCode)
        return result
    }

    
}


