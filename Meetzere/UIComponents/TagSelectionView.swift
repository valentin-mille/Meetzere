//
//  TagSelectionView.swift
//  Meetzere
//
//  Created by Valentin Mille on 3/21/24.
//

import SwiftUI

struct Tag: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var isSelected: Bool = false
}

struct TagView: View {
    @State var tags: [Tag]
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        // Wrap tags dynamically based on content size
        FlowLayout(tags: $tags) { tag in
            Toggle(tag.wrappedValue.name, isOn: tag.isSelected)
                .bold()
                .toggleStyle(.button).buttonStyle(.bordered).clipShape(Capsule())
                .foregroundColor(tag.wrappedValue.isSelected ? .blue : .primary)
                .tint(tag.wrappedValue.isSelected ? .blue : .black)
        }
    }
}

// A custom Flow Layout to dynamically adjust tags
struct FlowLayout<Item, ItemContent: View>: View where Item: Identifiable & Equatable {
    @Binding var items: [Item]
    var viewForItem: (Binding<Item>) -> ItemContent

    init(tags: Binding<[Item]>, @ViewBuilder viewForItem: @escaping (Binding<Item>) -> ItemContent) {
        self._items = tags
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(Array(zip(items.indices, items)), id: \.1.id) { index, item in
                viewForItem($items[index])
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading) { dimension in
                        if (abs(width - dimension.width) > geometry.size.width) {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if items[index].id != self.items.last!.id {
                            width -= dimension.width
                        } else {
                            width = 0 // last item
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height
                        if items[index].id == self.items.last!.id {
                            height = 0 // last item
                        }
                        return result
                    }
            }
        }
    }
}

#Preview {
    TagView(tags: [
        .init(name: "Memes"),
        .init(name: "News"),
        .init(name: "Music"),
        .init(name: "Crypto"),
        .init(name: "Comedy"),
        .init(name: "Technology"),
        .init(name: "Animals"),
        .init(name: "DIY"),
        .init(name: "Life Hacks"),
        .init(name: "Automobiles"),
        .init(name: "Fashion"),
        .init(name: "Food"),
        .init(name: "Outdoors"),
        .init(name: "Gaming"),
        .init(name: "Travel"),
        .init(name: "Parenting"),
        .init(name: "Gardening"),
        .init(name: "Skateboarding"),
        .init(name: "Witchcraft"),
        .init(name: "Love"),
        .init(name: "Relationships"),
        .init(name: "Vintage"),
        .init(name: "Office"),
        .init(name: "Emotional Support"),
        .init(name: "Synth"),
        .init(name: "Humor"),
        .init(name: "Fandom"),
        .init(name: "Events"),
        .init(name: "Work"),
        .init(name: "Halloween"),
        .init(name: "Crafts"),
        .init(name: "School"),
        .init(name: "College"),
        .init(name: "Dating"),
        .init(name: "Random")
    ])
    .padding()
}
