//  Created by Adam Kaplan on 8/29/17.
//  Copyright 2017 Yahoo Holdings Inc.

import Foundation
import UIKit

/// 30 values to test with. These are the market caps of the Dow Jones 30 index.
public struct TestValuesDow30: TestValues {
    public static let description: String = "Dow30"

    public static let AllValues: [Double] = [
        847097757696,
        575896485888,
        355281076224,
        323418619904,
        319795560448,
        236726419456,
        235342020608,
        235289427968,
        212552663040,
        203939905536,
        201734094848,
        195689299968,
        194284404736,
        192308461568,
        176669736960,
        174168571904,
        164793925632,
        161051607040,
        156200173568,
        141658963968,
        133295374336,
        129575223296,
        121931431936,
        95629107200,
        86858776576,
        86681804800,
        76110675968,
        72834957312,
        69433417728,
        33439258624
    ]

    public struct Company {
        public let symbol: String
        public let percentChange: Double
    }

    public static let Companies: [Company] = [
        Company(symbol: "AAPL", percentChange: 0.39791483),
        Company(symbol: "MSFT", percentChange: 1.0268809),
        Company(symbol: "JNJ",  percentChange: 0.9918271),
        Company(symbol: "XOM",  percentChange: 0.30223832),
        Company(symbol: "JPM",  percentChange: -0.45996952),
        Company(symbol: "V",    percentChange: -0.20245513),
        Company(symbol: "WMT",  percentChange: -0.5984227),
        Company(symbol: "PG",   percentChange: 0.43539122),
        Company(symbol: "GE",   percentChange: 1.1120204),
        Company(symbol: "CVX",  percentChange: -0.10210768),
        Company(symbol: "PFE",  percentChange: 1.4050745),
        Company(symbol: "VZ",   percentChange: -0.31171596),
        Company(symbol: "KO",   percentChange: 0.35250023),
        Company(symbol: "UNH",  percentChange: 1.5417546),
        Company(symbol: "HD",   percentChange: -0.086669919999999998),
        Company(symbol: "MRK",  percentChange: 1.1723728),
        Company(symbol: "INTC", percentChange: 0.515908),
        Company(symbol: "CSCO", percentChange: 0.6877127),
        Company(symbol: "DIS",  percentChange: -1.6234137),
        Company(symbol: "BA",   percentChange: -0.3326969),
        Company(symbol: "IBM",  percentChange: 0.3296866),
        Company(symbol: "MCD",  percentChange: 0.2758117),
        Company(symbol: "MMM",  percentChange: 0.30929592),
        Company(symbol: "UTX",  percentChange: 0.100336745),
        Company(symbol: "GS",   percentChange: 0.5934751),
        Company(symbol: "NKE",  percentChange: 0.82092464),
        Company(symbol: "AXP",  percentChange: 0.47846428),
        Company(symbol: "DD",   percentChange: 0.8895274399999999),
        Company(symbol: "CAT",  percentChange: -0.051046524000000003),
        Company(symbol: "TRV",  percentChange: -0.51719666)
    ]

    static func color(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
        return UIColor(red: CGFloat(Double(r) / 255.0),
                       green: CGFloat(Double(g) / 255.0),
                       blue: CGFloat(Double(b) / 255.0),
                       alpha: 1)
    }

    /// Static color ranges. In reality, you would compute dynamic ranges.
    public static let colors: [(Double, UIColor)] = [
        (-1.6234137,color(0xec, 0x00, 0x08)),
        (-1.296,    color(0xfa, 0x2c, 0x2c)),
        (-0.972,    color(0xfa, 0x49, 0x49)),
        (-0.648,    color(0xff, 0x72, 0x72)),
        (-0.324,    color(0xff, 0x96, 0x93)),
        (0.0,       color(0xcd, 0xdd, 0xd5)),
        (0.324,     color(0x0e, 0xe9, 0x8b)),
        (0.648,     color(0x13, 0xdd, 0x86)),
        (0.972,     color(0x0f, 0xcb, 0x74)),
        (1.296,     color(0x00, 0xbc, 0x69)),
        (1.6234137, color(0x00, 0xa9, 0x5b))
    ]
}
