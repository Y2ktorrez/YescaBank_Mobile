import 'package:flutter/material.dart';
import 'package:yescabank/services/customer_service_B.dart';

class MyCardPage extends StatefulWidget {
  const MyCardPage({super.key});

  @override
  State<MyCardPage> createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage> {
  final CustomerServiceB _customerServiceB = CustomerServiceB();
  String? _customerName;
  String? _nroAccount;

  @override
  void initState() {
    super.initState();
    _loadCustomerData();
  }

  Future<void> _loadCustomerData() async {
    try {
      final customerData = await _customerServiceB.getCustomerData();
      setState(() {
        _customerName = '${customerData.name} ${customerData.lastName}'; // Actualiza el estado con el nombre del cliente
        _nroAccount = customerData.nroAccount; // Actualiza el número de cuenta
      });
    } catch (e) {
      // Manejo de errores
      setState(() {
        _customerName = 'Error al cargar nombre'; // Mensaje de error
        _nroAccount = '****'; // Mensaje de error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton.outlined(
          onPressed: () {
            Navigator.pop(context); // Volver a la pantalla anterior
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
        title: const Text(
          "My Account",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // BackCard
              BackCard(nroAccount: _nroAccount ?? '****', customerName: _customerName ?? 'Nombre'), 
              const SizedBox(height: 25),
              // FrontCard
              const SizedBox(height: 30),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text(
                  "Add new Account",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[100]!),
                  fixedSize: const Size(double.maxFinite, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  backgroundColor: Colors.grey[100],
                  foregroundColor: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  final String nroAccount;
  final String customerName;

  const BackCard({super.key, required this.nroAccount, required this.customerName});

  @override
  Widget build(BuildContext context) {
    // Obtener los últimos cuatro dígitos del número de cuenta
    String maskedAccountNumber = nroAccount;

    return Container(
      height: 240,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 14, 19, 29)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Image.asset(
              "assets/card.png",
              fit: BoxFit.cover,
              width: 160,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white.withOpacity(0.8),
                        ),
                        Transform.translate(
                          offset: const Offset(-10, 0),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white.withOpacity(0.8),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maskedAccountNumber, // Mostrar el número de cuenta dinámicamente
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                  ],
                ),
                Text(
                  customerName, // Mostrar el nombre del cliente dinámicamente
                  style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}