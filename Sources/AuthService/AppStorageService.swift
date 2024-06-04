import Foundation

public class AppStorageService {
    
    public var deviceToken: String? {
        get { UserDefaults.standard.string(forKey: "DeviceToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "DeviceToken") }
    }
    // TODO: Keychain
    public var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: "RefreshToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "RefreshToken") }
    }
    // TODO: Store in memory
    public var sessionToken: String? {
        get { UserDefaults.standard.string(forKey: "SessionToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "SessionToken") }
    }
    public var bearerToken: String? {
        get { UserDefaults.standard.string(forKey: "BearerToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "BearerToken") }
    }
    // TODO: Keychain
    public var pin: String? {
        get { UserDefaults.standard.string(forKey: "Pin") }
        set { UserDefaults.standard.setValue(newValue, forKey: "Pin") }
    }
    public var pushToken: String? {
        get { UserDefaults.standard.string(forKey: "PushToken") }
        set { UserDefaults.standard.setValue(newValue, forKey: "PushToken") }
    }
    
    public init() { }
    
    public func logout() {
        sessionToken = nil
        refreshToken = nil
        bearerToken = nil
        pushToken = nil
        pin = nil
    }
}
