import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/update_item/update_item.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';

class UpdateItemScreen extends StatelessWidget {
  const UpdateItemScreen({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<UpdateItemBloc, UpdateItemState>(
        listenWhen: (p, c) => p is UpdateItemLoaded && c is UpdateItemLoaded && p.formState.status != c.formState.status,
        listener: (_, state) {
          if (state is UpdateItemLoaded) {
            Fluttertoast.cancel();
            if (state.formState.status == FormzSubmissionStatus.success) {
              Fluttertoast.showToast(msg: 'Update item successful');
              Navigator.of(context).pop(true);
            } else if (state.formState.status == FormzSubmissionStatus.failure) {
              Fluttertoast.showToast(msg: 'Update item failed');
            }
          }
        },
        buildWhen: (p, c) => p.runtimeType != c.runtimeType,
        builder: (context, state) {
          if (state is UpdateItemError) return _errorWidget(state.message, context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _MessageBlock(),
              const _ImageField(),
              const FormFieldTitle(text: "Item name"),
              const _ItemNameField(),
              const FormFieldTitle(text: "Item description"),
              const _ItemDescField(),
              const FormFieldTitle(text: "Initial price"),
              const _ItemPriceField(),
              _Button(item: item),
            ],
          );
        },
      ),
    );
  }

  Widget _errorWidget(String message, BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ErrorCommon(message: message),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () => context.read<UpdateItemBloc>().add(FetchItemData(item: item)),
            icon: const Icon(Icons.refresh),
            label: const Text('Reload'),
          )
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
      child: BlocBuilder<UpdateItemBloc, UpdateItemState>(
        builder: (context, state) {
          if (state is UpdateItemLoaded) {
            if (state.message != null) {
              return TextHighlight(
                code: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Error: ${state.message!}",
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              );
            } else {
              return TextHighlight(
                code: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Update item successful",
                    style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                ),
              );
            }
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
      child: BlocBuilder<UpdateItemBloc, UpdateItemState>(
        builder: (context, state) {
          if (state is UpdateItemLoading || state is UpdateItemInitial) {
            return _shimmerPreviewImage();
          }

          state as UpdateItemLoaded;

          if (state.newImagesPath.isEmpty && state.formerImages.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: AddImageCard()),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.newImagesPath.length + state.formerImages.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                EdgeInsets edgeInsets;
                if (index == 0) {
                  edgeInsets = const EdgeInsets.fromLTRB(16, 4, 4, 4);
                } else if (index == state.newImagesPath.length + state.formerImages.length) {
                  edgeInsets = const EdgeInsets.fromLTRB(4, 4, 16, 4);
                } else {
                  edgeInsets = const EdgeInsets.all(4);
                }

                if (index < state.formerImages.length) {
                  return Padding(
                    padding: edgeInsets,
                    child: ImagePreview(
                      index: index,
                      image: NetworkImage(state.formerImages[index].url),
                    ),
                  );
                }

                return Padding(
                  padding: edgeInsets,
                  child: index != state.newImagesPath.length + state.formerImages.length
                      ? ImagePreview(
                          imagePath: state.newImagesPath[index - state.formerImages.length],
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

  Widget _shimmerPreviewImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Center(
        child: ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: const ShimmerBasic(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class _ItemNameField extends StatelessWidget {
  const _ItemNameField();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<UpdateItemBloc, UpdateItemState>(
        listenWhen: (p, c) => p is UpdateItemLoading && c is UpdateItemLoaded,
        listener: (context, state) {
          if (state is UpdateItemLoaded) controller.value = TextEditingValue(text: state.formState.itemName.value);
        },
        buildWhen: (p, c) {
          if (p is UpdateItemLoaded && c is UpdateItemLoaded) return p.formState.itemName != c.formState.itemName;

          return p.runtimeType != c.runtimeType;
        },
        builder: (_, state) {
          if (state is UpdateItemLoading || state is UpdateItemInitial) {
            return const ShimmerBasic(
              child: CustomTextFormField(),
            );
          }

          state as UpdateItemLoaded;

          return CustomTextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<UpdateItemBloc>().add(ItemNameChanged(itemName: value ?? ''));
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
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<UpdateItemBloc, UpdateItemState>(
        listenWhen: (p, c) => p is UpdateItemLoading && c is UpdateItemLoaded,
        listener: (context, state) {
          if (state is UpdateItemLoaded) controller.value = TextEditingValue(text: state.formState.itemDesc.value);
        },
        buildWhen: (p, c) {
          if (p is UpdateItemLoaded && c is UpdateItemLoaded) return p.formState.itemDesc != c.formState.itemDesc;

          return p.runtimeType != c.runtimeType;
        },
        builder: (_, state) {
          if (state is UpdateItemLoading || state is UpdateItemInitial) {
            return const ShimmerBasic(
              child: CustomTextFormField(minLines: 2),
            );
          }

          state as UpdateItemLoaded;

          return CustomTextFormField(
            controller: controller,
            onChanged: (value) {
              context.read<UpdateItemBloc>().add(ItemDescChanged(itemDesc: value ?? ''));
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
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocConsumer<UpdateItemBloc, UpdateItemState>(
        listenWhen: (p, c) => p is UpdateItemLoading && c is UpdateItemLoaded,
        listener: (context, state) {
          if (state is UpdateItemLoaded) {
            controller.value = TextEditingValue(text: state.formState.itemPrice.value.toString());
          }
        },
        buildWhen: (p, c) {
          if (p is UpdateItemLoaded && c is UpdateItemLoaded) return p.formState.itemPrice != c.formState.itemPrice;

          return p.runtimeType != c.runtimeType;
        },
        builder: (_, state) {
          if (state is UpdateItemLoading || state is UpdateItemInitial) {
            return const ShimmerBasic(
              child: CustomTextFormField(),
            );
          }

          state as UpdateItemLoaded;

          return CustomTextFormField(
            controller: controller,
            isNumberInput: true,
            prefixText: 'Rp.',
            onChanged: (value) {
              context.read<UpdateItemBloc>().add(ItemPriceChanged(itemPrice: int.tryParse(value ?? '') ?? 0));
            },
            errorText: state.formState.itemPrice.displayError?.text,
          );
        },
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: BlocBuilder<UpdateItemBloc, UpdateItemState>(
        builder: (context, state) {
          bool isSubmitting = state is UpdateItemLoaded ? (state.formState.status == FormzSubmissionStatus.inProgress) : false;

          return Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (state is UpdateItemLoaded) context.read<UpdateItemBloc>().add(FetchItemData(item: item));
                  },
                  text: "Reset",
                  backgroundColor: ColorPalettes.amberHighlight,
                  disabled: state is! UpdateItemLoaded,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    if (state is UpdateItemLoaded) context.read<UpdateItemBloc>().add(UpdateItem());
                  },
                  text: isSubmitting ? "Loading..." : "Confirm",
                  disabled: state is! UpdateItemLoaded || isSubmitting,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
