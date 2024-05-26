//
//  LoadedView.swift
//  RikAndMortySUI


import SwiftUI

struct LoadView: View {
    @State var angle: Double = 0
    
    var body: some View {
        Image("circle")
            .rotationEffect(Angle(degrees: angle), anchor: UnitPoint(x: 0.5, y: 0.5))
            .animation(.linear(duration: 3))
            .onAppear {
                angle += 250
            }
    }
}

struct LoadView_Previews: PreviewProvider {
    static var previews: some View {
        LoadView()
    }
}
