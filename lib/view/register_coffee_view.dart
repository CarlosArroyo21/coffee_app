import 'package:coffee_app/models/coffee_model.dart';
import 'package:coffee_app/utils/coffee_sizes.dart';
import 'package:coffee_app/utils/colors.dart';
import 'package:coffee_app/utils/input_formatters.dart';
import 'package:coffee_app/utils/widgets/buttons.dart';
import 'package:coffee_app/utils/widgets/form_textfields.dart';
import 'package:coffee_app/view_models/coffee_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterCoffeeView extends ConsumerStatefulWidget {
  const RegisterCoffeeView({super.key});

  @override
  ConsumerState<RegisterCoffeeView> createState() => _RegisterCoffeeViewState();
}

class _RegisterCoffeeViewState extends ConsumerState<RegisterCoffeeView> {
  final coffeeNameController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  CoffeeSize coffeeSize = CoffeeSize.small;
  int amountSelected = 1;

  @override
  Widget build(BuildContext context) {
    final coffeeViewModel = ref.watch(coffeeViewModelProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              //Coffee logo
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 150,
              ),
              //Register title
              const Text(
                "REGISTER COFFEE ORDER",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: kTextColor),
              ),
              //Form
              Column(
                spacing: 30,
                children: [
                  //Coffee's name or type
                  CustomTextField(
                    controller: coffeeNameController,
                    labelText: 'Coffee name',
                    prefixIcon: const Icon(Icons.coffee, color: kButtonColor),
                  ),
                  //Quantity
                  CustomTextField(
                    controller: quantityController,
                    inputFormatters: [PositiveNumberFormatter()],
                    onChanged: (value) {
                      setState(() {
                        amountSelected = int.tryParse(value) ?? 1;
                      });
                    },
                    labelText: 'Quantity',
                    prefixIcon: const Icon(
                      Icons.numbers,
                      color: kButtonColor,
                    ),
                  ),
                  //Coffee's size title
                  const Text(
                    "CHOOSE COFFEE SIZE",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextColor),
                  ),
                  //Coffee's size
                  Container(
                    constraints:
                        const BoxConstraints(maxWidth: 400, minHeight: 100),
                    child: Row(
                      spacing: 15,
                      children: [
                        Expanded(
                            child: IconButton(
                          padding: EdgeInsets.zero,
                          style: IconButton.styleFrom(
                            alignment: Alignment.center,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(100, 100),
                            backgroundColor: coffeeSize == CoffeeSize.small
                                ? kButtonColor.withValues(alpha: 0.5)
                                : kAppBarColor.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            setState(() {
                              coffeeSize = CoffeeSize.small;
                            });
                          },
                          icon: const Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.coffee_rounded,
                                size: 30,
                                color: kButtonColor,
                              ),
                              Text(
                                "SMALL",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                        Expanded(
                          child: IconButton(
                            style: IconButton.styleFrom(
                              minimumSize: const Size(100, 100),
                              backgroundColor: coffeeSize == CoffeeSize.medium
                                  ? kButtonColor.withValues(alpha: 0.5)
                                  : kAppBarColor.withValues(alpha: 0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              setState(() {
                                coffeeSize = CoffeeSize.medium;
                              });
                            },
                            icon: const Column(
                              spacing: 5,
                              children: [
                                Icon(
                                  Icons.coffee_rounded,
                                  size: 45,
                                  color: kButtonColor,
                                ),
                                Text(
                                  "MEDIUM",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: const Size(100, 100),
                            backgroundColor: coffeeSize == CoffeeSize.large
                                ? kButtonColor.withValues(alpha: 0.5)
                                : kAppBarColor.withValues(alpha: 0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            setState(() {
                              coffeeSize = CoffeeSize.large;
                            });
                          },
                          icon: const Column(
                            spacing: 5,
                            children: [
                              Icon(
                                Icons.coffee_rounded,
                                size: 60,
                                color: kButtonColor,
                              ),
                              Text(
                                "LARGE",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  //Total price title
                  const Text(
                    "TOTAL",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTextColor),
                  ),
                  //Price (Autocalculated)
                  Text(
                    "\$ ${coffeeSize.price * amountSelected}",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: kSecondaryColor),
                  ),
                ],
              ),
              coffeeViewModel.maybeWhen(
                  orElse: () => const SizedBox.shrink(),
                  error: (error, stack) {
                    final errorMessage = (error as Exception).toString();
                    final message = errorMessage.split(':').last.trim();
                    return Text(
                      message.toString(),
                      style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    );
                  }),
              //Register Button
              CustomIconButton(
                  height: 50,
                  onPressed: () async {
                    final totalPrice = coffeeSize.price * amountSelected;

                    final newCoffee = CoffeeModel(
                        name: coffeeNameController.text,
                        quantity: amountSelected,
                        size: coffeeSize,
                        price: totalPrice.toDouble());

                    final wasAdded = await ref
                        .read(coffeeViewModelProvider.notifier)
                        .addCoffee(newCoffee);

                    if (wasAdded && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  label: const Text("Register coffee order")),

              
            ],
          ),
        ),
      ),
    );
  }
}
