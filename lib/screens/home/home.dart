import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/bloc/products/products_bloc.dart';
import 'package:shopping_app/bloc/products/products_events.dart';
import 'package:shopping_app/bloc/products/products_state.dart';
import 'package:shopping_app/constants/colors.dart';
import 'package:shopping_app/screens/product_preview/product_preview.dart';
import 'package:shopping_app/widgets/product/product_card.dart';
import 'package:shopping_app/widgets/product/product_shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(ProductsFetchEvent());
  }

  SizedBox _buildProductList(List products) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductPreview(
                    product: products[index],
                  ),
                ),
              );
            },
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const defaultPaddingSize = 8.0;
    const defaultGapSize = 16.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPaddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('News & Community', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: defaultGapSize),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: SphereShopColors.primaryColorDark,
                ),
                child: Image.asset('assets/images/christmas_banner.jpg', fit: BoxFit.cover),
              ),
              const SizedBox(height: defaultGapSize),
              Text('New Arrivals', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: defaultGapSize),
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProductList(state.popularProducts),
                        const SizedBox(height: defaultGapSize),
                        Text('Cheapest Products', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: defaultGapSize),
                        _buildProductList(state.cheapestProducts),
                      ],
                    );
                  } else if (state is ProductsLoading) {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const ProductShimmer();
                        },
                      ),
                    );
                  } else if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
