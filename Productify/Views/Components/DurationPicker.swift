//
//  DurationPicker.swift
//  Productify
//
//  Created by Camilo Medel on 2/16/26.
//

import SwiftUI

/// 3 Field Picker View allowing user to select a set hour, minute, and seconds duration
struct DurationPicker: UIViewRepresentable {
    
    @Binding var hours: Int
    @Binding var minutes: Int
    @Binding var seconds: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        uiView.selectRow(hours, inComponent: 0, animated: false)
        uiView.selectRow(minutes, inComponent: 1, animated: false)
        uiView.selectRow(seconds, inComponent: 2, animated: false)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        var parent: DurationPicker
        
        init(_ parent: DurationPicker) {
            self.parent = parent
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            3
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            switch component {
            case 0: return 24
            case 1: return 60
            case 2: return 60
            default: return 0
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0: parent.hours = row
            case 1: parent.minutes = row
            case 2: parent.seconds = row
            default: break
            }
        }
        
        func pickerView(_ pickerView: UIPickerView,
                        viewForRow row: Int,
                        forComponent component: Int,
                        reusing view: UIView?) -> UIView {
            
            let label = UILabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 22)
            
            switch component {
            case 0: label.text = "\(row)"
            case 1: label.text = "\(row)"
            case 2: label.text = "\(row)"
            default: break
            }
            
            return label
        }
    }
}
