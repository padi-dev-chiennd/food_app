import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/theme/color.dart';
import 'package:food_app/theme/string.dart';
import 'package:food_app/utils/data.dart';
import 'package:food_app/widgets/category_item.dart';
import 'package:food_app/widgets/custom_textbox.dart';
import 'package:food_app/widgets/feature_item.dart';
import 'package:food_app/widgets/popular_item.dart';

import '../widgets/appbar.dart';
import '../widgets/jelly_belly_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBarCusTome(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBody(), // ScrollView
            JellyBellyScreen() //Listview
          ],
        ),
      ),
      // JellyBellyScreen()
    );
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            Hello_Sangvaleap,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            Find_Your_Meals,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        _buildSearch(),
        const SizedBox(
          height: 25,
        ),
        _buildBannerImage(),
        const SizedBox(
          height: 25,
        ),
        _buildCategories(),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Popular,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                See_all,
                style: TextStyle(fontSize: 14, color: darker),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _buildPopulars(),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            Featured,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _buildSearch() {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: CustomTextBox(
        hint: Search,
        prefix: Icon(Icons.search, color: darker),
        suffix: Icon(
          Icons.filter_list_outlined,
          color: primary,
        ),
      ),
    );
  }

  _buildBannerImage() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2ZpbGV8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
          ),
        ),
      ),
    );
  }

  int selectedIndex = -1;

  _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(
        children: [
          CategoryItem(
            data: const {
              "name": categoryNameString,
              "icon": FontAwesomeIcons.th,
            },
            seleted: selectedIndex == -1,
            onTap: () => {
              setState(() {
                selectedIndex = -1;
              })
            },
          ),
          ...List.generate(
            categories.length,
            (index) => CategoryItem(
              data: categories[index],
              seleted: selectedIndex == index,
              onTap: () => {
                setState(() {
                  selectedIndex = index;
                })
              },
            ),
          )
        ],
      ),
    );
  }

  _buildPopulars() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: List.generate(
          populars.length,
          (index) => PopularItem(
            data: populars[index],
          ),
        ),
      ),
    );
  }

  _buildFeatured() {
    return Column(
      children: List.generate(
        featured.length,
        (index) => FeaturedItem(data: featured[index]),
      ),
    );
  }
}
