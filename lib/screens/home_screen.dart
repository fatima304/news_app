import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/cubit/news_state.dart';
import 'package:news_app/screens/news_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: const Text('data'),
            centerTitle: true,
          ),
          body: const NewsScreen(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                label: 'Technology',
                icon: Icon(
                  Icons.computer,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Business',
                icon: Icon(
                  Icons.business,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Sports',
                icon: Icon(
                  Icons.sports,
                ),
              ),
            ],
            currentIndex: cubit.selectedIndex,
            onTap: cubit.onTapScreen,
            selectedItemColor: Colors.amber,
          ),
        );
      },
    );
  }
}
