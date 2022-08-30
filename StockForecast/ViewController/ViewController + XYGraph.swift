//
//  ViewController + XYGraph.swift
//  UIKit
//
//  Created by Arthur Wang on 7/26/22.
//

import Foundation
import Cocoa

extension ViewController: XYChartDataSource {
    func getXAxisLabels() -> [String] {
        var res = [String]()
        switch(self.timePeriodTabs.period) {
        case .week:
            var record: TimeInterval = 0;
            for i in 0..<timeData.count {
                if timeData[i] - record > 3601 {
                    res.append(UnitConvertion.timeToString(time: timeData[i], format: "MM-dd"))
                }
                record = timeData[i]
            }
            break
        case .day:
            break
        default:
            let end = NSDate().timeIntervalSince1970
            let incre = timeData.count / 6
            for i in 0..<6 {
                let time = timeData[i * incre]
                res.append(UnitConvertion.timeToString(time: time, format: "YYYY-MM-dd"))
            }
            break
        }
        res.append("now")
        return res
    }
    
    func getXYData() -> [([CGPoint], NSColor)] {
        if (momentumCheckBox.state == .on) {
            let ema12 = Techinical.ema(data: processData, period: 12)
            let ema26 = Techinical.ema(data: processData, period: 26)
            var ema12Graph = [CGPoint].init(repeating: CGPoint(), count: self.graphData.count)
            var ema26Graph = [CGPoint].init(repeating: CGPoint(), count: self.graphData.count)
            for i in 0..<graphData.count {
                let index = ema12.count - graphData.count + i
                ema12Graph[i].y = ema12[index]
                ema26Graph[i].y = ema26[index]
                ema12Graph[i].x = graphData[i].x
                ema26Graph[i].x = graphData[i].x
            }
            return [(self.graphData, NSColor.blue), (ema12Graph, NSColor.green), (ema26Graph, NSColor.red)]
        } else {
            return [(self.graphData, NSColor.blue)]
        }
    }
    func getXYData(by set: Int) {
        
    }
}

extension ViewController: XYChartDelegate {
    func axisXFormat(val: CGFloat) -> String {
        return UnitConvertion.timeToString(time: TimeInterval(val), format: "YYYY-MM-dd")
    }
    
    func axisYFormat(val: CGFloat) -> String {
        return String(format: "%.2f", Double(val))
    }
    
    func getRange() -> (CGFloat, CGFloat) {
        return range
    }
    
    func getDomain() -> (CGFloat, CGFloat) {
        return domain
    }
    
    func select(line: Int) {
        
    }
}
