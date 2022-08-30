//
//  TechinicalCalculation.swift
//  StockForecast
//
//  Created by Arthur Wang on 8/30/22.
//

import Foundation
class Techinical {
    static func ema(data: [CGFloat], period: Int) -> [CGFloat] {
        if (data.count == 0) {
            return []
        }
        var res = [CGFloat].init(repeating: 0, count: data.count)
        var ema: CGFloat = data[0];
        let multiplier = 2.0 / CGFloat(period + 1)
        for i in 0..<res.count {
            ema = data[i] * multiplier + ema * (1 - multiplier)
            res[i] = ema
        }
        return res;
    }
}
