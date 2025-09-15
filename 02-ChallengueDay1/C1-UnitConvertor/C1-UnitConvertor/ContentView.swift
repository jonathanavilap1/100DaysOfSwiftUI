//
//  ContentView.swift
//  C1-UnitConvertor
//
//  Created by Jonathan Avila on 09/09/25.
//

import SwiftUI

struct ContentView: View {
    
    
    enum Units: String, CaseIterable, Identifiable {
        case celsius, fahrenheit, kelvin
        var id: Self { self }
        var display: String { rawValue.capitalized }
        var unit: UnitTemperature {
            switch self {
            case .celsius: .celsius
            case .fahrenheit: .fahrenheit
            case .kelvin: .kelvin
            }
        }
    }
    
    @State private var fromUnit: Units = .celsius
    @State private var toUnit: Units = .fahrenheit
    @State private var Unidad: Double = 0.0
    @FocusState private var isFocused: Bool
    
    private var result: Double {
        let input = Measurement(value: Unidad, unit: fromUnit.unit)
        return input.converted(to: toUnit.unit).value
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Escribe la unidad de origen:")
                    .font(.headline)
                    .padding(.bottom, 5)
                    .padding(.top, 50)
                Picker("Unidad", selection: $fromUnit) {
                    ForEach(Units.allCases){
                        Text($0.display)
                    }
                }.pickerStyle(.segmented)
                
                TextField("Escribe la unidad a convertir", value: $Unidad, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                
                
                Text("Selecciona la unidad de destino:")
                    .font(.headline)
                    .padding(.bottom, 5)
                    .padding(.top, 50)
                
                Picker("Unidad", selection: $toUnit) {
                    ForEach(Units.allCases.filter{$0 != fromUnit}){
                        Text($0.display)
                    }
                }.pickerStyle(.segmented)
                    .onChange(of: fromUnit) {
                        toUnit = Units.allCases.first(where: { $0 != fromUnit }) ?? .celsius
                    }
                
                HStack{
                    Text("Tu resultado es: ")
                    Text("\(result.formatted())")
                        .bold()
                        .foregroundColor(.blue)
                    Text(toUnit.unit.symbol)
                        .foregroundColor(.green)
                }
                .padding(.top, 50)
                
                Spacer()
            }
            
            .navigationTitle("Unit Convertor")
            .padding()
            .toolbar {
                if isFocused {
                    Button("Done"){
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
