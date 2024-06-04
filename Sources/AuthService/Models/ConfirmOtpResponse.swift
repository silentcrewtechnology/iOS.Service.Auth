import Foundation

public struct ConfirmOtpResponse: Decodable {
    
    public var session: String?
    public var refreshToken: String?
    public var userId: Int?
    public var displayName: String?
    public var phone: String?
    public var isRegisteredOnLogin: Bool?
    public var identityAccessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case session = "Session"
        case refreshToken = "RefreshToken"
        case userId = "UserId"
        case displayName = "DisplayName"
        case phone = "Phone"
        case isRegisteredOnLogin = "IsRegisteredOnLogin"
        case identityAccessToken = "IdentityAccessToken"
    }
}
