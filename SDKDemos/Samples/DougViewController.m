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
/*    GMSMutableCameraPosition *camera = [GMSMutableCameraPosition
                                        cameraWithLatitude:40.75
                                                 longitude:-111.8833
                                                      zoom:13];
    
    //camera.viewingAngle = 45.0;
    self.view = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    [self.view animateToViewingAngle:45.0];*/
    
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
  /*    SCNView *sceneView = [[SCNView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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
    
    [self.view addSubview:sceneView];*/
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

/*
 import SceneKit
 import SpriteKit
 import Foundation
 
 let cameraStartVector = SCNVector3(x: 0.0, y: 35.0, z: 120.0)
 let labelHeight : CGFloat = 20.0
 let kMinY : Float = 1.5
 
 class ViewController: UIViewController {
 
 var geometryNode: SCNNode = SCNNode()
 var currentX: Float = cameraStartVector.x
 var currentY: Float = cameraStartVector.y
 var currentZ: Float = cameraStartVector.z
 
 var currentYaw: Float = 0.0
 var currentPitch: Float = 0.0
 var currentRoll: Float = 0.0
 var positionLabel : UILabel?
 var rotationLabel : UILabel?
 
 func radiansToDegrees(angleInRadians: Float) -> (Float) {
 return (Float)(180.0/M_PI)*angleInRadians;
 }
 
 func degreesToRadians(angleInDegrees: Float) -> (Float) {
 return (Float)(M_PI/180.0)*angleInDegrees;
 }
 
 
 override func viewDidLoad() {
 
 super.viewDidLoad()
 
 let scene = SCNScene()
 let sceneView = SCNView()
 sceneView.frame = self.view.frame
 sceneView.autoresizingMask = UIViewAutoresizing.allZeros
 sceneView.scene = scene
 sceneView.autoenablesDefaultLighting = true
 sceneView.allowsCameraControl = false
 sceneView.backgroundColor = UIColor.blueColor()
 self.view = sceneView
 
 //Add camera to scene.
 let camera = self.makeCamera()
 scene.rootNode.addChildNode(camera)
 
 geometryNode = camera;
 
 let panRecognizer = UIPanGestureRecognizer(target: self, action: "panGesture:")
 panRecognizer.minimumNumberOfTouches = 1
 panRecognizer.maximumNumberOfTouches = 1
 sceneView.addGestureRecognizer(panRecognizer)
 
 let panRecognizer2 = UIPanGestureRecognizer(target: self, action: "panGesture2:")
 panRecognizer2.minimumNumberOfTouches = 2
 panRecognizer2.maximumNumberOfTouches = 2
 sceneView.addGestureRecognizer(panRecognizer2)
 
 let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "pinchGesture:")
 sceneView.addGestureRecognizer(pinchRecognizer)
 
 //Add some ambient light so it's not so dark.
 let lights = self.makeAmbientLight()
 scene.rootNode.addChildNode(lights)
 
 //Create and add the floor.
 let floor = self.makeFloor()
 scene.rootNode.addChildNode(floor)
 
 self.buildStonehenge(scene)
 
 positionLabel = UILabel(frame: CGRectMake(15, self.view.bounds.size.height-(labelHeight*2), self.view.bounds.size.width, labelHeight))
 positionLabel!.textAlignment = NSTextAlignment.Left
 positionLabel!.textColor = UIColor.whiteColor()
 self.view.addSubview(positionLabel!)
 
 
 rotationLabel = UILabel(frame: CGRectMake(15, self.view.bounds.size.height-labelHeight, self.view.bounds.size.width, labelHeight))
 //rotationLabel.center = CGPointMake(160, 284)
 rotationLabel!.textAlignment = NSTextAlignment.Left
 rotationLabel!.textColor = UIColor.whiteColor()
 self.view.addSubview(rotationLabel!)
 
 self.updateLabels(x:currentX, y:currentY, z:currentZ, yaw:currentYaw, pitch:currentPitch, roll:currentRoll)
 }
 
 func updateLabels(#x: Float, y: Float, z: Float, yaw: Float, pitch: Float, roll: Float) {
 positionLabel!.text = String(format: "x:%.2f y:%.2f z:%.2f", x, y, z)
 rotationLabel!.text = String(format: "yaw:%0.2f pitch:%0.2f roll:%02.f", self.radiansToDegrees(yaw), self.radiansToDegrees(pitch), self.radiansToDegrees(roll))
 }
 
 func pinchGesture(sender: UIPinchGestureRecognizer) {

var scaleFactor = ((Float)(-sender.velocity))

var deltaX = scaleFactor*(sin(currentYaw)*cos(currentPitch))
var deltaY = -scaleFactor*(sin(currentPitch))
var deltaZ = scaleFactor*(cos(currentPitch) * cos(currentYaw))

currentX += deltaX
currentY += deltaY
currentZ += deltaZ

if (currentY < kMinY) {
    currentY = kMinY
}
//currentZ = currentZ + ((Float)(-sender.velocity))

//println(NSString(format:"currentZ: %.2f; scale: %.2f; velocity: %.2f", currentZ, sender.scale, sender.velocity))

self.updateLabels(x:currentX, y:currentY, z:currentZ, yaw:currentYaw, pitch:currentPitch, roll:currentRoll)

geometryNode.position = SCNVector3(x:currentX, y:currentY, z:currentZ)
}

func panGesture2(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(sender.view!)
    var newX = (Float)(translation.x)
    var newY = (Float)(-translation.y)
    newX += currentX
    newY += currentY
    if (newY < kMinY) {
        newY = kMinY
    }
    
    self.updateLabels(x:newX, y:newY, z:currentZ, yaw:currentYaw, pitch:currentPitch, roll:currentRoll)
    
    geometryNode.position = SCNVector3(x:newX, y:newY, z:currentZ)
    //geometryNode.transform = SCNMatrix4MakeRotation(newAngle, 0, 0, 1)
    
    if(sender.state == UIGestureRecognizerState.Ended) {
        currentX = newX
        currentY = newY
    }
}

func panGesture(sender: UIPanGestureRecognizer) {
    let translation = sender.translationInView(sender.view!)
    //var newYaw = self.degreesToRadians((Float)(translation.x))
    //var newPitch = self.degreesToRadians((Float)(translation.y))
    var newYaw = (Float)(-translation.x)*(Float)(M_PI/180.0)
    var newPitch = (Float)(translation.y)*(Float)(M_PI/180.0)
    newYaw += currentYaw
    newPitch += currentPitch
    
    newYaw = newYaw % (Float)(2*M_PI)
    newPitch = newPitch % (Float)(2*M_PI)
    
    self.updateLabels(x:currentX, y:currentY, z:currentZ, yaw:newYaw, pitch:newPitch, roll:currentRoll)
    
    geometryNode.eulerAngles = SCNVector3(x:newPitch, y:newYaw, z:currentRoll)
    
    if(sender.state == UIGestureRecognizerState.Ended) {
        currentPitch = newPitch
        currentYaw = newYaw
    }
}

func makeCamera() -> SCNNode {
    let camera = SCNCamera()
    let cameraNode = SCNNode()
    cameraNode.camera = camera
    cameraNode.position = cameraStartVector
    camera.zFar = 1000
    return cameraNode
}

func makeAmbientLight() -> SCNNode{
    let lightNode = SCNNode()
    let light = SCNLight()
    light.type = SCNLightTypeAmbient
    light.color = SKColor(white: 0.1, alpha: 1)
    lightNode.light = light
    return lightNode
}

func makeFloor() -> SCNNode {
    let floor = SCNFloor()
    floor.reflectivity = 0
    let floorNode = SCNNode()
    floorNode.geometry = floor
    let floorMaterial = SCNMaterial()
    floorMaterial.litPerPixel = false
    floorMaterial.diffuse.contents = UIImage(named:"green2.png")
    floorMaterial.diffuse.wrapS = SCNWrapMode.Repeat
    floorMaterial.diffuse.wrapT = SCNWrapMode.Repeat
    floor.materials = [floorMaterial]
    return floorNode
}

func buildStonehenge(scene: SCNScene){
    
    let radius: Double = 30.0
    let numberOfStones = 30
    
    let material = SCNMaterial()
    material.diffuse.contents = UIImage(named: "rock.jpg")
    material.specular.contents = UIImage(named: "rock.jpg")
    
    //Create the base stones.
    let baseStone = SCNBox(width: 4.5, height: 8, length: 3.25, chamferRadius: 0.5)
    baseStone.materials = [material]
    let baseStones = self.buildCircleOfObjects(baseStone, numberOfItems: numberOfStones, radius: radius)
    baseStones.position = SCNVector3(x: 0, y: 4, z: 0)
    scene.rootNode.addChildNode(baseStones)
    
    //Create the top header stones.
    let topStone = SCNBox(width: 6, height: 1.75, length: 3.25, chamferRadius: 0.5)
    topStone.materials = [material]
    
    let rotateY: Float = Float(M_PI) / Float(30)
    let topStones = self.buildCircleOfObjects(topStone, numberOfItems: numberOfStones, radius: radius)
    topStones.position = SCNVector3(x: 0, y: 8.9, z:0)
    topStones.rotation = SCNVector4(x: 0, y: 1, z: 0, w: rotateY)
    scene.rootNode.addChildNode(topStones)
    
    //Create the inner circle of little stones.
    let littleStone = SCNBox(width: 2, height: 4, length: 2, chamferRadius: 0.5)
    littleStone.materials = [material]
    let littleStones = self.buildCircleOfObjects(littleStone, numberOfItems: numberOfStones, radius: 24.0)
    littleStones.position = SCNVector3(x: 0 , y:2, z:0)
    scene.rootNode.addChildNode(littleStones)
    
    
    //Create the 5 inner structures.
    var structure1 = centerStructure(SCNVector3(x: 0 , y:0, z: -12.5))
    scene.rootNode.addChildNode(structure1)
    
    let structure2 = centerStructure(SCNVector3(x: -12 , y:0, z: -5))
    structure2.rotation = SCNVector4(x: 0, y: 1, z: 0, w: 1.4)
    scene.rootNode.addChildNode(structure2)
    
    let structure3 = centerStructure(SCNVector3(x: 12 , y:0, z:-5))
    structure3.rotation = SCNVector4(x: 0, y: 1, z: 0, w: -1.4)
    scene.rootNode.addChildNode(structure3)
    
    let structure4 = centerStructure(SCNVector3(x: -13 , y:0, z:10))
    structure4.rotation = SCNVector4(x: 0, y: 1, z: 0, w: 1.8)
    scene.rootNode.addChildNode(structure4)
    
    let structure5 = centerStructure(SCNVector3(x: 13 , y:0, z:10))
    structure5.rotation = SCNVector4(x: 0, y: 1, z: 0, w: -1.8)
    scene.rootNode.addChildNode(structure5)
    
}

func buildCircleOfObjects(_geometry: SCNGeometry, numberOfItems: Int, radius: Double) -> SCNNode{
    
    var x: Double = 0.0
    var z: Double = radius
    let theta: Double = (M_PI) / Double(numberOfItems / 2)
    let incrementalY: Double = (M_PI) / Double(numberOfItems) * 2
    
    let nodeCollection = SCNNode()
    nodeCollection.position = SCNVector3(x: 0, y: 4, z: 0)
    
    for index in 1...numberOfItems {
        
        x = radius * sin(Double(index) * theta)
        z = radius * cos(Double(index) * theta)
        
        let node = SCNNode(geometry: _geometry)
        node.position = SCNVector3(x: Float(x), y: 0, z:Float(z))
        
        let rotation = Float(incrementalY) * Float(index)
        node.rotation = SCNVector4(x: 0, y: 1, z: 0, w: rotation)
        nodeCollection.addChildNode(node)
        
    }
    
    return nodeCollection
    
}

func centerStructure(vector3: SCNVector3) -> SCNNode{
    
    let parentNode = SCNNode()
    parentNode.position = vector3
    
    let material = SCNMaterial()
    material.diffuse.contents = UIImage(named: "rock.jpg")
    material.specular.contents = UIImage(named: "rock.jpg")
    
    let leftStone = SCNBox(width: 4.25, height: 12, length: 3.25, chamferRadius: 0.5)
    leftStone.materials = [material]
    let leftStoneNode = SCNNode(geometry: leftStone)
    leftStoneNode.position = SCNVector3(x: -3 , y:6, z:0)
    parentNode.addChildNode(leftStoneNode)
    
    let rightStone = SCNBox(width: 4.25, height: 12, length: 3.25, chamferRadius: 0.5)
    let rightStoneNode = SCNNode(geometry: rightStone)
    rightStoneNode.position = SCNVector3(x: 3 , y:6, z:0)
    rightStone.materials = [material]
    parentNode.addChildNode(rightStoneNode)
    
    let topStone = SCNBox(width: 11, height: 1.75, length: 4.25, chamferRadius: 0.5)
    let topStoneNode = SCNNode(geometry: topStone)
    topStoneNode.position = SCNVector3(x: 0, y:12, z: 0)
    topStone.materials = [material]
    parentNode.addChildNode(topStoneNode)
    
    return parentNode
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}
*/
