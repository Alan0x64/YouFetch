// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String bigText;
  final String smallerText;
  final VoidCallback fun;
  final Color bc;
  final bool quit;
  final bool hideCancelButton;


  const CustomDialog({
    super.key,
    required this.bigText,
    required this.smallerText,
    required this.fun,
    this.quit=false,
    this.hideCancelButton=false,
    this.bc = const Color.fromARGB(255, 182, 31, 21),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        ModalBarrier(dismissible: false, color: Colors.black.withOpacity(0.5)),
        AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title: Text(bigText),
          actionsOverflowButtonSpacing: 20,
          actions: [
            if(!hideCancelButton)
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 14, 192, 20)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(bc),
                ),
                onPressed: () async {
                },
                child: const Text("Continue")),
          ],
          content: Text(smallerText))],
    );
  }
}

// CupertinoAlertDialog(
        //   title: const Text("Sure You Wanna Delete Account?"),
        //   actions: [
        //     CupertinoDialogAction(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: const Text("Go Back")),
        //     CupertinoDialogAction(
        //         onPressed: () async {
        //           await runFun(context, widget.deleteFun);
        //           await clearTokens();
        //           gotoClear(context, LoginScreen());
        //         },
        //         child: const Text("Continue")),
        //   ],
        //   content: const Text(
        //       "This Will Cause All Your Data To Be Deleted But Data Such As Certifacte Will Remain,This Action Is Unreviersible"),
        // );