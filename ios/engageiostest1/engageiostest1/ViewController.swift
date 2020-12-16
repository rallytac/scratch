//
//  ViewController.swift
//  engageiostest1
//
//  Created by Shaun Botha on 10/8/20.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController,
                      UIPickerViewDelegate,
                      UIPickerViewDataSource,
                      EngageEngineEventsHandler,
                      EngageGroupEventsHandler
{
    // ===========================================================================================
    // MARK: Properties
    // ===========================================================================================
    @IBOutlet weak var pttButton: UIButton!
    @IBOutlet weak var groupPicker: UIPickerView!
    @IBOutlet weak var useRpSwitch: UISwitch!
    @IBOutlet weak var useRpLabel: UILabel!
    @IBOutlet weak var codecPicker: UIPickerView!
    @IBOutlet weak var activeGroupLabel: UILabel!
    @IBOutlet weak var timelineTestButton: UIButton!
    
    
    // ===========================================================================================
    // MARK: Variables
    // ===========================================================================================
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    
    
    // ===========================================================================================
    // MARK: Picker
    // ===========================================================================================
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        EngageEventsDistributor.subscribe(eventHandler: self as EngageEngineEventsHandler)
        EngageEventsDistributor.subscribe(eventHandler: self as EngageGroupEventsHandler)
        
        groupPicker.delegate = self
        groupPicker.dataSource = self

        codecPicker.delegate = self
        codecPicker.dataSource = self

        useRpSwitch.isOn = appDelegate.getUseRallypoint()
        useRpLabel.text = "Use the Rallypoint at " + appDelegate.getRallypointHost()
        
        disablePtt()
        hideGroupPicker()
    }

    
    
    // ===========================================================================================
    // MARK: Picker
    // ===========================================================================================
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == groupPicker
        {
            return appDelegate.getAudioGroups().count
        }
        else if pickerView == codecPicker
        {
            return appDelegate.getCodecNames().count
        }

        return 0;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == groupPicker
        {
            return appDelegate.getGroupName(id: appDelegate.getAudioGroups()[row])
        }
        else if pickerView == codecPicker
        {
            return appDelegate.getCodecNames()[row]
        }
        
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == groupPicker
        {
            let newId = appDelegate.getAudioGroups()[row]
        
            if !appDelegate.isSelectedAudioGroup(id: newId)
            {
                disablePtt()
                appDelegate.setSelectedAudioGroupId(id: newId)
            }
        }
        else if pickerView == codecPicker
        {
            let newName = appDelegate.getCodecNames()[row]
            
            if !appDelegate.isSelectedCodecName(name: newName)
            {
                disablePtt()
                appDelegate.setSelectedCodecName(name: newName)
            }
        }
    }

    
    
    // ===========================================================================================
    // MARK: Functions
    // ===========================================================================================
    func enablePtt()
    {
        pttButton.isEnabled = true
    }
    
    func disablePtt()
    {
        pttButton.isEnabled = false
    }
    
    func showGroupPicker()
    {
        groupPicker.isHidden = false
    }
    
    func hideGroupPicker()
    {
        groupPicker.isHidden = true
    }

    
    
    // ===========================================================================================
    //MARK: Actions
    // ===========================================================================================
    @IBAction func onUseRpSwitchChanged(_ sender: Any)
    {
        appDelegate.setUseRallypoint(useIt: useRpSwitch.isOn)
        appDelegate.restartEngage()
    }
    
    @IBAction func onPTTTouchDown(_ sender: Any)
    {
        engageBeginGroupTxAdvanced(appDelegate.getSelectedAudioGroupId(), "{}")
    }
    
    @IBAction func onPTTTouchUpOutside(_ sender: Any)
    {
        engageEndGroupTx(appDelegate.getSelectedAudioGroupId())
    }
    
    @IBAction func onPTTTouchUpInside(_ sender: Any)
    {
        engageEndGroupTx(appDelegate.getSelectedAudioGroupId())
    }
    
    @IBAction func onPTTTouchCancel(_ sender: Any)
    {
        engageEndGroupTx(appDelegate.getSelectedAudioGroupId())
    }

    @IBAction func onTimelineTestTouchUpInside(_ sender: Any)
    {
        let qryJsonText = "{}";
        
        //engageQueryGroupTimeline(appDelegate.getSelectedAudioGroupId(), qryJsonText);
        
        
        let ids = appDelegate.getAudioGroups();
        
        for (id):(String) in ids
        {
            engageQueryGroupTimeline(id, qryJsonText);
        }
        
    }
    

    // ===========================================================================================
    //MARK: Engage events
    // ===========================================================================================
    func onEngineStarted(extraEventsJson: String?)
    {
        logger.debug("\(#function)")
        showGroupPicker()
    }

    func onEngineStopped(extraEventsJson: String?)
    {
        logger.debug("\(#function)")
        disablePtt()
        hideGroupPicker()
    }
    
    func onGroupCreated(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupCreateFailed(id: String, extraEventsJson: String?)
    {
        logger.error("\(#function): \(id)")
    }
    
    func onGroupDeleted(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupJoined(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupJoinFailed(id: String, extraEventsJson: String?)
    {
        logger.error("\(#function): \(id)")
    }
    
    func onGroupLeft(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }

    func onGroupConnected(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
        if appDelegate.isSelectedAudioGroup(id: id)
        {
            enablePtt()
        }
    }
    
    func onGroupConnectFailed(id: String, extraEventsJson: String?)
    {
        logger.error("\(#function): \(id)")
        if appDelegate.isSelectedAudioGroup(id: id)
        {
            disablePtt()
        }
    }
    
    func onGroupDisconnected(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
        if appDelegate.isSelectedAudioGroup(id: id)
        {
            disablePtt()
        }
    }
    
    func onGroupRxStarted(id: String, extraEventsJson: String?)
    {
        //myLabel.text = "RX: " + id
        activeGroupLabel.text = "Active group: RX"
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupRxEnded(id: String, extraEventsJson: String?)
    {
        //myLabel.text = ""
        activeGroupLabel.text = "Active group:"
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupRxMuted(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupRxUnmuted(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
        
    func onGroupRxSpeakersChanged(id: String, groupTalkerJson: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }

    func onGroupTxMuted(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupTxUnmuted(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupTxStarted(id: String, extraEventsJson: String?)
    {
        pttButton.setBackgroundImage(UIImage(systemName: "mic.circle.fill"), for: UIControl.State.normal)
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupTxEnded(id: String, extraEventsJson: String?)
    {
        pttButton.setBackgroundImage(UIImage(systemName: "mic.circle"), for: UIControl.State.normal)
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupTxFailed(id: String, extraEventsJson: String?)
    {
        pttButton.setBackgroundImage(UIImage(systemName: "mic.circle"), for: UIControl.State.normal)
        logger.debug("\(#function): \(id)")
    }
    func onGroupTimelineReportFailed(id: String, extraEventsJson: String?)
    {
        logger.debug("\(#function): \(id)")
    }
    
    func onGroupTimelineReport(id: String, reportJson: String, extraEventsJson: String?)
    {
        //logger.debug("#DBG#: \(#function): \(id), \(reportJson)")
        
        let report = try! JSON(data: Data(reportJson.utf8))
        let events = report["events"]
        logger.debug("#DBG#: \(id), \(events.count)")
    }
}
