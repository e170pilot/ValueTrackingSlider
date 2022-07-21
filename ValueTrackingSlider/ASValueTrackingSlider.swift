//  Converted to Swift 5.6.1 by Swiftify v5.6.32533 - https://swiftify.com/
//
//  ASValueTrackingSlider.swift
//  ValueTrackingSlider
//
//  Created by Alan Skipp on 19/10/2013.
//  Copyright (c) 2013 Alan Skipp. All rights reserved.
//

import UIKit

class ASValueTrackingSlider: UISlider, ASValuePopUpViewDelegate {


    var  isTickType : Bool = false
    var  trackFrame : CGRect!
    var ticsAt : [CGFloat]!
    var prayers : CGFloat!
    var tickview : UIView!
    
    
    func setIsTickType(TickType : Bool){
        self.isTickType = TickType
        if (TickType) {
            if (tickview != nil) {
                tickview.isHidden = false
                self.addSubview(tickview)
            }
        }else{
            tickview.isHidden = true;
            tickview.removeFromSuperview()
        }
    }
    
    
    func placeTicMarksAt(ticArray : [CGFloat]) {
        
        self.ticsAt = ticArray
        trackFrame = self.trackRect(forBounds: self.bounds)
        let numberOfTics = ticsAt.count
        let  min = self.minimumValue
        let max = self.maximumValue
        let trackwidth = trackFrame.size.width -  self.thumbRect().size.width + 4
        
        let thumbWidth =  self.thumbRect().size.width / 2.0
        // NSLog(@"%.2f", trackwidth);
       // tickview = UIView(frame: CGRect.zero)
       // tickview.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width, self.frame.size.height);
        tickview = UIView(frame: CGRect.zero)
        tickview.backgroundColor = UIColor.clear
        
        for i in 0..<numberOfTics {
            
            var tic  = ticsAt[i] / CGFloat((max - min)) * trackwidth
            if ( i == 0) {
                tic += 0
            }
            if (i == numberOfTics - 1) {
                tic -=  0
            }
            tic += thumbWidth
            
            let tick = UIView(frame: CGRect(x: tic, y: (self.frame.size.height - 30) / 2  , width: 2, height: 30))
            tick.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
           // tick.layer.shadowColor = UIColor.white.cgColor
            tick.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            tick.layer.shadowOpacity = 1.0
            tick.layer.shadowRadius = 0.0
            tickview.addSubview(tick)
        }
    }
    
    func drawBackground() -> UIView {

        let noOfTicks = ticsAt.count
        // let stepValue = self.frame.size.width / noOfTicks
        let tickwidth = self.frame.size.width; // noOfTicks
        // var xPos = self.frame.origin.x
        // initialize view to return
        let tickview = UIView(frame: self.frame)
        var xPos = tickview.frame.origin.x;
        tickview.backgroundColor = UIColor.clear;
        // make a UIImageView with tick for each tick in the slider
        for i in 0..<noOfTicks {
            
            let tic = ticsAt[i]  / 24.0 *  tickwidth
            
            let tick = UIView(frame: CGRect(x: tic, y: -10, width: 1, height: 30))
           // UIView* tick =  [[UIView alloc] initWithFrame:CGRectMake(tic, -10, 1, 10)]; //  UIView.init(frame: CGRect.init(x: tic, y: 0 / 2, width: 1, height: 10))
            //  UIView *tick = [[UIView alloc] initWithFrame:CGRectMake(xPos,((self.frame.size.height - 10)/2),1, 10)];
            tick.backgroundColor = UIColor.gray ;// init(white: 0.7, alpha: 1) // [UIColor colorWithWhite:0.7 alpha:1];
            tick.layer.shadowColor = UIColor.white.cgColor; // [[UIColor whiteColor] CGColor];
            tick.layer.shadowOffset = CGSize(width: 0.0, height: 0.0);// CGSize.init(width: 0.0, height: 0.0) //  CGSizeMake(0.0f, 1.0f);
            tick.layer.shadowOpacity = 1.0;
            tick.layer.shadowRadius = 1;
            tickview.addSubview(tick) // [tickview insertSubview:tick belowSubview:self];
            xPos += (tickwidth );
        }
        return tickview;
        
    }
    
    
    private var keyTimes: [AnyHashable]?
    private var valueRange: CGFloat = 0.0

