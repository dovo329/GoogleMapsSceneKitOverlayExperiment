//
//  DougViewController.h
//  SDKDemos
//
//  Created by Douglas Voss on 5/1/15.
//
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <math.h>
#import <SpriteKit/SpriteKit.h>
#import <SceneKit/SceneKit.h>

@interface DougViewController : UIViewController

@property (nonatomic, readwrite) float cameraViewAngle;
@property (nonatomic, readwrite) float cameraViewAngleVelocity;
@property (nonatomic, readwrite) float cameraBearing;
@property (nonatomic, readwrite) float cameraBearingVelocity;
@property (nonatomic, readwrite) GMSMapView *mapView;
@property (nonatomic, readwrite) GMSMutableCameraPosition *cameraPosition;

@end
