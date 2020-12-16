//
//  Engage.swift
//  engageiostest1
//
//  Created by Shaun Botha on 10/15/20.
//

import Foundation

// ===========================================================================================
// Baseline for all Engage events
// ===========================================================================================
public protocol EngageEventHandlerBase : class
{
}



// ===========================================================================================
// Engine-specific events
// ===========================================================================================
public protocol EngageEngineEventsHandler : EngageEventHandlerBase
{
    func onEngineStarted(extraEventsJson: String?)
    func onEngineStopped(extraEventsJson: String?)
}



// ===========================================================================================
// Group-specific events
// ===========================================================================================
public protocol EngageGroupEventsHandler : EngageEventHandlerBase
{
    func onGroupCreated(id: String, extraEventsJson: String?)
    func onGroupCreateFailed(id: String, extraEventsJson: String?)
    func onGroupDeleted(id: String, extraEventsJson: String?)
    func onGroupJoined(id: String, extraEventsJson: String?)
    func onGroupJoinFailed(id: String, extraEventsJson: String?)
    func onGroupLeft(id: String, extraEventsJson: String?)
    func onGroupConnected(id: String, extraEventsJson: String?)
    func onGroupConnectFailed(id: String, extraEventsJson: String?)
    func onGroupDisconnected(id: String, extraEventsJson: String?)
    func onGroupRxStarted(id: String, extraEventsJson: String?)
    func onGroupRxEnded(id: String, extraEventsJson: String?)
    func onGroupRxMuted(id: String, extraEventsJson: String?)
    func onGroupRxUnmuted(id: String, extraEventsJson: String?)
    func onGroupRxSpeakersChanged(id: String, groupTalkerJson: String, extraEventsJson: String?)
    func onGroupTxMuted(id: String, extraEventsJson: String?)
    func onGroupTxUnmuted(id: String, extraEventsJson: String?)
    func onGroupTxStarted(id: String, extraEventsJson: String?)
    func onGroupTxEnded(id: String, extraEventsJson: String?)
    func onGroupTxFailed(id: String, extraEventsJson: String?)
    func onGroupTimelineReportFailed(id: String, extraEventsJson: String?)
    func onGroupTimelineReport(id: String, reportJson: String, extraEventsJson: String?)
}



