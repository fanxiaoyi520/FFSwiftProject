//
//  FFUserManager.swift
//  FFAcssell
//
//  Created by zhou on 2019/8/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import AEAlertView

/// 用户登录类型
///
/// - UserLoginTypeIsUnKnow: 未知
/// - UserLoginTypeIsWeChat: 微信登录
/// - UserLoginTypeIsQQ: QQ登录
/// - UserLoginTypeIsPassword: 账号密码登录
enum UserLoginType {
    case UserLoginTypeIsUnKnow
    case UserLoginTypeIsWeChat
    case UserLoginTypeIsQQ
    case UserLoginTypeIsPassword
}

typealias loginBlock = (_ success: Bool, _ descript: String) -> Void

class FFUserManager: NSObject {
    
    static let shared = FFUserManager()
    private override init(){}
    private let defaults = UserDefaults.standard
    
    private struct Token {
        static let token = "token"
    }
    
    private struct Key {
        static let user = "user"
    }

    //MARK: Token
    var currentToken: TokenModel? {
        get {
            if let tokenData = defaults.data(forKey: Token.token) {
                return try? PropertyListDecoder().decode(TokenModel.self, from: tokenData)
            } else {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                if let tokenData = try? PropertyListEncoder().encode(newValue) {
                    defaults.set(tokenData, forKey: Token.token)
                }
            } else {
                defaults.removeObject(forKey: Token.token)
            }
        }
    }
    
    func updateToken(token: String?, expire: String?, refreshToken: String?, refreshExpire: String?) {
        if let tokenModel = currentToken {
            if let newToken = token {
                tokenModel.token = newToken
            }
            if let newExpire = expire {
                tokenModel.expire = newExpire
            }
            if let newRefreshToken = refreshToken {
                tokenModel.refreshToken = newRefreshToken
            }
            if let newRefreshExpire = refreshExpire {
                tokenModel.refreshExpire = newRefreshExpire
            }
            currentToken = tokenModel
        }
    }
    
    func removeToken() {
        currentToken = nil
    }
    
    //MARK: User
    var currentUser: UserModel? {
        get {
            if let userData = defaults.data(forKey: Key.user) {
                return try? PropertyListDecoder().decode(UserModel.self, from: userData)
            } else {
                return nil
            }
        }
        set {
            if let newValue = newValue {
                if let userData = try? PropertyListEncoder().encode(newValue) {
                    defaults.set(userData, forKey: Key.user)
                }
            } else {
                defaults.removeObject(forKey: Key.user)
            }
        }
    }
    
    func removeUser() {
        currentUser = nil
    }

    // MARK: - 第三方登录
    func login(loginType: UserLoginType, completion:@escaping loginBlock) -> Void {
        login(loginType: loginType, params: [:], completion: completion)
    }
    
    // MARK: - 带参登录
    func login(loginType: UserLoginType, params: [String : Any], completion: @escaping loginBlock) -> Void {
        loginToService(params: params, completion: completion)
    }
    
    // MARK: - 手动登录到服务器
    func loginToService(params: [String : Any], completion: @escaping loginBlock) -> Void {
        let parameters: [String : Any] = params
        
        NetworkManager.shared.request(url: Login,
                                      method: .post,
                                      parameters: parameters,
                                      success: { (response: ResponseModel<TokenModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====token：\(String(describing: response.data))")
            self.saveTokenInfo(response: response)
            self.getUserInfo(completion: completion)
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    func getUserInfo(completion: @escaping loginBlock) -> Void {
        
        NetworkManager.shared.request(url: GetUserInfo, method: .get,success: { (response: ResponseModel<UserModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====用户数据：\(String(describing: response.data))")
            self.saveUserInfo(response: response)
            self.loginSuccess(responeObject: response as Any, completion: completion)
        }, failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
    
    // MARK: - 自动登录到服务器
    func autoLoginToService(completion: loginBlock) -> Void{
        //暂时弃用
    }
    
    // MARK: - 登录成功处理
    func loginSuccess(responeObject: Any ,completion:loginBlock) -> Void {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationLoginStateChange), object: true)
    }
    
    // MARK: - 储存Token信息
    func saveTokenInfo(response: ResponseModel<TokenModel>?) -> Void {
        FFUserManager.shared.currentToken = response?.data
    }
    
    // MARK: - 加载Token信息
    func loadTokenInfo() -> Bool {
        return FFUserManager.shared.currentToken != nil
    }
    
    // MARK: - 储存用户信息
    func saveUserInfo(response: ResponseModel<UserModel>?) -> Void {
        FFUserManager.shared.currentUser = response?.data
    }
    
    // MARK: - 退出登录
    func logout() -> Void {
        NetworkManager.shared.request(url: logOut,
                                      method: .get,
                                      success: { (response: ResponseModel<TokenModel>?) in
            guard let response = response,response.status == 1 else {
                ToastManager.shared.showToast(message: kLanguage(response?.message ?? "未知错误"))
                return
            }
            debugPrint("====退出登陆：\(String(describing: response.data))")
            FFUserManager.shared.removeToken()
            FFUserManager.shared.removeUser()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationLoginStateChange), object: false)
        },failure: { error in
            debugPrint("====请求失败：\(error)")
            ToastManager.shared.showToast(message: error.localizedDescription)
        })
    }
}
