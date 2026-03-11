// ignore_for_file: sort_child_properties_last, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int selectedValue = 10;

  Widget buildRadioGroup() {
    return Row(
      children: [10, 20, 30, 40, 50].map((value) {
        return Row(
          children: [
            Radio<int>(
              value: value,
              groupValue: selectedValue,
              onChanged: (int? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
            ),
            Text(value.toString()),
          ],
        );
      }).toList(),
    );
  }

  String selectedMonth = "24 เดือน";

  Widget buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<String>(
        value: selectedMonth,
        underline: SizedBox(),
        isExpanded: true,
        items: ["24 เดือน", "36 เดือน", "48 เดือน", "60 เดือน", "72 เดือน"]
            .map((month) => DropdownMenuItem(
                  value: month,
                  child: Text(month),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedMonth = value!;
          });
        },
      ),
    );
  }

  final TextEditingController priceController = TextEditingController();
  final TextEditingController interestController = TextEditingController();

  double monthlyPayment = 0;
  final formatter = NumberFormat('#,##0.00');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  'CI Calculator',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                centerTitle: true,
              ),
              SizedBox(height: 50),
              Text(
                'คำนวนค่างวดรถ',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/car.jpg',
                    width: 170,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ราคารถ (บาท)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 15,
                        ),
                        hintText: '0.00',
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'จำนวนเงินดาวน์ (%)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    buildRadioGroup(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ระยะเวลาผ่อน (เดือน)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    buildDropdown()
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'อัตราดอกเบี้ย (%/ปี)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 6),
                    TextField(
                      controller: interestController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 15,
                        ),
                        hintText: '0.00',
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (priceController.text.length == 0 ||
                          interestController.text.length == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('กรุณากรอกข้อมูลให้ครบ'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                        return;
                      }
                      double price = double.tryParse(priceController.text) ?? 0;
                      double interestRate =
                          double.tryParse(interestController.text) ?? 0;

                      int months = int.parse(selectedMonth.split(" ")[0]);

                      double downPayment = price * selectedValue / 100;
                      double loanAmount = price - downPayment;

                      double totalInterest =
                          loanAmount * (interestRate / 100) * (months / 12);

                      double totalPayment = loanAmount + totalInterest;

                      setState(() {
                        monthlyPayment = totalPayment / months;
                      });
                    },
                    child: Text(
                      'คำนวณ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          165,
                          55,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        backgroundColor: Colors.green),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        priceController.clear();
                        interestController.clear();
                        selectedMonth = '24 เดือน';
                        selectedValue = 10;
                        monthlyPayment = 0.0;
                      });
                    },
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(165, 55),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        backgroundColor: Colors.deepOrange),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    height: 150,
                    width: 350,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 225, 255, 236),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.green,
                          width: 3,
                        )),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'ค่างวดรถต่อเดือนเป็น',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatter.format(monthlyPayment),
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 18, 2)),
                          ),
                          Text(
                            'บาทต่อเดือน',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
