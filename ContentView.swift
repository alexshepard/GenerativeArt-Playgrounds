import SwiftUI

struct ContentView: View {
    @State private var fgColor: Color = .white
    @State private var bgColor: Color = .white
    @State private var rectSideLength: CGFloat = 0
    
    var body: some View {
        GeometryReader { geom in 
            Canvas { context, size in
                let originX = (size.width - rectSideLength) / 2
                let originY = (size.height - rectSideLength) / 2
                let rect = CGRect(x: originX, y: originY, width: rectSideLength, height: rectSideLength)
                let path = Path(rect)
                context.fill(path, with: .color(fgColor))
            }
            .background(bgColor)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged({ newValue in
                        var hue = (newValue.location.y / geom.size.height)
                        if hue > 1 { hue = 1 }
                        if hue < 0 { hue = 0 }
                        self.fgColor = Color(hue: hue, saturation: 1.0, brightness: 1.0)
                        self.bgColor = Color(hue: 1-hue, saturation: 1.0, brightness: 1.0)
                        var length = (newValue.location.x / geom.size.width)
                        if length < 0 { length = 0 }
                        if length > 1 { length = 1 }
                        self.rectSideLength = length * geom.size.width
                    })
            )
        }
    }
}
