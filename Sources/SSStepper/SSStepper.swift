//
//  SSStepper.swift
//  customStepper
//
//  Created by Shubham Vyas on 29/09/22.
//

import SwiftUI

public struct SSStepper: View {
    @Binding var currentNumber: Int
    let stepperModal: StepperModal

    public init(
        value currentNumber: Binding<Int>,
        stepperModal: StepperModal = StepperModal()
    ) {
        self._currentNumber = currentNumber
        self.stepperModal = stepperModal
    }

    public var body: some View {
        ContentView(
            value: $currentNumber,
            stepperModal: stepperModal
        )
    }
}

