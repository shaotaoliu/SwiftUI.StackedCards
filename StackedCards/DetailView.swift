import SwiftUI

struct DetailView: View {
    @Binding var showDetailPage: Bool
    let card: Card?
    var namespace: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .leading) {
            if let card = card, showDetailPage {
                Rectangle()
                    .fill(card.color)
                    .matchedGeometryEffect(id: card.id, in: namespace)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text(card.name)
                        .font(.title)
                    
                    HStack {
                        Text(card.park)
                        Spacer()
                        Text(card.state)
                    }
                    .font(.subheadline)
                    
                    Rectangle()
                        .fill(.white)
                        .frame(maxWidth: .infinity, maxHeight: 1)
                    
                    ScrollView {
                        Text(card.description)
                    }
                }
                .padding()
            }
        }
        .foregroundColor(.white)
        .onTapGesture {
            withAnimation {
                showDetailPage = false
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        DetailView(showDetailPage: .constant(true), card: ViewModel().cards[0], namespace: namespace)
    }
}
