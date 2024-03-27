import Foundation
import SwiftUI

/// provides two cases for animations based on which the sliding of a screen will be decided
enum TransitionCase {
    case pop
    case push
}


/// `CustomNavigationStack` Is the manager behind the `CustomNavigationView`, provides all logic and methods for navigation
/// - Declared in: CustomNavigationStack.swift
class CustomNavigationStack: ObservableObject {
    
    
    @Published private var stack =  [AnyView]()
    @Published var transition: TransitionCase?
    var names = [String]()
    
    ///add a new view to the hierarchy and adjusts the transition
    /// - Parameters:
    ///   - element: The view itself
    ///   - name: The name that will be dispayed
    func push<Element: View>(element: Element,  name: String) {
        print("working ")
        transition = .push
        names.append(name)
        // withAnimation part is important, because without it the screens won't animate
        withAnimation {
            stack.append(AnyView(element))
        }
        print("working \(stack.count)")
       
    }
    
    ///removes a view from the hierarchy and adjusts the transition
    func pop() {
        transition = .pop
        // withAnimation part is important, because without it the screens won't animate
        withAnimation {
            stack.removeLast()
        }
        names.removeLast()
    }
    
    func count() -> Int {
        return stack.count
    }
    
    func last() -> AnyView {
        return stack.last!
    }
}