    private var _textColor: UIColor?
    var textColor: UIColor? {
        get {
            _textColor
        }
        set(color) {
            _textColor = color
            popUpView?.setTextColor(color)
        }
    }
    // font can not be nil, it must be a valid UIFont
    // default is ‘boldSystemFontOfSize:22.0’

    private var _font: UIFont?
    var font: UIFont? {
        get {
            _font
        }
        set(font) {
            assert(font != nil, "font can not be nil, it must be a valid UIFont")
            _font = font
            popUpView?.setFont(font)
        }
    }
    // setting the value of 'popUpViewColor' overrides 'popUpViewAnimatedColors' and vice versa
    // the return value of 'popUpViewColor' is the currently displayed value
    // this will vary if 'popUpViewAnimatedColors' is set (see below)

    private var _popUpViewColor: UIColor?
    var popUpViewColor: UIColor? {
        get {
            return popUpView?.color ?? _popUpViewColor
        }
        set(color) {
            _popUpViewColor = color
            _popUpViewAnimatedColors = nil // animated colors should be discarded
            popUpView?.color = color

            if autoAdjustTrackColor {
                super.minimumTrackTintColor = popUpView?.opaqueColor
            }
        }
    }
    // pass an array of 2 or more UIColors to animate the color change as the slider moves

    private var _popUpViewAnimatedColors: [UIColor]?
    var popUpViewAnimatedColors: [UIColor]? {
        get {
            _popUpViewAnimatedColors
        }
        set(colors) {
            setPopUpViewAnimatedColors(colors, withPositions: nil)
        }
    }
    // cornerRadius of the popUpView, default is 4.0

    var popUpViewCornerRadius: CGFloat {
        get {
            return popUpView?.cornerRadius ?? 0.0
        }
        set(radius) {
            popUpView?.cornerRadius = radius
        }
    }
    // arrow height of the popUpView, default is 13.0

    var popUpViewArrowLength: CGFloat {
        get {
            return popUpView?.arrowLength ?? 0.0
        }
        set(length) {
            popUpView?.arrowLength = length
        }
    }
    // width padding factor of the popUpView, default is 1.15

    var popUpViewWidthPaddingFactor: CGFloat {
        get {
            return popUpView?.widthPaddingFactor ?? 0.0
        }
        set(factor) {
            popUpView?.widthPaddingFactor = factor
        }
    }
    // height padding factor of the popUpView, default is 1.1

    var popUpViewHeightPaddingFactor: CGFloat {
        get {
            return popUpView?.heightPaddingFactor ?? 0.0
        }
        set(factor) {
            popUpView?.heightPaddingFactor = factor
        }
    }
    // changes the left handside of the UISlider track to match current popUpView color
    // the track color alpha is always set to 1.0, even if popUpView color is less than 1.0

    private var _autoAdjustTrackColor = false
    var autoAdjustTrackColor: Bool {
        get {
            _autoAdjustTrackColor
        }
        set(autoAdjust) {
            if _autoAdjustTrackColor == autoAdjust {
                return
            }

            _autoAdjustTrackColor = autoAdjust

            // setMinimumTrackTintColor has been overridden to also set autoAdjustTrackColor to NO
            // therefore super's implementation must be called to set minimumTrackTintColor
            if !autoAdjust {
                super.minimumTrackTintColor = nil // sets track to default blue color
            } else {
                super.minimumTrackTintColor = popUpView?.opaqueColor
            }
        }
    } // (default is YES)
    // take full control of the format dispayed with a custom NSNumberFormatter

