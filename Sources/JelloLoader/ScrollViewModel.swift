//
//  ScrollViewModel.swift
//  
//
//  Created by Amit Vaidya on 11/06/2023.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
class ScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    // MARK: Properties
    @Published var isEligible: Bool = false
    @Published var isRefreshing: Bool = false
    // MARK: Offsets and Progress
    @Published var scrollOffset: CGFloat = 0
    @Published var contentOffset: CGFloat = 0
    @Published var progress: CGFloat = 0
    private let gestureID = UUID().uuidString
    
    // MARK: Since We need to Know when the user Left the Screen to Start Refresh
    // Adding Pan Gesture To UI Main Application Window
    // with Simultaneous Gesture Desture
    // Thus it Wont disturb SwiftUI Scroll's And Gesture's
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: Adding gesture
    func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange(gesture:)))
        panGesture.delegate = self
        panGesture.name = gestureID
        rootController().view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Finding Root Controller
    func rootController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        guard let root = screen.windows.first?.rootViewController else { return .init() }
        return root
    }
    
    @objc
    func onGestureChange(gesture: UIPanGestureRecognizer) {
        if gesture.state == .cancelled || gesture.state == .ended {
            // MARK: Your Max Duration Goes Here
            if scrollOffset > 150 {
                isEligible = true
            } else {
                isEligible = false
            }
        }
    }
    
    // MARK: Removing When Leaving The View
    func removeGesture() {
        rootController().view.gestureRecognizers?.removeAll(where: { gesture in
            gesture.name == gestureID
        })
    }
}
