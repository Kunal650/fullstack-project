# 🍎 CocoaPods Guide - Full-Stack iOS App

## 🚀 **Option A: With CocoaPods (Enhanced)**

You've chosen to use CocoaPods for your iOS app! This gives you access to powerful third-party libraries for building a professional full-stack mobile application.

## 📦 **Included Dependencies**

### **Networking & API**
- ✅ **Alamofire** - HTTP networking library
- ✅ **SwiftyJSON** - JSON parsing and handling

### **Security & Storage**
- ✅ **KeychainSwift** - Secure keychain storage

### **UI & Images**
- ✅ **SDWebImageSwiftUI** - Image loading and caching
- ✅ **SwiftUI-Introspect** - Advanced SwiftUI customization

## 🔧 **Enhanced GitHub Actions Workflow**

The workflow now includes:

### **1. CocoaPods Installation**
```yaml
- name: Install CocoaPods
  run: |
    sudo gem install cocoapods
    pod --version
```

### **2. Dependencies Installation**
```yaml
- name: Install CocoaPods dependencies
  run: |
    cd ios
    pod install --verbose --repo-update
```

### **3. Workspace Build**
```yaml
- name: Build iOS app for Simulator
  run: |
    xcodebuild -workspace ProjectApp.xcworkspace -scheme ProjectApp build
```

## 📱 **Using Dependencies in Your iOS App**

### **1. Networking with Alamofire**
```swift
import Alamofire

// API calls to your Django backend
func fetchData() {
    AF.request("http://localhost:8000/api/data")
        .responseJSON { response in
            // Handle response
        }
}
```

### **2. JSON Parsing with SwiftyJSON**
```swift
import SwiftyJSON

func parseJSON(data: Data) {
    let json = JSON(data)
    let name = json["name"].stringValue
    let age = json["age"].intValue
}
```

### **3. Secure Storage with KeychainSwift**
```swift
import KeychainSwift

let keychain = KeychainSwift()

// Store user token securely
keychain.set("user_token", forKey: "auth_token")

// Retrieve user token
let token = keychain.get("auth_token")
```

### **4. Image Loading with SDWebImageSwiftUI**
```swift
import SDWebImageSwiftUI

// Load images from your Django backend
WebImage(url: URL(string: "http://localhost:8000/media/image.jpg"))
    .resizable()
    .aspectRatio(contentMode: .fit)
```

## 🎯 **Full-Stack Integration**

### **Connect to Your Django Backend**
```swift
// API Configuration
struct APIConfig {
    static let baseURL = "http://localhost:8000/api"
    static let authToken = KeychainSwift().get("auth_token")
}

// User Authentication
func loginUser(email: String, password: String) {
    let parameters = ["email": email, "password": password]
    
    AF.request("\(APIConfig.baseURL)/auth/login", 
               method: .post, 
               parameters: parameters)
        .responseJSON { response in
            // Handle login response
        }
}
```

### **Data Models**
```swift
import SwiftyJSON

struct User: Codable {
    let id: Int
    let email: String
    let name: String
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.email = json["email"].stringValue
        self.name = json["name"].stringValue
    }
}
```

## 🔄 **Development Workflow**

### **1. Local Development (if you have macOS)**
```bash
cd ios
pod install
open ProjectApp.xcworkspace
```

### **2. Cloud Building (GitHub Actions)**
- ✅ **Automatic CocoaPods installation**
- ✅ **Dependency resolution**
- ✅ **Workspace build**
- ✅ **Artifact creation**

## 📋 **Build Process**

### **What Happens in GitHub Actions:**
1. **Install CocoaPods** gem
2. **Navigate to iOS directory**
3. **Run `pod install`** to fetch dependencies
4. **Create workspace** with dependencies
5. **Build using workspace** file
6. **Create archive** for distribution
7. **Upload artifacts** for download

## 🎉 **Benefits of CocoaPods**

### **✅ Professional Development:**
- ✅ **Industry-standard** dependency management
- ✅ **Rich ecosystem** of libraries
- ✅ **Easy integration** with existing code
- ✅ **Version management** and updates

### **✅ Full-Stack Capabilities:**
- ✅ **API integration** with your Django backend
- ✅ **Secure authentication** and storage
- ✅ **Image handling** and caching
- ✅ **Advanced UI** components

## 🚀 **Next Steps**

### **1. Push Your Code**
```bash
git add .
git commit -m "Enhanced CocoaPods setup with full-stack dependencies"
git push origin main
```

### **2. Watch the Build**
- Go to GitHub Actions tab
- Watch CocoaPods installation
- See dependencies being resolved
- Download build artifacts

### **3. Start Development**
- Use the included libraries
- Connect to your Django backend
- Build professional iOS features

## 🎯 **Success!**

Your iOS app now has:
- ✅ **Professional dependencies** via CocoaPods
- ✅ **Full-stack integration** capabilities
- ✅ **Enhanced GitHub Actions** workflow
- ✅ **Ready for production** development

**Your iOS app will build successfully with all the powerful CocoaPods dependencies!** 🚀
