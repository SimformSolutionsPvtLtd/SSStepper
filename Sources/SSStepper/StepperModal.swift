//
//  StepperModal.swift
//  customStepper
//
//  Created by Shubham Vyas on 29/09/22.
//

import Foundation
import SwiftUI

public struct StepperModal {
    /**Overall size of the Stepper. Default is width: 150, height: 50**/
    private(set) var size: CGSize
    /**Maximum number of Stepper. Default is 100**/
    private(set) var maxNumber: Int
    /**Minimum number of Stepper. Default is 100**/
    private(set) var minNumber: Int
    /**Counter number throught with stepper will increase or decrease its value. Default is 1**/
    private(set) var countValue: Int
    /**Inner shape of background shape with Control Button(+,-) and its backgroud color property. Default is Capsule with accent color background**/
    private(set) var innerShape: Shapes
    /**Outer shape of background shape with Text of current number and its backgroud color property. Default is Circle with primary color background**/
    private(set) var outerShape: Shapes
    /**Drection of stepper supported by stepper in which you have two options
     1.) .oneDirection = This will lock vertical scroll during Horizontal scroll or vice versa
     2.) .allDirections = This will not lock any directions you can swipe vertical during active horizontal swipe or vice versa
     Default is .oneDirection**/
    private(set) var direction: Directions
    /**Text color of stepper on the Text in the outer shape. Default is Accent color**/
    private(set) var textColor: Color
    /**Icon color and text color of stepper on the Icos and text in the inner shape. Default is White color**/
    private(set) var iconColor: Color
    /**Axis of stepper which changes whether you want Horizontal stepper or Vertical stepper. Default is horizontal**/
    private(set) var axis: Axis
    /**Feedback style of haptic feedback on value change. Select none for no haptic feedback. Default is .light*/
    private(set) var feedBackStyle: FeedbackStyle
    /**Boolean for whether you want the shadow between both shapes or not. Default is true.**/
    private(set) var showShadow: Bool
    /**Center text when user swipes down to minimize the value**/
    private(set) var minText: String
    /**Center text when user swipes up to maximize the value**/
    private(set) var maxText: String
    /**Boolean for whether you want the Error Shake Animation while minimum or maximum valuet. Default is true.**/
    private(set) var showErrorShakeAnimation: Bool
    /**Boolean to enable or disable Vertical scroll for Minimum and Maximum. Default is true.**/
    private(set) var enableVerticalMinMax: Bool

    public init(
        size: CGSize = CGSize(width: 150, height: 60),
        maxNumber: Int = 100,
        minNumber: Int = 0,
        countValue: Int = 1,
        innerShape: Shapes = .capsule(color: .accentColor.opacity(0.6)),
        outerShape: Shapes = .circle(color: .white),
        direction: Directions = .oneDirection,
        textColor: Color? = nil,
        iconColor: Color? = nil,
        axis: Axis = .horizontal,
        feedBackStyle: FeedbackStyle = .light,
        showShadow: Bool = true,
        minText: String = "MIN",
        maxText: String = "MAX",
        showErrorShakeAnimation: Bool = true,
        enableVerticalMinMax: Bool = true
    ) {
        self.size = size
        self.maxNumber = maxNumber
        self.minNumber = minNumber
        self.countValue = countValue
        self.innerShape = innerShape
        self.outerShape = outerShape
        self.direction = direction
        self.textColor = textColor ?? innerShape.color
        self.iconColor = iconColor ?? outerShape.color
        self.axis = axis
        self.feedBackStyle = feedBackStyle
        self.showShadow = showShadow
        self.minText = minText
        self.maxText = maxText
        self.showErrorShakeAnimation = showErrorShakeAnimation
        self.enableVerticalMinMax = enableVerticalMinMax
    }
}

public enum Shapes {
    case rectangle(color: Color)
    case roundedRectangle(color: Color)
    case circle(color: Color)
    case capsule(color: Color)

    @ViewBuilder
    var shape: some View {
        switch self {
            case .rectangle(let color):
                Rectangle()
                    .fill(color)
            case .roundedRectangle(let color):
                RoundedRectangle(cornerRadius: 15)
                    .fill(color)
            case .circle(let color):
                Circle()
                    .fill(color)
            case .capsule(let color):
                Capsule()
                    .fill(color)
        }
    }

    var color: Color {
        switch self {
            case .rectangle(let color):
                return color
            case .roundedRectangle(let color):
                return color
            case .circle(let color):
                return color
            case .capsule(let color):
                return color
        }
    }
}

public enum Directions {
    case oneDirection, allDirections
}

public enum Axis {
    case horizontal, vertical
}

public enum FeedbackStyle {
    case light
    case medium
    case heavy
    @available(iOS 13.0, *)
    case soft
    @available(iOS 13.0, *)
    case rigid
    case none

    var feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle? {
        switch self {
            case .light:
                return .light
            case .medium:
                return .medium
            case .heavy:
                return .heavy
            case .soft:
                return .soft
            case .rigid:
                return .rigid
            case .none:
                return nil
        }
    }
}
