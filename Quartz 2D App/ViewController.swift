//
//  ViewController.swift
//  Quartz 2D App
//
//  Created by Frederic Mokren on 8/16/15.
//  Copyright (c) 2015 Sharp Scissors Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createBitmapContext(width: Int, height: Int) -> CGContextRef
    {
        let bitmapBytesPerRow = width * 4
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let cxt = CGBitmapContextCreate(nil, width, height, 8, bitmapBytesPerRow, colorSpace, CGImageAlphaInfo.PremultipliedLast.rawValue)
        
        return cxt!
    }
    
    /*
        CGContextRef    context = NULL;
        CGColorSpaceRef colorSpace;
        void *          bitmapData;
        int             bitmapByteCount;
        int             bitmapBytesPerRow;
    
        bitmapBytesPerRow   = (pixelsWide * 4);// 1
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);// 2
    bitmapData = calloc( bitmapByteCount );// 3
    if (bitmapData == NULL)
    {
    fprintf (stderr, "Memory not allocated!");
    return NULL;
    }
    context = CGBitmapContextCreate (bitmapData,// 4
    pixelsWide,
    pixelsHigh,
    8,      // bits per component
    bitmapBytesPerRow,
    colorSpace,
    kCGImageAlphaPremultipliedLast);
    if (context== NULL)
    {
    free (bitmapData);// 5
    fprintf (stderr, "Context not created!");
    return NULL;
    }
    CGColorSpaceRelease( colorSpace );// 6
    
    return context;// 7
    }
    
    */
}

