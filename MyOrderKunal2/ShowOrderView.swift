import SwiftUI
import CoreData

struct ShowOrderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: false)],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(orders) { order in
                    NavigationLink("Order on: \(order.date!, formatter: itemFormatter)") {
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
                }.onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { orders[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
