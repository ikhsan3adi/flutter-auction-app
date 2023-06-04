import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';

class NewItemScreen extends StatelessWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormFieldTitle(text: "Item name"),
          const _ItemNameField(),
          const FormFieldTitle(text: "Item description"),
          const _ItemDescField(),
          const FormFieldTitle(text: "Initial price"),
          const _ItemPriceField(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: CustomButton(
              onPressed: () {},
              text: "Create",
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemNameField extends StatelessWidget {
  const _ItemNameField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<NewItemBloc, NewItemState>(
        buildWhen: (previous, current) => previous.formState.itemName != current.formState.itemName,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<NewItemBloc>().add(ItemNameChanged(itemName: value ?? ''));
            },
            errorText: state.formState.itemName.displayError?.text,
          );
        },
      ),
    );
  }
}

class _ItemDescField extends StatelessWidget {
  const _ItemDescField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<NewItemBloc, NewItemState>(
        buildWhen: (previous, current) => previous.formState.itemDesc != current.formState.itemDesc,
        builder: (context, state) {
          return CustomTextFormField(
            onChanged: (value) {
              context.read<NewItemBloc>().add(ItemDescChanged(itemDesc: value ?? ''));
            },
            hintText: "Description",
            minLines: 2,
            maxLines: 5,
            errorText: state.formState.itemDesc.displayError?.text,
          );
        },
      ),
    );
  }
}

class _ItemPriceField extends StatelessWidget {
  const _ItemPriceField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<NewItemBloc, NewItemState>(
        buildWhen: (previous, current) => previous.formState.itemPrice != current.formState.itemPrice,
        builder: (context, state) {
          return CustomTextFormField(
            isNumberInput: true,
            prefixText: 'Rp.',
            onChanged: (value) {
              context.read<NewItemBloc>().add(ItemPriceChanged(itemPrice: int.tryParse(value ?? '') ?? 0));
            },
            errorText: state.formState.itemPrice.displayError?.text,
          );
        },
      ),
    );
  }
}
