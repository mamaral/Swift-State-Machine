//
//  CDPlayerStateMachine.swift
//  StateMachine
//
//  Created by Mike on 1/25/16.
//  Copyright © 2016 Mike Amaral. All rights reserved.
//

import Foundation
import AVFoundation

class CDPStateMachine: StateMachine {
    let interface: CDPInterface = CDPInterface()
    let stoppedStateIndex: Int = 0
    let playingStateIndex: Int = 1
    let pausedStateIndex: Int = 2


    // MARK: Initialization
    //
    override init() {
        super.init()

        // Create our initial states, and set the current state to the desired initial state,
        // which in this case is stopped.
        //
        self.states = [CDPStopped(self), CDPPlaying(self), CDPPaused(self)]
        self.currentState = self.states[0]
    }
}
