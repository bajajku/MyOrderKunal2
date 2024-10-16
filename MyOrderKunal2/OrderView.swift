//
//  OrderView.swift
//  MyOrderKunal2
//
//  Created by Kunal Bajaj on 2024-10-11.
//
//Kunal Bajaj 991648986


import SwiftUI
import CoreData

struct OrderView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: true)],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    
    // list of sizes
    var sizes = ["Small", "Medium", "Large"]
    @State private var selectedSize = "Medium"
    
    //list of toppings
    var toppings = ["Cheese", "Pepperoni", "Veggie", "Meat Lovers"]
    @State private var selectedTopping = "Cheese"
    
    //list of crusts
    var crusts = ["Thin", "Regular", "Thick", "Stuffed"]
    @State private var selectedCrust = "Regular"
    
    @State private var numPizzas: Int = 1
    
    @State private var date: Date = Date.now
    
    
    func addOrder(){
        let newOrder = Order(context: viewContext)
        newOrder.id = UUID()
        newOrder.size = selectedSize
        newOrder.topping = selectedTopping
        newOrder.pizzaType = selectedCrust
        newOrder.quantity = Int16(numPizzas)
        newOrder.date = date
        
        do {
            try viewContext.save()
            
            print("Order saved successfully")
        }catch {
            print("Error saving order")}
    }
    
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            
            // Title Section of the Home Page
            Text("Customize your Pizza")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Pizza Size Picker
            Text("Select Pizza Size")
                .font(.headline)
            Picker("Please choose the size of Pizza", selection: $selectedSize) {
                ForEach(sizes, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            // Topping Picker
            Text("Select Topping")
                .font(.headline)
            Picker("Please choose the topping for the Pizza", selection: $selectedTopping) {
                ForEach(toppings, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            // Crust Picker
            Text("Select Crust")
                .font(.headline)
            Picker("Please choose the crust", selection: $selectedCrust) {
                ForEach(crusts, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            // Quantity Stepper 1-3 only...
            Text("Select Quantity")
                .font(.headline)
            Stepper("Number of Pizzas: \(numPizzas)", value: $numPizzas, in: 1...3)
            
            DatePicker(selection: $date, in: Date.now..., displayedComponents: .date) {
                Text("Select date for the order")
            }
            
            // Add Order Button, to add order in orders list
            Button(action: {
                addOrder()
            }) {
                Text("Add Order")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("My Pizza Order")
        
    }
}


#Preview {
    OrderView()
}
