//
//  MainView.swift
//  Location
//
//  Created by Jeremy Merezhko on 11/26/23.
//

import SwiftUI
import MapKit

struct AddLocationView: View {
    var body: some View {
        
        VStack {
            Map {
                
            }.ignoresSafeArea().frame(height: 500)
            Spacer()
        }
    }
}

#Preview {
    AddLocationView()
}
