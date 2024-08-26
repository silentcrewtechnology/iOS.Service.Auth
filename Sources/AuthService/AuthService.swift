import Foundation
import Alamofire
import NetworkService
import Services
import Extensions

public class AuthService {
    
    private let networkService: NetworkServiceProtocol
    public let storageService: AppStorageService
    
    private var headers: HTTPHeaders = []
    
    public init(
        networkService: NetworkServiceProtocol,
        storageService: AppStorageService
    ) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    @discardableResult
    public func initLogin(
        login: String,
        password: String,
        success: @escaping (AuthInitResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        let parameters: [String: Any] = [
            "login": login,
            "password": password.sha1Base64,
            "applicationType": 1]
        return networkService.request(
            endpoint: "AkbarsOnlineAuth/LoginInit",
            method: .post,
            parameters: parameters,
            encoder: JSONEncoding.default,
            headers: headers,
            progress: nil,
            success: { (response: ResultResponse<AuthInitResponse>) in
                guard let model = response.result else {
                    // TODO: Handle error correctly
                    failure(NSError.somethingWentWrong)
                    return
                }
                success(model)
            },
            failure: failure
        )
    }
    
    @discardableResult
    public func initLogin(
        cardNumber: String,
        success: @escaping (AuthInitResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        let parameters: [String: Any] = [
            "cardNumber": cardNumber
        ]
        return networkService.request(
            endpoint: "AkbarsOnlineAuth/LoginInitByCard",
            method: .post,
            parameters: parameters,
            encoder: JSONEncoding.default,
            headers: headers,
            progress: nil,
            success: {(response: ResultResponse<AuthInitResponse>) in
                guard let model = response.result else {
                    // TODO: Handle error correctly
                    failure(NSError.somethingWentWrong)
                    return
                }
                success(model)
            },
            failure: failure
        )
    }
    
    @discardableResult
    public func initLogin(
        accountNumber: String,
        success: @escaping (AuthInitResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        let parameters: [String: Any] = [
            "accountNumber": accountNumber
        ]
        return networkService.request(
            endpoint: "AkbarsOnlineAuth/LoginInitByAccount",
            method: .post,
            parameters: parameters,
            encoder: JSONEncoding.default,
            headers: headers,
            progress: nil,
            success: { (response: ResultResponse<AuthInitResponse>) in
                guard let model = response.result else {
                    // TODO: Handle error correctly
                    failure(NSError.somethingWentWrong)
                    return
                }
                success(model)
            },
            failure: failure
        )
    }
    @discardableResult
    public func sendPin(
        pin: String,
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        let hashedPin = pin.sha256Base64
        let parameters: [String: Any] = [
            "Pin": hashedPin,
            "RefreshToken": storageService.refreshToken as Any
        ]
        storageService.pin = hashedPin
        
        struct EmptyDecodable: Decodable { }
        
        return networkService.request(
            endpoint: "auth/setPin",
            method: .post,
            parameters: parameters,
            encoder: JSONEncoding.default,
            headers: headers,
            progress: nil,
            success: { (response: ResultResponse<EmptyDecodable>) in
                // TODO: Handle error correctly
                success()
            },
            failure: failure
        )
    }

    /// Метод получения `SessionToken`/`RefreshToken`
    /// при наличии старого `RefreshToken` и `Pin`
    @discardableResult
    public func createSession(
        pin: String,
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        let hashedPin = pin.sha256Base64
        let parameters: [String: Any] = [
            "RefreshToken": storageService.refreshToken as Any,
            "Pin": hashedPin,
            "123": ["123": "123"],
            "DeviceToken": storageService.deviceToken as Any
            // TODO: "GeoLocation": ["latitude": 0, "longitude": 0]
        ]
        var headers = headers
        if let sessionToken = storageService.sessionToken {
            headers.add(name: "SessionToken", value: sessionToken)
        }
        return networkService.request(
            endpoint: "auth/createsession",
            method: .post,
            parameters: parameters,
            encoder: JSONEncoding.default,
            headers: headers,
            progress: nil,
            success: { [weak self] (response: ResultResponse<CreateSessionResponse>) in
                guard let self else { return }
                guard let model = response.result else {
                    // TODO: Handle error correctly
                    failure(NSError.somethingWentWrong)
                    return
                }
                storageService.sessionToken = model.sessionToken
                storageService.refreshToken = model.refreshToken
                success()
            },
            failure: failure
        )
    }
    
    @discardableResult
    public func getStatus(
        authorized: Bool,
        success: @escaping (LoginPasswordStatusResponse) -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        var headers = headers
        if authorized {
            if let sessionToken = storageService.sessionToken {
                headers.add(name: "SessionToken", value: sessionToken)
            } else if let bearerToken = storageService.bearerToken {
                headers.add(name: "Authorization", value: "Bearer \(bearerToken)")
            }
        } else if let bearerToken = storageService.bearerToken {
            headers.add(name: "Authorization", value: "Bearer \(bearerToken)")
        }
        return networkService.request(
            endpoint: "api/identity/loginpassword/status",
            method: .get,
            parameters: nil,
            encoder: URLEncoding.httpBody,
            headers: headers,
            progress: nil,
            success: { (response: ResultResponse<LoginPasswordStatusResponse>) in
                guard let model = response.result else {
                    // TODO: Handle error correctly
                    failure(NSError.somethingWentWrong)
                    return
                }
                success(model)
            },
            failure: failure
        )
    }
    
    @discardableResult
    public func logout(
        success: @escaping () -> Void,
        failure: @escaping (Error) -> Void
    ) -> DataRequest {
        let parameters: [String: Any] = [
            "SessionToken": storageService.sessionToken as Any
        ]
        var headers = headers
        if let sessionToken = storageService.sessionToken {
            headers.add(name: "SessionToken", value: sessionToken)
        }
        
        struct EmptyDecodable: Decodable { }
        
        return networkService.request(
            endpoint: "auth/logout",
            method: .post,
            parameters: parameters,
            encoder: JSONEncoding.default,
            headers: headers,
            progress: nil,
            success: { [weak self] (response: EmptyDecodable) in
                // TODO: Handle error correctly
                guard let self else { return }
                storageService.logout()
                success()
            },
            failure: failure
        )
    }
}

private extension NSError {
    
    static var somethingWentWrong: NSError {
        return NSError.init(
            domain: "com.bankok.error",
            code: -1,
            userInfo: [
                NSLocalizedFailureReasonErrorKey: "SomethingWentWrong.Title",
                NSLocalizedDescriptionKey: "SomethingWentWrong.Subtitle"
            ]
        )
    }
}
