import 'package:flutter/material.dart';
import 'package:yescabank/screens/estracto.dart'; // Asegúrate de que este import sea correcto
import 'package:yescabank/screens/transfer_money.dart'; // Importar si no está ya

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 244, 245),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ActionButton(
              icon: Icons.account_balance,
              label: "Deposito",
              onPressed: () {
                // Lógica para Depósito
              },
            ),
            ActionButton(
              icon: Icons.swap_horiz,
              label: "Transferencia",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const TransferMoney()));
              },
            ),
            ActionButton(
              icon: Icons.receipt_long,
              label: "Estracto",
              onPressed: () {
                // Aquí se navega a la pantalla de extractos
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatementScreen(accountNumber: '****'), // Cambia '****' por el número de cuenta real si es necesario
                  ),
                );
              },
            ),
            ActionButton(
              icon: Icons.apps_sharp,
              label: "More",
              onPressed: () {
                // Lógica para Más
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.outlined(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: const Color.fromARGB(255, 5, 124, 150),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }
}