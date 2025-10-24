//  ContentView.swift
//  SUI_Toast
//  Created by Miguel Gallego on 22/10/25.
import SwiftUI

struct ContentView: View {
    @State private var showToast = false
    let toastMsg = "File saved successfully"
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button("Show success toast") {
                showToast = true
            }
            .buttonStyle(.borderedProminent)
            
        }
        .padding()
        
        .toast(isPresented: $showToast) {
            ToastView(msg: toastMsg)
        }
    }
}

#Preview {
    ContentView()
}
