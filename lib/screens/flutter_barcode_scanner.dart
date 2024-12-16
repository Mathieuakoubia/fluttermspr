// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:mspr/screens/productListScrren.dart';  // Importe ta page pour afficher la liste des produits
//
// class QRScanScreen extends StatefulWidget {
//   @override
//   _QRScanScreenState createState() => _QRScanScreenState();
// }
//
// class _QRScanScreenState extends State<QRScanScreen> {
//   String scannedData = ''; // Variable pour stocker les données scannées
//
//   // Méthode pour lancer le scanner
//   Future<void> scanQRCode() async {
//     String scannedResult = await FlutterBarcodeScanner.scanBarcode(
//       '#ff6666', // Couleur du scanner
//       'Cancel',   // Texte du bouton de retour
//       true,       // Activer la lampe torche (flash)
//       ScanMode.QR, // Mode de scan QR Code
//     );
//     setState(() {
//       scannedData = scannedResult; // Met à jour la variable avec les données scannées
//     });
//     if (scannedData != '-1') {
//       // Si un QR Code valide a été scanné, navigue vers la page des produits
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ProductListScreen(
//             scannedData: scannedData, // Passe les données scannées à la page suivante
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Scanner QR Code"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 4,
//             child: Center(
//               child: ElevatedButton(
//                 onPressed: scanQRCode, // Appeler la méthode pour scanner un QR code
//                 child: Text('Scanner un QR Code'),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Text('QR Code Data: $scannedData'), // Affiche les données scannées
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
