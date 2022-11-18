class ProductlistItem {
  String name;
  String price;
  String weight;
  String description;
  String imageAsset;
  String? diskon;

  ProductlistItem({
    required this.name,
    required this.price,
    required this.weight,
    required this.description,
    required this.imageAsset,
    required this.diskon,
  });
}

var productList = [
  ProductlistItem(
    name: 'Kubis Hijau',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp 18.000',
    weight: '1 - 10 Kg',
    imageAsset: 'assets/img/img0.png',
    diskon: "Diskon s/d 30%",
  ),
  ProductlistItem(
    name: 'Sawi',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp 15.000',
    weight: '1 Kg',
    imageAsset: 'assets/img/img1.png',
    diskon: "",
  ),
  ProductlistItem(
    name: 'Brokoli',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp. 20.000',
    weight: '1 - 5 Kg',
    imageAsset: 'assets/img/img2.png',
    diskon: "",
  ),
  ProductlistItem(
    name: 'Kol',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp 20.000',
    weight: '1 - 5 Kg',
    imageAsset: 'assets/img/img3.png',
    diskon: "",
  ),
  ProductlistItem(
    name: 'Salada Keriting',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp. 15.000',
    weight: '1 Kg',
    imageAsset: 'assets/img/img4.png',
    diskon: "",
  ),
  ProductlistItem(
    name: 'Selada Air',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp 15.000',
    weight: '1 Kg',
    imageAsset: 'assets/img/img5.png',
    diskon: "",
  ),
  ProductlistItem(
    name: 'Selada Kepala',
    description:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
    price: 'Rp 20.000',
    weight: '25.000',
    imageAsset: 'assets/img/img3.png',
    diskon: "",
  ),
];
