//
//  PinchApp.swift
//  Pinch
//
//  Created by Kyungyun Lee on 11/02/2022.
//

import SwiftUI

@main
struct PinchApp: App {
    
    @StateObject var vm : PageModel = PageModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
