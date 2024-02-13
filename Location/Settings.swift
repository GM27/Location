//
//  Settings.swift
//  Location
//
//  Created by Jeremy Merezhko on 11/28/23.
//

import SwiftUI
import PhotosUI

 struct SettingsView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image? = Image("user")
    @State private var darkModeOn = false
    @State private var adress: CGFloat = 80
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.mainAppColor, Color.mainAppColor2]), startPoint: .top,endPoint: .bottom)
            
            VStack {
                ScrollView {
                    VStack {
                        profileImage.padding(.top, 20)
                        Text("William Shakespeare").font(.system(size: 25)).bold()
                        Text(verbatim: "willy.spear@gmail.com")
                        
                        Section(image: "user-2", label: "Account") {
                            Item(label: "Edit profile")
                            Item(label: "Change password")
                            Item(label: "Cloud Sync")
                        }.padding(.bottom, 10)
                        Section(image: "preferences", label: "preferences") {
                            
                            HStack {
                                Text("Language")
                                Spacer()
                                Text("English")
                                Image("right_arrow").resizable().scaledToFit().frame(width: 15).padding(.trailing, 10)
                            }
                            HStack {
                                Text("Dark Mode")
                                Spacer()
                             }
                        }
                        
      
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
         .ignoresSafeArea(.all)
      
    }
}


struct Section<Content: View>: View {
    
    let content: Content
    let image: String
    let label: String
    init(image: String, label: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.label = label
        self.image = image
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image("\(image)").resizable().scaledToFit().frame(width: 20)
                Text("\(label)").font(.system(size: 17)).bold()
                Spacer()
            }.padding(.vertical, 5)
                .padding(.leading, 10)
            .background(
                Color.mainAppColor2
            )
            .frame(height: 40)

            content.padding(.leading, 15)
            
            
        }
    }
}

struct Item: View {
    let label: String
    var body: some View {
        HStack {
            Text("\(label)")
            Spacer()
            Image("right-arrow").resizable().scaledToFit().frame(width: 15).padding(.trailing, 10)
        }
    }
}


extension SettingsView {
    private var profileImage: some View {
        
                       ZStack {
                    if let avatarImage {
                        avatarImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: adress, height: adress)
                            .clipShape(Circle())
                            .onTapGesture {
                                withAnimation {
                                    if adress == 80 {
                                        adress = 200
                                    } else {
                                        adress = 80
                                    }
                                }
                            }
                            .background {
                              
                            }
                    } else {
                        
                    }
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    PhotosPicker("     ", selection: $avatarItem, matching: .images)
                        .frame(width: 40, height: 40)
                        .background {
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Color.mainAppColor2.clipShape(Circle()).frame(width: 28, height: 28)
                           
                            .overlay {
                                    
                                    Image("pen").resizable(
                                    )
                                    .frame(width: 15, height: 15)
                             }
                            }
                        }
                    }
                }
            }
        }.frame(width: adress)
            .onChange(of: avatarItem, {
                Task {
                    if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            avatarImage = Image(uiImage: uiImage)
                            return
                        }
                    }
                }
            })
    }
    
}



struct Settings_Previews: PreviewProvider {
 
    static var previews: some View {
        CustomNavigationView(named: "some name,") {
            SettingsView()
        }
     
    }
}
