import 'package:flutter/material.dart';
import 'package:modbus_client_tcp/modbus_client_tcp.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PLC Modbus App',
      home: PLCModbusPage(),
    );
  }
}

class PLCModbusPage extends StatefulWidget {
  const PLCModbusPage({super.key});

  @override
  _PLCModbusPageState createState() => _PLCModbusPageState();
}

class _PLCModbusPageState extends State<PLCModbusPage> {
  ModbusClientTcp? _modbusClient;

  @override
  void initState() {
    super.initState();
    _connectToPLC();
  }

  void _connectToPLC() async {
    try {
      _modbusClient = ModbusClientTcp(
        '192.168.0.100', // Siemens PLC IP adresi
        serverPort: 502, // Modbus bağlantı noktası genellikle 502'dir
      );

      await _modbusClient?.connect();
      print('PLC Connected!');
    } catch (e) {
      print('Error connecting to PLC: $e');
    }
  }

  // Bu fonksiyon ile PLC'ye veri yazabilirsiniz.
  void _writeDataToPLC() async {
    try {
      // Modbus işlemlerini burada gerçekleştirin
    } catch (e) {
      print('Error writing data to PLC: $e');
    }
  }

  // Bu fonksiyon ile PLC'den veri okuyabilirsiniz.
  void _readDataFromPLC() async {
    try {

    } catch (e) {
      print('Error reading data from PLC: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PLC Modbus App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _writeDataToPLC();
            _readDataFromPLC();
          },
          child: Text('PLC Veri Alışverişi'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _modbusClient?.disconnect();
    super.dispose();
  }
}
