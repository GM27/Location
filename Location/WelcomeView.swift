
import SwiftUI

struct WelcomeView: View {
    
   @State private var email: String = ""
   @State private var password: String = ""
   @State private var tapped = false
   let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
          if tapped == false  {
              
              ZStack {
                  
                  LinearGradient(
                    gradient: Gradient(colors: [Color.mainAppColor, Color.mainAppColor2]), startPoint: .top,endPoint: .bottom
                  )
                  
                  VStack {
                      
                    
                      Text("Welcome!")
                          .font(.system(size: 30))
                          .bold()
                          .foregroundStyle(Color.almostBlack)
                      
                      
                      CustomTextField(placeholder: "email", text: $email).padding(.bottom, 5).tint(.placeholderColor)
                      
                      CustomTextField(placeholder: "password", text: $password)
                          .tint(.placeholderColor)
                          .padding(.bottom, 10)
                      
                      VStack(spacing: 20) {
                          
                          Button(action: {
                              withAnimation {
                                  tapped = true
                              }
                          }, label: {
                              Buttonlabel(text: "Login")
                          })
                          
                          OrStack
                          
                          Button(action: {}, label: {
                              Buttonlabel(text: "Sign up")
                          })
                      }
                     
                      
                  }
                  .safeAreaPadding()
                  .transition(.move(edge: .leading))

              }.ignoresSafeArea()
               .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        else {
              AllLocations()
              .transition(.move(edge: .trailing))
        }
  
    }
}


extension WelcomeView {
    private var OrStack: some View {
        HStack {
            Rectangle()
                .frame(width: screenWidth / 3, height: 2)
                .foregroundStyle(Color.placeholderColor)
            Text("Or")
                .foregroundStyle(Color.placeholderColor)
                .font(.system(size: 18))
            Rectangle()
                .frame(width: screenWidth / 3, height: 2)
                .foregroundStyle(Color.placeholderColor)
        }
    }
}

struct Buttonlabel: View {
    let text: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 50)
                .foregroundStyle(Color.mainButtonColor)
            Text("\(text)")
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(Color.mainAppColor)
        }
    }
}

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var body: some View {
                ZStack {
                    TextField("", text: $text)
                        .placeholder(when: text.isEmpty) {
                            Text("\(placeholder)").foregroundColor(.placeholderColor)
                         }
                         .padding(.leading, 7)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.placeholderColor, lineWidth: 2)

        }.frame(height: 50)
    }

}



#Preview {
    WelcomeView()
}

