//
//  LCZSan.swift
//  Diary
//
//  Created by glgl on 2019/7/19.
//  Copyright © 2019 lcz. All rights reserved.
// LCZCameraManage

import UIKit

enum LCZCameraPosition {

    case back // 后
    case front // 前
}

protocol LCZCameraManageDelegate {
    
    /// 获取实时图像，这个代理方法的回调频率很快，几乎与手机屏幕的刷新频率一样快
//    func lczSwiftScanCaptureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection);
    
    /// 获取拍照数据
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?)
}

class LCZCameraManage: NSObject {
    
    static let shared = LCZCameraManage()
    
    private override init() {}
    
    /// LCZCameraManageDelegate协议
    public var delegate: LCZCameraManageDelegate?
    
    /// 相机方向
    public var cameraPosition: LCZCameraPosition? = .back
    
    /// 前摄像头
    private lazy var frontAVCaptureDevice: AVCaptureDevice = {
        // 默认前摄像头
        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        if ((try! device?.lockForConfiguration()) == nil) {
            // 自动白平衡
            if ((device?.isWhiteBalanceModeSupported(.autoWhiteBalance))!) {
                device?.whiteBalanceMode = .autoWhiteBalance
            }
            // 自动对焦
            if ((device?.isFocusModeSupported(.continuousAutoFocus))!) {
                device?.focusMode = .continuousAutoFocus
            }
            // 自动曝光
            if ((device?.isExposureModeSupported(.continuousAutoExposure))!) {
                device?.exposureMode = .continuousAutoExposure
            }
            device!.unlockForConfiguration()
        }
        self.cameraPosition = .front
        return device!
    }()
    
    /// 后摄像头
    private lazy var backAVCaptureDevice: AVCaptureDevice = {
        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .back)
        if ((try! device?.lockForConfiguration()) == nil) {
            // 自动白平衡
            if ((device?.isWhiteBalanceModeSupported(.autoWhiteBalance))!) {
                device?.whiteBalanceMode = .autoWhiteBalance
            }
            // 自动对焦
            if ((device?.isFocusModeSupported(.continuousAutoFocus))!) {
                device?.focusMode = .continuousAutoFocus
            }
            // 自动曝光
            if ((device?.isExposureModeSupported(.continuousAutoExposure))!) {
                device?.exposureMode = .continuousAutoExposure
            }
            device!.unlockForConfiguration()
        }
        self.cameraPosition = .back
        return device!
    }()
    
    
    /// 硬件前置的输入流
    private lazy var frontAVCaptureDeviceInput: AVCaptureDeviceInput = {
        let input = try! AVCaptureDeviceInput(device: self.frontAVCaptureDevice)
        return input
    }()
    
    /// 硬件后置的输入流
    private lazy var backAVCaptureDeviceInput: AVCaptureDeviceInput = {
        let input = try! AVCaptureDeviceInput(device: self.backAVCaptureDevice)
        return input
    }()
    
    
    /// 协调输入和输出数据的会话，然后把input添加到会话中
    public lazy var avCaptureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        // 设置默认的相机方向
        if self.cameraPosition == .back {
            if session.canAddInput(self.backAVCaptureDeviceInput) {
                session.addInput(self.backAVCaptureDeviceInput)
            }
        } else {
            if session.canAddInput(self.frontAVCaptureDeviceInput) {
                session.addInput(self.frontAVCaptureDeviceInput)
            }
        }
        
