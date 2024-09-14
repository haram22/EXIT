//
//  LimitSelectedApp.swift
//  Exit
//
//  Created by 김하람 on 9/12/24.
//

import SwiftUI
import FamilyControls
import ManagedSettings

// ObservableObject 프로토콜을 채택한 Model 클래스 정의
class Model: ObservableObject {
    
    // 이 클래스의 공유 인스턴스 생성 (싱글톤 패턴)
    static var shared = Model()
    
    // ManagedSettingsStore의 인스턴스를 생성하여 설정을 관리할 수 있게 함
    let store = ManagedSettingsStore()
    
    // 사용자가 제한하려는 앱 및 카테고리 선택을 저장하는 변수, 변경될 때마다 UI 업데이트
    @Published var selectedtoLimit: FamilyActivitySelection
    
    // 초기화 메서드: selectedtoLimit을 새로운 FamilyActivitySelection 객체로 초기화
    init() {
        selectedtoLimit = FamilyActivitySelection()
    }
    
    // 사용자가 선택한 앱과 카테고리에 대해 차단 제한을 설정하는 함수
    func setShieldRestrictions() {
        // 사용자가 제한할 앱과 카테고리 선택을 가져옴
        let applications = Model.shared.selectedtoLimit
        
        // 앱 차단을 설정, 선택된 앱이 없으면 nil로 설정
        store.shield.applications = applications.applicationTokens.isEmpty ? nil : applications.applicationTokens
        
        // 앱 카테고리 차단 설정, 선택된 카테고리가 없으면 nil로 설정
        store.shield.applicationCategories = applications.categoryTokens.isEmpty
        ? nil
        : ShieldSettings.ActivityCategoryPolicy.specific(applications.categoryTokens)
    }
}
