import 'package:auction_repository/auction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_auction_app/features/new_auction/new_auction.dart';
import 'package:flutter_online_auction_app/shared/shared.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class NewAuctionScreen extends StatelessWidget {
  const NewAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormFieldTitle(text: "Select item"),
          _ItemDropdown(),
          FormFieldTitle(text: "Finished date"),
          _FinishedDatePicker(),
          _CreateButton(),
        ],
      ),
    );
  }
}

class _ItemDropdown extends StatelessWidget {
  const _ItemDropdown();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<NewAuctionBloc, NewAuctionState>(
        builder: (context, state) {
          if (state is! NewAuctionLoaded) {
            return const ShimmerBasic(child: CustomTextFormField(minLines: 2));
          }

          return CustomDropdownButtonField<Item>(
            itemHeight: 55,
            style: const TextStyle(fontSize: 50),
            items: [
              _emptyDropdownMenu(theme),
              ...state.itemList.map((e) {
                return DropdownMenuItem<Item>(
                  // onTap: () => context.read<NewAuctionBloc>().add(AuctionItemChanged(item: e)),
                  value: e,
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: e.images.isNotEmpty
                              ? Image.network(
                                  e.images[0].url,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.warning_amber),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.itemName,
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              "Rp${e.initialPrice}",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
            value: state.selectedItem,
            onChanged: (selectedItem) {
              if (selectedItem != null) {
                context.read<NewAuctionBloc>().add(AuctionItemChanged(item: selectedItem));
              }
            },
          );
        },
      ),
    );
  }

  DropdownMenuItem<Item> _emptyDropdownMenu(ThemeData theme) {
    return DropdownMenuItem<Item>(
      value: null,
      child: Text(
        '--Select item here--',
        style: theme.textTheme.titleMedium,
      ),
    );
  }
}

class _FinishedDatePicker extends StatelessWidget {
  const _FinishedDatePicker();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<NewAuctionBloc, NewAuctionState>(
        builder: (context, state) {
          if (state is NewAuctionLoading) {
            return const ShimmerBasic(child: CustomTextFormField());
          }

          if (state is NewAuctionLoaded && state.finishedDate != null) {
            controller.value = TextEditingValue(text: DateFormat('dd/MM/yyyy').format(state.finishedDate!));
          }

          return CustomTextFormField(
            controller: controller,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null && context.mounted) {
                context.read<NewAuctionBloc>().add(FinishedDateChanged(finishedDate: pickedDate));
              }
            },
            prefixIcon: const Icon(Icons.calendar_month),
            readOnly: true,
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
      child: BlocConsumer<NewAuctionBloc, NewAuctionState>(
        listenWhen: (previous, current) {
          if (current is NewAuctionLoaded) {
            return current.status == FormzSubmissionStatus.success || current.status == FormzSubmissionStatus.failure;
          }
          return false;
        },
        listener: (context, state) {
          if (state is NewAuctionLoaded) {
            if (state.status == FormzSubmissionStatus.success) {
              Fluttertoast.cancel();
              Fluttertoast.showToast(msg: 'Auction created successfully');
              Navigator.of(context).pop(true);
            } else if (state.status == FormzSubmissionStatus.failure) {
              Fluttertoast.cancel();
              Fluttertoast.showToast(msg: 'Create auction failed: ${state.errorSubmissionMessage}');
            }
          }
        },
        builder: (context, state) {
          String btnText = 'Create';

          if (state is NewAuctionLoaded) {
            switch (state.status) {
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
          }

          return CustomButton(
            onPressed: () => context.read<NewAuctionBloc>().add(CreateNewAuction()),
            text: btnText,
            disabled: state is! NewAuctionLoaded || state.status == FormzSubmissionStatus.success || state.status == FormzSubmissionStatus.inProgress,
          );
        },
      ),
    );
  }
}
