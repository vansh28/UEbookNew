//
//  RecordingViewController.swift
//  UeBook
//
//  Created by Admin on 29/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import AVFoundation


class RecordingViewController: UIViewController , AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    
    
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var btnRecording: UIButton!
    
    @IBOutlet weak var btnStopRecording: UIButton!
    
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
    var recordingSession: AVAudioSession!
    var END_TIME = 10.0
    var timer:Timer!

  //  var recordButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
//
//        recordingSession = AVAudioSession.sharedInstance()
//
//        do {
//            try recordingSession.setCategory(.playAndRecord, mode: .default)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                DispatchQueue.main.async {
//                    if allowed {
//                      //  self.loadRecordingUI()
//                    } else {
//                        // failed to record!
//                    }
//                }
//            }
//        } catch {
//            // failed to record!
//        }
//    }
        
//        func loadRecordingUI() {
//            recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 128, height: 64))
//            recordButton.setTitle("Tap to Record", for: .normal)
//            recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
//            recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
//            view.addSubview(recordButton)
//        }
//        @IBAction func btnRecording(_ sender: Any) {
//            if audioRecorder == nil {
//                startRecording()
//            } else {
//                finishRecording(success: true)
//            }
//          }
//        func startRecording() {
//            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//
//            let settings = [
//                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                AVSampleRateKey: 12000,
//                AVNumberOfChannelsKey: 1,
//                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
//
//
//                //        }
//
//
//            do {
//                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//                audioRecorder.delegate = self
//                audioRecorder.record()
//
//
//                let hr = Int((audioRecorder.currentTime / 60) / 60)
//                let min = Int(audioRecorder.currentTime / 60)
//                let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
//                let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
//                lblTime.text = totalTimeString
//                print (totalTimeString)
//                audioRecorder.updateMeters()
//                btnRecording.setTitle("Tap to Stop", for: .normal)
//            } catch {
//                finishRecording(success: false)
//            }
//        }
//        func getDocumentsDirectory() -> URL {
//            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//            return paths[0]
//        }
//
//        func finishRecording(success: Bool) {
//            audioRecorder.stop()
//            audioRecorder = nil
//
//            if success {
//                btnRecording.setTitle("Tap to Re-record", for: .normal)
//            } else {
//                btnRecording.setTitle("Tap to Record", for: .normal)
//                // recording failed :(
//            }
//        }
//    @objc func recordTapped() {
//            if audioRecorder == nil {
//                startRecording()
//            } else {
//                finishRecording(success: true)
//            }
//        }
//        func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//            if !flag {
//                finishRecording(success: false)
//            }
//        }
        check_record_permission()
        }

        func check_record_permission()
        {
            switch AVAudioSession.sharedInstance().recordPermission {
            case AVAudioSessionRecordPermission.granted:
                isAudioRecordingGranted = true
                break
            case AVAudioSessionRecordPermission.denied:
                isAudioRecordingGranted = false
                break
            case AVAudioSessionRecordPermission.undetermined:
                AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                        if allowed {
                            self.isAudioRecordingGranted = true
                        } else {
                            self.isAudioRecordingGranted = false
                        }
                })
                break
            default:
                break
            }
        }
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func getFileUrl() -> URL
    {
        let filename = "myRecording.m4a"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
    return filePath
    }
    func setup_recorder()
    {
        if isAudioRecordingGranted

        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(.playAndRecord, mode: .default)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: "Error", msg_desc: error.localizedDescription, action_title: "OK")
            }
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Don't have access to use your microphone.", action_title: "OK")
        }
    }
       @IBAction func btnRecording(_ sender: Any) {

        if(isRecording)
        {
            finishAudioRecording(success: true)
            btnRecording.setTitle("Record", for: .normal)
            btnStopRecording.isEnabled = true
            isRecording = true
            meterTimer = Timer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
        }
        else
        {
            setup_recorder()

            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.updateAudioMeter(timer:)), userInfo: nil, repeats: true)

          //  meterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector(("checkTime")), userInfo: nil, repeats: true)

            
            btnRecording.setTitle("Pause", for: .normal)
            btnStopRecording.isEnabled = false
            isRecording = true
        }
    }
    func checkTime() {
        if self.audioPlayer.currentTime >= END_TIME {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
                let min = Int(audioRecorder.currentTime / 60)
                let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
                lblTime.text = totalTimeString
            self.audioPlayer.stop()
            timer.invalidate()
            print (timer as Any)
        }
    }

//
//    func updateAudioMeter(timer:Timer) {
//       if audioPlayer.ire {
//          let dFormat = "%02d"
//          let min:Int = Int(recorder.currentTime / 60)
//          let sec:Int = Int(recorder.currentTime % 60)
//          let s = "\(String(format: dFormat, min)):\(String(format: dFormat, sec))"
//          statusLabel.text = s
//          recorder.updateMeters()
//          var apc0 = recorder.averagePowerForChannel(0)
//          var peak0 = recorder.peakPowerForChannel(0)
//   // print them out...
//       }
//    }
    @objc func updateAudioMeter(timer: Timer)
    {
      //  if isRecording == true
      if audioRecorder.isRecording
        {
//
            let min = Int(audioRecorder.currentTime / 60)

                       let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
                       let playinTime = String(format: "%02d:%02d", min, sec)
                       lblTime.text = playinTime
            print (playinTime)

//            let hr = Int((audioRecorder.currentTime / 60) / 60)
//            let min = Int(audioRecorder.currentTime / 60)
//            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
        //let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
          //  lblTime.text = totalTimeString
            //print (totalTimeString)
            audioRecorder.updateMeters()
    }
    }
    func finishAudioRecording(success: Bool)
    {
        if success
        {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            print("recorded successfully.")
        }
        else
        {
            display_alert(msg_title: "Error", msg_desc: "Recording failed.", action_title: "OK")
        }
    }
    func prepare_play()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
   @IBAction func btnStopRecording(_ sender: Any) {
    
        if(isPlaying)
        {
            audioPlayer.stop()
            btnRecording.isEnabled = true
            btnStopRecording.setTitle("Play", for: .normal)
            isPlaying = false
        }
        else
        {
            if FileManager.default.fileExists(atPath: getFileUrl().path)
            {
                btnRecording.isEnabled = false
                btnStopRecording.setTitle("pause", for: .normal)
                prepare_play()
                audioPlayer.play()
                isPlaying = true
            }
            else
            {
                display_alert(msg_title: "Error", msg_desc: "Audio file is missing.", action_title: "OK")
            }
        }
    }


    @IBAction func btnClose(_ sender: Any) {

    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        btnStopRecording.isEnabled = true
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        btnRecording.isEnabled = true
    }

    func display_alert(msg_title : String , msg_desc : String ,action_title : String)
    {
        let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action_title, style: .default)
        {
            (result : UIAlertAction) -> Void in
        _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
