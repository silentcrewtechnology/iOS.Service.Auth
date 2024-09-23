import Foundation

public struct AuthInitResponse: Decodable {
    
    public var needOtp: Bool? = true
    public var hasPhone: Bool? = false
    public var needChangePassword: Bool? = false
    public var abbLoginOperationId: String?
    
    public init() { }
    
    #if DEBUG
    enum CodingKeys: String, CodingKey {
        case needOtp = "NeedOtp"
        case hasPhone = "HasPhone"
        case needChangePassword = "NeedChangePassword"
        case abbLoginOperationId = "AkbarsLoginOperationId"
    }
    #else
    private struct RedactedCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init(stringValue: String) { self.stringValue = stringValue }
        init?(intValue: Int) { nil }
        
        static let needOtp = Self.init(stringValue: "NeedOtp")
        static let hasPhone = Self.init(stringValue: "HasPhone")
        static let needChangePassword = Self.init(stringValue: "NeedChangePassword")
        static let abbLoginOperationId = Self.init(
            stringValue: "AXXarsLoginOperationId".replacingOccurrences(of: "XX", with: "kb")
        )
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RedactedCodingKeys.self)
        self.needOtp = try container.decodeIfPresent(Bool.self, forKey: .needOtp)
        self.hasPhone = try container.decodeIfPresent(Bool.self, forKey: .hasPhone)
        self.needChangePassword = try container.decodeIfPresent(Bool.self, forKey: .needChangePassword)
        self.abbLoginOperationId = try container.decodeIfPresent(String.self, forKey: .abbLoginOperationId)
    }
    #endif
}
