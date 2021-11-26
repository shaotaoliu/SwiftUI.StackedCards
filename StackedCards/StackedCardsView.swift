import SwiftUI

struct StackedCardsView: View {
    @EnvironmentObject var vm: ViewModel
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack {
            VStack {
                Text("The End")
                    .font(Font(UIFont(name: "Snell Roundhand", size: 48)!))
                    .padding(10)
                
                Button("Restart") {
                    vm.load()
                }
            }
            
            ZStack {
                ForEach(vm.cards, id: \.id) { card in
                    CardView(card: card, namespace: namespace)
                        .stacked(vm: vm, card: card)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

extension View {
    func stacked(vm: ViewModel, card: Card) -> some View {
        let index = vm.getIndex(card: card)
        let zIndex = Double(vm.cards.count - index)
        
        return self
            .zIndex(zIndex)
            .offset(vm.getOffset(card: card))
            .padding(.leading, vm.settings.cardsPadding)
    }
}

struct StackedCardsView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        StackedCardsView(namespace: namespace)
            .environmentObject(ViewModel())
    }
}
