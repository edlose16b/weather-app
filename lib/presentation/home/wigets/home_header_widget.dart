import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/presentation/home/logic/header_mode_cubit.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeaderModeCubit(),
      child: BlocConsumer<HeaderModeCubit, HeaderMode>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                child: FaIcon(
                  FontAwesomeIcons.locationPin,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.6,
                child: state == HeaderMode.dropdown
                    ? _buildDropdownButton()
                    : _buildSearchTextField(context),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.read<HeaderModeCubit>().changeMode(
                        state == HeaderMode.dropdown
                            ? HeaderMode.input
                            : HeaderMode.dropdown,
                      );
                },
                icon: state == HeaderMode.dropdown
                    ? const Icon(Icons.search)
                    : const Icon(Icons.cancel),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchTextField(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Where to?',
        border: InputBorder.none,
        // fillColor: Colors.red,
        // filled: true,
        isDense: false,
      ),
      onFieldSubmitted: (value) {
        // print('da');
        context.read<SearchCubit>().search(value);
      },
    );
  }

  Widget _buildDropdownButton() {
    return DropdownButtonFormField(
      hint: const Text('Select City'),
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.black),

          borderSide: BorderSide.none,
          // gapPadding: 10,
        ),
      ),
      items: const [
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
    );
  }
}
