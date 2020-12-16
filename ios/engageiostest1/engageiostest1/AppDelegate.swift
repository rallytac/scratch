//
//  AppDelegate.swift
//  engageiostest1
//
//  Created by Shaun Botha on 10/8/20.
//

import os
import UIKit
import SwiftyJSON
import AVKit

let logger: Logger = Logger(subsystem: "dev", category: "testing")

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate,
                   EngageEngineEventsHandler,
                   EngageGroupEventsHandler
{
    // ===========================================================================================
    // MARK: Variables
    // ===========================================================================================
    private var policyJsonText: String = ""
    private var identityJsonText: String = ""
    private var missionJsonText: String = ""
    private var rp: JSON = JSON.null
    private var groups: JSON = JSON.null
    private var audioGroups: [String] = [String]()
    private var selectedAudioGroupId = ""
    private var useRallypoint = false
    private var startEngageOnEngineStopped = false
    private var codecs: JSON = JSON.null
    private var selectedCodecName = ""
    private var codecNames: [String] = [String]()
    
    
    // ===========================================================================================
    // MARK: AppDelegate
    // ===========================================================================================
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // TODO: Work In Progress : Try to set the process' audio output to the large speaker(s)
        do
        {
            try AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        }
        catch
        {
            logger.error("overrideOutputAudioPort exception")
        }

        EngageEventsDistributor.registerWithEngage()
        EngageEventsDistributor.subscribe(eventHandler: self as EngageEngineEventsHandler)
        EngageEventsDistributor.subscribe(eventHandler: self as EngageGroupEventsHandler)

        let optsJson = try! JSON(data: Data(Utils.getTextFile(fileName: "opts", fileType: "json").utf8))
        rp = optsJson["rp"]
        
        codecs = optsJson["codecs"]
        for (_, codec):(String, JSON) in codecs
        {
            codecNames.append(codec["name"].stringValue)
        }
        
        let filePath = Bundle.main.bundlePath + "/all-rts-certs.certstore"
        engageSetLogLevel(4)
        engageOpenCertStore(filePath, "")
        
        policyJsonText = Utils.getTextFile(fileName: "ep", fileType: "json")
        identityJsonText = Utils.getTextFile(fileName: "id", fileType: "json")
        
        missionJsonText = Utils.getTextFile(fileName: "m", fileType: "json")
        let missionJson = try? JSON(data: Data(missionJsonText.utf8))
        groups = missionJson!["groups"]
        
        for (_, group):(String, JSON) in groups
        {
            if group["type"] == 1
            {
                audioGroups.append(group["id"].stringValue)
                if selectedAudioGroupId == ""
                {
                    selectedAudioGroupId = group["id"].stringValue
                }
            }
        }
        
        engageInitialize(policyJsonText, identityJsonText, "")
        engageStart()
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    
    // ===========================================================================================
    // MARK: Functions
    // ===========================================================================================
    func getCodecIdByName(name: String) -> Int
    {
        for (_, codec):(String, JSON) in codecs
        {
            if codec["name"].stringValue == name
            {
                return codec["id"].intValue
            }
        }
        
        return 0;
    }
    
    func setSelectedCodecName(name: String)
    {
        if name != selectedAudioGroupId
        {
            selectedCodecName = name
            restartEngage()
        }
    }
    
    func isSelectedCodecName(name: String) -> Bool
    {
        return (name == selectedCodecName)
    }
    
    func getRallypointHost() -> String
    {
        return rp["host"]["address"].stringValue
    }
        
    func setUseRallypoint(useIt: Bool)
    {
        useRallypoint = useIt
    }
    
    func getUseRallypoint() -> Bool
    {
        return useRallypoint
    }
    
    func setSelectedAudioGroupId(id: String)
    {
        if id != selectedAudioGroupId
        {
            engageLeaveGroup(selectedAudioGroupId)
            selectedAudioGroupId = id
            engageJoinGroup(id)
        }
    }
    
    func getSelectedAudioGroupId() -> String
    {
        return selectedAudioGroupId
    }
    
    func getCodecNames() -> [String]
    {
        return codecNames
    }
    
    func getGroups() -> JSON
    {
        return groups
    }
    
    func getAudioGroups() -> [String]
    {
        return audioGroups
    }
        
    func getGroupJson(id: String) -> JSON
    {
        for (_, group):(String, JSON) in groups
        {
            if group["id"].stringValue == id
            {
                return group
            }
        }
        
        return JSON.null
    }
    
    func getGroupName(id: String) -> String
    {
        let group = getGroupJson(id: id)
        if group != JSON.null
        {
            return group["name"].stringValue
        }

        return "?"
    }
    
    func isMissionControlGroup(id: String) -> Bool
    {
        let group = getGroupJson(id: id)
        if group != JSON.null
        {
            return (group["type"] == 2)
        }
        
        return false
    }
    
    func isSelectedAudioGroup(id: String) -> Bool
    {
        return (id == selectedAudioGroupId)
    }
    
    private func buildFinalGroupCreationJson(baseline: JSON) -> JSON
    {
        var group = baseline
        
        group["rallypoints"].dictionaryObject?.removeAll()
        if useRallypoint
        {
            var rallypoints: JSON = ["rallypoints"]
            rallypoints[0] = rp
            group["rallypoints"] = rallypoints
        }
        
        if group["type"] == 1
        {
            let codecId = getCodecIdByName(name: selectedCodecName)
            if codecId > 0
            {
                var txAudio = group["txAudio"]
                
                txAudio["encoder"] = JSON(codecId)
                txAudio["framingMs"] = JSON(20)
                
                group["txAudio"] = txAudio
            }
        }
        
        return group
    }

    func restartEngage()
    {
        startEngageOnEngineStopped = true
        engageStop()
    }

    func createAllGroups()
    {
        for (_, group):(String, JSON) in groups
        {
            let s = buildFinalGroupCreationJson(baseline: group).rawString()!
            print("groupjson:" + s)
            engageCreateGroup(s)
        }
    }

    func deleteAllGroups()
    {
        for (_, group):(String, JSON) in groups
        {
            engageDeleteGroup(group["id"].rawString()!)
        }
    }
    
    
    
    // ===========================================================================================
    // MARK: Engage events
    // ===========================================================================================
    func onEngineStarted(extraEventsJson: String?)
    {
        createAllGroups()
    }
    
    func onEngineStopped(extraEventsJson: String?)
    {
        if startEngageOnEngineStopped
        {
            startEngageOnEngineStopped = false
            engageStart()
        }
    }
    
    func onGroupCreated(id: String, extraEventsJson: String?)
    {
        if (id == selectedAudioGroupId) || (isMissionControlGroup(id: id))
        {
            engageJoinGroup(id)
        }
    }
    
    func onGroupCreateFailed(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupDeleted(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupJoined(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupJoinFailed(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupLeft(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupConnected(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupConnectFailed(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupDisconnected(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupRxStarted(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupRxEnded(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupRxMuted(id: String, extraEventsJson: String?)
    {
    }

    func onGroupRxUnmuted(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupRxSpeakersChanged(id: String, groupTalkerJson: String, extraEventsJson: String?)
    {
    }
        
    func onGroupTxMuted(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupTxUnmuted(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupTxStarted(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupTxEnded(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupTxFailed(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupTimelineReportFailed(id: String, extraEventsJson: String?)
    {
    }
    
    func onGroupTimelineReport(id: String, reportJson: String, extraEventsJson: String?)
    {
    }
}
