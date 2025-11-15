import Foundation

public struct LoginPasswordStatusResponse: Decodable {
    
    public var status: LoginPasswordStatus
    
    enum CodingKeys: String, CodingKey {
        case status = "Status"
    }
}

public enum LoginPasswordStatus: Int, Decodable {
    case unknown = -1
    case actual = 0
    case needCreate = 1
    case needUpdate = 2
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(RawValue.self)
        if let decoded = type(of: self).init(rawValue: rawValue) {
            self = decoded
        } else {
            self = .unknown
        }
    }
}
