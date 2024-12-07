import 'package:flutter/material.dart';
import 'package:match_home_client/shared/utils/custom_assets.dart';

class MatchHomeCardScreen extends StatelessWidget {
  const MatchHomeCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text('OXXO Pay', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(CustomAssets.imgWorld),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: 350,
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade800,
                      Colors.blue.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Match Home',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'assets/img/bbva.png',
                            width: 70,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '4152 3140 4703 9303',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'Mandar comprobante a:\nmatchhomee@gmail.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Image.asset(
                            'assets/img/oxxo_pay.png',
                            width: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}