import Foundation
import Alamofire
import SwiftyJSON
import KeychainSwift

// MARK: - Network Service using CocoaPods dependencies

class NetworkService: ObservableObject {
    static let shared = NetworkService()
    
    private let keychain = KeychainSwift()
    private let baseURL = "http://localhost:8000/api"
    
    private init() {}
    
    // MARK: - Authentication
    
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let parameters = [
            "email": email,
            "password": password
        ]
        
        AF.request("\(baseURL)/auth/login", 
                   method: .post, 
                   parameters: parameters,
                   encoding: JSONEncoding.default)
            .validate()
            .responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let token = json["token"].stringValue
                    
                    // Store token securely using KeychainSwift
                    self?.keychain.set(token, forKey: "auth_token")
                    
                    let authResponse = AuthResponse(
                        token: token,
                        user: User(
                            id: json["user"]["id"].intValue,
                            email: json["user"]["email"].stringValue,
                            username: json["user"]["username"].stringValue,
                            firstName: json["user"]["first_name"].stringValue,
                            lastName: json["user"]["last_name"].stringValue,
                            fullName: "\(json["user"]["first_name"].stringValue) \(json["user"]["last_name"].stringValue)",
                            phoneNumber: json["user"]["phone_number"].string,
                            profilePicture: json["user"]["profile_picture"].string,
                            isVerified: json["user"]["is_verified"].boolValue,
                            dateJoined: json["user"]["date_joined"].stringValue
                        )
                    )
                    completion(.success(authResponse))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func register(userData: RegistrationData, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let parameters = [
            "first_name": userData.firstName,
            "last_name": userData.lastName,
            "email": userData.email,
            "username": userData.username,
            "password": userData.password
        ]
        
        AF.request("\(baseURL)/auth/register", 
                   method: .post, 
                   parameters: parameters,
                   encoding: JSONEncoding.default)
            .validate()
            .responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let token = json["token"].stringValue
                    
                    // Store token securely
                    self?.keychain.set(token, forKey: "auth_token")
                    
                    let authResponse = AuthResponse(
                        token: token,
                        user: User(
                            id: json["user"]["id"].intValue,
                            email: json["user"]["email"].stringValue,
                            username: json["user"]["username"].stringValue,
                            firstName: json["user"]["first_name"].stringValue,
                            lastName: json["user"]["last_name"].stringValue,
                            fullName: "\(json["user"]["first_name"].stringValue) \(json["user"]["last_name"].stringValue)",
                            phoneNumber: json["user"]["phone_number"].string,
                            profilePicture: json["user"]["profile_picture"].string,
                            isVerified: json["user"]["is_verified"].boolValue,
                            dateJoined: json["user"]["date_joined"].stringValue
                        )
                    )
                    completion(.success(authResponse))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func logout() {
        // Remove token from keychain
        keychain.delete("auth_token")
    }
    
    // MARK: - API Calls with Authentication
    
    func fetchUserProfile(completion: @escaping (Result<User, Error>) -> Void) {
        guard let token = keychain.get("auth_token") else {
            completion(.failure(NetworkError.noAuthToken))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request("\(baseURL)/user/profile", 
                   method: .get, 
                   headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let user = User(
                        id: json["id"].intValue,
                        email: json["email"].stringValue,
                        username: json["username"].stringValue,
                        firstName: json["first_name"].stringValue,
                        lastName: json["last_name"].stringValue,
                        fullName: "\(json["first_name"].stringValue) \(json["last_name"].stringValue)",
                        phoneNumber: json["phone_number"].string,
                        profilePicture: json["profile_picture"].string,
                        isVerified: json["is_verified"].boolValue,
                        dateJoined: json["date_joined"].stringValue
                    )
                    completion(.success(user))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchAppStatus(completion: @escaping (Result<String, Error>) -> Void) {
        AF.request("\(baseURL)/status", method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let message = json["message"].stringValue.isEmpty ? 
                        "Backend connected successfully!" : 
                        json["message"].stringValue
                    completion(.success(message))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // MARK: - Helper Methods
    
    var isLoggedIn: Bool {
        return keychain.get("auth_token") != nil
    }
    
    func getAuthToken() -> String? {
        return keychain.get("auth_token")
    }
}

// MARK: - Data Models

struct AuthResponse {
    let token: String
    let user: User
}

struct RegistrationData {
    let firstName: String
    let lastName: String
    let email: String
    let username: String
    let password: String
}

enum NetworkError: Error {
    case noAuthToken
    case invalidResponse
    case networkUnavailable
}

// MARK: - User Model (Enhanced)

struct User: Identifiable, Codable {
    let id: Int
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let fullName: String
    let phoneNumber: String?
    let profilePicture: String?
    let isVerified: Bool
    let dateJoined: String
}
