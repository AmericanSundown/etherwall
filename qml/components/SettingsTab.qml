/*
    This file is part of etherwall.
    etherwall is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
    etherwall is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with etherwall. If not, see <http://www.gnu.org/licenses/>.
*/
/** @file SettingsTab.qml
 * @author Ales Katona <almindor@gmail.com>
 * @date 2015
 *
 * Settings tab
 */

import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2

Tab {
    id: accountsTab
    title: qsTr("Settings")

    Column {
        id: col
        anchors.margins: 20
        anchors.fill: parent
        spacing: 15

        Row {
            id: rowIPCPath
            width: parent.width

            Label {
                id: ipcPathLabel
                text: "IPC path: "
            }

            TextField {
                id: ipcPathField
                width: parent.width - ipcSaveButton.width - ipcPathLabel.width - ipcPathButton.width
                text: settings.value("ipc/path", "")
            }

            Button {
                id: ipcPathButton
                text: qsTr("Choose")

                onClicked: {
                    fileDialog.folder = settings.value("/ipc/path")
                    fileDialog.open()
                }
            }

            Button {
                id: ipcSaveButton
                text: qsTr("Set")

                onClicked: {
                    settings.setValue("/ipc/path", ipcPathField.text)
                }
            }

            FileDialog {
                id: fileDialog
                title: qsTr("IPC")
                nameFilters: ["Unix Socket IPC (*.ipc)"]

                onAccepted: {
                    ipcPathField.text = fileDialog.fileUrl
                }
            }
        }

        Row {
            width: parent.width

            Label {
                text: qsTr("Account unlock duration (s): ")
            }

            SpinBox {
                id: unlockDurSpinBox
                minimumValue: 10
                maximumValue: 3600

                value: settings.value("/ipc/accounts/lockduration", 300)
            }

            Button {
                text: qsTr("Set")

                onClicked: {
                    settings.setValue("/ipc/accounts/lockduration", unlockDurSpinBox.value)
                }
            }
        }

        Row {
            width: parent.width

            Label {
                text: qsTr("Update interval (s): ")
            }

            SpinBox {
                id: intervalSpinBox
                minimumValue: 5
                maximumValue: 60

                value: settings.value("/ipc/interval", 10)
            }

            Button {
                text: qsTr("Set")

                onClicked: {
                    settings.setValue("/ipc/interval", intervalSpinBox.value)
                    ipc.setInterval(intervalSpinBox.value * 1000)
                }
            }
        }

        Row {
            width: parent.width

            Label {
                text: qsTr("Transaction history (hours estimate): ")
            }

            SpinBox {
                id: historySpinBox
                minimumValue: 2
                maximumValue: 24 * 30

                value: settings.value("/ipc/transactions/historyblocks", 10800) / 225
            }

            Button {
                text: qsTr("Set")

                onClicked: {
                    settings.setValue("/ipc/transactions/historyblocks", historySpinBox.value * 225) // roughly 225 blocks per hour
                }
            }
        }

    }
}