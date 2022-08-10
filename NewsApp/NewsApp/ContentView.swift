import SwiftUI

struct ContentView: View {
    @State var selection = 1
    
    
    var body: some View {
        TabView(selection: $selection){
            News1()
            
                .tag(1)
            News2()
            
                .tag(2)
            News3()
            
                .tag(3)
        }
        .tabViewStyle(.page)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

