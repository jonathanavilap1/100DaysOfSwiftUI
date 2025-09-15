//
//  ContentView.swift
//  WeSplit
//
//  Created by Jonathan Avila on 02/09/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var getTip: Double {
        
        return Double((checkAmount/100.00)*Double(tipPercentage))
    }
    
    var getTotal: Double {
        
        return (checkAmount+getTip)
    }
    
    var getTotalPerPerson: Double {
                    
        return getTotal/Double(numberOfPeople)
    }
    
    let currencyCode = Locale.current.currency?.identifier ?? "MXN"
                            
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "MXN"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of pleople", selection: $numberOfPeople){
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?"){
                    Picker("Tip percentage picket", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self){
                            Text($0 * 5, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Grand total"){
                    Text(getTotal, format: .currency(code: currencyCode))
                }
                Section("Total Per Person"){
                    Text(getTotalPerPerson, format: .currency(code: currencyCode))
                }
                Section("Tip Amount"){
                    Text(getTip, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
