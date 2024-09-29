import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellermultivendor/Helper/Color.dart';
import 'package:sellermultivendor/Helper/extensions/extensions.dart';
import 'package:sellermultivendor/Model/order/order_model.dart';
import 'package:sellermultivendor/Screen/OrderList/Widget/ordered_item_card.dart';
import 'package:sellermultivendor/Widget/snackbar.dart';
import 'package:sellermultivendor/cubits/order/create_consignment_cubit.dart';
import 'package:sellermultivendor/cubits/order/fetch_consignments_cubit.dart';
import 'package:sellermultivendor/cubits/order/fetch_orders_cubit.dart';
import 'package:sellermultivendor/main.dart';

class ConsignmentItemSelectionBottomSheet extends StatefulWidget {
  final List<OrderItem> orderItems;
  final String orderId;
  const ConsignmentItemSelectionBottomSheet({
    super.key,
    required this.orderId,
    required this.orderItems,
  });

  @override
  State<ConsignmentItemSelectionBottomSheet> createState() =>
      _ConsignmentItemSelectionBottomSheetState();
}

class _ConsignmentItemSelectionBottomSheetState
    extends State<ConsignmentItemSelectionBottomSheet> {
  final TextEditingController _consignmentNameController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> selectedItemIds = [];
  late List<OrderItem> pendingConsignmentItems =
      widget.orderItems.where((e) => e.isConsignmentCreated == '0').toList();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateConsignmentCubit, CreateConsignmentState>(
      listener: (context, state) {
        if (state is CreateConsignmentSuccess) {
          context.read<FetchOrdersCubit>().updateOrder(state.orderModel);
          context
              .read<FetchConsignmentsCubit>()
              .fetch(orderId: state.orderModel.id!);

          Navigator.pop(context);
          setSnackbar('consign_created'.translate(context), context);
        }
        if (state is CreateConsignmentFail) {
          Navigator.pop(context);
          Navigator.pop(context);

          setSnackbar(state.error.toString(), rootNavigatorKey.currentContext!);
        }
      },
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: context.screenHeight * 0.75,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('confirm_parcel'.translate(context)).size(20),
                    const CloseButton()
                  ],
                ),
              ),
              const Divider(
                height: 0,
                indent: 0,
                thickness: 2,
              ),
              buildSearchField(),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: pendingConsignmentItems.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 14,
                    );
                  },
                  itemBuilder: (context, index) {
                    OrderItem item = pendingConsignmentItems[index];
                    return OrderdItemCard(
                      item: item,
                      enableSelection: true,
                      onSelectionChange: (id) {
                        if (selectedItemIds.contains(item.id!)) {
                          selectedItemIds.remove(item.id!);
                        } else {
                          selectedItemIds.add(item.id!);
                        }
                        setState(() {});
                      },
                      selected: selectedItemIds.contains(item.id),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              side: const BorderSide(color: primary),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: BlocBuilder<CreateConsignmentCubit,
                          CreateConsignmentState>(
                        builder: (context, state) {
                          return MaterialButton(
                            color: primary,
                            height: 42,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textColor: white,
                            onPressed: () async {
                              var result = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('CONFIRM_PARCEL_CREATION'
                                        .translate(context)),
                                    content: Text(
                                        'CONFIRM_PARCEL'.translate(context)),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child:
                                            Text('CANCEL'.translate(context)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                          //Navigator.pop(context);const
                                        },
                                        child:
                                            Text('CONFIRM'.translate(context)),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (result == true &&
                                  _formKey.currentState!.validate()) {
                                context.read<CreateConsignmentCubit>().create(
                                    consignmentTitle:
                                        _consignmentNameController.text,
                                    orderId: widget.orderId,
                                    orderItemIds: selectedItemIds);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (state is CreateConsignmentInProgress)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                          color: white,
                                          strokeWidth: 1.5,
                                        )),
                                  ),
                                Text('Create'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: TextFormField(
        controller: _consignmentNameController,
        validator: (value) {
          if (value!.isEmpty) {
            return 'please_enter_consignment_title'.translate(context);
          }
          return null;
        },
        autofocus: true,
        decoration: InputDecoration(
            hintText: 'consignment_title'.translate(context),
            filled: true,
            fillColor: lightWhite,
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
