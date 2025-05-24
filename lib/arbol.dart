import 'dart:math';

class Node {
  Node? leftNode;
  Node? rightNode;
  int key;
  int height = 1;
  Node(this.key);
}

class AVLTree {

  Node? root;

  void insertNode(int key) {
    Node node = Node(key);
    root = _insert(root, node);
  }

  Node? _insert(Node? root, Node node) {
    if (root == null) {
      return node;
    }

    if (node.key.compareTo(root.key) < 0) {
      root.leftNode = _insert(root.leftNode, node);
    } else {
      root.rightNode = _insert(root.rightNode, node);
    }
    root.height = 1 + _maxHeight(root.leftNode, root.rightNode);
    return _rebalance(root);
  }

  int _maxHeight(Node? left, Node? right) {
    return max(_height(left), _height(right));
  }

  int _height(Node? node) {
    return node?.height ?? 0;
  }

  Node? _rebalance(Node? node) {
    if (node == null) return node;

    int balance = _balanceFactor(node);

    if (balance > 1) {
      if (_balanceFactor(node.leftNode) < 0) {
        node.leftNode = _leftRotation(node.leftNode!);
      }
      return _rightRotation(node);
    }
    if (balance < -1) {
      if (_balanceFactor(node.rightNode) > 0) {
        node.rightNode = _rightRotation(node.rightNode!);
      }
      return _leftRotation(node);
    }
    return node;
  }

  int _balanceFactor(Node? node) {
    if (node == null) return 0;
    return _height(node.leftNode) - _height(node.rightNode);
  }

  Node? _rightRotation(Node nodeY) {
    Node nodeX = nodeY.leftNode!;
    Node? nodeT = nodeX.rightNode;

    nodeX.rightNode = nodeY;
    nodeY.leftNode = nodeT;

    nodeY.height = 1 + _maxHeight(nodeY.leftNode, nodeY.rightNode);
    nodeX.height = 1 + _maxHeight(nodeX.leftNode, nodeX.rightNode);

    return nodeX;
  }

  Node? _leftRotation(Node nodeX) {
    Node nodeY = nodeX.rightNode!;
    Node? nodeT = nodeY.leftNode;

    nodeY.leftNode = nodeX;
    nodeX.rightNode = nodeT;

    nodeX.height = 1 + _maxHeight(nodeX.leftNode, nodeX.rightNode);
    nodeY.height = 1 + _maxHeight(nodeY.leftNode, nodeY.rightNode);

    return nodeY;
  }

  void deleteNode(int key) {
    root = _delete(root, key);
  }

  Node? _delete(Node? root, int key) {
    if (root == null) return root;

    if (key.compareTo(root.key) < 0) {
      root.leftNode = _delete(root.leftNode, key);
    } else if (key.compareTo(root.key) > 0) {
      root.rightNode = _delete(root.rightNode, key);
    } else {
      if (root.leftNode == null || root.rightNode == null) {
        Node? temp = root.leftNode ?? root.rightNode;
        root = null;
        return temp;
      } else {
        Node? predecessor = _findMax(root.leftNode!);
        root.key = predecessor!.key;
        root.leftNode = _delete(root.leftNode, predecessor.key);
      }
    }
    return _rebalance(root);
  }

  Node? _findMax(Node root) {
    while (root.rightNode != null) {
      root = root.rightNode!;
    }
    return root;
  }

  List<int> preOrder(Node? node) {
    List<int> result = [];
    if (node != null) {
      result.add(node.key);
      result.addAll(preOrder(node.leftNode));
      result.addAll(preOrder(node.rightNode));
    }
    return result;
  }

  List<int> inOrder(Node? node) {
    List<int> result = [];
    if (node != null) {
      result.addAll(inOrder(node.leftNode));
      result.add(node.key);
      result.addAll(inOrder(node.rightNode));
    }
    return result;
  }

  List<int> postOrder(Node? node) {
    List<int> result = [];
    if (node != null) {
      result.addAll(postOrder(node.leftNode));
      result.addAll(postOrder(node.rightNode));
      result.add(node.key);
    }
    return result;
  }

 void clear() {
  root = null;
}
}
