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
    
    
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    
    @IBOutlet weak var lblTimer: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var meterTimer:Timer!
    var isAudioRecordingGranted: Bool!
    var isRecording = false
    var isPlaying = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    @IBAction func btnBack(_ sender: Any) {
   
    let BookdetailVC = self.storyboard?.instantiateViewController(withIdentifier: kUploadBookViewController) as! UploadBookViewController

      //  BookdetailVC.btnAudioLink = filepathnew
            BookdetailVC.modalPresentationStyle = .overFullScreen

    //        self.navigationController?.pushViewController(BookdetailVC, animated: true)
            self.present(BookdetailVC, animated: true, completion: nil)
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

        print()
    return filePath
    }
    
    
    func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
               // try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
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
    @IBAction func btnRecord(_ sender: Any) {
        if(isRecording)
        {
            finishAudioRecording(success: true)
            btnRecord.setTitle("Record", for: .normal)
            btnPlay.isEnabled = true
            isRecording = false
        }
        else
        {
            setup_recorder()

            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            btnRecord.setTitle("Stop", for: .normal)
            btnPlay.isEnabled = false
            isRecording = true
        }
    }
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            lblTimer.text = totalTimeString
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
            print(getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    @IBAction func btnPlay(_ sender: Any) {
   
        if(isPlaying)
        {
            audioPlayer.stop()
            btnRecord.isEnabled = true
            btnPlay.setTitle("Play", for: .normal)
            isPlaying = false
        }
        else
        {
            if FileManager.default.fileExists(atPath: getFileUrl().path)
            {
                btnRecord.isEnabled = false
                btnPlay.setTitle("pause", for: .normal)
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
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if !flag
        {
            finishAudioRecording(success: false)
        }
        btnPlay.isEnabled = true
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        btnRecord.isEnabled = true
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
}

