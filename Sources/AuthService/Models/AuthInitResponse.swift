import Foundation

public struct AuthInitResponse: Decodable {
    
    public var needOtp: Bool? = true
    public var hasPhone: Bool? = false
    public var needChangePassword: Bool? = false
    public var akbarsLoginOperationId: String?
    
    public init() { }
    
    enum CodingKeys: String, CodingKey {
        case needOtp = "NeedOtp"
        case hasPhone = "HasPhone"
        case needChangePassword = "NeedChangePassword"
        case akbarsLoginOperationId = "AkbarsLoginOperationId"
    }
}
