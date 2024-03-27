import SwiftUI


struct AllLocations: View {
    
   
    var body: some View {
       
       CustomNavigationView(named: "Locations") {
           AlLLocationsView()
        }

    }
}



struct AlLLocationsView: View {
    @EnvironmentObject var navigationStack: CustomNavigationStack
    @FocusState var isNameFocused: Bool
    @State  private var search = ""
    @State private var offsetEdit: CGFloat = 0
    @State private var offsetAdd: CGFloat = 0
    @State private var xOffsetSearch: CGFloat = 0
    @State private var isInternalRequest: Bool = true
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        VStack {
            
            GeometryReader { proxy in
                
                HStack {
                    
                    
                    Image("search").resizable().scaledToFit().frame(width: 20).padding(.leading, 10)
                    
                    TextField("location name", text: $search).padding(.trailing, 20)
                        .focused($isNameFocused)
                        .tint(Color.placeholderColor)
                        .padding(.trailing, 10)
                        .onChange(of: isNameFocused, {
                                if isNameFocused == true {
                                    withAnimation {
                                        offsetEdit = screenWidth / 6
                                        withAnimation {
                                            offsetAdd = screenWidth / 2
                                        }
                                        xOffsetSearch = screenWidth / 7.07
                                    }
                            } else {
                                withAnimation(.easeOut) {
                                        offsetEdit = 0
                                        offsetAdd = 0
                                        xOffsetSearch = 0
                                    }
                            }
                        })
                        .onSubmit {
                            isNameFocused = false
                        }
                        .onDisappear {
                            isNameFocused = false
                        }
                    
                }
                .frame(width: screenWidth * 0.65 + (offsetAdd / 4) , height: 40)
                
                
                .background {
                    RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.gray.opacity(0.25))
                }.frame(maxWidth: .infinity)
                
                    .padding(.leading, 10)
                    .position(x: screenWidth / 3 + (xOffsetSearch / 2.5) , y: 30)
                
                
                
                Group {
                    Button(action: {
                        isNameFocused = false
                    }, label: {
                        Text("Search").foregroundStyle(Color.black).bold()
                        
                    })
                    
                    .frame(width: 70, height: 40)
                    .background {
                        RoundedRectangle(cornerRadius:
                                            10).foregroundStyle(Color.gray.opacity(0.25))
                    }
                }.opacity(offsetAdd == 0  ? 0.0 : 1.0)
                    .position(x: screenWidth / 1.12, y: 30)
                
                
                
                Image("delete").resizable()
                
                    .scaledToFit()
                    .frame(width: 20)
                    .position(x: screenWidth / 1.33, y: 30)
                    .opacity(offsetAdd == 0  ? 0.0 : 1.0)
                    .onTapGesture {
                        search = ""
                    }
                
                
                
                Group {
                    Button(action: {
                        navigationStack.push(element: AddLocationView(), name: "Add New Location")
                    }, label: {
                        Image("plus").resizable().scaledToFit().frame(width: 20)
                        
                    })
                    
                    .frame(width: 50, height: 40)
                    .background {
                        RoundedRectangle(cornerRadius:
                                            10).foregroundStyle(Color.gray.opacity(0.25))
                    }
                }.position(x: screenWidth / 1.33  + offsetAdd, y: 30)
                
                
                Group {
                    Button(action: {}, label: {
                        Text("Edit").foregroundStyle(Color.editButtonColor).bold()
                    })
                    
                    .frame(width: 60, height: 40)
                    
                    .background {
                        RoundedRectangle(cornerRadius: 10).foregroundStyle(Color.gray.opacity(0.25))
                    }
                    
                }.position(x: screenWidth / 1.1 + offsetEdit, y: 30)
                
                
            }
            Spacer()
            
        }.background {
            Color.mainAppColor
        }
        
        
    }
    
}
struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        AllLocations()
    }
}