    private var _numberFormatter: NumberFormatter?
    var numberFormatter: NumberFormatter? {
        get {
            return _numberFormatter // return a copy to prevent formatter properties changing and causing mayhem
        }
        set(numberFormatter) {
            _numberFormatter = numberFormatter
        }
    }
    // supply entirely customized strings for slider values using the datasource protocol - see below
    weak var dataSource: ASValueTrackingSliderDataSource?
    // delegate is only needed when used with a TableView or CollectionView - see below
    weak var delegate: ASValueTrackingSliderDelegate?
    private var popUpView: ASValuePopUpView?
    private var popUpViewAlwaysOn = false // default is NO

    // MARK: - initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // if 2 or more colors are present, set animated colors
    // if only 1 color is present then call 'setPopUpViewColor:'
    // if arg is nil then restore previous _popUpViewColor
    func setPopUpViewAnimatedColors(_ colors: [UIColor]?, withPositions positions: [CGFloat]?) {
        if let positions = positions {
            assert((colors?.count ?? 0) == positions.count, "popUpViewAnimatedColors and locations should contain the same number of items")
        }

        _popUpViewAnimatedColors = colors
        keyTimes = keyTimes(fromSliderPositions: positions)

        if (colors?.count ?? 0) >= 2 {
            popUpView?.setAnimatedColors(colors, withKeyTimes: keyTimes)
        } else {
            popUpViewColor = colors?.last ?? _popUpViewColor
        }
    }

    // when either the min/max value or number formatter changes, recalculate the popUpView width
    override var maximumValue: Float {
        get {
            super.maximumValue
        }
        set(maximumValue) {
            super.maximumValue = maximumValue
            valueRange = CGFloat(self.maximumValue - minimumValue)
        }
    }

    override var minimumValue: Float {
        get {
            super.minimumValue
        }
        set(minimumValue) {
            super.minimumValue = minimumValue
            valueRange = CGFloat(maximumValue - self.minimumValue)
        }
    }

    // when setting max FractionDigits the min value is automatically set to the same value
    // this ensures that the PopUpView frame maintains a consistent width

    // set max and min digits to same value to keep string length consistent
    func setMaxFractionDigitsDisplayed(_ maxDigits: Int) {
        numberFormatter?.maximumFractionDigits = maxDigits
        numberFormatter?.minimumFractionDigits = maxDigits
    }

    // present the popUpView manually, without touch event.
    func showPopUpView(animated: Bool) {
        popUpViewAlwaysOn = true
        _showPopUpView(animated: animated)
    }

    // the popUpView will not hide again until you call 'hidePopUpViewAnimated:'
    func hidePopUpView(animated: Bool) {
        popUpViewAlwaysOn = false
        _hidePopUpView(animated: animated)
    }

    // MARK: - ASValuePopUpViewDelegate

    func colorDidUpdate(_ opaqueColor: UIColor?) {
        super.minimumTrackTintColor = opaqueColor
    }

    // returns the current offset of UISlider value in the range 0.0 – 1.0
    var currentValueOffset: CGFloat {
            return CGFloat((value - minimumValue)) / valueRange

    }

    // MARK: - private

    func setup() {
        autoAdjustTrackColor = true
        valueRange = CGFloat(maximumValue - minimumValue)
        popUpViewAlwaysOn = false

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        numberFormatter = formatter

        popUpView = ASValuePopUpView(frame: CGRect.zero)
        popUpViewColor = UIColor(hue: 0.6, saturation: 0.6, brightness: 0.5, alpha: 0.8)

        popUpView?.alpha = 0.0
        popUpView?.delegate = self
        if let popUpView = popUpView {
            addSubview(popUpView)
        }

        textColor = UIColor.white
        font = UIFont.boldSystemFont(ofSize: 22.0)
        
        
        trackFrame = self.trackRect(forBounds: self.bounds)
    }

    // ensure animation restarts if app is closed then becomes active again
    @objc func didBecomeActiveNotification(_ note: Notification?) {
        if popUpViewAnimatedColors != nil {
            popUpView?.setAnimatedColors(popUpViewAnimatedColors, withKeyTimes: keyTimes)
        }
    }

