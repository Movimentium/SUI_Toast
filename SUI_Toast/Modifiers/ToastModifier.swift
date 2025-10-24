//  ToastModifier.swift
//  SUI_Toast
//  Created by Miguel Gallego on 25/10/25.
import SwiftUI
 
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
