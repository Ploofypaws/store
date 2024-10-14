import 'package:emergencystore/common/widgets/custom_shapes/rounded_container.dart';
import 'package:emergencystore/utils/constants/colors.dart';
import 'package:emergencystore/utils/constants/enums.dart';
import 'package:emergencystore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key,  required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress ? Colors.
        white.withOpacity(0.5): Colors.transparent,
      borderColor: selectedAddress ? Colors.black45 : Colors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: const Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('USERNAME',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 2,),
                Text('7303413985',style: TextStyle(fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('Peopleist India xyz , New delhi , India, 110085 , lorem loremm  ',softWrap:true,overflow:TextOverflow.ellipsis
                  ,maxLines: 2,style: TextStyle(
                  fontSize: 18
                ),),
                SizedBox(
                  height: TSizes.sm/2
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}
