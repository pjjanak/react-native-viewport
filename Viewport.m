#import "Viewport.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#import "RCTUtils.h"

static NSDictionary *RCTCurrentDimensions()
{
  static NSDictionary *dimensions;
  
  CGSize frameSize = [UIScreen mainScreen].applicationFrame.size;
  if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
      && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
    frameSize = CGSizeMake(frameSize.height, frameSize.width);
  }
  
  dimensions = @{
                 @"width": @(frameSize.width),
                 @"height": @(frameSize.height)
                 };
  
  return dimensions;
}


@implementation Viewport
{
  NSDictionary *_lastKnownDimensions;
}

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

#pragma mark - Lifecycle

- (instancetype)init
{
  if ((self = [super init])) {
    _lastKnownDimensions = RCTCurrentDimensions();
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
  }
  
  return self;
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification methods

- (void)deviceOrientationDidChangeNotification:(NSNotification*)note
{
  _lastKnownDimensions = RCTCurrentDimensions();
  [_bridge.eventDispatcher sendDeviceEventWithName:@"dimensionsDidChange" body:_lastKnownDimensions];
}

#pragma mark - Public API
/**
 * Get the current dimensions of the viewport
 */
RCT_EXPORT_METHOD(getCurrentDimensions:(RCTResponseSenderBlock)callback)
{
  _lastKnownDimensions = RCTCurrentDimensions();
  callback(@[_lastKnownDimensions]);
}

@end
