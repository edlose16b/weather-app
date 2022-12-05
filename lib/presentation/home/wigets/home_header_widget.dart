import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/l10n/l10n.dart';
import 'package:weather_app/presentation/home/logic/cities_cubit.dart';
import 'package:weather_app/presentation/home/logic/header_mode_cubit.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeaderModeCubit(),
      child: BlocBuilder<HeaderModeCubit, HeaderMode>(
        builder: (context, state) {
          return HomeHeaderContent(state: state);
        },
      ),
    );
  }
}

@visibleForTesting
class HomeHeaderContent extends StatelessWidget {
  const HomeHeaderContent({super.key, required this.state});
  final HeaderMode state;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('home_header'),
      children: [
        const Icon(
          Icons.pin_drop,
          size: 18,
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 55,
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
  }

  Widget _buildSearchTextField(BuildContext context) {
    return TextFormField(
      key: const Key('search_text_field'),
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
    return BlocBuilder<CitiesCubit, CitiesCubitState>(
      builder: (context, state) {
        if (state.cities.isEmpty) return const SizedBox.shrink();

        final items = state.cities
            .map(
              (e) => DropdownMenuItem(
                value: e.toLowerCase(),
                child: Text(e),
              ),
            )
            .toList();

        return DropdownButtonFormField(
          key: const Key('dropdown_cities'),
          hint: Text(context.l10n.select_city),
          value: state.selected?.toLowerCase(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          items: items,
          onChanged: (value) {
            context.read<CitiesCubit>().select(value!);
            context.read<SearchCubit>().search(value);
          },
        );
      },
    );
  }
}
