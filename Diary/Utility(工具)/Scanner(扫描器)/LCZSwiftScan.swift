//
//  LCZSan.swift
//  Diary
//
//  Created by glgl on 2019/7/19.
//  Copyright © 2019 lcz. All rights reserved.
//

import UIKit

protocol LCZSwiftScanProtocol {
    
    /// 获取实时图像，这个代理方法的回调频率很快，几乎与手机屏幕的刷新频率一样快
    func lczSwiftScanCaptureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection);
}

class LCZSwiftScan: NSObject {
    
    static let shared = LCZSwiftScan()
    
    private override init() {}
    
    /// LCZSwiftScanProtocol协议
    public var delegate: LCZSwiftScanProtocol?
    
    
    /// 相机硬件的接口，用于配置底层硬件的属性（例如相机聚焦、白平衡、感光度ISO、曝光、帧率、闪光灯、缩放等），
    /// 这些底层硬件包括前置摄像头、后置摄像头、麦克风、闪光灯等。使用AVCaptureDevice向AVCaptureSession对象提供输入数据(如音频或视频)
    private lazy var avCaptureDevice: AVCaptureDevice = {
        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
       // let s = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: .video, position: device!.position)
        if ((try! device?.lockForConfiguration()) == nil) {
            // 自动闪光灯
            if ((device?.isFlashModeSupported(.auto))!) {
                device?.flashMode = AVCaptureDevice.FlashMode.auto
            }
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
        return device!
    }()
    
    
    /// 硬件的输入流
    private lazy var avCaptureDeviceInput: AVCaptureDeviceInput = {
        let input = try! AVCaptureDeviceInput(device: self.avCaptureDevice)
        return input
    }()
    
    
    /// 协调输入和输出数据的会话，然后把input添加到会话中
    public lazy var avCaptureSession: AVCaptureSession = {
        let session = AVCaptureSession()
        if session.canAddInput(self.avCaptureDeviceInput) {
            session.addInput(self.avCaptureDeviceInput)
        }
        if session.canAddOutput(self.avCaptureVideoDataOutput) {
            session.addOutput(self.avCaptureVideoDataOutput)
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
    private lazy var avCaptureVideoDataOutput: AVCaptureVideoDataOutput = {
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "LCZSwiftScan"))
        dataOutput.videoSettings = ["\(kCVPixelFormatType_32BGRA)":kCVPixelBufferPixelFormatTypeKey]
        return dataOutput
    }()
    
    
    /// 人脸检测
    public lazy var ciDetector: CIDetector = {
        let detector = CIDetector(ofType: CIDetectorTypeFace, context: CIContext(), options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        return detector!
    }()
}

extension LCZSwiftScan: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    //AVCaptureVideoDataOutput获取实时图像，这个代理方法的回调频率很快，几乎与手机屏幕的刷新频率一样快
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if (self.delegate != nil) {
            self.delegate?.lczSwiftScanCaptureOutput(output, didOutput: sampleBuffer, from: connection)
        }
    }
}
