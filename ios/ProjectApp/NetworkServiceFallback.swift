import Foundation

// MARK: - Network Service Fallback (No External Dependencies)

// This version works without CocoaPods dependencies
// Uses only built-in iOS networking capabilities

class NetworkServiceFallback: ObservableObject {
    static let shared = NetworkServiceFallback()
    
    private let baseURL = "http://localhost:8000/api"
    
    private init() {}
    
    // MARK: - Authentication using URLSession
    
    func login(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/auth/login") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginData = [
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: loginData)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let token = json["token"] as? String,
                   let userDict = json["user"] as? [String: Any] {
                    
                    // Store token in UserDefaults (fallback to Keychain)
                    UserDefaults.standard.set(token, forKey: "auth_token")
                    
                    let user = User(
                        id: userDict["id"] as? Int ?? 0,
                        email: userDict["email"] as? String ?? "",
                        username: userDict["username"] as? String ?? "",
                        firstName: userDict["first_name"] as? String ?? "",
                        lastName: userDict["last_name"] as? String ?? "",
                        fullName: "\(userDict["first_name"] as? String ?? "") \(userDict["last_name"] as? String ?? "")",
                        phoneNumber: userDict["phone_number"] as? String,
                        profilePicture: userDict["profile_picture"] as? String,
                        isVerified: userDict["is_verified"] as? Bool ?? false,
                        dateJoined: userDict["date_joined"] as? String ?? ""
                    )
                    
                    let authResponse = AuthResponse(token: token, user: user)
                    completion(.success(authResponse))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func register(userData: RegistrationData, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/auth/register") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let registrationData = [
            "first_name": userData.firstName,
            "last_name": userData.lastName,
            "email": userData.email,
            "username": userData.username,
            "password": userData.password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: registrationData)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let token = json["token"] as? String,
                   let userDict = json["user"] as? [String: Any] {
                    
                    // Store token in UserDefaults
                    UserDefaults.standard.set(token, forKey: "auth_token")
                    
                    let user = User(
                        id: userDict["id"] as? Int ?? 0,
                        email: userDict["email"] as? String ?? "",
                        username: userDict["username"] as? String ?? "",
                        firstName: userDict["first_name"] as? String ?? "",
                        lastName: userDict["last_name"] as? String ?? "",
                        fullName: "\(userDict["first_name"] as? String ?? "") \(userDict["last_name"] as? String ?? "")",
                        phoneNumber: userDict["phone_number"] as? String,
                        profilePicture: userDict["profile_picture"] as? String,
                        isVerified: userDict["is_verified"] as? Bool ?? false,
                        dateJoined: userDict["date_joined"] as? String ?? ""
                    )
                    
                    let authResponse = AuthResponse(token: token, user: user)
                    completion(.success(authResponse))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "auth_token")
    }
    
    // MARK: - API Calls
    
    func fetchAppStatus(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/status") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = json["message"] as? String {
                    completion(.success(message.isEmpty ? "Backend connected successfully!" : message))
                } else {
                    completion(.success("Backend connected successfully!"))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: - Helper Methods
    
    var isLoggedIn: Bool {
        return UserDefaults.standard.string(forKey: "auth_token") != nil
    }
    
    func getAuthToken() -> String? {
        return UserDefaults.standard.string(forKey: "auth_token")
    }
}

// MARK: - Data Models (Same as before)

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
    case invalidURL
    case noData
    case invalidResponse
    case noAuthToken
    case networkUnavailable
}

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
