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

class ModifyCoffeeView extends ConsumerStatefulWidget {
  const ModifyCoffeeView({super.key});

  @override
  ConsumerState<ModifyCoffeeView> createState() => _ModifyCoffeeViewState();
}

class _ModifyCoffeeViewState extends ConsumerState<ModifyCoffeeView> {
  final coffeeNameController = TextEditingController();
  final quantityController = TextEditingController(text: '1');
  CoffeeSize coffeeSize = CoffeeSize.small;
  int amountSelected = 1;
  late int coffeeId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final coffeeData =
          ModalRoute.of(context)!.settings.arguments as CoffeeModel;

      coffeeNameController.text = coffeeData.name;
      quantityController.text = coffeeData.quantity.toString();
      setState(() {
        coffeeSize = coffeeData.size;
        coffeeId = coffeeData.id!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 30,
            children: [
              //Coffee logo
              SvgPicture.asset(
                'assets/icons/logo.svg',
                width: 150,
              ),
              //Register title
              const Text(
                "COFFEE ORDER",
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
              //Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Delete button
                  CustomIconButton(
                      height: 50,
                      onPressed: () async {
                        final deletedCoffee = CoffeeModel(
                            id: coffeeId,
                            name: coffeeNameController.text,
                            quantity: amountSelected,
                            size: coffeeSize,
                            price: coffeeSize.price.toDouble());

                        final isDeleted = await ref
                            .read(coffeeViewModelProvider.notifier)
                            .deleteCoffee(deletedCoffee);

                        if (isDeleted && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                      ),
                      label: const Text("Delete", style: TextStyle(fontSize: 18),)),
                  //Modify button
                  CustomIconButton(
                      height: 50,
                      onPressed: () async {
                        final totalPrice = coffeeSize.price * amountSelected;

                        final updatedCoffee = CoffeeModel(
                            id: coffeeId,
                            name: coffeeNameController.text,
                            quantity: amountSelected,
                            size: coffeeSize,
                            price: totalPrice.toDouble());

                        final isUpdated = await ref
                            .read(coffeeViewModelProvider.notifier)
                            .updateCoffee(updatedCoffee);

                        if (isUpdated && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 30,
                      ),
                      label: const Text("Update", style: TextStyle(fontSize: 18))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
