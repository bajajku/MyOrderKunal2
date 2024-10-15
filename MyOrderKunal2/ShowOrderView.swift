import SwiftUI
import CoreData

struct ShowOrderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: true)],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(orders) { order in
                    NavigationLink("Order ID: \(order.id?.uuidString ?? "Unknown")") {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Order Details")
                                .font(.headline)
                            Spacer()
                            
                            Text("Pizza Type: \(order.pizzaType ?? "Unknown")")
                            Text("Size: \(order.size ?? "Unknown")")
                            Text("Quantity: \(order.quantity)")
                            Text("Toppings: \(order.topping ?? "None")")
                            Text("Date: \(order.date!, formatter: itemFormatter)")
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
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
