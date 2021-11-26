import SwiftUI

class ViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var settings = Settings()
    
    init() {
        load()
    }
    
    private let colors: [Color] = [.red, .green, .blue, .purple, .brown, .orange]
    
    func load() {
        let file = Bundle.main.url(forResource: "landmarks", withExtension: "json")!
        let data = try! Data(contentsOf: file)
        let landmarks = try! JSONDecoder().decode([Landmark].self, from: data)
        
        cards.removeAll()
        
        for i in 0..<landmarks.count {
            cards.append(
                Card(color: colors[i % colors.count],
                     name: landmarks[i].name,
                     park: landmarks[i].park,
                     state: landmarks[i].state,
                     description: landmarks[i].description,
                     imageName: landmarks[i].imageName))
        }
    }
    
    func getIndex(card: Card) -> Int {
        return cards.firstIndex {
            $0.id == card.id
        }!
    }
    
    func isFirstCard(card: Card) -> Bool {
        return card.id == cards[0].id
    }
    
    func getCardWidth() -> CGFloat {
        return settings.cardWidth
    }
    
    func getCardHeight() -> CGFloat {
        return settings.cardHeight
    }
    
    func getOffset(card: Card) -> CGSize {
        // calculate the max space the behind cards can take
        let cardsToShown = settings.showAllCards ? cards.count : min(settings.cardsToShown, cards.count)
        let maxSpace1 = CGFloat(cardsToShown - 1) * settings.maxInternal
        
        let maxSpace2 = UIScreen.main.bounds.width - settings.cardWidth - settings.cardsPadding * 2
        let maxSpace = min(maxSpace1, maxSpace2)
        
        // calculate the interval between the cards
        var interval = settings.maxInternal
        if cardsToShown == 1 {
            interval = 0
        }
        else {
            interval = min(interval, maxSpace / CGFloat(cardsToShown - 1))
        }
        
        // calculate the offset
        var index = getIndex(card: card)
        index = min(index, cardsToShown - 1)
        
        let startPosition = (UIScreen.main.bounds.width - settings.cardWidth - maxSpace) / 2 - settings.cardsPadding
        
        var offset = CGSize()
        offset.width = startPosition + interval * CGFloat(index)
        offset.height = interval * CGFloat(index)
        
        return offset
    }
    
    func moveFirstCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if self.settings.repeatable {
                var card = self.cards.first!
                
                // create a new id; otherwise, ForEach will give a warning
                card.id = UUID()
                self.cards.append(card)
            }
            
            self.cards.removeFirst()
        }
    }
}

struct Settings {
    var cardsPadding: CGFloat = 20
    var cardWidth: CGFloat = 300
    var cardHeight: CGFloat = 400
    var showAllCards: Bool = false
    var cardsToShown: Int = 3
    var maxInternal: CGFloat = 15
    var repeatable: Bool = true
}

struct Card: Identifiable {
    var id = UUID()
    var color: Color
    var name: String
    var park: String
    var state: String
    var description: String
    var imageName: String
}

struct Landmark: Codable {
    var name: String
    var park: String
    var state: String
    var description: String
    var imageName: String
}
