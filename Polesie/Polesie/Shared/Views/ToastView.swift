//
//  ToastView.swift
//  Polesie
//
//  Created by Владислав Бут-Гусаим on 17.04.25.
//

import SwiftUI

enum ToastType {
    case success
    case failure
}

struct ToastView: View {
    @Binding var isShowing: Bool
    
    var message: String
    var type: ToastType
    
    var icon: some View {
        switch type {
        case .success:
            return Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Constants.Colors.darkGreen)
        case .failure:
            return Image(systemName: "xmark.circle.fill")
                .foregroundStyle(Constants.Colors.earthyBrown)
            
        }
    }
    
    var backgroundColor: Color {
        switch type {
        case .success:
            return Constants.Colors.darkGreen
                .opacity(Constants.PaddingSizes.p05)
        case .failure:
            return Constants.Colors.earthyBrown
                .opacity(Constants.PaddingSizes.p05)
        }
    }
    
    var borderColor: Color {
        switch type {
        case .success: return Constants.Colors.darkGreen
        case .failure: return Constants.Colors.earthyBrown
        }
    }
    
    var body: some View {
        if isShowing {
            HStack {
                icon
                    .padding(.bottom, Constants.PaddingSizes.p50)
                
                Text(message)
                    .font(Constants.BaseFonts.bodyBold)
                    .foregroundStyle(Constants.Colors.text)
                    .padding(.horizontal, Constants.PaddingSizes.p16)
                    .padding(.vertical, Constants.PaddingSizes.p12)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                            .stroke(borderColor, lineWidth: 1.5)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                isShowing = false
                            }
                        }
                    }
            }
            .padding(.bottom, UIScreen.main.bounds.height * 0.7)
            .transition(.move(edge: .top).combined(with: .opacity))
            .animation(.spring, value: isShowing)
            .zIndex(1)
        }
    }
}
