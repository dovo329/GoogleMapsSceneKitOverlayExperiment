//
//  DougViewController.m
//  SDKDemos
//
//  Created by Douglas Voss on 5/1/15.
//
//

#import "DougViewController.h"

static NSString const * kSatelliteType = @"Satellite";


@implementation DougViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.cameraViewAngle = 45;
  self.cameraViewAngleVelocity = -1;
  self.cameraBearing = 0;
  self.cameraBearingVelocity = 1;
  self.mapView = [[GMSMapView alloc] initWithFrame:self.view.bounds];
    
  self.mapView.mapType = kGMSTypeSatellite;
    
  self.mapView.settings.zoomGestures = NO;
  self.mapView.settings.scrollGestures = NO;
  self.mapView.settings.rotateGestures = NO;
  self.mapView.settings.tiltGestures = NO;
    GMSCameraPosition *camPos = [GMSCameraPosition cameraWithLatitude:40.75
                                                          longitude:-111.8833
                                                               zoom:13
                                                            bearing:self.cameraBearing
                                                      viewingAngle:self.cameraViewAngle];
    //[self.mapView moveCamera:[GMSCameraUpdate setCamera:camPos]];
    [self.mapView animateWithCameraUpdate:[GMSCameraUpdate setCamera:camPos]];
    

  self.view = self.mapView;
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 20)];
    testLabel.textColor = [UIColor whiteColor];
    testLabel.backgroundColor = [UIColor clearColor];
    testLabel.text = @"Test Text";
    [self.view addSubview:testLabel];
    
  NSTimer *updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(updateMethod:)
                                   userInfo:nil
                                    repeats:YES];
    
    //OverlayView *overlayView = [[OverlayView alloc] init];
    //NSLog(@"overlayView = %@; frame = %@", overlayView, overlayView.frame);
    //[self.view addSubview:overlayView];
    //SCNView *sceneView = [[SCNView alloc] initWithFrame:CGRectMake(0, 50, 320, 100)];
    SCNView *sceneView = [[SCNView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //sceneView.backgroundColor = [UIColor blueColor];
    sceneView.backgroundColor = [UIColor clearColor];
    SCNScene *scene = [SCNScene scene];
    
    // Create a camera and attach it to a node
    SCNCamera *camera = [SCNCamera camera];
    camera.xFov = 10;
    camera.yFov = 45;
    
    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 50);
    [scene.rootNode addChildNode:cameraNode]; // Place camera in the scene
    
    // Create a cube and place it in the scene
    SCNBox *cube = [SCNBox boxWithWidth:5 height:5 length:5 chamferRadius:0.0];
    cube.firstMaterial.diffuse.contents = [UIColor colorWithRed:0.149 green:0.604 blue:0.859 alpha:1.000];
    SCNNode *cubeNode = [SCNNode nodeWithGeometry:cube];
    [scene.rootNode addChildNode:cubeNode];
    
    // Add an animation to the cube.
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"rotation"];
    animation.values = @[[NSValue valueWithSCNVector4:SCNVector4Make(1, 1, 0.3, 0 * M_PI)],
                         [NSValue valueWithSCNVector4:SCNVector4Make(1, 1, 0.3, 1 * M_PI)],
                         [NSValue valueWithSCNVector4:SCNVector4Make(1, 1, 0.3, 2 * M_PI)]];
    animation.duration = 5;
    animation.repeatCount = HUGE_VALF;
    [cubeNode addAnimation:animation forKey:@"rotation"];
    cubeNode.paused = NO; // Start out paused
    
    sceneView.scene = scene;
    
    [self.view addSubview:sceneView];
}

-(void)updateMethod:(NSTimer *)timer
{
    //self.cameraViewAngle += self.cameraViewAngleVelocity;
    self.cameraBearing += self.cameraBearingVelocity;
    self.cameraBearing = fmodf(self.cameraBearing, 360);
    if (self.cameraViewAngle < 1.0) {
        self.cameraViewAngle = 0.0;
        self.cameraViewAngleVelocity = -self.cameraViewAngleVelocity;
    }
    if (self.cameraViewAngle > 44.0) {
        self.cameraViewAngle = 45.0;
        self.cameraViewAngleVelocity = -self.cameraViewAngleVelocity;
    }
    
    //NSLog(@"self.cameraViewAngle=%f", self.cameraViewAngle);
    //NSLog(@"self.cameraBearing=%f", self.cameraBearing);
    //[self.mapView animateToViewingAngle:self.cameraViewAngle];
    //[self.mapView animateToBearing:self.cameraBearing];
    
    GMSCameraPosition *camPos = [GMSCameraPosition cameraWithLatitude:40.75
                                                          longitude:-111.8833
                                                               zoom:13
                                                            bearing:self.cameraBearing
                                                      viewingAngle:self.cameraViewAngle];
    //[self.mapView moveCamera:[GMSCameraUpdate setCamera:camPos]];
    [self.mapView animateWithCameraUpdate:[GMSCameraUpdate setCamera:camPos]];
    
}

@end

