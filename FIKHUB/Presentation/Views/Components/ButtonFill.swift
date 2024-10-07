//
//  ButtonFill.swift
//  FIKHUB
//
//  Created by Rangga Biner on 06/10/24.
//

import SwiftUI

struct ButtonFill: View {
    let title: String
    let action: () -> Void
    let backgroundColor: Color
    let foregroundColor: Color
    let height: CGFloat
    let cornerRadius: CGFloat
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    
    init(
        title: String,
        action: @escaping () -> Void,
        backgroundColor: Color = .orange,
        foregroundColor: Color = .white,
        height: CGFloat = 50,
        cornerRadius: CGFloat = 12,
        fontSize: CGFloat = 17,
        fontWeight: Font.Weight = .regular
    ) {
        self.title = title
        self.action = action
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.height = height
        self.cornerRadius = cornerRadius
        self.fontSize = fontSize
        self.fontWeight = fontWeight
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: height)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                .foregroundColor(foregroundColor)
                .font(.system(size: fontSize, weight: fontWeight))
        }
    }
}
