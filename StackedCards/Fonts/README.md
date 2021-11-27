# UIFont.familyNames 

```Swift
struct ContentView: View {
    var body: some View {
        ScrollView {
            ForEach(UIFont.familyNames, id: \.self) { name in
                HStack {
                    Text("Hello World")
                        .font(Font(UIFont(name: name, size: 20)!))
                    Spacer()
                    Text(name)
                }
                .font(.caption)
                .padding(.vertical, 5)
                .padding(.horizontal)
            }
        }
    }
}
```

![image](https://user-images.githubusercontent.com/15805568/143661951-97fd915a-9bc4-48f0-9ceb-63c50096ff07.png)

![image](https://user-images.githubusercontent.com/15805568/143661968-8b84d3c2-4819-4ecc-a055-57c2a63cba07.png)

![image](https://user-images.githubusercontent.com/15805568/143661982-7f1bedc0-ef21-4067-a4cd-02c8d28c495d.png)

![image](https://user-images.githubusercontent.com/15805568/143661992-3f3e9dac-3cd1-4108-9431-eae535f5f6a8.png)

![image](https://user-images.githubusercontent.com/15805568/143662004-2a48df0b-c5b9-43ce-8a48-9dd947d843a0.png)
