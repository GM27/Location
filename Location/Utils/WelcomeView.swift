
import SwiftUI

struct WelcomeView: View {
    
   @State private var email: String = ""
   @State private var password: String = ""
  
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        
        NavigationStackView {
           Spacer()
            VStack {
                
                Text("Welcome!")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundStyle(Color.almostBlack)
                
                CustomTextField(placeholder: "your email", text: $email).padding(.bottom, 5).tint(.placeholderColor)
                
                CustomTextField(placeholder: "your password", text: $password)
                .tint(.placeholderColor)
                .padding(.bottom, 10)
                
                VStack(spacing: 20) {
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Buttonlabel(text: "Login")
                    })
                    
                    orStack
                   
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Buttonlabel(text: "Sign up")
                    })
                }
            }.padding(.horizontal, 20)
            
            Spacer()
            
        } 
        .background {
          
            LinearGradient(gradient: Gradient(colors: [Color.mainAppColor, Color.mainAppColor2]) , startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        }
       
    }
}


extension WelcomeView {
    private var orStack: some View {
        HStack {
            Rectangle().frame(width: screenWidth / 3, height: 2).foregroundStyle(Color.placeholderColor)
            Text("Or").foregroundStyle(Color.placeholderColor).font(.system(size: 18))
            Rectangle().frame(width: screenWidth / 3, height: 2).foregroundStyle(Color.placeholderColor)
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
            Text("\(text)").font(.system(size: 20)).bold()
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

