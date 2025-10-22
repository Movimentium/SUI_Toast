//  ToastView.swift
//  SUI_Toast
//  Created by Miguel Gallego on 22/10/25.
import SwiftUI

struct ToastView: View {
    let msg: String
    
    let borderColor = Color(red: 0.14, green: 0.75, blue: 0.18)
    let bgColor = Color(red: 0.87, green: 1, blue: 0.91)
    let shadowColor = Color(red: 0.33, green: 0.33, blue: 0.33)

    var body: some View {
        Text(msg)
            .padding(20)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: shadowColor, radius: 8, x: 0, y: 4)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 8)
            }
    }
}

#Preview {
    ToastView(msg: "File saved successfully")
}

struct ToastModifier<ToastContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let theToast: ToastContent
    
    func body(content: Content) -> some View {
        ZStack {
            content // Principal View where toast is presented
            
            if isPresented {
                VStack {
                    Spacer()
                    theToast
                }
                .padding()
//                .transition(.opacity.combined(with: .move(edge: .bottom)))
                .transition(.move(edge: .bottom))
                .onAppear {
                    // Disappear after 2 secs
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

extension View {
    func toast<TheToastContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder TheToastContent: () -> TheToastContent) -> some View
    {
        modifier(ToastModifier(isPresented: isPresented, theToast: TheToastContent()))
    }
}
