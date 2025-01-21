//
//  Ring.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import SwiftUI

/// A custom shape representing a progress ring.
/// Used to visually indicate the progress of a loading operation.
struct Ring: Shape {
    var fillPoint: Double // Represents the progress percentage (0.0 to 1.0).
    var delayPoint: Double = 0.5 // Threshold to delay the ring's animation.

    var animatableData: Double {
        get { return fillPoint }
        set { fillPoint = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var start: Double
        let end = 360 * fillPoint // End angle based on progress.
        
        if fillPoint > delayPoint {
            start = (2 * fillPoint) * 360 // Start animation after delay.
        } else {
            start = 0
        }
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.size.width / 2, y: rect.size.height / 2),
            radius: rect.size.width / 2,
            startAngle: .degrees(start),
            endAngle: .degrees(end),
            clockwise: false
        )
        return path
    }
}
