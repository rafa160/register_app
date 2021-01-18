import 'package:flutter/material.dart';
import 'package:personal_register/helpers/shared.dart';

class SearchDialog extends StatelessWidget {

  final String initialText;

  const SearchDialog( this.initialText);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 4,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back, color: Shared.standardBackgroundColor,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
              ),
              onFieldSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
