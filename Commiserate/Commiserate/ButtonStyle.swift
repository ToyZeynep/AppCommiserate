//
//  ButtonStyle.swift
//  Commiserate
//
//  Created by Zeynep Toy on 23.03.2024.
//

import SwiftUI

public struct CABorderedButtonStyle: ButtonStyle {
    var borderColor: Color
    var textColor: Color
    var textSize: CGFloat
    var borderWidth: CGFloat
    var backgroundColor: Color
    var height: CGFloat
    var radius: CGFloat

    public init(
        borderColor: Color = .gray,
        textColor: Color = .white,
        textSize: CGFloat = 14,
        borderWidth: CGFloat = 1,
        backgroundColor: Color = .blue,
        height: CGFloat = 50,
        radius: CGFloat = 4
    ) {
        self.borderColor = borderColor
        self.textColor = textColor
        self.textSize = textSize
        self.borderWidth = borderWidth
        self.backgroundColor = backgroundColor
        self.height = height
        self.radius = radius
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .foregroundStyle(textColor)
        .background {
            RoundedRectangle(cornerRadius: radius)
                .stroke(borderColor, lineWidth: borderWidth)
                .background(RoundedRectangle(cornerRadius: 0).fill(backgroundColor))
        }
        .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

public struct NoBackgroundColorStyle: ButtonStyle {
    var fontSize: CGFloat
    var color: Color
    var weight: Font.Weight
    public init(fontSize: CGFloat = 20 , color: Color = .black , weight: Font.Weight = .regular) {
        self.fontSize = fontSize
        self.color = color
        self.weight = weight
    }
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: fontSize, weight: weight))
            .foregroundColor(color)
    }
}

#Preview {
    Button(action: {}, label: {
        Text("BorderedButtonStyle")
    })
    .buttonStyle(CABorderedButtonStyle())
    .padding(.horizontal)
}
