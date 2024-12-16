// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class ProductListScreen extends StatelessWidget {
//   final String scannedData;
//
//   ProductListScreen({required this.scannedData});
//
//   // Méthode pour récupérer les produits depuis une API
//   Future<List<String>> fetchProducts() async {
//     final response = await http.get(Uri.parse('https://exemple-api.com/products/$scannedData'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return List<String>.from(data['products'].map((product) => product['name']));
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Liste des Produits de Café"),
//       ),
//       body: FutureBuilder<List<String>>(
//         future: fetchProducts(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erreur: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('Aucun produit trouvé'));
//           } else {
//             final coffeeProducts = snapshot.data!;
//             return ListView.builder(
//               itemCount: coffeeProducts.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(coffeeProducts[index]),
//                   onTap: () {
//                     // Action quand l'utilisateur clique sur un produit
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
