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
    
    lazy var lczCameraManage: LCZCameraManage = {
        let scan = LCZCameraManage.shared
        scan.delegate = self
        return scan
    }()
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.avCaptureSession.startRunning()
        lczCameraManage.avCaptureSession.startRunning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        lczCameraManage.avCaptureVideoPreviewLayer.frame = self.view.bounds
     
        self.view.layer.addSublayer(lczCameraManage.avCaptureVideoPreviewLayer)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.lczCameraManage.takingPictures()
       // self.lczCameraManage.switchCamera()
    }
    
    @objc private func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        var showMessage = ""
        if error != nil{
            showMessage = "保存失败"
        }else{
            showMessage = "保存成功"
        }
        SVProgressHUD.showInfo(withStatus: showMessage)
        
        
    }
}

extension FaceRecognitionViewController: LCZCameraManageDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?, previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        let data = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
        let image = UIImage(data: data!)
        
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
}
