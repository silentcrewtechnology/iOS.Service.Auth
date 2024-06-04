import Foundation

public struct AuthRequestOtpResponse: Decodable {
    
    public var phone: String?
    
    enum CodingKeys: String, CodingKey {
        case phone = "Phone"
    }
}
