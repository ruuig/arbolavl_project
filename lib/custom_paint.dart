import 'package:avl_tree/arbol.dart';
import 'package:flutter/material.dart';

class AVLTreePainter extends CustomPainter {
  final AVLTree tree;
  static const double diameter = 27;
  static const double radius = diameter / 2;
  static const int width = 20;

  AVLTreePainter(this.tree);

  @override
  void paint(Canvas canvas, Size size) {
    if (tree.root != null) {
      _paintNode(canvas, size.width / 2, 20, tree.root!);
    }
  }

  @override
  bool shouldRepaint(AVLTreePainter oldDelegate) => true;

  void _paintNode(Canvas canvas, double x, double y, Node? node) {
    if (node != null) {
      Paint circleBorderPaint = Paint()
        ..color = const Color.fromARGB(255, 113, 32, 157)
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3;

      Paint circlePaint = Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.fill
        ..strokeWidth = 0;

      Paint linePaint = Paint()
        ..color = const Color.fromARGB(255, 195, 78, 78)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 3;

      const textStyle = TextStyle(
        color: Color.fromARGB(255, 70, 14, 102),
        fontSize: 25,
        fontWeight: FontWeight.bold,
      );

      final textSpan = TextSpan(
        text: node.key.toString(),
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(
        minWidth: x,
        maxWidth: x,
      );

      var offsetText = Offset(x - 30, y - 14);

      if (node.key.toString().length == 1) {
        offsetText = Offset(x - 6.5, y - 14);
      }
      if (node.key.toString().length == 2) {
        offsetText = Offset(x - 14, y - 14);
      }
      if (node.key.toString().length == 3) {
        offsetText = Offset(x - 21, y - 14);
      }

      double baseAdjustment = 2 * (width / 3);
      double leftAdjustment = 0;
      double rightAdjustment = 0;

      // Dibujar línea y calcular ajuste para nodo izquierdo
      if (node.leftNode != null) {
        leftAdjustment = adjustLeft(node, leftAdjustment, baseAdjustment);
        canvas.drawLine(
            Offset(x, y),
            Offset(x - width - leftAdjustment - radius + 10, 
                   y + width + diameter + 15),
            linePaint);
      }

      // Dibujar línea y calcular ajuste para nodo derecho
      if (node.rightNode != null) {
        rightAdjustment = adjustRight(node, rightAdjustment, baseAdjustment);
        canvas.drawLine(
            Offset(x, y),
            Offset(x + width + rightAdjustment + radius - 10, 
                   y + width + diameter + 15),
            linePaint);
      }

      // Dibujar el nodo actual
      canvas.drawCircle(Offset(x, y), diameter, circlePaint);
      canvas.drawCircle(Offset(x, y), diameter, circleBorderPaint);
      textPainter.paint(canvas, offsetText);

      // Recursivamente dibujar los hijos con los ajustes calculados
      _paintNode(canvas, x - width - leftAdjustment, y + width + 35, node.leftNode);
      _paintNode(canvas, x + width + rightAdjustment, y + width + 35, node.rightNode);
    }
  }

  // Función para ajustar la posición del nodo derecho
  double adjustRight(Node node, double rightAdjustment, double baseAdjustment) {
    if (node.rightNode != null) {
      if (node.rightNode!.leftNode != null) {
        return rightAdjustment = 
            adjustRightAux(node.rightNode!.leftNode!, rightAdjustment);
      }
    }
    return rightAdjustment = baseAdjustment;
  }

  // Función auxiliar para calcular el ajuste derecho recursivamente
  double adjustRightAux(Node node, double adjustment) {
    double extra = adjustment;
    extra = diameter * 1.65;
    if (node.leftNode != null) {
      extra = extra - 5 + adjustRightAux(node.leftNode!, extra);
    }
    if (node.rightNode != null) {
      extra = extra - 15 + adjustRightAux(node.rightNode!, extra);
    }
    return extra;
  }

  // Función para ajustar la posición del nodo izquierdo
  double adjustLeft(Node node, double leftAdjustment, double baseAdjustment) {
    if (node.leftNode != null) {
      if (node.leftNode!.rightNode != null) {
        return leftAdjustment = 
            adjustLeftAux(node.leftNode!.rightNode!, leftAdjustment);
      }
    }
    return leftAdjustment = baseAdjustment;
  }

  // Función auxiliar para calcular el ajuste izquierdo recursivamente
  double adjustLeftAux(Node node, double adjustment) {
    double extra = adjustment;
    extra = diameter * 1.65;
    if (node.rightNode != null) {
      extra = extra - 5 + adjustLeftAux(node.rightNode!, extra);
    }
    if (node.leftNode != null) {
      extra = extra - 15 + adjustLeftAux(node.leftNode!, extra);
    }
    return extra;
  }
}