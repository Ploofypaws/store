import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage(
      {super.key,
      this.title = 'something',
      this.price = '0',
      this.seller = 'some one',
      this.url = 'https://via.placeholder.com/300'});
  final String title;
  final String seller;
  final String price;
  final String url;

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  int selectedImageIndex = 0;
  int quantity = 1;

  String selectedSize = 'L';
  List<Map<String, dynamic>> cartItems = [];
  LocationData? _locationData;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> productImages = [
      widget.url,
      widget.url,
      widget.url,
      widget.url,
      widget.url,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Container(),
                ),
              );
            },
            icon: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_bag_outlined),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${cartItems.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.network(
                            productImages[selectedImageIndex],
                            height: 200,
                            width: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                List.generate(productImages.length, (index) {
                              return _buildImageSelectionOption(index);
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.seller,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '(320 Review)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Available in stock',
                      style: TextStyle(color: Colors.green),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Size',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildSizeOption('S'),
                        _buildSizeOption('M'),
                        _buildSizeOption('L'),
                        _buildSizeOption('XL'),
                        _buildSizeOption('XXL'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                  }
                                });
                              },
                            ),
                            Text(
                              '$quantity',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // TabBar and TabBarView
                    DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.black,
                            tabs: const [
                              Tab(text: 'Description'),
                              Tab(text: 'Specifications'),
                              Tab(text: 'Reviews'),
                            ],
                          ),
                          SizedBox(
                            height: 200, // Adjust height as needed
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry...'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                      'Specifications content goes here...'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('Reviews content goes here...'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Price',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      'Rs ${(double.parse(widget.price) * quantity).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    _getLocationAndShowBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 16.0),
                    backgroundColor: Colors.black,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      SizedBox(width: 5),
                      Text('Add to cart'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSelectionOption(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImageIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selectedImageIndex == index ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: selectedSize == size ? Colors.black : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: selectedSize == size ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> _getLocationAndShowBottomSheet(BuildContext context) async {
    final location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();

    setState(() {
      _locationData = locationData;
    });

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Location:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              if (_locationData != null)
                Text(
                  'Latitude: ${_locationData!.latitude}\nLongitude: ${_locationData!.longitude}',
                  style: const TextStyle(fontSize: 16),
                )
              else
                const Text(
                  'Location data not available',
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        );
      },
    );
  }
}
