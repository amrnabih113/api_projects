import 'package:api_projects/carts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  Cart? cart;

  Future<void> getData() async {
    String apiUrl = "https://dummyjson.com/carts";
    try {
      Response response = await Dio().get(apiUrl);
      setState(() {
        cart = Cart.fromJson(response.data);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Fetch Data From API using Dio"),
          centerTitle: true,
        ),
        body: cart == null
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                itemCount: cart!.carts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          cart!.carts[index].products[1].thumbnail,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            cart!.carts[index].products[1].title,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
