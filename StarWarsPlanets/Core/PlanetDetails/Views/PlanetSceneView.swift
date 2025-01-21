//
//  PlanetSceneView.swift
//  StarWarsPlanets
//
//  Created by Juan Pedro Lozano Baño on 21/1/25.
//
import SwiftUI
import SceneKit
struct PlanetSceneView: View {
    var body: some View {
        SceneView(scene: createScene())
            .edgesIgnoringSafeArea(.all)
            .background(.black)
    }

    private func createScene() -> SCNScene {
        let scene = SCNScene()
        let tiltNode = SCNNode()
        scene.rootNode.addChildNode(tiltNode)
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 1.0))
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.brown
        let bumpImage = UIImage(named: "bumpmap.jpg")
        material.normal.contents = bumpImage
        material.normal.intensity = 0.6
        material.lightingModel = .physicallyBased
        material.isDoubleSided = true
        sphereNode.geometry?.firstMaterial = material
        sphereNode.castsShadow = false
        tiltNode.addChildNode(sphereNode)
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .directional
        lightNode.light?.castsShadow = true
        lightNode.position = SCNVector3(x: 0, y: 1, z: 0)


        scene.rootNode.addChildNode(lightNode)
        let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi), z: 0, duration: 10)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        sphereNode.runAction(repeatAction)
        scene.rootNode.addChildNode(sphereNode)
        return scene
    }
}

#Preview {
    PlanetSceneView()
}
