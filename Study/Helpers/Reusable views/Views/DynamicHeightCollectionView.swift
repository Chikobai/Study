//
//  DynamicHeightCollectionView.swift
//  Study
//
//  Created by I on 3/13/20.
//  Copyright © 2020 Shyngys. All rights reserved.
//

import Foundation
import UIKit

class DynamicHeightCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var tempCellAttributesArray = [UICollectionViewLayoutAttributes]()
    let leftEdgeInset: CGFloat = 10

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let cellAttributesArray = super.layoutAttributesForElements(in: rect)
        //Oth position cellAttr is InConvience Emoji Cell, from 1st onwards info cells are there, thats why we start count from 2nd position.
        if(cellAttributesArray != nil && cellAttributesArray!.count > 1) {
            for i in 1..<(cellAttributesArray!.count) {
                let prevLayoutAttributes: UICollectionViewLayoutAttributes = cellAttributesArray![i - 1]
                let currentLayoutAttributes: UICollectionViewLayoutAttributes = cellAttributesArray![i]
                let maximumSpacing: CGFloat = 8
                let prevCellMaxX: CGFloat = prevLayoutAttributes.frame.maxX
                //UIEdgeInset 30 from left
                let collectionViewSectionWidth = self.collectionViewContentSize.width - leftEdgeInset
                let currentCellExpectedMaxX = prevCellMaxX + maximumSpacing + (currentLayoutAttributes.frame.size.width )
                if currentCellExpectedMaxX < collectionViewSectionWidth {
                    var frame: CGRect? = currentLayoutAttributes.frame
                    frame?.origin.x = prevCellMaxX + maximumSpacing
                    frame?.origin.y = prevLayoutAttributes.frame.origin.y
                    currentLayoutAttributes.frame = frame ?? CGRect.zero
                } else {
                    // self.shiftCellsToCenter()
                    currentLayoutAttributes.frame.origin.x = 0
                    //To Avoid InConvience Emoji Cell
                    if (prevLayoutAttributes.frame.origin.x != 0) {
                        currentLayoutAttributes.frame.origin.y = prevLayoutAttributes.frame.origin.y + prevLayoutAttributes.frame.size.height + 08
                    }
                }
                // print(currentLayoutAttributes.frame)
            }
            //print("Main For Loop End")
        }
        // self.shiftCellsToCenter()
        return cellAttributesArray
    }

    func shiftCellsToCenter() {
        if (tempCellAttributesArray.count == 0) {return}
        let lastCellLayoutAttributes = self.tempCellAttributesArray[self.tempCellAttributesArray.count-1]
        let lastCellMaxX: CGFloat = lastCellLayoutAttributes.frame.maxX
        let collectionViewSectionWidth = self.collectionViewContentSize.width - leftEdgeInset
        let xAxisDifference = collectionViewSectionWidth - lastCellMaxX
        if xAxisDifference > 0 {
            for each in self.tempCellAttributesArray{
                each.frame.origin.x += xAxisDifference/2
            }
        }

    }
}

import UIKit

class TokenCollViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementsInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()

        var leftMargin: CGFloat = self.sectionInset.left

        for attributes in attributesForElementsInRect! {
            if (attributes.frame.origin.x == self.sectionInset.left) {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = attributes.frame

                if leftMargin + attributes.frame.width < self.collectionViewContentSize.width {
                    newLeftAlignedFrame.origin.x = leftMargin
                } else {
                    newLeftAlignedFrame.origin.x = self.sectionInset.left
                }

                attributes.frame = newLeftAlignedFrame
            }
            leftMargin += attributes.frame.size.width + 8
            newAttributesForElementsInRect.append(attributes)
        }

        return newAttributesForElementsInRect
    }
}

//class DynmicHeightCollectionView: UICollectionView {
//
//    var isDynamicSizeRequired = false
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
//
//            if self.intrinsicContentSize.height > frame.size.height {
//                self.invalidateIntrinsicContentSize()
//            }
//            if isDynamicSizeRequired {
//                self.invalidateIntrinsicContentSize()
//            }
//        }
//    }
//
//    override var intrinsicContentSize: CGSize {
//        return contentSize
//    }
//}

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        return collectionViewLayout.collectionViewContentSize
    }
}
