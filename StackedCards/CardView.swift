import SwiftUI

struct CardView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var offset: CGFloat = .zero
    var card: Card
    var namespace: Namespace.ID
    
    var body: some View {
        VStack {
            Text(card.name)
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .shadow(radius: 5)
                .padding()
        }
        .frame(width: vm.getCardWidth(), height: vm.getCardHeight())
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(card.color)
                .matchedGeometryEffect(id: card.id, in: namespace)
        )
        .rotationEffect(.degrees(Double(offset / 10)))
        .offset(x: offset, y: 0)
        .opacity(1 - Double(abs(offset / vm.getCardWidth())))
        .shadow(radius: 10)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    if vm.isFirstCard(card: card) && value.translation.width < 0 {
                        offset = value.translation.width
                    }
                })
                .onEnded({ value in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        if -value.translation.width > UIScreen.main.bounds.width / 2  {
                            offset = -UIScreen.main.bounds.width
                            vm.moveFirstCard()
                        }
                        else {
                            offset = .zero
                        }
                    }
                })
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static let vm = ViewModel()
    @Namespace static var namespace
    
    static var previews: some View {
        CardView(card: vm.cards[0], namespace: namespace)
            .environmentObject(vm)
    }
}