// ===========================================================================================
// MARK: Callback hooks
// ===========================================================================================
fileprivate func cb_onEngineStarted(extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)

    DispatchQueue.main.async
    {
        EngageEventsDistributor.onEngineStarted(extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onEngineStopped(extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)

    DispatchQueue.main.async
    {
        EngageEventsDistributor.onEngineStopped(extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupCreated(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)

    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupCreated(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupCreateFailed(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)

    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupCreateFailed(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupDeleted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)

    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupDeleted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupJoined(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupJoined(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupJoinFailed(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupJoinFailed(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupLeft(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupLeft(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupConnected(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupConnected(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupConnectFailed(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupConnectFailed(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupDisconnected(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupDisconnected(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupRxStarted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupRxStarted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupRxEnded(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupRxEnded(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupRxMuted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupRxMuted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupRxUnmuted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupRxUnmuted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupRxSpeakersChanged(id: UnsafePointer<CChar>, groupTalkerJson: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_groupTalkerJson = Utils.maybeNil(s: groupTalkerJson)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    print(Utils.maybeNil(s: groupTalkerJson))
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupRxSpeakersChanged(id: captured_id, groupTalkerJson: captured_groupTalkerJson, extraEventsJson: captured_extraEventsJson)
    }
}


fileprivate func cb_onGroupTxMuted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTxMuted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupTxUnmuted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTxUnmuted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupTxStarted(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTxStarted(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupTxEnded(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTxEnded(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupTxFailed(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTxFailed(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupTimelineReportFailed(id: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTimelineReportFailed(id: captured_id, extraEventsJson: captured_extraEventsJson)
    }
}

fileprivate func cb_onGroupTimelineReport(id: UnsafePointer<CChar>, reportJson: UnsafePointer<CChar>, extraEventsJson: UnsafePointer<CChar>?)
{
    let captured_id = Utils.maybeNil(s: id)
    let captured_reportJson = Utils.maybeNil(s: reportJson)
    let captured_extraEventsJson = Utils.maybeNil(s: extraEventsJson)
    
    DispatchQueue.main.async
    {
        EngageEventsDistributor.onGroupTimelineReport(id: captured_id, reportJson: captured_reportJson, extraEventsJson: captured_extraEventsJson)
    }
}

// ===========================================================================================
// Wrapper for the Engage Engine
// ===========================================================================================
class EngageEventsDistributor
{
    init()
    {
    }
    
    
    
    // ===========================================================================================
    // Our singleton instance
    // ===========================================================================================
    static private let theInstance: EngageEventsDistributor = EngageEventsDistributor()
    static func getInstance() -> EngageEventsDistributor
    {
        return theInstance
    }
    
    
    
    // ===========================================================================================
    // MARK: Event subscription
    // ===========================================================================================
    static private var engineEventsHandlers: [EngageEventHandlerBase] = [EngageEngineEventsHandler]()
    static private var groupEventsHandlers: [EngageEventHandlerBase] = [EngageGroupEventsHandler]()
    
    static private func subscriberIndex(element: EngageEventHandlerBase, list: [EngageEventHandlerBase]) -> Int
    {
        var index: Int = 0
        
        for e: EngageEventHandlerBase in list
        {
            if e === element
            {
                return index
            }
            
            index += 1
        }
        
        return -1
    }
    
    static private func internalSubscribe(handler: EngageEventHandlerBase, l: inout [EngageEventHandlerBase])
    {
        if subscriberIndex(element: handler, list: l) == -1
        {
            l.append(handler)
        }
    }
    
    static private func internalUnsubscribe(handler: EngageEventHandlerBase, l: inout [EngageEventHandlerBase])
    {
        let index = subscriberIndex(element: handler, list: l)
        if index != -1
        {
            l.remove(at: index)
        }
    }

    static func subscribe(eventHandler: EngageEngineEventsHandler)
    {
        internalSubscribe(handler: eventHandler, l: &engineEventsHandlers)
    }
    
    static func unsubscribe(eventHandler: EngageEngineEventsHandler)
    {
        internalUnsubscribe(handler: eventHandler, l: &engineEventsHandlers)
    }
    
    static func subscribe(eventHandler: EngageGroupEventsHandler)
    {
        internalSubscribe(handler: eventHandler, l: &groupEventsHandlers)
    }
    
    static func unsubscribe(eventHandler: EngageGroupEventsHandler)
    {
        internalUnsubscribe(handler: eventHandler, l: &groupEventsHandlers)
    }
    
    static func registerWithEngage() {
        var engageEventHandlers = EngageEvents_t(
            PFN_ENGAGE_ENGINE_STARTED: cb_onEngineStarted,
            PFN_ENGAGE_ENGINE_STOPPED: cb_onEngineStopped,
            
            PFN_ENGAGE_RP_PAUSING_CONNECTION_ATTEMPT: nil,
            PFN_ENGAGE_RP_CONNECTING: nil,
            PFN_ENGAGE_RP_CONNECTED: nil,
            PFN_ENGAGE_RP_DISCONNECTED: nil,
            PFN_ENGAGE_RP_ROUNDTRIP_REPORT: nil,
            
            PFN_ENGAGE_GROUP_CREATED: cb_onGroupCreated,
            PFN_ENGAGE_GROUP_CREATE_FAILED: cb_onGroupCreateFailed,
            PFN_ENGAGE_GROUP_DELETED: cb_onGroupDeleted,
            
            PFN_ENGAGE_GROUP_CONNECTED: cb_onGroupConnected,
            PFN_ENGAGE_GROUP_CONNECT_FAILED: cb_onGroupConnectFailed,
            PFN_ENGAGE_GROUP_DISCONNECTED: cb_onGroupDisconnected,
            
            PFN_ENGAGE_GROUP_JOINED: cb_onGroupJoined,
            PFN_ENGAGE_GROUP_JOIN_FAILED: cb_onGroupJoinFailed,
            PFN_ENGAGE_GROUP_LEFT: cb_onGroupLeft,
            
            PFN_ENGAGE_GROUP_MEMBER_COUNT_CHANGED: nil,
            
            PFN_ENGAGE_GROUP_NODE_DISCOVERED: nil,
            PFN_ENGAGE_GROUP_NODE_REDISCOVERED: nil,
            PFN_ENGAGE_GROUP_NODE_UNDISCOVERED: nil,
            
            PFN_ENGAGE_GROUP_RX_STARTED: cb_onGroupRxStarted,
            PFN_ENGAGE_GROUP_RX_ENDED: cb_onGroupRxEnded,
            PFN_ENGAGE_GROUP_RX_SPEAKERS_CHANGED: cb_onGroupRxSpeakersChanged,
            PFN_ENGAGE_GROUP_RX_MUTED: cb_onGroupRxMuted,
            PFN_ENGAGE_GROUP_RX_UNMUTED: cb_onGroupRxUnmuted,
            
            PFN_ENGAGE_GROUP_TX_STARTED: cb_onGroupTxStarted,
            PFN_ENGAGE_GROUP_TX_ENDED: cb_onGroupTxEnded,
            PFN_ENGAGE_GROUP_TX_FAILED: cb_onGroupTxFailed,
            PFN_ENGAGE_GROUP_TX_USURPED_BY_PRIORITY: nil,
            PFN_ENGAGE_GROUP_MAX_TX_TIME_EXCEEDED: nil,
            PFN_ENGAGE_GROUP_TX_MUTED: cb_onGroupTxMuted,
            PFN_ENGAGE_GROUP_TX_UNMUTED: cb_onGroupTxUnmuted,
            
            PFN_ENGAGE_GROUP_ASSET_DISCOVERED: nil,
            PFN_ENGAGE_GROUP_ASSET_REDISCOVERED: nil,
            PFN_ENGAGE_GROUP_ASSET_UNDISCOVERED: nil,
            
            PFN_ENGAGE_LICENSE_CHANGED: nil,
            PFN_ENGAGE_LICENSE_EXPIRED: nil,
            PFN_ENGAGE_LICENSE_EXPIRING: nil,
            
            PFN_ENGAGE_GROUP_BLOB_SENT: nil,
            PFN_ENGAGE_GROUP_BLOB_SEND_FAILED: nil,
            PFN_ENGAGE_GROUP_BLOB_RECEIVED: nil,
            
            PFN_ENGAGE_GROUP_RTP_SENT: nil,
            PFN_ENGAGE_GROUP_RTP_SEND_FAILED: nil,
            PFN_ENGAGE_GROUP_RTP_RECEIVED: nil,
            
            PFN_ENGAGE_GROUP_RAW_SENT: nil,
            PFN_ENGAGE_GROUP_RAW_SEND_FAILED: nil,
            PFN_ENGAGE_GROUP_RAW_RECEIVED: nil,
            
            PFN_ENGAGE_GROUP_TIMELINE_EVENT_STARTED: nil,
            PFN_ENGAGE_GROUP_TIMELINE_EVENT_UPDATED: nil,
            PFN_ENGAGE_GROUP_TIMELINE_EVENT_ENDED: nil,
            
            PFN_ENGAGE_GROUP_TIMELINE_REPORT: cb_onGroupTimelineReport,
            PFN_ENGAGE_GROUP_TIMELINE_REPORT_FAILED: cb_onGroupTimelineReportFailed,
            
            PFN_ENGAGE_GROUP_TIMELINE_GROOMED: nil,
            
            PFN_ENGAGE_GROUP_HEALTH_REPORT: nil,
            PFN_ENGAGE_GROUP_HEALTH_REPORT_FAILED: nil,
            
            PFN_ENGAGE_BRIDGE_CREATED: nil,
            PFN_ENGAGE_BRIDGE_CREATE_FAILED: nil,
            PFN_ENGAGE_BRIDGE_DELETED: nil,
            
            PFN_ENGAGE_GROUP_STATS_REPORT: nil,
            PFN_ENGAGE_GROUP_STATS_REPORT_FAILED: nil,
            
            PFN_ENGAGE_GROUP_RX_VOLUME_CHANGED: nil,
            
            PFN_ENGAGE_GROUP_RX_DTMF: nil
        )
        
        engageRegisterEventCallbacks(&engageEventHandlers)
    }
    
    
    
    // ===========================================================================================
    // MARK: Event distribution
    // ===========================================================================================
    static fileprivate func onEngineStarted(extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in engineEventsHandlers
        {
            (e as! EngageEngineEventsHandler).onEngineStarted(extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onEngineStopped(extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in engineEventsHandlers
        {
            (e as! EngageEngineEventsHandler).onEngineStopped(extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupCreated(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupCreated(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupCreateFailed(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupCreateFailed(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupDeleted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupDeleted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupJoined(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupJoined(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupJoinFailed(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupJoinFailed(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupLeft(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupLeft(id: id, extraEventsJson: extraEventsJson)
        }
    }

    static fileprivate func onGroupConnected(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupConnected(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupConnectFailed(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupConnectFailed(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupDisconnected(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupDisconnected(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupRxStarted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupRxStarted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupRxEnded(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupRxEnded(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupRxMuted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupRxMuted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupRxUnmuted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupRxUnmuted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupRxSpeakersChanged(id: String, groupTalkerJson: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupRxSpeakersChanged(id: id, groupTalkerJson: groupTalkerJson, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTxMuted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTxMuted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTxUnmuted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTxUnmuted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTxStarted(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTxStarted(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTxEnded(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTxEnded(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTxFailed(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTxFailed(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTimelineReportFailed(id: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTimelineReportFailed(id: id, extraEventsJson: extraEventsJson)
        }
    }
    
    static fileprivate func onGroupTimelineReport(id: String, reportJson: String, extraEventsJson: String?)
    {
        for e: EngageEventHandlerBase in groupEventsHandlers
        {
            (e as! EngageGroupEventsHandler).onGroupTimelineReport(id: id, reportJson: reportJson, extraEventsJson: extraEventsJson)
        }
    }
}
