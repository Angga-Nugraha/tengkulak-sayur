import 'package:flutter/material.dart';
import 'package:tengkulak_sayur/data/utils/routes.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, searchPageRoute);
            },
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.7,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: Icon(Icons.search),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('Search product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
