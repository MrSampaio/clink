//
//  GradientColors.swift
//  Clink
//
//  Created by Vitor Silva Souza on 23/07/26.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    
    static var brownDarkGradient: LinearGradient {
        LinearGradient(
            colors: [.brown, Color(red: 111 / 255, green: 55 / 255, blue: 0 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var indigoGradient: LinearGradient {
        LinearGradient(
            colors: [.indigo, Color(red: 86 / 255, green: 74 / 255, blue: 222 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var purpleGradient: LinearGradient {
        LinearGradient(
            colors: [.purple, Color(red: 176 / 255, green: 47 / 255, blue: 194 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var brownGradient: LinearGradient {
        LinearGradient(
            colors: [.brown, Color(red: 149 / 255, green: 109 / 255, blue: 81 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var blueGradient: LinearGradient {
        LinearGradient(
            colors: [.blue, Color(red: 30 / 255, green: 110 / 255, blue: 244 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var pinkGradient: LinearGradient {
        LinearGradient(
            colors: [.pink, Color(red: 231 / 255, green: 18 / 255, blue: 77 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var greenGradient: LinearGradient {
        LinearGradient(
            colors: [.green, Color(red: 0 / 255, green: 137 / 255, blue: 50 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var redGradient: LinearGradient {
        LinearGradient(
            colors: [.red, Color(red: 233 / 255, green: 21 / 255, blue: 45 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var orangeGradient: LinearGradient {
        LinearGradient(
            colors: [.orange, Color(red: 197 / 255, green: 83 / 255, blue: 0 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
    
    static var mintGradient: LinearGradient {
        LinearGradient(
            colors: [.mint, Color(red: 0 / 255, green: 133 / 255, blue: 177 / 255)],
            startPoint: .top,
            endPoint: .bottom)
    }
}

extension View {
    private func gradient(for color: Color) -> LinearGradient {
        
        let baseColors: [Color] = [
            .listColor9,
            .listColor2,
            .listColor3,
            .listColor10,
            .listColor1,
            .listColor5,
            .listColor4,
            .listColor6,
            .listColor7,
            .listColor8
        ]
        
        let palette: [LinearGradient] = [
            .pinkGradient,
            .redGradient,
            .orangeGradient,
            .brownGradient,
            .brownDarkGradient,
            .greenGradient,
            .mintGradient,
            .blueGradient,
            .indigoGradient,
            .purpleGradient
        ]
        
        if let index = baseColors.firstIndex(of: color) {
            return palette[index % palette.count]
        }
        
        if color == .blue {
            return .blueGradient
        }
        
        return LinearGradient(
            colors: [color, color.opacity(0.5)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
