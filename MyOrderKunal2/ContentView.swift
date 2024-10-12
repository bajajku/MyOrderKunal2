import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.date, ascending: true)],
        animation: .default)
    private var orders: FetchedResults<Order>
    
    
    var body: some View {
        Text("Something")
    }
}


#Preview {
    ContentView()
}