import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/app/ui/colors.dart';
import 'package:weather_app/app/ui/paddings.dart';
import 'package:weather_app/presentation/home/wigets/forecast_card.dart';
import 'package:weather_app/presentation/home/wigets/weather_detail_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.thunderGradientColors,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: Paddings.medium),
              const WeatherDetailWidget(),
              const SizedBox(height: Paddings.medium),
              _buildForecast()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const FaIcon(
          FontAwesomeIcons.locationPin,
          size: 18,
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 60,
          width: 150,
          child: DropdownButtonFormField(
            hint: const Text('Select City'),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                // borderSide: BorderSide(color: Colors.black),

                borderSide: BorderSide.none,
                // gapPadding: 10,
              ),
            ),
            items: [
              DropdownMenuItem(
                child: Text('New York'),
                value: 'New York',
              ),
              DropdownMenuItem(
                child: Text('London'),
                value: 'London',
              ),
              DropdownMenuItem(
                child: Text('Tokyo'),
                value: 'Tokyo',
              ),
            ],
            onChanged: (value) {
              print(value);
            },
          ),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {
              print('fa');
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  Widget _buildForecast() {
    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ForecastCard();
        },
        shrinkWrap: true,
        itemCount: 5,
      ),
    );
  }
}
