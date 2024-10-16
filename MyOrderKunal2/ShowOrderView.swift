//Kunal Bajaj 991648986

import SwiftUI
import CoreData

struct ShowOrderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: false)],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    @State private var selectedQuantity: Int = 1
    @State private var showAlert: Bool = false
    
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(orders) { order in
                    NavigationLink(destination: {
                        VStack(alignment: .center, spacing: 12) {
                            Text("Order Details")
                                .font(.title)
                            Spacer()
                            
                            Text("Pizza Type: \(order.pizzaType ?? "Unknown")")
                            Text("Size: \(order.size ?? "Unknown")")
                            Text("Quantity: \(order.quantity)")
                            Text("Toppings: \(order.topping ?? "None")")
                            Text("Date: \(order.date!, formatter: itemFormatter)")
                            
                            Spacer()
                            Stepper("Edit Order Quantity: \(selectedQuantity)", value: $selectedQuantity, in: 1...6)
                            
                            Button(action: {
                                updateOrderQuantity(order: order)
                            }) {
                                Text("Update Quantity")
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            Spacer()
                        }
                        .padding()
                    }) {
                        Text("Order on: \(order.date!, formatter: itemFormatter)")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Alert!!!"), message: Text("Order quantity has been updated"), dismissButton: .default(Text("OK")))
                    }
                }.onDelete(perform: deleteOrders)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }
    private func deleteOrders(offsets: IndexSet) {
        withAnimation {
            offsets.map { orders[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func updateOrderQuantity(order: Order) {
        if(selectedQuantity != order.quantity){
            
            order.quantity = (Int16(selectedQuantity))
            selectedQuantity = 1
            do {
                try viewContext.save()
                showAlert = !showAlert
                
                print("Order saved successfully")
            }catch {
                print("Error saving order")}
        }
    }
}


// Date Formatter for displaying the date properly
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

#Preview {
    ShowOrderView()
}
