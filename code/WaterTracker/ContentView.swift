//
//  ContentView.swift
//  WaterTracker
//
//  Created for HydroTracker project.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var viewModel = WaterConsumptionViewModel()
    @State private var isCustomAmountPresented = false
    @State private var customAmount = ""
    @State private var isAddingWater = true
    @State private var animateWaterLevel = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Current total display
                VStack {
                    Text(NSLocalizedString("Today's Water Intake", comment: "Header for daily intake"))
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text(viewModel.todayEntry?.formattedAmount ?? "0 \(viewModel.preferredUnit.localizedAbbreviation)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .contentTransition(.numericText())
                        .accessibilityLabel(Text("\(viewModel.todayEntry?.amount ?? 0) \(viewModel.preferredUnit.localizedName)"))
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Water visualization
                WaterLevelView(level: CGFloat(viewModel.todayEntry?.amount ?? 0) / 3000)
                    .frame(height: 200)
                    .padding(.horizontal)
                    .accessibilityHidden(true) // Hide from VoiceOver since it's decorative
                
                // Preset buttons
                Text(NSLocalizedString("Quick Add", comment: "Label for preset buttons"))
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .accessibilityAddTraits(.isHeader)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 15) {
                    ForEach(viewModel.presetAmounts, id: \.self) { amount in
                        Button {
                            withAnimation {
                                viewModel.addWater(amount)
                                animateWaterLevel.toggle()
                            }
                        } label: {
                            Text("+\(Int(amount)) \(viewModel.preferredUnit.localizedAbbreviation)")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                                .accessibilityLabel(Text("Add \(Int(amount)) \(viewModel.preferredUnit.localizedName)"))
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 15) {
                    // Remove water button
                    Button {
                        if let entry = viewModel.todayEntry, entry.amount > 0 {
                            isAddingWater = false
                            isCustomAmountPresented = true
                        }
                    } label: {
                        Label(NSLocalizedString("Remove", comment: "Button to remove water"), systemImage: "minus.circle")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.2))
                            .foregroundColor(.red)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.borderless)
                    
                    // Custom amount button
                    Button {
                        isAddingWater = true
                        isCustomAmountPresented = true
                    } label: {
                        Label(NSLocalizedString("Custom", comment: "Button for custom water amount"), systemImage: "plus.circle")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.borderless)
                }
                .padding(.horizontal)
                .padding(.top, 5)
            }
            .padding(.bottom)
            .navigationTitle(NSLocalizedString("Water Tracker", comment: "App title"))
            .sheet(isPresented: $isCustomAmountPresented) {
                CustomAmountView(
                    isPresented: $isCustomAmountPresented,
                    isAddingWater: $isAddingWater,
                    unit: viewModel.preferredUnit,
                    onSubmit: { amount in
                        withAnimation {
                            _ = viewModel.updateWater(amount: amount, isAddition: isAddingWater)
                            animateWaterLevel.toggle()
                        }
                    }
                )
            }
        }
    }
}

/// View that displays a water level visualization
struct WaterLevelView: View {
    let level: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Container
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue, lineWidth: 3)
                    .background(Color.blue.opacity(0.05).cornerRadius(20))
                
                // Water level
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue.opacity(0.3)]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(height: min(geometry.size.height * level, geometry.size.height))
                    .animation(.spring(response: 0.7, dampingFraction: 0.6), value: level)
            }
        }
    }
}

/// View that allows user to input a custom water amount
struct CustomAmountView: View {
    @Binding var isPresented: Bool
    @Binding var isAddingWater: Bool
    @State private var amount: String = ""
    let unit: WaterUnit
    let onSubmit: (Double) -> Void
    
    // For accessibility voice over
    let addWaterLabel = NSLocalizedString("Add water amount", comment: "VoiceOver label for adding water")
    let removeWaterLabel = NSLocalizedString("Remove water amount", comment: "VoiceOver label for removing water")
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Picker("", selection: $isAddingWater) {
                    Text(NSLocalizedString("Add", comment: "Toggle option to add water")).tag(true)
                    Text(NSLocalizedString("Remove", comment: "Toggle option to remove water")).tag(false)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .accessibilityLabel(Text("Select operation"))
                
                Text(isAddingWater ? 
                     NSLocalizedString("Add Water", comment: "Title for adding water") : 
                     NSLocalizedString("Remove Water", comment: "Title for removing water"))
                    .font(.headline)
                    .accessibilityHidden(true) // Hidden because the picker already indicates this
                
                TextField(
                    NSLocalizedString("Amount", comment: "Placeholder for water amount input"),
                    text: $amount
                )
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .accessibilityLabel(Text(isAddingWater ? addWaterLabel : removeWaterLabel))
                
                Text(unit.localizedName)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Button {
                    if let amountValue = Double(amount), amountValue > 0 {
                        onSubmit(amountValue)
                        isPresented = false
                    }
                } label: {
                    Text(NSLocalizedString("Confirm", comment: "Button to confirm water amount"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(Double(amount) == nil || Double(amount)! <= 0)
                .buttonStyle(.borderless)
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle(NSLocalizedString("Custom Amount", comment: "Title for custom amount view"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(NSLocalizedString("Cancel", comment: "Button to cancel")) {
                        isPresented = false
                    }
                }
            }
        }
        .presentationDetents([.medium])
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
