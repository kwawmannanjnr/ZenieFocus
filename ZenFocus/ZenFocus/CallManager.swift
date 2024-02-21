//
//  CallManager.swift
//  ZenFocus
//
//  Created by Kwaw Annan on 2/20/24.
//

import Foundation
import Combine

//n observable object that will hold the call state information and can be observed by your SwiftUI views.
class CallManager: ObservableObject {
    @Published var isCallActive: Bool = false
    
    static let shared = CallManager()
}
