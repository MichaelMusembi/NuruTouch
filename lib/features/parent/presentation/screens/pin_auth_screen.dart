import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/auth_provider.dart';

class PinAuthScreen extends ConsumerStatefulWidget {
  final String userType;
  const PinAuthScreen({super.key, required this.userType});

  @override
  ConsumerState<PinAuthScreen> createState() => _PinAuthScreenState();
}

class _PinAuthScreenState extends ConsumerState<PinAuthScreen> {
  String _pin = "";

  void _addNumber(String num) {
    if (_pin.length < 4) {
      setState(() {
        _pin += num;
      });
      if (_pin.length == 4) {
        _submitPin();
      }
    }
  }

  void _clear() {
    setState(() {
      _pin = "";
    });
  }

  void _submitPin() {
    // In production, this verifies against an encrypted SQLite hash.
    if (widget.userType == 'teacher') {
      ref.read(authProvider.notifier).authenticateTeacher(_pin);
    } else {
      ref.read(authProvider.notifier).authenticateParent(_pin);
    }

    // AuthProvider logic (via GoRouter redirect) will auto-push if successful
    // If we're still here after a brief moment, it failed
    Future.delayed(const Duration(milliseconds: 300), () {
        if(mounted) {
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN')));
           _clear();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.userType.toUpperCase()} PORTAL')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter 4-Digit PIN", style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            Text(_pin.padRight(4, '·'), style: const TextStyle(fontSize: 48, letterSpacing: 10)),
            const SizedBox(height: 40),
            _buildNumPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildNumPad() {
    return SizedBox(
      width: 300,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          for (int i = 1; i <= 9; i++)
             _buildButton(i.toString(), () => _addNumber(i.toString())),
          _buildButton("C", _clear, color: Colors.red.shade100),
          _buildButton("0", () => _addNumber("0")),
          _buildButton("X", () => Navigator.pop(context), color: Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onTap, {Color? color}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
      ),
      onPressed: onTap,
      child: Text(text, style: const TextStyle(fontSize: 24, color: Colors.black87)),
    );
  }
}
