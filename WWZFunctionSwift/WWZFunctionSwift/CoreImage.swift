//
//  CoreImage.swift
//  WWZFunctionSwift
//
//  Created by wwz on 2017/3/30.
//  Copyright © 2017年 tijio. All rights reserved.
//

import UIKit
import CoreImage

typealias Filter = (CIImage) -> CIImage

/// 高斯模糊滤镜
func blur(radius: Double) -> Filter {

    return { image in
        let parameters : [String: Any] = [kCIInputRadiusKey: radius, kCIInputImageKey: image]
        
        guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        
        return outputImage
    }
}

/// 颜色叠层
func colorGenerator(color: UIColor) -> Filter {

    return { _ in
        
        let ciColor = CIColor(color: color)
        let parameters = [kCIInputColorKey: ciColor]
        
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        
        return outputImage
    }
}

/// 合成滤镜
func compositeSourceOver(overlay: CIImage) -> Filter {

    return { image in
        let parameters : [String: Any] = [kCIInputBackgroundImageKey: image, kCIInputImageKey: overlay]
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }

        return outputImage.cropping(to: image.extent)
    }
}

/// 颜色叠层滤镜
func colorOverlay(color: UIColor) -> Filter {

    return { image in
        
        let overlay = colorGenerator(color: color)(image)
        return compositeSourceOver(overlay: overlay)(image)
    }
}

/// 组合
func composeFilters(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {

    return { image in filter2(filter1(image)) }
}


// 一元运算符： postfix
// 二元运算符： infix
infix operator >>>
func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    
    return { image in filter2(filter1(image)) }
}
