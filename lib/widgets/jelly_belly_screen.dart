import 'package:flutter/material.dart';
import 'package:food_app/api/api_service.dart';

import '../model/jelly_belly.dart';

class JellyBellyScreen extends StatefulWidget {
  const JellyBellyScreen({super.key});

  @override
  _JellyBellyScreenState createState() => _JellyBellyScreenState();
}

class _JellyBellyScreenState extends State<JellyBellyScreen> {
  late Future<List<JellyBeanModel>> _jellyBeanModel;

  @override
  void initState() {
    super.initState();
    // Initialize the API call
    _jellyBeanModel = ApiService().fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    _jellyBeanModel = ApiService().fetchItems();
    return FutureBuilder<List<JellyBeanModel>>(
      future: _jellyBeanModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final items = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: Image.network(
                          item.imageUrl,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(item.flavorName),
                        subtitle: Text(item.description)),
                  ));
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
