//
//  ContentView.swift
//  Todolist
//
//  Created by JIN LI on 10/21/20.
//  Copyright © 2020 Test. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: {
                
            }){
                Text("button")
                .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
            }.cornerRadius(10)
            .shadow(radius: 10)
            
            
            
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
