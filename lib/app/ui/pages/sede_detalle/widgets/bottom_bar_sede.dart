

import 'package:flutter/material.dart';

import '../../../theme/colores.dart';
class BottomBarSede extends StatelessWidget {
  
  final Function(int value) seleccionarTab;

  const BottomBarSede({super.key, required this.seleccionarTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(width: 1, color: Colores.negro)),
        color: Colores.blanco,
      ),
      height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TabBar(
                labelColor: Colores.negro,
                unselectedLabelColor: Colores.gris,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colores.blanco,
                indicator: null,
                indicatorPadding: EdgeInsets.all(0),
                isScrollable: true,
                padding: EdgeInsets.all(0),
                onTap: seleccionarTab,
                tabs: const [
                  Tab(
                    text: "Combo / plan",                
                  ),
                  Tab(
                    text: "Evento",
                  ),
                  Tab(
                    text: "Renta",
                  ),
                  Tab(
                    text: "Tickets",
                  ),
                  Tab(
                    text: "Terminos y condiciones",
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}