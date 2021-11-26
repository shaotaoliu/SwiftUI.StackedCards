import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: ViewModel
    @State var showDetailPage = false
    @State var showSettingsSheet = false
    @Namespace var namespace
    
    var body: some View {
        VStack {
            ZStack {
                Text("Placemark Cards")
                    .font(.title.bold())
                    .padding()
                
                Button(action: {
                    showSettingsSheet = true
                }, label: {
                    Image(systemName: "gearshape")
                        .font(.title3)
                })
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .sheet(isPresented: $showSettingsSheet) {
                        SettingsView()
                    }
            }
            
            VStack {
                StackedCardsView(namespace: namespace)
            }
            .padding(.bottom, 80)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .onTapGesture {
                withAnimation(.spring()) {
                    showDetailPage = true
                }
            }
        }
        .overlay(
            DetailView(showDetailPage: $showDetailPage, card: vm.cards.first, namespace: namespace)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
