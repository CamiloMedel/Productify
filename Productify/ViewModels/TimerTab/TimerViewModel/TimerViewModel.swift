//
//  TimerViewModel.swift
//  Productify
//
//  Created by Camilo Medel on 2/10/26.
//

import Combine

class TimerViewModel: ObservableObject {
    @Published var displayTime: String = "0:00"
   
    init() {}
    
}
