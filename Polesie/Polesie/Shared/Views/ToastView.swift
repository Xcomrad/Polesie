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
    var message: String
    var type: ToastType
    
    var icon: some View {
        switch type {
        case .success:
            return Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Color.green)
        case .failure:
            return Image(systemName: "xmark.circle.fill")
                .foregroundStyle(Color.red)
            
        }
    }
    
    var backgroundColor: some View {
        switch type {
        case .success:
            return Color.green
                .opacity(Constants.PaddingSizes.p05)
        case .failure:
            return Color.red
                .opacity(Constants.PaddingSizes.p05)
        }
    }
    
    var body: some View {
        HStack {
            icon
                .padding(.leading, Constants.PaddingSizes.p12)
            
            Text(message)
                .font(Constants.BaseFonts.bodyBold)
                .foregroundStyle(Constants.Colors.text)
                .padding(.horizontal, Constants.PaddingSizes.p16)
                .padding(.vertical, Constants.PaddingSizes.p12)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12))
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.PaddingSizes.p12)
                        .stroke(lineWidth: 1.5)
                )
                .padding(.top, Constants.PaddingSizes.p50)
            
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(), value: message)
        }
    }
}

#Preview {
    ToastView(message: "Данные успешно загруженны", type: .success)
    ToastView(message: "Ошибка загрузки данных", type: .failure)
}

