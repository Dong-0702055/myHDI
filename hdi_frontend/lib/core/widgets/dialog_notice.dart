import 'package:flutter/material.dart';
import '../../app/theme/app_color.dart';

class DialogNotice1 extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onpress;
  final String image;
  final String textbutton;

  DialogNotice1({super.key,required this.title, required this.text, required this.onpress, required this.image, required this.textbutton});

  static void show(BuildContext context,{
    required String title,
    required String text,
    required VoidCallback onpress,
    required String image,
    required String textbutton,
  }) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) =>  DialogNotice1(title: title,
        text: text,
        onpress: onpress,
        image: image,
        textbutton: textbutton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset(image),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
             title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
             Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Container(
              margin: EdgeInsets.only(top: 0,bottom: 20,left: 80,right: 80),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onpress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFBB8A0B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    textbutton,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class DialogNotice2 extends StatelessWidget {
  final String title;
  final String text;
  final VoidCallback onpress1;
  final VoidCallback onpress2;
  final String image;
  final String textbutton1;
  final String textbutton2;

  DialogNotice2({
    super.key,required this.title,
    required this.text, required this.onpress1,
    required this.onpress2, required this.image,
    required this.textbutton1,required this.textbutton2});

  static void show(BuildContext context,{
    required String title,
    required String text,
    required VoidCallback onpress1,
    required VoidCallback onpress2,
    required String image,
    required String textbutton1,
    required String textbutton2,
  }) {
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (context) =>  DialogNotice2(title: title,
        text: text,
        onpress1: onpress1,
        onpress2: onpress2,
        image: image,
        textbutton1: textbutton1,
        textbutton2: textbutton2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset(image),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              text,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Container(
              margin: EdgeInsets.only(top: 0,bottom: 20,left: 10,right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onpress1,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:  BorderSide(
                              color: AppColor.appButtonColor,
                              width: 1,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          textbutton1,
                          style: TextStyle(
                            color: AppColor.appButtonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onpress2,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.appButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          textbutton2,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}