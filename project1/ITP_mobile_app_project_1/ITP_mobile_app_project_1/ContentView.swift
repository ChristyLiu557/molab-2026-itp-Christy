////
////  ContentView.swift
////  ITP_mobile_app_project_1
////
////  Created by Christy Liu on 9/17/26.
////
//
//import SwiftUI
//
//struct ContentView: View {
//    @State var counter = 0
//    var body: some View {
//        
//        VStack {
//            Image(systemName: "car")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//            Text("counter\(counter)")
//                .font(.system(size:60))
//            if counter > 2 {
//                Image(systemName: "apple.logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            }
//            Button("minus"){
//                counter -= 1
//                print("counter -= 1\(counter)")
//            }
//            .font(.system(size:60))
//            
//            Button(counter > 10 ? "> 10" : "< 10"){
//                counter += 1
//                print("counter += 1\(counter)")
//            }
//            .font(.system(size:60))
//        }
//        .onAppear(){
//            print("counter\(counter)")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

//
//  CanvasAnimView.swift
//  Canvas-Explore
//
//  Created by jht2 on 1/26/25.
//

import SwiftUI

// Swift implmentation of 10Print algorithm
// spiced up with a little color

// See UIGraphicsImageRenderer version:
// https://github.com/molab-itp/01-UIRender-playground / 10print save

let animInterval = 0.10; // update very tenth of a second
let ncell = 10.0
let lineWidth = 10.0
let colorSpecs = [Color.red, Color.green, Color.yellow, Color.black];

var loc = CGPoint.zero;
var nsize: CGSize = .zero;
struct PathData {
  var path: Path;
  var color: Color;
}
var paths: [PathData] = [];


struct CanvasAnimView: View {
  var body: some View {
    TimelineView(.animation(minimumInterval: animInterval)) { timeline in
      Canvas { context, size in
        // print("size", size)
        nsize = CGSize(width: size.width/ncell, height: size.width/ncell)
          
        // Add a path and random color to paths array
        let path = randomSlash(loc);
        let color = colorSpecs.randomElement()!
        paths.append(PathData(path: path, color: color));
        
        // Draw all the paths in paths array
        for p in paths {
          let style = StrokeStyle(lineWidth: lineWidth, lineCap: .round);
          context.stroke(p.path, with: .color(p.color), style: style)
        }
        
        // Advance to next location
        loc.x += nsize.width;
        if loc.x > size.width {
          loc.x = 0;
          loc.y += nsize.height;
          if loc.y > size.height {
            loc.y = 0
            paths = [];
          }
        }
        // must read to trigger update
        _ = timeline.date
      }
    }
  }
}

// Draw a diagonal line in random direction
func randomSlash(_ p: CGPoint) -> Path {
  var path = Path()
  let x = loc.x;
  let y = loc.y;
  let xlen = nsize.width;
  let ylen = nsize.height;
  if Bool.random() {
    // Draw line top left to bottom right
    path.move(to: CGPoint(x: x, y: y))
    path.addLine(to: CGPoint(x: x+xlen, y: y+ylen))
  }
  else {
    // Draw line top right to bottom left
    path.move(to: CGPoint(x: x+xlen, y: y))
    path.addLine(to: CGPoint(x: x, y: y+ylen))
  }
  return path;
}

#Preview {
  CanvasAnimView()
}