    func updatePopUpView() {
        var valueString: String? // ask dataSource for string, if nil or blank, get string from _numberFormatter
        var popUpViewSize: CGSize
        if (valueString = dataSource?.slider(self, stringForValue: value)) != nil && (valueString?.count ?? 0) != 0 {
            popUpViewSize = popUpView?.popUpSize(for: valueString) ?? CGSize.zero
        } else {
            valueString = numberFormatter?.string(from: NSNumber(value: value))
            popUpViewSize = calculatePopUpViewSize()
        }

        // calculate the popUpView frame
        let thumbRect = self.thumbRect()
        let thumbW = thumbRect.size.width
        let thumbH = thumbRect.size.height

        var popUpRect = thumbRect.insetBy(dx: (thumbW - popUpViewSize.width) / 2, dy: (thumbH - popUpViewSize.height) / 2)
        popUpRect.origin.y = thumbRect.origin.y - popUpViewSize.height

        // determine if popUpRect extends beyond the frame of the progress view
        // if so adjust frame and set the center offset of the PopUpView's arrow
        let minOffsetX = popUpRect.minX
        let maxOffsetX = popUpRect.maxX - bounds.width

        let offset = minOffsetX < 0.0 ? minOffsetX : (maxOffsetX > 0.0 ? maxOffsetX : 0.0)
        popUpRect.origin.x -= offset

        popUpView?.setFrame(popUpRect, arrowOffset: offset, text: valueString)
    }

    func calculatePopUpViewSize() -> CGSize {
        // negative values need more width than positive values
        let minValSize = popUpView?.popUpSize(for: numberFormatter?.string(from: NSNumber(value: minimumValue)))
        let maxValSize = popUpView?.popUpSize(for: numberFormatter?.string(from: NSNumber(value: maximumValue)))

        return (((minValSize?.width ?? 0.0) >= (maxValSize?.width ?? 0.0)) ? minValSize : maxValSize) ?? CGSize.zero
    }

    // takes an array of NSNumbers in the range self.minimumValue - self.maximumValue
    // returns an array of NSNumbers in the range 0.0 - 1.0
    func keyTimes(fromSliderPositions positions: [AnyHashable]?) -> [AnyHashable]? {
        if positions == nil {
            return nil
        }

        var keyTimes: [AnyHashable] = []
        for num in (positions as NSArray?)?.sortedArray(using: #selector(NSNumber.compare(_:))) ?? [] {
            guard let num = num as? NSNumber else {
                continue
            }
            keyTimes.append(NSNumber(value: Float(CGFloat((num.floatValue - minimumValue)) / valueRange)))
        }
        return keyTimes
    }

    func thumbRect() -> CGRect {
        return self.thumbRect(
            forBounds: bounds,
            trackRect: trackRect(forBounds: bounds),
            value: value)
    }

    func _showPopUpView(animated: Bool) {
        if let delegate = delegate {
            delegate.sliderWillDisplayPopUpView(self)
        }
        popUpView?.show(animated: animated)
    }

    func _hidePopUpView(animated: Bool) {
        if delegate?.responds(to: #selector(ASValueTrackingSliderDelegate.sliderWillHidePopUpView(_:))) ?? false {
            delegate?.sliderWillHidePopUpView?(self)
        }
        popUpView?.hide(animated: animated) { [self] in
            if delegate?.responds(to: #selector(ASValueTrackingSliderDelegate.sliderDidHidePopUpView(_:))) ?? false {
                delegate?.sliderDidHidePopUpView?(self)
            }
        }
    }

