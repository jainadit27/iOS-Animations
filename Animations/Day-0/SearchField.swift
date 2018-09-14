//
//  SearchField.swift
//  Animations
//
//  Created by Aditya Jain on 9/14/18.
//  Copyright © 2018 Aditya. All rights reserved.
//

import UIKit

class SearchField : UITextField {
    
    var cursorWidth : CGFloat = 0
    var cursorHeight : CGFloat = 0
    var cursorYOffset : CGFloat = 0
    
    init(cursorWidth : CGFloat, cursorHeight : CGFloat, cursorYOffset : CGFloat){
        super.init(frame: CGRect.zero)
        self.cursorWidth = cursorWidth
        self.cursorHeight = cursorHeight
        self.cursorYOffset = cursorYOffset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        var rect : CGRect = super.caretRect(for: position)
        rect.origin.y = rect.origin.y - cursorYOffset
        rect.size.height = self.cursorHeight
        rect.size.width = self.cursorWidth
        return rect
    }
}
