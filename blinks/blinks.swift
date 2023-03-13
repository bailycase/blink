//
//  blinks.swift
//  blinks
//
//  Created by Baily Case on 3/9/23.
//

import WidgetKit
import SwiftUI
import Intents

func fetchImages(fromURLs urls: [URL]) -> [UIImage] {
    var images = [UIImage]()
    let group = DispatchGroup()
    
    for url in urls {
        group.enter()
        URLSession.shared.dataTask(with: url) { data, response, error in
            defer { group.leave() }
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                images.append(image)
            }
        }.resume()
    }
    
    group.wait()
    return images
}

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date(), text: "Hello world!", imageUrl: "https://i.kym-cdn.com/entries/icons/original/000/043/403/cover3.jpg", image: nil)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entry = SimpleEntry(date: Date(), text: "Hello I am visible!", imageUrl: "https://i.kym-cdn.com/entries/icons/original/000/043/403/cover3.jpg", image: nil)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "Hello I am the placeholder", imageUrl: "", image: nil)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
    let imageUrl: String
    let image: UIImage?
}

struct blinksEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                if let unwrappedImage = entry.image {
                    Image(uiImage: unwrappedImage).resizable().scaledToFill().frame(width: geo.size.width, height: geo.size.height)
                } else {
                    Text("Uh-oh no image!")
                }
            }
        }
    }
}

struct blinks: Widget {
    let kind: String = "blinks"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            blinksEntryView(entry: entry)
        }
        .configurationDisplayName("Blinks")
        .description("Keep up with your friends and never miss a beat.")
    }
}

struct blinks_Previews: PreviewProvider {
    static var previews: some View {
        let images = fetchImages(fromURLs: [URL(string: "https://static.wikia.nocookie.net/terrachaoverse-the-broken-realm/images/e/e4/Meme_Man.png/revision/latest?cb=20180807212511")!])
        blinksEntryView(entry: SimpleEntry(date: Date(), text: "Hello preview!", imageUrl: "https://google.com", image: images.first))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