    // MARK: - subclassed

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePopUpView()
    }

    override func didMoveToWindow() {
        if window == nil {
            // removed from window - cancel notifications
            NotificationCenter.default.removeObserver(self)
        } else {
            // added to window - register notifications

            if popUpViewAnimatedColors != nil {
                // restart color animation if needed
                popUpView?.setAnimatedColors(popUpViewAnimatedColors, withKeyTimes: keyTimes)
            }

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(didBecomeActiveNotification(_:)),
                name: UIApplication.didBecomeActiveNotification,
                object: nil)
        }
    }

    override var value: Float {
        get {
            super.value
        }
        set(value) {
            super.value = value
            popUpView?.setAnimationOffset(currentValueOffset, returnColor: { opaqueReturnColor in
                super.minimumTrackTintColor = opaqueReturnColor
            })
        }
    }

    override func setValue(_ value: Float, animated: Bool) {
        if animated {
            popUpView?.animateBlock({  duration in
                UIView.animate(withDuration: TimeInterval(duration), animations: {
                    super.setValue(value, animated: animated)
                    self.popUpView?.setAnimationOffset(self.currentValueOffset, returnColor: { opaqueReturnColor in
                        super.minimumTrackTintColor = opaqueReturnColor
                    })
                    self.layoutIfNeeded()
                })
            })
        } else {
            super.setValue(value, animated: animated)
        }
    }

    override var minimumTrackTintColor: UIColor? {
        get {
            super.minimumTrackTintColor
        }
        set(color) {
            autoAdjustTrackColor = false // if a custom value is set then prevent auto coloring
            super.minimumTrackTintColor = color
        }
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let begin = super.beginTracking(touch, with: event)
        if begin && !popUpViewAlwaysOn {
            _showPopUpView(animated: true)
        }
        return begin
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let continueTrack = super.continueTracking(touch, with: event)
        if continueTrack {
            popUpView?.setAnimationOffset(currentValueOffset, returnColor: { opaqueReturnColor in
                super.minimumTrackTintColor = opaqueReturnColor
            })
        }
        return continueTrack
    }

    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        if !popUpViewAlwaysOn {
            _hidePopUpView(animated: true)
        }
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        if !popUpViewAlwaysOn { _hidePopUpView(animated: true) }
        
        
        if (isTickType) {
            var previuosTick : CGFloat = 0
            for i in 0...ticsAt.count  {
                let tic =  i == ticsAt.count  ? CGFloat(self.maximumValue) : ticsAt[i]
                previuosTick = i == 0  ? CGFloat(self.minimumValue) : ticsAt[i - 1]
               // if ( previuosTick  == _ticsAt.count ) { tickPlace =  self.maximumValue;}
                let value = CGFloat(self.value)
                if (tic > value) {
                    let halfDistance = (tic - previuosTick) / 2.0
                    if (value > previuosTick + halfDistance ) {
                        self.value = Float(tic)
                     //   NSLog(@"%.2f", tic);
                        break;
                    } else {
                        self.value = Float(previuosTick)
                      //  NSLog(@"%.2f", self.value);
                        break;
                    }
                }
            } // end of for loop
            self.updatePopUpView()
        }
    }
}
// to supply custom text to the popUpView label, implement <ASValueTrackingSliderDataSource>
// the dataSource will be messaged each time the slider value changes
protocol ASValueTrackingSliderDataSource: NSObjectProtocol {
    func slider(_ slider: ASValueTrackingSlider?, stringForValue value: Float) -> String?
}

// when embedding an ASValueTrackingSlider inside a TableView or CollectionView
// you need to ensure that the cell it resides in is brought to the front of the view hierarchy
// to prevent the popUpView from being obscured
@objc protocol ASValueTrackingSliderDelegate: NSObjectProtocol {
    func sliderWillDisplayPopUpView(_ slider: ASValueTrackingSlider?)

    @objc optional func sliderWillHidePopUpView(_ slider: ASValueTrackingSlider?)
    @objc optional func sliderDidHidePopUpView(_ slider: ASValueTrackingSlider?)
}

/*
// the recommended technique for use with a tableView is to create a UITableViewCell subclass ↓

 @interface SliderCell : UITableViewCell <ASValueTrackingSliderDelegate>
 @property (weak, nonatomic) IBOutlet ASValueTrackingSlider *slider;
 @end

 @implementation SliderCell
 - (void)awakeFromNib
 {
    [super awakeFromNib];
    self.slider.delegate = self;
 }

 - (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider;
 {
    [self.superview bringSubviewToFront:self];
 }
 @end
 */
