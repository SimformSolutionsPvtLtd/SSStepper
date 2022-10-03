//
//  ViewController.swift
//  SSStepper_Example
//
//  Created by Shubham Vyas on 30/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import SwiftUI
import SSStepper

struct MainView {
    @State private var defaultNumber: Int = 0
    @State private var firstCustomisedNumber: Int = 0
    @State private var secondCustomisedNumber: Int = 0
    @State private var thirdCustomisedNumber: Int = 0
    @State private var forthCustomisedNumber: Int = 0
}

extension MainView : View {
    var body: some View {
        ZStack {
                Color.white
                    .ignoresSafeArea()

                VStack(spacing: 10) {
                    Text("Default SSStepper")
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    SSStepper(
                        value: $defaultNumber
                    )

                    Text("Customised SSStepper 1\n(With different shapes and size)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    SSStepper(
                        value: $firstCustomisedNumber,
                        stepperModal: StepperModal(
                            size: .init(width: 200, height: 60),
                            innerShape: .rectangle(color: .yellow),
                            outerShape: .roundedRectangle(color: .red)
                        )
                    )

                    Text("Customised SSStepper 2\n(With unlocked feature)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    SSStepper(
                        value: $secondCustomisedNumber,
                        stepperModal: StepperModal(
                            direction: .allDirections
                        )
                    )

                    Text("Customised SSStepper \n(With different Count value of 5)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    SSStepper(
                        value: $thirdCustomisedNumber,
                        stepperModal: StepperModal(
                            countValue: 5
                        )
                    )

                    Text("Customised SSStepper \n(With different axis)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    SSStepper(
                        value: $forthCustomisedNumber,
                        stepperModal: StepperModal(
                            axis: .vertical
                        )
                    )
                }
            }
    }
}

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: MainView())
        addChild(childView)
        childView.view.frame = CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height
        )
        view.addSubview(childView.view)
        childView.didMove(toParent: self)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
