//
//  AuthService.swift
//  XibAppWithVkAuth
//
//  Created by Светлана Мухина on 31.03.2022.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    
    func authServiceShuldPresent(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate{
    private let appId = "8123335"
    private let vkSdk: VKSdk
    
    override init(){
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.uiDelegate = self
        print("VKSdk.initialize")
        //vkSdk.unregisterDelegate(self)
        vkSdk.register(self)
    }
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken().accessToken
    }
    
    
    func wakeUpSession() {
       let scope = ["notify"]
        //let scope = [VK_PER_EMAIL, VK_PER_NOHTTPS]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                delegate?.authServiceSignIn()
            default:
                print("Sorry")
                delegate?.authServiceSignInDidFail()
            }
        }
    }
}

extension AuthService {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        } else {
            print(result.error.localizedDescription)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShuldPresent(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
