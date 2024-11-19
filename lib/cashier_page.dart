import 'package:flutter/material.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  List<Map<String, dynamic>> products = [
  {
    "image": "assets/images/download.jpg",
    "name": "Ariana",
    "price": 1000000,
    "stock": 1,
    "quantity": 0, // Tambahkan quantity dengan nilai awal 0
  },
  {
    "image": "assets/images/download (1).jpg",
    "name": "Clarissa",
    "price": 2000000,
    "stock": 2,
    "quantity": 0, // Tambahkan quantity dengan nilai awal 0
  },
  {
    "image": "assets/images/download (2).jpg",
    "name": "Melania",
    "price": 3000000,
    "stock": 3,
    "quantity": 0, // Tambahkan quantity dengan nilai awal 0
  },
  {
    "image": "assets/images/download (3).jpg",
    "name": "Aluna",
    "price": 4000000,
    "stock": 20,
    "quantity": 0, // Tambahkan quantity dengan nilai awal 0
  },
];

  int _totalItem = 0;
  int _totalHarga = 0;

  Future<void> _TambahItemBeli(int index) async {
    setState(() {
      if (products[index]['stock'] > 0) {
        products[index]['stock']--;
        products[index]['quantity'] = (products[index]['quantity'] ?? 0) + 1;
        _totalItem++;
        _totalHarga += products[index]['price'] as int;
      }
       else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Stock sudah habis!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> _KurangItemBeli(int index) async {
    setState(() {
      if (products[index]['quantity'] != null &&
          products[index]['quantity'] > 0) {
        products[index]['stock']++;
        products[index]['quantity'] = (products[index]['quantity'] ?? 0) - 1;
        _totalItem--;
        _totalHarga -= products[index]['price'] as int;
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak bisa mengurangi lebih dari 0'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cashier App",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  "Semoga harimu menyenangkan :)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari Produk...',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 15,
                        );
                      },
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[300],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "${products[index]['image']}"),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0)),
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "${products[index]['name']}",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                            Text(
                                                "Stock : ${products[index]['stock']}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ],
                                        ),
                                        Text(
                                            "Rp. ${products[index]['price']}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: [
                                    if ((products[index]['quantity'] ?? 0) > 0)
                                      GestureDetector(
                                        onTap: () {
                                          _KurangItemBeli(index);
                                        },
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Icon(
                                            Icons
                                                .remove_circle_outline_rounded,
                                            color: Colors.red[400],
                                          ),
                                        ),
                                      ),
                                    // Show quantity only when greater than 0
                                    if ((products[index]['quantity'] ?? 0) > 0)
                                      SizedBox(
                                        width: 40,
                                        child: Center(
                                          child: Text(
                                            "${products[index]['quantity'] ?? 0}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    GestureDetector(
                                      onTap: () {
                                        _TambahItemBeli(index);
                                      },
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(
                                          Icons.add_circle_outline_outlined,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
       Align(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 55,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                       "Total ($_totalItem Item) = Rp. $_totalHarga",  
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    ),
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    )
                    
                  ],
                ),
                ),
            ),
          ),
        )
        ],
      ),
    );
  }
}