//        if session.canAddOutput(self.avCaptureVideoDataOutput) {
//            session.addOutput(self.avCaptureVideoDataOutput)
//        }
        if session.canAddOutput(self.avCapturePhotoOutput) {
            session.addOutput(self.avCapturePhotoOutput)
        }
        return session
    }()
    
    
    /// 预览图像的层
    public lazy var avCaptureVideoPreviewLayer: AVCaptureVideoPreviewLayer = {
        let previewLayer = AVCaptureVideoPreviewLayer(session: self.avCaptureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        return previewLayer
    }()
    
    /// 实时获取预览图像
//    private lazy var avCaptureVideoDataOutput: AVCaptureVideoDataOutput = {
//        let dataOutput = AVCaptureVideoDataOutput()
//        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "LCZSwiftScan"))
//        dataOutput.videoSettings = ["\(kCVPixelFormatType_32BGRA)":kCVPixelBufferPixelFormatTypeKey]
//        return dataOutput
//    }()
    
    
    /// 人脸检测
    public lazy var ciDetector: CIDetector = {
        let detector = CIDetector(ofType: CIDetectorTypeFace,
                                  context: CIContext(),
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh,
                                            CIDetectorSmile: true,
                                            CIDetectorEyeBlink: true
                                           ]
                                  )
        return detector!
    }()
    
    public lazy var avCapturePhotoOutput: AVCapturePhotoOutput = {
        let output = AVCapturePhotoOutput()
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])
        // 自动闪光灯
        settings.flashMode = AVCaptureDevice.FlashMode.auto
        output.photoSettingsForSceneMonitoring = settings
        
        return output
    }()

    
    
    /// 拍照
    public func takingPictures() {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecJPEG])
        self.avCapturePhotoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    /// 切换前后摄像头
    public func switchCamera() {
        // 为摄像头的转换加转场动画
        let caTransition = CATransition()
        caTransition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        caTransition.type = .init(rawValue: "oglFlip")
        caTransition.duration = 2
        if self.cameraPosition == .back {
            self.avCaptureSession.removeInput(self.backAVCaptureDeviceInput)
            caTransition.subtype = .fromRight
            if self.avCaptureSession.canAddInput(self.frontAVCaptureDeviceInput) {
                self.avCaptureSession.addInput(self.frontAVCaptureDeviceInput)
                self.cameraPosition = .front
            }
        } else {
            self.avCaptureSession.removeInput(self.frontAVCaptureDeviceInput)
            caTransition.subtype = .fromLeft
            if self.avCaptureSession.canAddInput(self.backAVCaptureDeviceInput) {
                self.avCaptureSession.addInput(self.backAVCaptureDeviceInput)
                self.cameraPosition = .back
            }
        }
        
        

//        if position == AVCaptureDevice.Position.front {
//            self.avCaptureSession.removeInput(self.frontAVCaptureDeviceInput)
//            an.subtype = .fromLeft
//            if self.avCaptureSession.canAddInput(self.backAVCaptureDeviceInput) {
//                self.avCaptureSession.addInput(self.backAVCaptureDeviceInput)
//            }
//
//        } else if position == AVCaptureDevice.Position.back {
//            self.avCaptureSession.removeInput(self.backAVCaptureDeviceInput)
//            an.subtype = .fromRight
//            if self.avCaptureSession.canAddInput(self.frontAVCaptureDeviceInput) {
//                self.avCaptureSession.addInput(self.frontAVCaptureDeviceInput)
//            }
//        }
        
        self.avCaptureVideoPreviewLayer.add(caTransition, forKey: nil)
        
    }
    
}

extension LCZCameraManage: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        if (self.delegate != nil) {
            self.delegate?.photoOutput(output, didFinishProcessingPhoto: photoSampleBuffer, previewPhoto: previewPhotoSampleBuffer, resolvedSettings: resolvedSettings, bracketSettings: bracketSettings, error: error)
        }
    }
}








//extension LCZSwiftScan: AVCaptureVideoDataOutputSampleBufferDelegate {
//
//    //AVCaptureVideoDataOutput获取实时图像，这个代理方法的回调频率很快，几乎与手机屏幕的刷新频率一样快
//    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        if (self.delegate != nil) {
//            self.delegate?.lczSwiftScanCaptureOutput(output, didOutput: sampleBuffer, from: connection)
//        }
//    }
//}
