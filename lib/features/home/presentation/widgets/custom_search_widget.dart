import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/router/app_routes.dart';

class CustomSearchWidget extends StatefulWidget {
  const CustomSearchWidget({
    super.key,
  });

  @override
  State<CustomSearchWidget> createState() => _CustomSearchWidgetState();
}

class _CustomSearchWidgetState extends State<CustomSearchWidget> {
  TextEditingController query = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Welcome", style: Theme.of(context).textTheme.bodyMedium),
           SizedBox(
            height: 5.h,
          ),
          Text("Enjoy your favorite Movies",
              style: Theme.of(context).textTheme.bodyLarge),
           SizedBox(
            height: 20.h,
          ),
          TextField(
            controller: query,
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.searchScreen,
          
            ),
            readOnly: true,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black),
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 24,
                ),
                onPressed: () {
                  if (query.text != "") {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(query: query.text,)));
                  }
                },
              ),
              hintText: "Search for Movies",
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


