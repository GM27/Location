import SwiftUI

///Is the wrapper around the first view in the navigation hierarchy, it provides the direct access to the navigation stack and it's methods
/// - stack:  is the manager behind the `CustomNavigationView`, provides all logic and methods for navigation
/// - Declared in: CustomNavigationView.swift
struct CustomNavigationView<RootView: View>: View {
  // first we create a stack, and in init, populate it with the first view (the one the CustomNavigationView is wrapped around)
    @ObservedObject var stack = CustomNavigationStack()
    
   // @Environment
    //this is just a reference of a first view
    private let rootView: RootView
    
    /// Creates a CustomNavigationView.
    /// - Parameters:
    ///   - named: The name of the screen that will be displayed
    ///   - rootView: the first view in the hierarchy
    init(named: String, @ViewBuilder rootView: () -> RootView) {
        print("initin")
        self.rootView = rootView()
        stack.push(element: self.rootView, name: named)
    }
    
    // MARK: body
    var body: some View {
        
        VStack(spacing: 0) {
            // the HStack will be hovering over the view a bit
            HStack {
                backButton
                Spacer()
                screenTitle
                Spacer()
                settingsButton
            }
            .frame(width: UIScreen.main.bounds.width, height: 80)
            .background(Color.mainAppColor2)
            .offset(y: 20)
            .bottomShadow()
            .padding(.bottom, 20)
            .zIndex(1.0)
            // if true i needed for the transition to work.
            // after the pop() or push() or any other action the stack would change and since .last() depends on the stack swiftUI will trigger this function
            // after the pop() or push() transition property would also be modified so swiftUI will use the appropriate transition
            
            if true {
                
                stack.last()
                    .transition(stack.transition == .pop
                                ? .asymmetric(insertion: .move(edge: .leading),removal: .move(edge: .trailing))
                                : .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    )
                    .environmentObject(stack)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.ignoresSafeArea()
        
        }
    
    // MARK: Subviews
    private var backButton: some View {
        Image("left_arrow.png").resizable().scaledToFit().frame(width: 25)
            .onTapGesture {
                stack.pop()
            }
            .opacity(stack.count() > 1 ? 1.0 : 0.0)
            .padding(.top, 20)
            .padding(.leading, 15)
    }
    
    private var screenTitle: some View {
        Text("\(stack.names.last!)").padding(.top, 20).font(.system(size: 20))
    }
    
    private var settingsButton: some View {
        Image("settings.png").resizable().scaledToFit().frame(width: 25)
            .opacity(stack.names.last! == "Settings" ? 0 : 1.0)
          .onTapGesture {
                   UIApplication.shared.endEditing()
              stack.push(element: SettingsView(), name: "Settings")
        
        }.padding(.top, 20)
         .padding(.trailing, 15)
    }
    
}


#Preview {
    CustomNavigationView(named: "hello", rootView: {Text("Hello")})
}
