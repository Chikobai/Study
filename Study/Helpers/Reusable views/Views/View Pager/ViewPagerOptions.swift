
import UIKit
import Foundation

public class ViewPagerOptions {
    
    public enum Distribution {
        case normal
    }
    
    public var distribution: ViewPagerOptions.Distribution = .normal
    public var tabType:ViewPagerTabType = .basic

    public var tabViewHeight:CGFloat = 44
    public var tabViewTextFont:UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    public var tabViewImageSize:CGSize = CGSize(width: 25, height: 25)
    public var tabViewImageMarginTop:CGFloat = 10
    public var tabViewImageMarginBottom:CGFloat = 5
    public var tabSelectedImageColor = AppColor.main.uiColor
    public var tabUnselectedImageColor = AppColor.secondaryLightGray.uiColor


    public init() {
        // Initialization
    }
    
    fileprivate struct Color {
        
        static let tabViewBackground = UIColor(red: 23 / 255.0, green: 26/255.0, blue: 33/255.0, alpha: 1.0)
        static let tabViewHighlight = tabViewBackground.withAlphaComponent(0.8)
        
        static let textDefault = UIColor.white
        static let textHighlight = UIColor.white
        
        static let tabIndicator =  UIColor(red: 214 / 255.0, green: 73/255.0, blue: 51/255.0, alpha: 1.0)
    }
}
