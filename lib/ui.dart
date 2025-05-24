import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:avl_tree/custom_paint.dart';
import 'package:avl_tree/controladores.dart';

class Pantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AVLController(),
      child: Consumer<AVLController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: Column(
              children: [






                Container(
                  width: double.infinity,
                  height: 120,
                  padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: 
                    [Color.fromARGB(255, 188, 156, 240),
                    Color.fromARGB(255, 230, 176, 227)]
                    ), 
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Árbol AVL',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                






               
                Expanded(
                  child: Stack(
                    children: [
                      InteractiveViewer(
                        boundaryMargin: const EdgeInsets.all(double.infinity),
                        minScale: 0.1,
                        maxScale: 3.0,
                        child: Center(
                          child: CustomPaint(
                            painter: AVLTreePainter(controller.avlTree),
                            size: Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),












                // Contenedor para mostrar los recorridos, pre in post
                Container(
                  height: 150, //75
                  padding: const EdgeInsets.all(20),
                  color: Color.fromARGB(0, 44, 66, 190),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.preOrderVisible)
                        GestureDetector(
                          onTap: controller.togglePreOrder,
                          child: Text(
                            'Pre Order: ${controller.preOrderRecorrido}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 56, 71, 98),
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      if (controller.inOrderVisible)
                        GestureDetector(
                          onTap: controller.toggleInOrder,
                          child: Text(
                            'In Order: ${controller.inOrderRecorrido}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 56, 71, 98),
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      if (controller.postOrderVisible)
                        GestureDetector(
                          onTap: controller.togglePostOrder,
                          child: Text(
                            'Post Order: ${controller.postOrderRecorrido}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 56, 71, 98),
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),













                // Botones del lado izq
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  color: Color.fromARGB(255, 163, 90, 197),
                  child: Column(
                    children: [
                      // Primera fila: Botones de acción y recorrido con TextField en el medio
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Botones de acción izquierda
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: controller.insertNode,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: controller.deleteNode,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.restore,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: controller.clearTree,
                          ),
                          










                          // TextField 
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: TextField(
                                // Controlador para manejar el texto del input
                                controller: controller.textController,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: '...',
                                  hintStyle: const TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold),
                                  filled: true,
                                  fillColor: Colors.white30,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 12,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                keyboardType: TextInputType.number,
                                // Actualizar el valor cuando el usuario escribe
                                onChanged: controller.setInputValue,
                              ),
                            ),
                          ),
                          








                          // Botones de recorridos
                          IconButton(
                            icon: const Icon(
                              Icons.east,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: controller.togglePreOrder,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.north,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: controller.toggleInOrder,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.west,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: controller.togglePostOrder,
                          ),
                        ],
                      ),
                      
                      // Espaciado
                      const SizedBox(height: 10),
                      
                      
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}