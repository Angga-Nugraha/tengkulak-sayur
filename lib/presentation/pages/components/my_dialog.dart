part of 'helpers.dart';

void myDialog(
    {required BuildContext context,
    required String title,
    required String textButton1,
    required String textButton2,
    required VoidCallback onPressed1,
    required VoidCallback onPressed2}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(5),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: kHeading6,
            textAlign: TextAlign.center,
          ),
          const Divider(
            // height: 2,
            thickness: 1,
            color: foregroundColor,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onPressed1,
          child: Text(textButton1),
        ),
        TextButton(
          onPressed: onPressed2,
          child: Text(textButton2),
        ),
      ],
    ),
  );
}
