import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/checkout/checkout_bloc.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/services/authentication.dart';
import 'package:shopping_app/services/service_locator.dart';
import 'package:shopping_app/widgets/elevated_button.dart';
import 'package:shopping_app/widgets/product/horizontal_product_card.dart';
import 'package:shopping_app/widgets/top_rounded_container.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = serviceLocator<Authentication>().userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SphereShopColors.secondaryColor,
      body: BlocProvider(
        create: (context) => CheckoutBloc()
          ..add(
            CheckoutFetchEvent(userId ?? '0'),
          ),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckoutError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CheckoutLoaded) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0), // Height of TopRoundedContainer
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) => context.read<CheckoutBloc>().add(
                                CheckoutRemoveEvent(
                                  state.shoppingCarts[index],
                                  index,
                                ),
                              ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HorizontalProductCard(product: state.products[index]),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TopRoundedContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: SphereShopColors.secondaryColorDark,
                                      fontSize: 14,
                                    ),
                              ),
                              Text(
                                context.read<CheckoutBloc>().calculateTotalPrice(state.products),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: SphereShopColors.white,
                                    ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SphereShopElevatedButton(
                            backgroundColor: SphereShopColors.primaryColorDark,
                            onPressed: () {},
                            child: Text(
                              'CHECK OUT',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: SphereShopColors.white,
                                  ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
