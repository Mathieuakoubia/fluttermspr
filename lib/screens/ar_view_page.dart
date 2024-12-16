import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';

class ARViewPage extends StatefulWidget {
  const ARViewPage({super.key});

  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> {
  // late ARSessionManager arSessionManager;
  // late ARObjectManager arObjectManager;
  // ARNode? localObjectNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visualiser le produit en AR")),
      body: Center(
        child: Text(
          "La fonctionnalité de réalité augmentée est temporairement désactivée.",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // void onARViewCreated(ARSessionManager sessionManager, ARObjectManager objectManager, ARAnchorManager anchorManager) {
  //   arSessionManager = sessionManager;
  //   arObjectManager = objectManager;

  //   arSessionManager.onInitialize(
  //     showFeaturePoints: false,
  //     showPlanes: true,
  //     customPlaneTexturePath: "images/expresso.jpg", // Remplacez par une image
  //   );

  //   addLocalObject();
  // }

  // void addLocalObject() async {
  //   final newNode = ARNode(
  //     type: NodeType.localGLTF2,
  //     uri: "images/coffee_model.glb", // Chemin de votre modèle 3D
  //     scale: Vector3(0.2, 0.2, 0.2),
  //     position: Vector3(0.0, 0.0, -1.0), // Position devant l'utilisateur
  //   );

  //   bool didAddNode = await arObjectManager.addNode(newNode);
  //   if (didAddNode) {
  //     setState(() {
  //       localObjectNode = newNode;
  //     });
  //   } else {
  //     print("Erreur : impossible d'ajouter le modèle 3D");
  //   }
  // }

  @override
  void dispose() {
    // arSessionManager.dispose();
    super.dispose();
  }
}
