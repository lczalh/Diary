//
//  FaceRecognitionViewController.swift
//  Diary
//
//  Created by glgl on 2019/7/18.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit
import AVFoundation

class FaceRecognitionViewController: DiaryBaseViewController {
    
    lazy var lczSwiftScan: LCZSwiftScan = {
        let scan = LCZSwiftScan.shared
        scan.delegate = self
        return scan
    }()
    
    var bootPromptLabel: UILabel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.avCaptureSession.startRunning()
        lczSwiftScan.avCaptureSession.startRunning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let faceView = UIView(frame: CGRect(x: LCZWidth / 2 - 125, y: LCZHeight / 2 - 125, width: 250, height: 250))
        
        lczSwiftScan.avCaptureVideoPreviewLayer.frame = faceView.bounds
        self.view.addSubview(faceView)
        faceView.layer.addSublayer(lczSwiftScan.avCaptureVideoPreviewLayer)
        let path = UIBezierPath(roundedRect: faceView.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 125, height: 125))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.frame = faceView.bounds
        faceView.layer.mask = layer
        
        self.bootPromptLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 40))
        self.bootPromptLabel?.text = "没有检测到人脸"
        self.view.addSubview(self.bootPromptLabel!)
    }
    
    
    

}

extension FaceRecognitionViewController: LCZSwiftScanProtocol {
    
    func lczSwiftScanCaptureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = .portrait
        let image = LCZImageFromSampleBuffer(sampleBuffer: sampleBuffer)
        // 人脸检测
        let faces = lczSwiftScan.ciDetector.features(in: CIImage(image: image)!)
        DispatchQueue.main.async {
            self.bootPromptLabel?.text = "没有检测到人脸"
        }
        autoreleasepool {
            for face in faces as! [CIFaceFeature] {
                autoreleasepool {
                    // 检测到部分人脸
                    if face.hasLeftEyePosition || face.hasRightEyePosition || face.hasMouthPosition {
                        DispatchQueue.main.async {
                            self.bootPromptLabel?.text = "把脸移入圈内"
                        }
                        if face.hasLeftEyePosition, face.hasRightEyePosition, face.hasMouthPosition {
                            DispatchQueue.main.async {
                                self.bootPromptLabel?.text = "脸已在圈内"
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.bootPromptLabel?.text = "没有检测到人脸"
                        }
                    }
                    
                }
            }
        }
    }
    
    
}

//// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
//extension FaceRecognitionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
//
//    //AVCaptureVideoDataOutput获取实时图像，这个代理方法的回调频率很快，几乎与手机屏幕的刷新频率一样快
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        connection.videoOrientation = .portrait
//        let image = LCZImageFromSampleBuffer(sampleBuffer: sampleBuffer)
//        // 人脸检测
//        let faces = ciDetector.features(in: CIImage(image: image)!)
//        autoreleasepool {
//            for face in faces as! [CIFaceFeature] {
//                autoreleasepool {
//                    LCZPrint(face.hasLeftEyePosition,face.hasRightEyePosition)
//                }
//            }
//        }
//
//    }
//}
