//
//  ContentView.swift
//  SSStepper
//
//  Created by Shubham Vyas on 09/09/22.
//

import SwiftUI

// MARK: - Variables
struct ContentView {
    @Binding var currentNumber: Int
    @State private var offsetValX: CGFloat = 0
    @State private var offsetValY: CGFloat = 0
    @State private var verticalScrollLock = false
    @State private var horizontalScrollLock = false
    @State private var isAllDirection: Bool
    @State private var occured = false
    @State private var errorOffset: CGFloat = 0
    private let animationDuration: Double = 0.1
    private let axisAngle: Double = 90
    private let zero: Double = 0
    let model: StepperModal
}

// MARK: - initializers
extension ContentView {
    init(
        value currentNumber: Binding<Int>,
        stepperModal: StepperModal = StepperModal()
    ) {
        self._currentNumber = currentNumber
        self.model = stepperModal
        self.isAllDirection = stepperModal.direction == .allDirections
    }
}

// MARK: - Computed Properties
extension ContentView {
    /**Contains width of Stepper**/
    private var width: CGFloat {
        model.size.width
    }

    /**Contains height of Stepper**/
    private var height: CGFloat {
        model.size.height
    }

    /**Contains point on which OuterView should not cross while Dragging Vertically*/
    private var maxVerticalPoint: CGFloat {
        height / 2
    }

    /**Contains point on which OuterView should not cross while Dragging Horizontally*/
    private var maxHorizontalPoint: CGFloat {
        (width / 2) - (outerShapeSize.width/2) - 10
    }

    /**Shape of innerView with its background color*/
    private var innerShape: some View {
        model.innerShape.shape
    }

    /**Shape of outerView with its background color*/
    private var outerShape: some View {
        model.outerShape.shape
    }

    private var isCapsule: Bool {
        "\(model.outerShape)".contains("capsule")
    }

    /**Contains size of outerView**/
    private var outerShapeSize: CGSize {
        CGSize(width: isCapsule ? width/2.5 : height - 10, height: height - 10)
    }

    /**Contains size of innerView**/
    private var innerShapeSize: CGSize {
        CGSize(width: width, height: height)
    }

    /**Contains if Stepper is vertical or not**/
    private var isVertical: Bool {
        model.axis == .vertical
    }

    /**Contains size of icons**/
    private var iconSize: CGFloat {
        height / 3
    }

    /**Contains offset of Text appears during vertical swipes**/
    private var centerTextOffset : CGFloat {
        if offsetValY > .zero {
            return -maxVerticalPoint / 2
        } else if offsetValY <  .zero {
            return maxVerticalPoint / 2
        } else {
            return .zero
        }
    }

    /**Contains text of Text appears during vertical swipes**/
    private var centerText : String {
        if offsetValY < 0 {
            return model.maxText
        } else if offsetValY > 0 {
            return model.minText
        } else {
            return ""
        }
    }
}

// MARK: - User Defined Functions
extension ContentView {
    /**Checks if current value is minimum or not**/
    private func isMin() -> Bool {
        return currentNumber == model.minNumber
    }

    /**Checks if current value is maximum or not**/
    private func isMax() -> Bool {
        return currentNumber == model.maxNumber
    }

    /**Decreses the value by count after checking for minimum value **/
    private func decrease() {
        if !isMin() {
            currentNumber -= model.countValue
        }
    }

    /**Increases the value by count after checking for maximum value **/
    private func increase() {
        if !isMax() {
            currentNumber += model.countValue
        }
    }

    /**Returns icons of Add and Subtract as per image name*/
    private func icon(systemName: String) -> some View {
        return Image(systemName: systemName)
            .font(.system(size: iconSize))
            .foregroundColor(model.iconColor)
            .frame(width: iconSize * 2)
            .frame(maxHeight: .infinity)
            .contentShape(Rectangle())
            .frame(width: iconSize, height: iconSize)
    }

