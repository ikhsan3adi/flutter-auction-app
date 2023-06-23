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
          const _ImageField(),
          const FormFieldTitle(text: "Item name"),
          const _ItemNameField(),
          const FormFieldTitle(text: "Item description"),
          const _ItemDescField(),
          const FormFieldTitle(text: "Initial price"),
          const _ItemPriceField(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: CustomButton(
              onPressed: () => context.read<NewItemBloc>().add(CreateNewItem()),
              text: "Create",
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageField extends StatelessWidget {
  const _ImageField();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<NewItemBloc, NewItemState>(
        builder: (context, state) {
          if (state.imagesPath.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: AddImageCard()),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.imagesPath.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                EdgeInsets edgeInsets;
                if (index == 0) {
                  edgeInsets = const EdgeInsets.fromLTRB(16, 4, 4, 4);
                } else if (index == state.imagesPath.length) {
                  edgeInsets = const EdgeInsets.fromLTRB(4, 4, 16, 4);
                } else {
                  edgeInsets = const EdgeInsets.all(4);
                }

                return Padding(
                  padding: edgeInsets,
                  child: index != state.imagesPath.length
                      ? ImagePreview(
                          imagePath: state.imagesPath[index],
                          index: index,
                        )
                      : const AddImageCard(text: "Select more images"),
                );
              },
            ),
          );
        },
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
              context.read<NewItemBloc>().add(ItemPriceChanged(itemPrice: value ?? 0));
            },
            errorText: state.formState.itemPrice.displayError?.text,
          );
        },
      ),
    );
  }
}
