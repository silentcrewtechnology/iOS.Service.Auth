import Foundation
import CryptoKit

extension String {
    
    var sha1Base64: String {
        guard let data = data(using: .utf8) else { return "" }
        return Data(Insecure.SHA1.hash(data: data)).base64EncodedString()
    }
    
    var sha256Base64: String {
        guard let data = data(using: .utf8) else { return "" }
        return Data(SHA256.hash(data: data)).base64EncodedString()
    }
}