    /**Calls during OnChanged callback of DragGesture inside outerView*/
    private func onDragChanged(value: DragGesture.Value) {
        let xDist =  abs(value.location.x - value.startLocation.x)
        let yDist =  abs(value.location.y - value.startLocation.y)
        errorOffset = 0

        /**Executes when use Swipes Down*/
        if value.startLocation.y <  value.location.y &&
            yDist > xDist &&
            !verticalScrollLock &&
            !isMin()
        {
            withAnimation(.linear(duration: animationDuration)) {
                let diffrence = value.location.y - value.startLocation.y
                offsetValX = .zero
                offsetValY = diffrence > maxVerticalPoint ? maxVerticalPoint : diffrence
            }
            if !isAllDirection {
                horizontalScrollLock = true
                verticalScrollLock = false
            }
            return
        }

        /**Executes when use Swipes Up*/
        if value.startLocation.y >  value.location.y &&
            yDist > xDist &&
            !verticalScrollLock &&
            !isMax()
        {
            withAnimation(.linear(duration: animationDuration)) {
                let diffrence = value.location.y - value.startLocation.y
                offsetValX = .zero
                offsetValY = abs(diffrence) > maxVerticalPoint ? -maxVerticalPoint : diffrence
            }
            if !isAllDirection {
                horizontalScrollLock = true
                verticalScrollLock = false
            }
            return
        }

        /**Executes when use Swipes Left*/
        if value.startLocation.x > value.location.x &&
            yDist < xDist &&
            !horizontalScrollLock &&
            !isMin()
        {
            withAnimation(.linear(duration: animationDuration)) {
                let diffrence = value.location.x - value.startLocation.x
                offsetValY = .zero
                offsetValX = abs(diffrence) > maxHorizontalPoint ? -maxHorizontalPoint : diffrence
            }
            if !isAllDirection {
                horizontalScrollLock = false
                verticalScrollLock = true
            }
            return
        }

        /**Executes when use Swipes Right*/
        if value.startLocation.x < value.location.x &&
            yDist < xDist &&
            !horizontalScrollLock &&
            !isMax()
        {
            withAnimation(.linear(duration: animationDuration)) {
                let diffrence = value.location.x - value.startLocation.x
                offsetValY = .zero
                offsetValX = abs(diffrence) > maxHorizontalPoint ? maxHorizontalPoint : diffrence
            }
            if !isAllDirection {
                horizontalScrollLock = false
                verticalScrollLock = true
            }
            return
        }

        if !occured && model.showErrorShakeAnimation {
            withAnimation(.linear(duration: animationDuration).repeatCount(3)) {
                errorOffset = 10
                errorOffset = .zero
                errorOffset = -10
            }
            occured = true
        }
    }

    /**Calls during OnEnded callback of DragGesture inside outerView*/
    private func onDragEnded() {
        withAnimation {
            if(offsetValX > .zero) {
                increase()
                hapticFeedback()
            } else if(offsetValX < .zero) {
                decrease()
                hapticFeedback()
            } else if(offsetValY < .zero && !isMax()) {
                currentNumber = model.maxNumber
                hapticFeedback()
            } else if(offsetValY > .zero && !isMin()) {
                currentNumber = model.minNumber
                hapticFeedback()
            }
            offsetValY = .zero
            offsetValX = .zero
            occured = false
            errorOffset = .zero
        }

        if !isAllDirection {
            horizontalScrollLock = false
            verticalScrollLock = false
        }
    }

    /**Produces an haptic Feedback*/
    private func hapticFeedback() {
        if let feedbackStyle = model.feedBackStyle.feedbackStyle {
            let impactMed = UIImpactFeedbackGenerator(style: feedbackStyle)
            impactMed.impactOccurred()
        }
    }
}

// MARK: - Body
extension ContentView: View {
    var body: some View {
        ZStack {
            innerView
            outerView
        }
        .offset(x: isVertical ? height - 20 : 0)
        .rotationEffect(.init(degrees: isVertical ? axisAngle : 0))
        .frame(
            width: width,
            height: height,
            alignment: .center
        )
    }
}

// MARK: - SubViews
extension ContentView {
    /**InnerView for background view of stepper with Buttons (+,-)**/
    private var innerView: some View {
        HStack {
            icon(systemName: "minus")
                .opacity(isMin() ? 0.5 : 1)
                .animation(.linear)
                .onTapGesture {
                    decrease()
                }
                .rotationEffect(.init(degrees: isVertical ? -axisAngle : 0))
            Spacer()
            Text(centerText)
                .font(.system(size: min(height, 14), weight: .black))
                .foregroundColor(model.iconColor)
                .opacity(offsetValY != .zero ? 1 : .zero)
                .rotationEffect(.init(degrees: isVertical ? -axisAngle : 0))
                .offset(y: centerTextOffset)
                .animation(.default, value: centerTextOffset)
            Spacer()
            icon(systemName: "plus")
                .opacity(isMax() ? 0.5 : 1)
                .animation(.linear)
                .onTapGesture {
                    increase()
                }
                .rotationEffect(.init(degrees: isVertical ? -axisAngle : 0))
        }
        .padding(.horizontal, 12)
        .frame(
            width: innerShapeSize.width,
            height: innerShapeSize.height,
            alignment: .leading
        )
        .background(innerShape)
    }

    /**OuterView for value and view with swipe gestures**/
    private var outerView: some View {
        VStack {
            Text("\(currentNumber)")
                .font(.system(size: height > 20 ? 20 : height))
                .foregroundColor(model.textColor)
                .rotationEffect(.init(degrees: isVertical ? -axisAngle : 0))
                .offset(x: model.showErrorShakeAnimation ? errorOffset : 0)
        }
        .frame(width: outerShapeSize.width, height: outerShapeSize.height)
        .background(
            outerShape
                .shadow(color: .black.opacity(0.7), radius: model.showShadow ? 4.5 : 0)
        )
        .offset(
            x: offsetValX,
            y: offsetValY
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    onDragChanged(value: value)
                }
                .onEnded { _ in
                    onDragEnded()
                }
        )
    }
}


