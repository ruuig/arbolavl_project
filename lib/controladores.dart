import 'package:flutter/material.dart';
import 'package:avl_tree/arbol.dart';

class AVLController extends ChangeNotifier {
  final AVLTree avlTree = AVLTree();
  
  // TextEditingController para manejar el campo de texto
  // Este controlador nos permite leer y modificar el contenido del TextField
  final TextEditingController textController = TextEditingController();

  String _inputValue = '';
  String _preOrderRecorrido = '';
  String _inOrderRecorrido = '';
  String _postOrderRecorrido = '';
  bool _preOrderVisible = false;
  bool _inOrderVisible = false;
  bool _postOrderVisible = false;

  // Getters
  String get inputValue => _inputValue;
  String get preOrderRecorrido => _preOrderRecorrido;
  String get inOrderRecorrido => _inOrderRecorrido;
  String get postOrderRecorrido => _postOrderRecorrido;
  bool get preOrderVisible => _preOrderVisible;
  bool get inOrderVisible => _inOrderVisible;
  bool get postOrderVisible => _postOrderVisible;

  // Setter para input value
  void setInputValue(String value) {
    _inputValue = value;
    notifyListeners();
  }

  // Método para limpiar el campo de texto
  void _clearTextField() {
    textController.clear(); 
    _inputValue = '';       
  }

  void togglePreOrder() {
    _preOrderVisible = !_preOrderVisible;
    if (_preOrderVisible) {
      _preOrderRecorrido = avlTree.preOrder(avlTree.root).join(', ');
      _inOrderVisible = false;
      _postOrderVisible = false;
    }
    notifyListeners();
  }

  void toggleInOrder() {
    _inOrderVisible = !_inOrderVisible;
    if (_inOrderVisible) {
      _inOrderRecorrido = avlTree.inOrder(avlTree.root).join(', ');
      _preOrderVisible = false;
      _postOrderVisible = false;
    }
    notifyListeners();
  }

  void togglePostOrder() {
    _postOrderVisible = !_postOrderVisible;
    if (_postOrderVisible) {
      _postOrderRecorrido = avlTree.postOrder(avlTree.root).join(', ');
      _preOrderVisible = false;
      _inOrderVisible = false;
    }
    notifyListeners();
  }

  void insertNode() {

    avlTree.insertNode(int.tryParse(_inputValue) ?? 0);
    
    //_clearTextField();
    
    notifyListeners();
  }

  void deleteNode() {

    avlTree.deleteNode(int.tryParse(_inputValue) ?? 0);
    
    //_clearTextField();
    
    notifyListeners();
  }

  void clearTree() {
    // Limpiar todo el árbol
    avlTree.clear();
    
    // Resetear todos los estados de visualización
    _preOrderVisible = false;
    _inOrderVisible = false;
    _postOrderVisible = false;
    _preOrderRecorrido = '';
    _inOrderRecorrido = '';
    _postOrderRecorrido = '';
    
    
    //_clearTextField();
    
 
    notifyListeners();
  }

  
  @override
  void dispose() {
    textController.dispose(); 
    super.dispose();
  }
}