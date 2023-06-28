import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/new_item/new_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:formz/formz.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewItemScreen extends StatelessWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MessageBlock(),
          _ImageField(),
          FormFieldTitle(text: "Item name"),
          _ItemNameField(),
          FormFieldTitle(text: "Item description"),
          _ItemDescField(),
          FormFieldTitle(text: "Initial price"),
          _ItemPriceField(),
          _CreateButton(),
        ],
      ),
    );
  }
}

class _MessageBlock extends StatelessWidget {
  const _MessageBlock();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: BlocBuilder<NewItemBloc, NewItemState>(
        builder: (context, state) {
          if (state.formState.status != FormzSubmissionStatus.success) {
            if (state.errorMessage != null) {
              return TextHighlight(
                code: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Error: ${state.errorMessage!}",
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              );
            }
          } else {
            return TextHighlight(
              code: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create item successful",
                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            );
          }
          return const SizedBox();
        },
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

class _CreateButton extends StatelessWidget {
  const _CreateButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocConsumer<NewItemBloc, NewItemState>(
        listenWhen: (previous, current) => current.formState.status == FormzSubmissionStatus.success,
        listener: (context, state) {
          if (state.formState.status == FormzSubmissionStatus.success) {
            Fluttertoast.cancel();
            Fluttertoast.showToast(msg: 'Item created successfully');
            Navigator.of(context).pop(true);
          }
        },
        builder: (context, state) {
          String btnText = '';

          switch (state.formState.status) {
            case FormzSubmissionStatus.success:
              btnText = 'Success';
              break;
            case FormzSubmissionStatus.inProgress:
              btnText = 'Processing...';
              break;
            case FormzSubmissionStatus.initial:
            default:
              btnText = 'Create';
          }

          return CustomButton(
            onPressed: () => context.read<NewItemBloc>().add(CreateNewItem()),
            text: btnText,
            disabled: state.formState.status == FormzSubmissionStatus.success || state.formState.status == FormzSubmissionStatus.inProgress,
          );
        },
      ),
    );
  }
}
