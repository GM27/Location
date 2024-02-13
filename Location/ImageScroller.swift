//
//  ImageScroller.swift
//  Location
//
//  Created by Jeremy Merezhko on 11/28/23.
//

import SwiftUI
import PhotosUI

struct ImageScroller: View {
    @State var images: [UIImage] = []
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        
        VStack {
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images, id:\.cgImage){ image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                    }
                }
            }
            Spacer()
            PhotosPicker(selection: $selectedItems, maxSelectionCount: 5,
                         matching: .images) {
                Text("Pick Photo")
            }
             .onChange(of: selectedItems, perform: { selectedItems in
                        
                             for item in selectedItems {
                                 item.loadTransferable(type: Data.self) { result in
                                     switch result {
                                     case .success(let imageData):
                                         if let imageData {
                                             self.images.append(UIImage(data: imageData)!)
                                         } else {
                                             print("No supported content type found.")
                                         }
                                     case .failure(let error):
                                         print(error)
                                     }
                                 }
                             }
                 self.selectedItems.removeAll()
                         })
                       
                         
        }
    }

}

#Preview {
    ImageScroller()
}
