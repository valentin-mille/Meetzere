//
//  Styles.swift
//  Bubly
//
//  Created by Valentin Mille on 3/5/24.
//

import Foundation

struct Styles {
    /// 8
    static let base: CGFloat = 8

    struct Spacing {
        /// 0
        static let spacing0x: CGFloat = 0.0
        /// 1
        static let spacing1Pointx: CGFloat = 0.125 * base
        /// 2
        static let spacingQuarterx: CGFloat = 0.25 * base
        /// 3
        static let spacingThreeEighthx: CGFloat = 0.375 * base
        /// 4
        static let spacingTwoFifthx: CGFloat = 0.4 * base
        /// 5
        static let spacingHalfx: CGFloat = 0.5 * base
        /// 6
        static let spacing3xQuarter: CGFloat = 0.75 * base
        /// 8
        static let spacing1x: CGFloat = 1 * base
        /// 9.08
        static let spacing1PointOneThreex: CGFloat = 1.135 * base
        /// 10
        static let spacing1Quarterx: CGFloat = 1.25 * base
        /// 12
        static let spacing1Halfx: CGFloat = 1.5 * base
        /// 14
        static let spacing1x3Quarter: CGFloat = 1.75 * base
        /// 16
        static let spacing2x: CGFloat = 2 * base
        /// 18
        static let spacing2Fourthx: CGFloat = 2.25 * base
        /// 19
        static let spacing2x1QuarterxQuarter: CGFloat = 2.375 * base
        /// 20
        static let spacing2Halfx: CGFloat = 2.5 * base
        /// 22
        static let spacing2x3Quarter: CGFloat = 2.75 * base
        /// 24
        static let spacing3x: CGFloat = 3 * base
        /// 26
        static let twentySix: CGFloat = 3.25 * base
        /// 29
        static let twentyNine: CGFloat = 3.625 * base
        /// 30
        static let spacing3x3Quarter: CGFloat = 3.75 * base
        /// 32
        static let spacing4x: CGFloat = 4 * base
        /// 34
        static let spacing4xQuarter: CGFloat = 4.25 * base
        /// 36
        static let spacing4xHalf: CGFloat = 4.5 * base
        /// 40
        static let spacing5x: CGFloat = 5 * base
        /// 42
        static let spacing5xQuarter: CGFloat = 5.25 * base
        /// 48
        static let spacing6x: CGFloat = 6 * base
        /// 50
        static let spacing6xFourthx: CGFloat = 6.25 * base
        /// 56
        static let spacing7x: CGFloat = 7 * base
        /// 60
        static let spacing7xHalf: CGFloat = 7.5 * base
        /// 64
        static let spacing8x: CGFloat = 8 * base
        /// 68
        static let spacing8xHalf: CGFloat = 8.5 * base
        /// 69
        static let spacing8x2QuarterxHalf: CGFloat = 8.625 * base
        /// 72
        static let spacing9x: CGFloat = 9 * base
        /// 74
        static let spacing9xQuarter: CGFloat = 9.25 * base
        /// 78
        static let spacing9x3Quarter: CGFloat = 9.75 * base
        /// 80
        static let spacing10x: CGFloat = 10 * base
        /// 84
        static let spacing10xHalf: CGFloat = 10.5 * base
        /// 86
        static let spacing10x3Quarter: CGFloat = 10.75 * base
        /// 88
        static let spacing11x: CGFloat = 11 * base
        /// 96
        static let spacing12x: CGFloat = 12 * base
        /// 100
        static let spacing12x2Quarter: CGFloat = 12.5 * base
        /// 104
        static let spacing13x: CGFloat = 13 * base
        /// 112
        static let spacing14x: CGFloat = 14 * base
        /// 120
        static let spacing15x: CGFloat = 15 * base
        /// 130
        static let spacing16xFourthx: CGFloat = 16.25 * base
        /// 230
        static let spacing28x3Quarter: CGFloat = 28.75 * base
    }

    struct Size {
        /// 8
        static let size1x: CGFloat = 1 * base
        /// 16
        static let size2x: CGFloat = 2 * base
        /// 18
        static let size2xQuarter: CGFloat = 2.25 * base
        /// 22
        static let size2x3Quarter: CGFloat = 2.75 * base
        /// 24
        static let size3x: CGFloat = 3 * base
        /// 29
        static let size3x2QuarterxHalf: CGFloat = 3.625 * base
        /// 30
        static let size3x3Quarter: CGFloat = 3.75 * base
        /// 32
        static let size4x: CGFloat = 4 * base
        /// 35
        static let size4xQuarterxHalf: CGFloat = 4.375 * base
        /// 40
        static let size5x: CGFloat = 5 * base
        /// 46
        static let size5x3Quarter: CGFloat = 5.75 * base
        /// 48
        static let size6x: CGFloat = 6 * base
        /// 56
        static let size7x: CGFloat = 7 * base
        /// 60
        static let size7x2Quarter: CGFloat = 7.5 * base
        /// 72
        static let size9x: CGFloat = 9 * base
        /// 100
        static let size12xHalf: CGFloat = 12.5 * base
        /// 188
        static let size23x2Quarter: CGFloat = 23.5 * base
        /// 189
        static let size23x2Quarterxhalf: CGFloat = 23.625 * base
        /// 200
        static let size25x: CGFloat = 25 * base
        /// 220
        static let size27xHalf: CGFloat = 27.5 * base
        /// 240
        static let size30x: CGFloat = 30 * base
        /// 320
        static let size40x: CGFloat = 40 * base
        /// 326
        static let size40x3Quarter: CGFloat = 40.75 * base
        /// 342
        static let size42x3Quarter: CGFloat = 42.75 * base

        static let messageButtonSize = CGSize(width: 64.0, height: 72.0)

        /// Size of the button that lives in the bottom right of map and my world.
        static let auxiliaryButtonSize = CGSize(width: 56, height: 64)
    }

    struct Radius {
        /// 10
        static let radius1xQuarter: CGFloat = 1.25 * base
        /// 15
        static let radiusTen: CGFloat = 1.25 * base
        /// 20
        static let radius2x2Quarter: CGFloat = 2.5 * base

        static func computeInnerRadius(outerRadius: CGFloat, gap: CGFloat) -> CGFloat {
            return outerRadius - gap
        }
    }

    struct Height {
        /// 10
        static let ten: CGFloat = 10.0
        /// 24
        static let extraSmall: CGFloat = 24.0
        /// 32
        static let small: CGFloat = 32.0
        /// 40
        static let medium: CGFloat = 40.0
        /// 48
        static let large: CGFloat = 48.0
        /// 56
        static let extraLarge: CGFloat = 56.0
        /// 58
        static let extraLarge2: CGFloat = 58.0
        /// 64
        static let height8x: CGFloat = 64.0
        /// 72
        static let height9x: CGFloat = 72.0
        /// 80
        static let xxLarge: CGFloat = 80.0
        /// 96
        static let height12x: CGFloat = 96.0
        /// 112
        static let xxxLarge: CGFloat = 112.0
        /// 120
        static let hTwenty: CGFloat = 120.0
        /// 128
        static let scrollGradientHeight: CGFloat = 128
        /// 173
        static let scrollListSpacing: CGFloat = 173.0
        /// 220
        static let fiveXLlarge: CGFloat = 220
    }

    struct CellHeight {
        /// 32
        static let xxSmall: CGFloat = 32.0
        /// 40
        static let xSmall: CGFloat = 40.0
        /// 64
        static let small: CGFloat = 64.0
        /// 90
        static let medium: CGFloat = 90.0
        /// 128
        static let large: CGFloat = 128.0
    }
}
