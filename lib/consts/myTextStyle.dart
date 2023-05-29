
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'colors.dart';

const bold="bold";
const regular="regular";


myStyle({family=regular, double ? size=14 , color = whiteColor}){
  return TextStyle( 
    fontSize: size, 
    color: color, 
    fontFamily: family,
    );
}