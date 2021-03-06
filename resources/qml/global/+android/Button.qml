import QtQuick 2.5
import QtGraphicalEffects 1.0

import "."

/*
 * Custom implementation to be replaced with template specialization of Qt.labs.controls Button
 * Android style guide for material design is adapted.
 */
Item {
	property alias text: textItem.text
	property color buttonColor: Constants.blue

	signal clicked

	height: Constants.button_height
	width: Math.max(textItem.implicitWidth + 2 * Utils.dp(16), Utils.dp(88))

	state: "normal"
	states: [
		State { name: "normal"; when: !mouseArea.pressed
			PropertyChanges { target: darkLayer; width: 0 }
			PropertyChanges { target: shadow; verticalOffset: Utils.dp(2) }
		},
		State { name: "pressed"; when: mouseArea.pressed
			PropertyChanges { target: darkLayer; width: 2 * rect.width }
			PropertyChanges { target: shadow; verticalOffset: Utils.dp(8) }
		}
	]
	transitions: [
		Transition {
			from: "normal"; to: "pressed"; reversible: false
			PropertyAnimation { target: darkLayer; property: "width"}
			PropertyAnimation { target: shadow; property: "verticalOffset"}
		}
	]

	Rectangle {
		id: rect
		anchors.fill: parent
		color: enabled ? buttonColor : "#10000000"
		radius: Utils.dp(3)

		Item {
			anchors.fill: parent
			clip: true
			Rectangle {
				id: darkLayer
				x: mouseArea.containsMouse ? mouseArea.mouseX - width * 0.5 : 0
				height: parent.height
				color: "#000000"
				opacity: 0.2
				radius: Utils.dp(3)
			}
		}

	}

	DropShadow {
		id: shadow
		anchors.fill: rect
		radius: 8.0
		fast: true
		color: "#40000000"
		source: rect
	}

	Text {
		id: textItem
		anchors.centerIn: rect
		color: enabled ? "white" : "#40000000"
		font.capitalization: Font.AllUppercase
		font.bold: true
		font.pixelSize: Utils.dp(16)
	}
	MouseArea{
		id: mouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: parent.clicked()
	}
}

