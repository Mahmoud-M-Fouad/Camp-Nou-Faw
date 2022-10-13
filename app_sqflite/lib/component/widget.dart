
import 'package:app_sqflite/component/theme.dart';
import 'package:flutter/material.dart';

buildMaterialButton({
  required Color color,
  required String text,
  required var function,
})
{
  return MaterialButton(
    color: color,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)),
    onPressed: function,
    child:Text(text ,style: headingStyle(
      color: Colors.white,
      fontSize: 16,
    )),
  );
}

buildIcon({
  required IconData icon,
  required Color color,
})
{
  return Icon(icon,color: color,);
}

buildIconButton(
{
  required IconData icon,
  required Color color,
  required var onPressed,
})
{
  return IconButton(
  onPressed: onPressed,
  icon: buildIcon(
    icon: icon,
    color: color
  )
  );
}

buildCheckBox(
    {
      required bool value,
      required String text,
      required var onChanged,
    })
{
  return CheckboxListTile(
    title: Text(text),
    autofocus: false,
    activeColor: Colors.indigo,
    checkColor: Colors.white,
    selected: value,
    value: value,
    onChanged:onChanged,
  );
}
buildTextFormFieldToReadOly(
    {
      required String text,
      required var controller,
      required IconData iconPre,

    }
    )
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          /*enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(50),
          ),*/
          border: const UnderlineInputBorder(),
          labelText: text,
          labelStyle: headingStyle(color: Colors.black, fontSize: 20),
          prefixIcon: Icon(iconPre, color: Colors.teal,),
        ),
      readOnly: true,
    ),
  );
}

buildTextFormField(
    {
      required String text,
      required IconData iconPre,
      required var textInputType,
      required var onSaved,
      required var controller,
      required var validate,

    }
    )
{
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      //onSaved: onSaved,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const UnderlineInputBorder(),
        labelText: text,
        labelStyle: headingStyle(color: Colors.black, fontSize: 18),
        prefixIcon: Icon(iconPre, color: Colors.teal,),
        suffixIcon: IconButton(onPressed: (){controller.text ="";},icon: const Icon(Icons.clear),color: Colors.teal,),
      ),
      keyboardType: textInputType,
      validator:validate,
      onChanged:onSaved
      /*(value)
      {
        if (value == null || value.isEmpty) {
          return textValidate;
        }
        return null;
      },
      */
    ),
  );
}