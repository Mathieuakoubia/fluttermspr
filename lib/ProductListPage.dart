import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProductDetailPage.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Map<String, dynamic>> products = []; // Liste complète des produits
  bool isLoading = true; // Indicateur de chargement
  final String apiKey = "x8QfIXSLDhEN8C9hKr8B3yNgbBFnPlrN_n7eBk2TEKo"; // Clé API

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Fonction pour récupérer les produits
  Future<void> fetchProducts() async {
    const String url = 'http://127.0.0.1:8000/products';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-API-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          products = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        throw Exception('Échec de la récupération des produits : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur : $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Produits'),
        backgroundColor: Colors.brown[800],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
          ? const Center(
        child: Text(
          'Aucun produit disponible.',
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.brown[50],
            child: ListTile(
              leading: Icon(Icons.coffee, color: Colors.brown[700]),
              title: Text(
                product['name'] ?? 'Produit sans nom',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.brown),
              onTap: () {
                // Naviguer vers la page de détails avec les données complètes
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
