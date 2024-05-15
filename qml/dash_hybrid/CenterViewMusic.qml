/****************************************************************************
**
** Copyright (C) 2016 Pelagicore AG
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Neptune IVI UI.
**
** $QT_BEGIN_LICENSE:GPL-QTAS$
** Commercial License Usage
** Licensees holding valid commercial Qt Automotive Suite licenses may use
** this file in accordance with the commercial license agreement provided
** with the Software or, alternatively, in accordance with the terms
** contained in a written agreement between you and The Qt Company.  For
** licensing terms and conditions see https://www.qt.io/terms-conditions.
** For further information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
** SPDX-License-Identifier: GPL-3.0
**
****************************************************************************/

import QtQuick 2.6

Item {
    id: musicContainer

    property url currentCover: "image://etc/cover.png"
    property string currentSong: "Doesn't Mean Anything"
    property string currentArtist: "Alicia Keys"
    opacity: 0.5
    property alias yTarget: startupAnimation.to
    property int defaultYPos: 400

    Rectangle {
        y: 10
        id: image
        width: 124
        height: 124
        border.color: "#EF2973"
        border.width: 2
        color: "black"

        Image {
            anchors.margins: 2
            fillMode: Image.PreserveAspectCrop
            anchors.fill: parent
            asynchronous: true
            source: musicContainer.currentCover
        }
    }

    Text {
        id: title
        anchors.top: image.bottom
        anchors.topMargin: 6
        anchors.horizontalCenter: image.horizontalCenter
        text: musicContainer.currentSong
        color: "gray"
        font.pixelSize: 16
    }

    Text {
        anchors.top: title.bottom
        anchors.horizontalCenter: image.horizontalCenter
        text: musicContainer.currentArtist
        color: "lightGray"
        font.pixelSize: 16
    }

    Timer {
        id: fadeOutTimer
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            musicContainer.opacity = 0.5
        }
    }

    Behavior on opacity { PropertyAnimation { duration: 500 } }

    PropertyAnimation on y {
        id: startupAnimation
        duration: 500
        easing.type: Easing.InCubic
        onStopped: {
            musicContainer.opacity = 1.0
            fadeOutTimer.start()
        }
    }

    onVisibleChanged: {
        if (visible) {
            y = defaultYPos
            startupAnimation.start()
        }
    }
}

