import 'package:flutter/material.dart';
import 'package:food_app/theme/color.dart';

class CategoryList extends StatefulWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryList({super.key, required this.categories});

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = -1; // Keeps track of which item is selected (-1 means none)

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.categories.length, (index) {
        return CategoryItem(
          data: widget.categories[index],
          seleted: selectedIndex == index, // Only the selected item gets true
          onTap: () {
            setState(() {
              selectedIndex = index; // Update the selected index
            });
          },
        );
      }),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.data,
    required this.seleted,
    required this.onTap,
  });

  final Map<String, dynamic> data;
  final bool seleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        width: 90,
        decoration: BoxDecoration(
          color: seleted ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              spreadRadius: .5,
              blurRadius: .5,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data["icon"],
              size: 17,
              color: seleted ? Colors.white : darker,
            ),
            const SizedBox(width: 7),
            Text(
              data["name"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: seleted ? Colors.white : darker,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

