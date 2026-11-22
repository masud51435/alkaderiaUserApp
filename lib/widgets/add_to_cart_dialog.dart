import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodnanny/app/features/cart/controller/cart_controller.dart';
import 'package:foodnanny/config/theme/app_color.dart';
import 'package:foodnanny/data/model/item_details_model.dart';
import 'package:foodnanny/widgets/custom_snackbar.dart';
import 'package:foodnanny/widgets/text_widget.dart';
import 'package:get/get.dart';

class AddToCartDialog extends StatefulWidget {
  const AddToCartDialog({
    super.key,
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.unitPrice,
    this.originalPrice,
    this.currencySymbol = '৳',
    this.restaurantId,
  });

  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final double unitPrice;
  final double? originalPrice;
  final String currencySymbol;
  final int? restaurantId;

  static void show({
    required BuildContext context,
    required int id,
    required String name,
    String? description,
    String? imageUrl,
    required double unitPrice,
    double? originalPrice,
    String currencySymbol = '৳',
    int? restaurantId,
  }) {
    showDialog(
      context: context,
      builder: (context) => AddToCartDialog(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        unitPrice: unitPrice,
        originalPrice: originalPrice,
        currencySymbol: currencySymbol,
        restaurantId: restaurantId,
      ),
    );
  }

  @override
  State<AddToCartDialog> createState() => _AddToCartDialogState();
}

class _AddToCartDialogState extends State<AddToCartDialog> {
  int quantity = 1;
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fullImageUrl = widget.imageUrl == null || widget.imageUrl!.isEmpty
        ? ''
        : (widget.imageUrl!.startsWith('http')
            ? widget.imageUrl!
            : 'https://hotel.w3informer.com${widget.imageUrl!}');

    final totalPrice = widget.unitPrice * quantity;
    final totalOriginalPrice = widget.originalPrice != null
        ? widget.originalPrice! * quantity
        : null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close button x at top right
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red.withValues(alpha: 0.5),
                      ),
                    ),
                    child: const Icon(Icons.close, size: 16, color: Colors.red),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Item Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      fullImageUrl,
                      height: 80.r,
                      width: 80.r,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        height: 80.r,
                        width: 80.r,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.fastfood,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: widget.name,
                          color: AppColor.black100,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.description != null &&
                            widget.description!.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          TextWidget(
                            text: widget.description!,
                            color: const Color(0xFF777777),
                            fontSize: 12.sp,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            if (totalOriginalPrice != null &&
                                totalOriginalPrice > totalPrice) ...[
                              TextWidget(
                                text:
                                    '${widget.currencySymbol}${totalOriginalPrice.toStringAsFixed(2)}',
                                color: const Color(0xFF888888),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough,
                              ),
                              SizedBox(width: 6.w),
                            ],
                            TextWidget(
                              text:
                                  '${widget.currencySymbol}${totalPrice.toStringAsFixed(2)}',
                              color: AppColor.black100,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Quantity Row
              Row(
                children: [
                  TextWidget(
                    text: 'Quantity: ',
                    color: AppColor.black100,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          child: const Icon(
                            Icons.remove_circle_outline,
                            size: 20,
                            color: AppColor.black100,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: TextWidget(
                            text: '$quantity',
                            color: AppColor.black100,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: const Icon(
                            Icons.add_circle_outline,
                            size: 20,
                            color: AppColor.black100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Special Instructions
              TextWidget(
                text: 'Special Instructions:',
                color: AppColor.black100,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: noteController,
                style: TextStyle(fontSize: 13.sp, color: AppColor.black100),
                decoration: InputDecoration(
                  hintText: 'Add note (extra mayo, cheese, etc.)',
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: AppColor.black80,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: AppColor.black20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: AppColor.black20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppColor.primaryColor),
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              // Add to Cart Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () {
                    final cartController = Get.find<CartController>();
                    cartController.numOfItems.value = quantity;
                    final added = cartController.addToCart(
                      product: MainItem(
                        id: widget.id,
                        name: widget.name,
                        flatPrice: widget.unitPrice.toString(),
                        convertPrice: widget.unitPrice,
                        currencyPrice:
                            '${widget.currencySymbol}${widget.unitPrice.toStringAsFixed(2)}',
                        thumb: widget.imageUrl,
                      ),
                      itemPrice: widget.unitPrice,
                      itemPriceForTax: widget.unitPrice,
                      taxRate: 0,
                      restaurantId: widget.restaurantId ?? 1,
                      instructionText: noteController.text,
                      subtotal: totalPrice,
                      total: totalPrice,
                    );
                    if (!added) return;

                    Navigator.of(context).pop();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      customSnackbar(
                        "SUCCESS".tr,
                        "Item added to cart",
                        AppColor.positiveDark,
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    elevation: 0,
                  ),
                  child: TextWidget(
                    text:
                        'Add to Cart - ${widget.currencySymbol}${totalPrice.toStringAsFixed(2)}',
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
