import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../details_screen.dart';

class PictureName extends StatelessWidget {
  const PictureName({
    super.key,
    required this.widget,
  });

  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(180),
                image: DecorationImage(
                    image: FadeInImage.assetNetwork(
                      image: widget.contact.pictureLink,
                      placeholder: 'assets/images/account_circle.png',
                      fit: BoxFit.fill,
                      placeholderFit: BoxFit.fill,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/account_circle.png');
                      },
                    ).image,
                    fit: BoxFit.fill)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //contact name
        Text(
          "${widget.contact.first} ${widget.contact.last}",
          style:
              GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        //contact email
        Text(
          widget.contact.email,
          style: GoogleFonts.montserrat(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
