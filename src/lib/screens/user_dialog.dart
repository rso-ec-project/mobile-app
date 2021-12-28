import 'package:charging_stations_mobile/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserDialog extends StatefulWidget {
  const UserDialog({Key? key}) : super(key: key);

  @override
  _UserDialogState createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("User Id: ${Config.userId}", style: const TextStyle(fontSize: 16),),
        ElevatedButton(
          child: const Icon(Icons.account_circle),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => createDialog(context)
            );
          },
        )
      ],
    );
  }

  Widget createDialog(BuildContext context){
    return SimpleDialog(
      title: const Text("Update User Id"),
      contentPadding: const EdgeInsets.all(30),
      children: [
        TextFormField(
          initialValue: Config.userId.toString(),
          decoration: const InputDecoration(
            hintText: 'User Id',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent),
            ),
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) => _textEditingController.text = value,
        ),
        const SizedBox(
          height: 20,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: 10,
          children: <Widget>[
            OutlinedButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text("Submit", style: TextStyle(color: Colors.white),),
              onPressed: () async {
                Config.userId = int.parse(_textEditingController.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }

}