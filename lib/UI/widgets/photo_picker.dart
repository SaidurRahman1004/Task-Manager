import 'package:flutter/material.dart';

class PhotoPickerWidget extends StatelessWidget {
   PhotoPickerWidget({super.key, required this.onPressed});
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildPhotosButton(),
          SizedBox(width: 8),
          // Expanded(child: TextFormField(decoration: InputDecoration(hintText: 'No file chosen')))
          SizedBox(width: 8),
          _buildPhotoInputField(),
        ],
      ),
    );
  }

   //ImageButton
  Widget _buildPhotosButton() {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Photos', style: TextStyle(fontSize: 14)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
    );
  }

  //PhotoInputFeild
  Widget _buildPhotoInputField() {
    return Expanded(
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.fromBorderSide(
              BorderSide(color: Colors.grey, width: 0.5),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'No file chosen',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
