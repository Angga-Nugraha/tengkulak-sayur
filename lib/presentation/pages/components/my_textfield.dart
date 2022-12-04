part of 'components_helpers.dart';

Widget myTextfield(
    {required TextEditingController controller,
    required hintText,
    required icon,
    required type,
    obscure = false}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Colors.black38,
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(1, 3), // changes position of shadow
        ),
      ],
    ),
    child: Form(
      child: TextField(
        keyboardType: type,
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
          ),
          prefixIconColor: foregroundColor,
          prefixIcon: Icon(
            icon,
            color: secondaryColor,
            size: 20,
          ),
        ),
      ),
    ),
  );
}
