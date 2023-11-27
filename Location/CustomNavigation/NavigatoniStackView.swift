

import SwiftUI



public enum NavigationTransition {
   
    case none


    case `default`


    case custom(AnyTransition)

  
    public static var defaultTransitions: (push: AnyTransition, pop: AnyTransition) {
        let pushTrans = AnyTransition.asymmetric(insertion: .move(edge: .trailing),
                                                 removal: .move(edge: .leading))
        let popTrans = AnyTransition.asymmetric(insertion: .move(edge: .leading),
                                                removal: .move(edge: .trailing))
        return (pushTrans, popTrans)
    }
}


public struct NavigationStackView<Root>: View where Root: View {
    @ObservedObject private var navigationStack: NavigationStackCompat
    private let rootView: Root
    private let transitions: (push: AnyTransition, pop: AnyTransition)
    public init(transitionType: NavigationTransition = .default,
                easing: Animation = NavigationStackCompat.defaultEasing,
                @ViewBuilder rootView: () -> Root) {

        self.init(transitionType: transitionType,
                  navigationStack: NavigationStackCompat(easing: easing),
                  rootView: rootView)
    }

    /// Creates a NavigationStackView with the provided NavigationStackCompat.
    /// - Parameters:
    ///   - transitionType: The type of transition to apply between views in every push and pop operation.
    ///   - navigationStack: the shared NavigationStackCompat.
    ///   - rootView: The very first view in the NavigationStack.
    public init(transitionType: NavigationTransition = .default,
                navigationStack: NavigationStackCompat,
                @ViewBuilder rootView: () -> Root) {

        self.rootView = rootView()
        self.navigationStack = navigationStack
        switch transitionType {
        case .none:
            self.transitions = (.identity, .identity)
        case .custom(let trans):
            self.transitions = (trans, trans)
        default:
            self.transitions = NavigationTransition.defaultTransitions
        }
    }

    public var body: some View {
        let showRoot = navigationStack.currentView == nil
        let navigationType = navigationStack.navigationType

        return ZStack {
            Group {
                if showRoot {
                    rootView
                        .transition(navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(navigationStack)
                } else {
                    navigationStack.currentView!.wrappedElement
                        .transition(navigationType == .push ? transitions.push : transitions.pop)
                        .environmentObject(navigationStack)
                }
            }
        }
    }
}
