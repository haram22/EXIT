//
//  SceneDelegate.swift
//  Exit
//
//  Created by 김하람 on 9/11/24.
//

import UIKit
import SwiftUI
import FamilyControls

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
           
           guard let windowScene = (scene as? UIWindowScene) else { return }
           
           // `Model.shared`의 인스턴스를 생성
           let model = Model.shared
           
           // SwiftUI의 AppListView를 설정
           let contentView = AppListView().environmentObject(model)
           
           // 새로운 UIWindow를 생성하고 초기 뷰 컨트롤러로 설저
           let window = UIWindow(windowScene: windowScene)
           window.rootViewController = UIHostingController(rootView: contentView)
           self.window = window
           window.makeKeyAndVisible()
       }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

