import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCReader extends StatefulWidget {
  const NFCReader({super.key});

  @override
  State<NFCReader> createState() => _NFCReaderState();
}

class _NFCReaderState extends State<NFCReader> {
  String _nfcData = 'Scan an NFC tag to begin.';

  @override
  void initState() {
    super.initState();
    _checkNfc();
  }

  void _checkNfc() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      setState(() => _nfcData = 'NFC is not available on this device.');
    }
  }

  void _startScanning() {
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        setState(() {
          _nfcData = tag.data.toString();
        });
        NfcManager.instance.stopSession();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NFC Reader')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_nfcData),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startScanning,
                child: const Text('Scan NFC Tag'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
