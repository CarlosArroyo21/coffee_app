import 'package:coffee_app/utils/colors.dart';
import 'package:coffee_app/utils/widgets/buttons.dart';
import 'package:coffee_app/utils/widgets/cards.dart';
import 'package:coffee_app/view_models/coffee_view_model.dart';
import 'package:coffee_app/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coffeeViewModelProvider.notifier).getCoffees();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(loginViewModelProvider).valueOrNull;
    final coffeeViewModel = ref.watch(coffeeViewModelProvider);
    final totalCoffeesOrdered = ref.watch(totalCoffeeQuantityProvider);
    final totalEarnings = ref.watch(totalEarningsProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        leadingWidth: 50,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          userData?.username?.toUpperCase() ?? "",
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: kTextColor),
        ),
        centerTitle: true,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 30,
              color: kTextColor,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //InfoCards
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Total orders counter
                CustomValueCard(
                  title: "TOTAL ORDERS",
                  value: totalCoffeesOrdered.toString(),
                ),
                // Total earnings
                CustomValueCard(
                  title: "TOTAL EARNINGS",
                  value: totalEarnings.toInt().toString(),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            //New Coffee Order Button
            CustomIconButton(
              height: 60,
              onPressed: () {
                Navigator.pushNamed(context, '/newCoffee');
              },
              label: const Text(
                "New Coffee Order",
                style: TextStyle(fontSize: 18),
              ),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            //List of Orders Title
            const Text(
              "ORDERS",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: kTextColor),
            ),
            const Divider(
              color: kSecondaryColor,
              thickness: 2,
              indent: 10,
              endIndent: 10,
              height: 0,
            ),
            //List of Coffees Sold
            Expanded(
              child: coffeeViewModel.maybeWhen(
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                  data: (coffees) => ListView.builder(
                        itemCount: coffees.length,
                        itemBuilder: (context, index) {
                          final coffeeSize =
                              coffees[index].size.name.toUpperCase();

                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Material(
                              type: MaterialType.card,
                              borderRadius: BorderRadius.circular(20),
                              shadowColor:
                                  kSecondaryColor.withValues(alpha: 0.25),
                              elevation: 10,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                leading: Column(
                                  children: [
                                    const Icon(Icons.coffee_rounded, size: 40),
                                    Text(
                                      coffeeSize,
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  coffees[index].name,
                                  style: const TextStyle(
                                      color: kTextColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${coffees[index].quantity.toString()} Unid",
                                ),
                                trailing: Text(
                                  "\$ ${coffees[index].price.toInt().toString()}",
                                  style: const TextStyle(
                                      color: kButtonColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, '/editCoffee',
                                    arguments: coffees[index]),
                              ),
                            ),
                          );
                        },
                      )),
            ),
            const Divider(
              color: kSecondaryColor,
              thickness: 2,
              indent: 10,
              endIndent: 10,
              height: 0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        padding: const EdgeInsets.all(10),
        color: kAppBarColor,
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_rounded,
                        size: 30,
                        color: kSecondaryColor,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(color: kSecondaryColor),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // Handle press
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
