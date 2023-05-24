import 'package:flutter/material.dart';

class AppBarActionItems extends StatelessWidget {
  const AppBarActionItems({
    Key ?key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // IconButton(
        //     icon: SvgPicture.asset(
        //       'assets/calendar.svg',
        //       width: 20,
        //     ),
        //     onPressed: () {}),
        SizedBox(width: 10),
        // IconButton(
        //     icon: SvgPicture.asset('assets/ring.svg', width: 20.0),
        //     onPressed: () {}),
        SizedBox(width: 15),
        Row(children: [
          CircleAvatar(
            radius: 17,
            backgroundImage: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/957/957284.png?w=826&t=st=1680585807~exp=1680586407~hmac=21ff556b4507f144366c2c52ea6e07f0cfd7133ce4f631ba5264a34313cc24af',
            ),
          ),
          //Icon(Icons.arrow_drop_down_outlined, color: AppColors.black),
          SizedBox(width: 15),
        ]),
      ],
    );
  }
}
