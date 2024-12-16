
import 'package:flutter/material.dart';


import '../widgets/home_bottom_bar.dart';
import '../widgets/items_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allProducts = [
    'Café Moka',
    'Café Expresso',
    'Latte',
    'Cappuccino',
    'Americano',
    'Macchiato',
    'Flat White',
    'Ristretto'
  ]; // Liste des produits (types de café)
  List<String> _filteredProducts = []; // Liste filtrée selon la recherche

  @override
  void initState() {
    super.initState();
    _filteredProducts = []; // On affiche aucun produit par défaut
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Fonction de filtrage des produits
  void _searchProducts() {
    setState(() {
      String query = _searchController.text.trim();
      if (query.isEmpty) {
        _filteredProducts = [];
      } else {
        _filteredProducts = _allProducts
            .where((product) => product.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  // Fonction pour naviguer vers la page sélectionnée
  void _navigateToCategory(String category) {
    // Logique de navigation en fonction de la catégorie sélectionnée
    print('Naviguer vers: $category'); // À remplacer par la navigation réelle vers la page
    // Vous pouvez par exemple définir une logique de navigation vers un écran de catégorie spécifique
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              // Gradient Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6F4F37),
                      Color(0xFF3E2723),
                      Color(0xFF9E7C4F),
                      Color(0xFFCBB89C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Icône de tri avec un menu contextuel
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.sort_rounded,
                              color: Colors.white.withOpacity(0.5),
                              size: 35,
                            ),
                            onSelected: _navigateToCategory,
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'Hot Coffee',
                                  child: Text('Hot Coffee'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Cold Coffee',
                                  child: Text('Cold Coffee'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Cappuccino',
                                  child: Text('Cappuccino'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Americano',
                                  child: Text('Americano'),
                                ),
                              ];
                            },
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white.withOpacity(0.5),
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "It's a Great Day for Coffee",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Champ de recherche avec icône
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 50, 54, 56),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Trouver votre produit",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                contentPadding: EdgeInsets.only(left: 15),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
                            onPressed: () {
                              _searchProducts();
                            },
                          ),
                        ],
                      ),
                    ),
                    // Affichage des résultats de la recherche
                    if (_filteredProducts.isNotEmpty)
                      Column(
                        children: _filteredProducts.map((product) {
                          return ListTile(
                            title: Text(
                              product,
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              // Action au tap sur un produit
                            },
                          );
                        }).toList(),
                      ),
                    if (_filteredProducts.isEmpty && _searchController.text.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Aucun produit trouvé.',
                          style: TextStyle(color: Colors.white.withOpacity(0.8)),
                        ),
                      ),
                    // TabBar
                    // TabBar(
                    //   controller: _tabController,
                    //   labelColor: Color(0xFFE57734),
                    //   unselectedLabelColor: Colors.white.withOpacity(0.5),
                    //   isScrollable: true,
                    //   indicator: UnderlineTabIndicator(
                    //     borderSide: BorderSide(
                    //       width: 3,
                    //       color: Color(0xFFE57734),
                    //     ),
                    //     insets: EdgeInsets.symmetric(horizontal: 16),
                    //   ),
                    //   labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    //   labelPadding: EdgeInsets.symmetric(horizontal: 20),
                    //   tabs: [
                    //     Tab(text: "Hot Coffee"),
                    //     Tab(text: "Cold Coffee"),
                    //     Tab(text: "Cappuccino"),
                    //     Tab(text: "Americano"),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Center(
                      child: [
                        ItemsWidget(),
                        ItemsWidget(),
                        ItemsWidget(),
                        ItemsWidget(),
                      ][_tabController.index],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
