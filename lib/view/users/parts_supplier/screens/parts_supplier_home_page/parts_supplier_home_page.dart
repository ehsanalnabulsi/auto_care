import 'package:flutter/material.dart';

class PartsSupplierHomePage extends StatelessWidget {
  const PartsSupplierHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts Supplier Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_business_rounded),
      ),
      drawer: const Drawer(),
      body: const SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
