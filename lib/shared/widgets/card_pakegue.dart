import 'package:flutter/material.dart';

import '../../models/models.dart';

class CardPakeguesScreen extends StatefulWidget {
   
  const CardPakeguesScreen({super.key, required this.suscricion, required this.index, required this.indexSeleccionado});
  final SuscribeModel suscricion; 
  final int index ;
  final int indexSeleccionado;
  @override
  State<CardPakeguesScreen> createState() => _CardPakeguesScreenState();
}

class _CardPakeguesScreenState extends State<CardPakeguesScreen> {
  bool isDark=false;
  @override
  Widget build(BuildContext context) {
   
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 5, right: 10, left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        color: widget.index == widget.indexSeleccionado ? Colors.grey:Colors.white,// colors(isDark),
        boxShadow: [BoxShadow(
        color: Colors.grey.shade600,
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 8)
        )]
      ),
      
      child: SizedBox(
        //width: MediaQuery.of(context).size.width * 0.27,
        //height: MediaQuery.of(context).size.height * 0.1,
          child:  Center(
            child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                               TextSpan(
                                  text: '      ${widget.suscricion.cantidad}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black)),
                              const TextSpan(text: '\n'),
                              TextSpan(
                                  text: '${widget.suscricion.name}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black)),
                                      const TextSpan(text: '\n'),
                              TextSpan(
                                  text: 'MXN ${widget.suscricion.price?.toString()}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
          ),
          
      
      ),
    );
  }
}

Color colors(bool isdark){
  if(isdark){
    return Colors.grey.shade300;
  }else{
    return Colors.white;
  }
}