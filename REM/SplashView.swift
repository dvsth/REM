//
//  SplashView.swift
//  REM
//
//  Created by Dev Seth on 1/13/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("Logo.jpg")
            .resizable()
            .frame(width: 200, height: 200)
            .padding()
    }
    
    private func myFunc(text: String) -> Void {
        
    }
}

#Preview {
    SplashView()
}
