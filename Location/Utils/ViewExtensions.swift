import Foundation
import SwiftUI



extension View {
    
    func placeholder<Content: View>(
         when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content ) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension View {
    
    /// adds shadow dropping from the bottom of a view
    /// - Returns: the view with a shadow
    func bottomShadow() -> some View {
        return self.shadow(color: Color.gray.opacity(0.2), radius: 2, x: 0, y: +6)
    }
    /// adds shadow dropping all around a view
    /// - Returns: the view with a shadow
    func roundShadow() -> some View {
        return self.shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 0)
    }
}



