//
//  SplashScreenView.swift
//  Clink
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        if isActive {
            TabViewComponent()
        } else {
            ZStack {
                (colorScheme == .dark ? Color(.darkSplashscreenBckg) : Color(.background))
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    SplashVideoView(videoName: colorScheme == .dark ? "logo_dark" : "logo_light")
                        .frame(width: 300, height: 300)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
