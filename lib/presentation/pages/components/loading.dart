part of 'helpers.dart';

void myLoading(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black45,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Loading...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(
              thickness: 1,
              color: foregroundColor,
            ),
            Row(
              children: [
                const CircularProgressIndicator(color: foregroundColor),
                const SizedBox(width: 15.0),
                Text(text)
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
