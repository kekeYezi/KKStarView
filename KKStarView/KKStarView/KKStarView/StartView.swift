//
//  StartView.swift
//  KKStarView
//
//  Created by Daniel on 17/5/13.
//  Copyright © 2017年 kekeYezi. All rights reserved.
//

import Foundation
import UIKit

class StartView: UIView {
    var starModel : StarModel = StarModel.init()
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(colorLiteralRed: 0.129, green: 0.5686, blue: 0.5686, alpha: 1)
        self.starModel = StarModel.init()
        
        let cadiplaylink : CADisplayLink = CADisplayLink.init(target: self, selector: #selector(StartView.drawSelf))
        cadiplaylink.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawSelf() {
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        self.starModel.updateStarData()
        UIColor.init(colorLiteralRed: 1, green: 0.913, blue: 1, alpha: 0.8).set()
        let currentContext : CGContext = UIGraphicsGetCurrentContext()!
        
        currentContext.setStrokeColor(red: 0.3058, green: 0.698, blue: 0.6039, alpha: 0.2)
        currentContext.setLineWidth(1.0)
        
        for star in self.starModel.starAry {
            currentContext.addEllipse(in: CGRect.init(x: star.starCenter.x, y: star.starCenter.y, width: 4, height: 4))
            currentContext.setFillColor(red: 1, green: 0.93, blue: 1, alpha: 1)
            currentContext.fillPath()
        }

        for tmpline in self.starModel.linesAry {
            currentContext.move(to: CGPoint.init(x: tmpline.startPoint.x, y: tmpline.startPoint.y))
            currentContext.addLine(to: CGPoint.init(x: tmpline.endPoint.x, y: tmpline.endPoint.y))
        }
        
        currentContext.strokePath()
    }
}
