//
//  ContentView.swift
//  week3 homework
//
//  Created by Christy Liu on 9/22/26.
//

import SwiftUI
import Combine

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("🍬 Your Candy Jar 🍬")
                    .font(.largeTitle)

                NavigationLink("get your candy") {
                    CandyView()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct CandyView: View {
    let timer = Timer.publish(
        every: 0.5,
        on: .main,
        in: .common
    ).autoconnect()

    let colors: [Color] = [
        .pink, .purple, .blue, .orange, .green
    ]

    @State private var isStopped = false

    @State private var candyColors: [Color] = [
        .pink, .purple, .blue, .orange, .green
    ]

    @State private var candySizes: [Double] = [
        40, 40, 40, 40, 40
    ]

    var body: some View {
        VStack(spacing: 30) {
            Text(isStopped ? "This is your candy" : "what candy favor will I get today？")
                .font(.title)

            VStack(spacing: 12) {
                ForEach(0..<5, id: \.self) { i in
                    Circle()
                        .fill(candyColors[i])
                        .frame(
                            width: candySizes[i],
                            height: candySizes[i]
                        )
                }
            }
            .frame(width: 180, height: 350)
            .background(Color.yellow.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 25))

            Button(isStopped ? "you got your candy today" : "Stop！") {
                isStopped = true
            }
            .buttonStyle(.borderedProminent)
            .disabled(isStopped)
        }
        .onAppear {
            if !isStopped {
                generateCandies()
            }
        }
        .onReceive(timer) { _ in
            if !isStopped {
                withAnimation(.easeInOut(duration: 0.3)) {
                    generateCandies()
                }
            }
        }
    }

    func generateCandies() {
        for i in 0..<5 {
            candyColors[i] = colors.randomElement()!
            candySizes[i] = Double.random(in: 30...50)
        }
    }
}

#Preview {
    ContentView()
}
