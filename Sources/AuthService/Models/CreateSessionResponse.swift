import Foundation

public struct CreateSessionResponse: Decodable {
    
    public let sessionToken: String?
    public let refreshToken: String?
    public let expirationTime: String?
    
    enum CodingKeys: String, CodingKey {
        case sessionToken = "SessionToken"
        case refreshToken = "RefreshToken"
        case expirationTime = "ExpirationTime"
    }
}
