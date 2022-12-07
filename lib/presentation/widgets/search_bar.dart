import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/common/styles/color.dart';
import 'package:tengkulak_sayur/data/common/utils/routes.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, searchPageRoute);
        },
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.5,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(1, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: Icon(
                    Icons.search,
                    color: foregroundColor,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    'Search product',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
