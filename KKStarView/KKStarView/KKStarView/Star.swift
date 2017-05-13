//
//  Star.swift
//  KKStarView
//
//  Created by Daniel on 17/5/13.
//  Copyright © 2017年 kekeYezi. All rights reserved.
//

import Foundation
import UIKit

let WIDTH = UIScreen.main.bounds.size.width
let HIGHT = UIScreen.main.bounds.size.height
let starRadius : CGFloat = 2
let maxCount = 60

class Star: NSObject {
    var starCenter : CGPoint = CGPoint.init()
    var speed : CGFloat = 0.0
    var angle : CGFloat = 0.0
    
    init(centerX : CGFloat , centerY : CGFloat ) {
        super.init()
        self.starCenter = CGPoint.init(x: centerX, y: centerY)
    }
    
    func changeValue() {
        self.starCenter = CGPoint.init(x: self.starCenter.x + self.speed * (cos(self.angle)) , y: self.starCenter.y + self.speed * (sin(self.angle)))
        
        //星星碰撞屏幕 反向运行
        if self.starCenter.x < starRadius || self.starCenter.x >= WIDTH - starRadius {
            self.angle = self.angle + CGFloat(M_PI_2)
        }
        
        if self.starCenter.y < starRadius || self.starCenter.y >= HIGHT - starRadius {
            self.angle = -self.angle
        }
    }
}

class StarLine: NSObject {
    var startPoint : CGPoint = CGPoint.init()
    var endPoint : CGPoint = CGPoint.init()
    
    override init() {
        super.init()
    }
}

class StarModel: NSObject {
    var starAry : [Star] = [Star]()
    var linesAry : [StarLine] = [StarLine]()
    
    override init() {
        super.init()
        for _ in 0...maxCount {
            self.starAry.append(self.produceStar())
        }
    }
    
    func updateStarData() {
        for star in self.starAry {
            star.changeValue()
        }
        
        self.makeLinesAry()
    }
    
    func produceStar() -> Star {
        let x : CGFloat = CGFloat(arc4random() % UInt32(WIDTH))
        let y : CGFloat = CGFloat(arc4random() % UInt32(HIGHT))
        
        let star = Star.init(centerX: x, centerY: y)
        
        let a  = arc4random() % UInt32(10)
        let speed : CGFloat = CGFloat(a) / 10 + 0.8
        star.speed = speed == 0 ? 0.1 : speed;
        
        let angle : CGFloat = CGFloat(arc4random() % UInt32(10) / 10 * UInt32(M_PI));
        star.angle = angle == 0 ? CGFloat(M_PI_4) : angle;
        
        return star
    }
    
    func makeLinesAry() {
        self.linesAry.removeAll()
        for star1 in self.starAry {
            for star2 in self.starAry {
                if self.ifProduceLines(star1: star1, star2: star2, distance: 60) {
                    let line : StarLine = StarLine.init()
                    line.startPoint = star1.starCenter
                    line.endPoint = star2.starCenter
                    self.linesAry.append(line)
                }
            }
        }
    }
    
    func ifProduceLines(star1 : Star , star2 : Star , distance : Double) -> Bool {
        let x : Double = Double(star1.starCenter.x - star2.starCenter.x)
        let y : Double = Double(star1.starCenter.y - star2.starCenter.y)
        
        if sqrt(x * x + y * y) < distance {
            return true
        } else {
            return false
        }
    }
}
