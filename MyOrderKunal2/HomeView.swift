//
//  HomeView.swift
//  MyOrderKunal2
//
//  Created by Kunal Bajaj on 2024-10-11.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: true)],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    
    // list of orders
//    @State private var orders: [Order] = []
    
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
    
        
    var body: some View {
        NavigationStack{
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
                
                // Add Order Button, to add order in orders list
                Button(action: {
//                    let order = Order(size: selectedSize, topping: selectedTopping, crust: selectedCrust, count: numPizzas)
//                    addOrder(order: order)
                }) {
                    Text("Add Order")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                // Navigation Link to navigate to ShowOrdersView
//                NavigationLink(destination: ShowOrdersView(orders: orders)) {
//                    Text("Show Orders")
//                        .font(.headline)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(.white)
//                        .background(Color.teal)
//                        .cornerRadius(10)
//                }
                // spacer for making app reable
                Spacer()
            }
            .padding()
            .navigationTitle("My Pizza Order")
        }    }
}

#Preview {
    HomeView()
}
