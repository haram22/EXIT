//
//  AppleLogin.swift
//  Exit
//
//  Created by 김하람 on 9/13/24.
//

import Foundation
import AuthenticationServices

class AppleLoginViewController : UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppleLoginButton()
    }
    
    func setupAppleLoginButton() {
        // ASAuthorizationAppleIDButton을 사용해 애플 로그인 버튼 생성
        let appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        appleLoginButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        // 버튼을 화면에 추가
        self.view.addSubview(appleLoginButton)
        
        // 오토레이아웃 설정
        NSLayoutConstraint.activate([
            appleLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            appleLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 50),
            appleLoginButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    // apple id로 권한 요청하기 위한 함수
    @objc func handleAuthorizationAppleIDButtonPress() {
        // 애플 ID Provider 생성 (애플로그인 요청을 생성하기 위한 ASAuthorizationAppleIDProvider객체임)
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        // 애플 로그인에 필요한 request 객체 생성하기
        let request = appleIDProvider.createRequest()
        // 사용자에게 얻고자 하는 정보 지정하기 (이름, 메일)
        request.requestedScopes = [.fullName, .email]
        
        // 애플로그인 절차를 관리하는 컨트롤러이다.
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        // 로그인 과정의 성공/실패 결과를 처리한다.
        authorizationController.delegate = self
        // 인증 컨트롤러가 어떤 화면에 표시될지 결정하는 부분. 보통 현재 화면을 지정한다.
        authorizationController.presentationContextProvider = self
        // 애플로그인 request 시작 !
        authorizationController.performRequests()
    }
    
    // didCompleteWithAuthorization = 애플로그인 후 사용자 정보를 처리하는 함수
    // 이 함수는 애플로그인 절차가 완료된 뒤 호출된다.
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            
        // case1: 사용자가 apple ID로 로그인했을 때 반환되는 정보를 처리
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(String(describing: fullName))")
            print("email: \(email ?? "failed")")
        
            // UserDefaults에 이름과 이메일 저장
            let defaults = UserDefaults.standard
            
            // Optional fullName 처리
            if let givenName = fullName?.givenName, let familyName = fullName?.familyName {
                let completeName = "\(givenName) \(familyName)"
                defaults.set(completeName, forKey: "fullName")
                print("Saved fullName: \(completeName)")
            } else {
                defaults.set("", forKey: "fullName") // 이름이 없을 경우 빈 문자열로 저장
                print("Saved fullName as empty string")
            }
            
            if let email = email {
                defaults.set(email, forKey: "email")
                print("Saved email: \(email)")
            } else {
                defaults.set("", forKey: "email") // 이메일이 없을 경우 빈 문자열로 저장
                print("Saved email as empty string")
            }
            
        // case2 : iCloud 키체인에 저장된 것을 사용해 로그인하는 방식 (여기선 사용하지 않음)
        case let passwordCredential as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("passwordCredential = \(username)")
            print("passwordCredential = \(password)")
            
        default:
            break
        }
    }
}
