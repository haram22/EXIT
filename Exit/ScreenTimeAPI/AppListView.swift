//
//  AppListView.swift
//  Exit
//
//  Created by 김하람 on 9/12/24.
//

import UIKit
import SwiftUI
import FamilyControls

struct AppListView: View {
    
    // 상태 관리를 위해 @State 사용하기
    // FamilyActivitySelection()은 사용자가 선택한 가족 활동 데이터를 나타내는 객체.
    @State var selection = FamilyActivitySelection()
    
    // isPresented는 familyActivityPicker가 화면에 표시되는지 통제함
    @State var isPresented = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        
        // VStack은 수직으로 그리기
        VStack {
            Button {
                // 버튼이 클릭되면 isPresented 상태를 true로 설정
                isPresented = true
            } label: {
                // 버튼의 레이블 지정하기
                Text("show app list")
                // .familyActivityPicker는 family activity를 선택할 수 있는 Picker 화면에 보여주기
                // isPresented가 true일 때 Picker가 표시.
                // selection은 사용자가 선택한 활동 데이터를 모델에 저장함.
            }.familyActivityPicker(isPresented: $isPresented, selection: $model.selectedtoLimit)
        }
        // 이후 선택한 앱들에 대한 shieldRestriction이 실행된다.
        .onChange(of: model.selectedtoLimit, {
            Model.shared.setShieldRestrictions()
        })
    }
}
