import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showAllCards = false
    @State var numberOfCards: Int = 1
    @State var repeatable = false
    
    var body: some View {
        Form {
            Toggle("Show All Cards", isOn: $showAllCards)
            
            HStack {
                Spacer()
                Stepper(value: $numberOfCards, in: 1...max(vm.cards.count, 1), label: {
                    HStack {
                        Text("Number")
                        Spacer()
                        Text("\(numberOfCards)")
                    }
                    .foregroundColor(showAllCards ? .gray : .black)
                })
            }
            .disabled(showAllCards)
            
            Toggle("Repeat", isOn: $repeatable)
            
            HStack(spacing: 80) {
                Button("Save") {
                    vm.settings.showAllCards = showAllCards
                    vm.settings.cardsToShown = numberOfCards
                    vm.settings.repeatable = repeatable
                    
                    vm.load()
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderless)
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(.borderless)
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
        .onAppear(perform: {
            showAllCards = vm.settings.showAllCards
            numberOfCards = vm.settings.cardsToShown
            repeatable = vm.settings.repeatable
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewModel())
    }
}
