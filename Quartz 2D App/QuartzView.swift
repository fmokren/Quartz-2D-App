//
//  QuartzView.swift
//  Quartz 2D App
//
//  Created by Frederic Mokren on 8/16/15.
//  Copyright (c) 2015 Sharp Scissors Software. All rights reserved.
//

import Foundation
import UIKit

class QuartzView : UIView
{
    func makeSquareFromRect(rect: CGRect) -> CGRect
    {
        let side = min(rect.size.width, rect.size.height)
        let square = CGRectMake(rect.origin.x + ((rect.size.width - side) / 2), rect.origin.y + ((rect.size.height - side) / 2), side, side)
        
        return square
    }
    
    func drawGlobe(cxt: CGContextRef, rect: CGRect)
    {
        let square = makeSquareFromRect(rect)
        
        CGContextAddEllipseInRect(cxt, square)
        
        let x = square.origin.x
        let y = square.origin.y
        let midX = square.origin.x + (square.width / 2)
        let midY = square.origin.y  + (square.height / 2)
        let fullX = x + square.size.width
        let fullY = y + square.size.height
        
        CGContextAddLines(cxt, [CGPoint(x: midX, y: y), CGPoint(x: midX, y: fullY)], 2)
        
        CGContextAddLines(cxt, [CGPoint(x: x, y: midY), CGPoint(x: fullX, y: midY)], 2)
        
        
        let eWidth = square.width * 0.5;
        let eHeight = square.height;
        
        let eX = x + (square.width - eWidth) / 2
        let ey = y + (square.height - eHeight) / 2
        
        let eRect = CGRectMake(eX, ey, eWidth, eHeight)
        CGContextAddEllipseInRect(cxt, eRect)
        
        let radius = square.width * 0.5
        
        let startAngle = 45 * M_PI / 180;
        
        let relX = CGFloat(cos(startAngle) * Double(radius))
        let relY = CGFloat(sin(startAngle) * Double(radius))
        
        CGContextMoveToPoint(cxt, midX + relX, midY - relY)
        
        let intY = sqrt(radius * radius - relX * relX)
        let topY = (midY - relY) - intY
        let bottomY = (midY + relY) + intY
        
        let arcStartAngle = CGFloat(M_PI_2) - asin(relX / radius)
        let arcEndAngle = CGFloat(M_PI) - arcStartAngle
        
        CGContextAddArc(cxt, midX, topY, radius, arcStartAngle, arcEndAngle, 0)
        
        CGContextMoveToPoint(cxt, midX + relX, midY + relY)
        
        CGContextAddArc(cxt, midX, bottomY, radius, CGFloat(2 * M_PI) - arcStartAngle, CGFloat(M_PI) + arcStartAngle, 1)
        
        CGContextSetLineWidth(cxt, 1.0)
        
        CGContextStrokePath(cxt)
    }
    
    func drawBackspace(cxt: CGContextRef, rect: CGRect)
    {
        CGContextBeginPath(cxt)
        
        let x = rect.origin.x
        let y = rect.origin.y
        let w = rect.size.width
        let h = rect.size.height
        let r: CGFloat = 5.0
        let a = 45.0 * M_PI / 180.0
        let wp = CGFloat(tan(a)) * h / 2
        let wpp = w - wp
        
        var points:[(x: CGFloat, y: CGFloat)] = []
        points += [(x + w, y + h / 2)]
        points += [(x + w, y + h)]
        points += [(x + wp, y + h)]
        points += [(x, y + h / 2)]
        points += [(x + wp, y)]
        points += [(x + w, y)]
        points += [(x + w, y + h / 2)]
        
        CGContextMoveToPoint(cxt, points[0].x, points[0].y)
        
        for i in 1 ..< points.count - 1
        {
            CGContextAddArcToPoint(cxt, points[i].x, points[i].y, points[i+1].x, points[i+1].y, r)
        }
        
        CGContextClosePath(cxt)
        
        let xRect = CreateSubRect(CGRect(x: x + wp, y: y, width: wpp, height: h), ratio: 0.5)
        
        drawX(cxt, rect: xRect, thickness: 1.0)
        
        CGContextSetRGBFillColor(cxt, 1.0, 1.0, 1.0, 1.0)
        CGContextFillPath(cxt)
    }
    
    func drawX(cxt: CGContextRef, rect: CGRect, thickness: CGFloat)
    {
        let square = makeSquareFromRect(rect)
        
        let t = thickness
        let x = square.origin.x
        let y = square.origin.y
        let l = square.size.width
        let m = l / 2
        
        let points = [
            CGPointMake(x + t, y - t),
            CGPointMake(x - t, y + t),
            CGPointMake(x + m - 2 * t, y + m),
            CGPointMake(x - t, y + l - t),
            CGPointMake(x + t, y + l + t),
            CGPointMake(x + m, y + m + 2 * t),
            CGPointMake(x + l - t, y + l + t),
            CGPointMake(x + l + t, y + l - t),
            CGPointMake(x + m + 2 * t, y + m),
            CGPointMake(x + l + t, y + t),
            CGPointMake(x + l - t, y - t),
            CGPointMake(x + m, y + m - 2 * t)]
        
        CGContextAddLines(cxt, points, points.count)
        CGContextClosePath(cxt)
    }
    
    func CreateSubRect(rect: CGRect, ratio: CGFloat) -> CGRect
    {
        let x = rect.origin.x
        let y = rect.origin.y
        let w = rect.size.width
        let h = rect.size.height
        
        let nw = w * ratio
        let nh = h * ratio
        let bx = (w - nw) / 2
        let by = (h - nh) / 2
        
        return CGRect(x: x + bx, y: y + by, width: nw, height: nh)
    }
    
    override func drawRect(rect: CGRect) {
        let cxt = UIGraphicsGetCurrentContext()
        
        let l: CGFloat = 100.0
        let h = l * 0.5
        
        let centerRect = CGRectMake(rect.origin.x + rect.size.width / 2 - h, rect.origin.y + rect.size.height / 2 - (h * 2), l, l)
        
        drawGlobe(cxt!, rect: centerRect)
        
        let width: CGFloat = 100
        let height: CGFloat = 0.75 * width
        
        let x = rect.origin.x + (rect.size.width - width) / 2
        let y = rect.origin.y + (rect.size.height - height) / 2
        
        let drawRect: CGRect = CGRectMake(x, y + height * 2, width, height)
        
        drawBackspace(cxt!, rect: drawRect)
    }
    
}