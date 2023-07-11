import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileParameter extends StatefulWidget {
  final IconData icon;
  final String parameterName;
  final String value;
  final bool edit;
  final TextEditingController controller;

  const ProfileParameter(
      {Key? key,
      required this.icon,
      required this.parameterName,
      required this.value,
      required this.controller,
      required this.edit})
      : super(key: key);

  @override
  State<ProfileParameter> createState() => _ProfileParameterState();
}

class _ProfileParameterState extends State<ProfileParameter> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromARGB(255, 233, 228, 228)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(widget.icon),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.parameterName,
                style: GoogleFonts.montserrat(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              widget.edit
                  ? SizedBox(
                      height: 20,
                      width: (width * 60) / 100,
                      child: TextField(
                        controller: widget.controller,
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                    )
                  : SizedBox(
                      width: (width * 75) / 100,
                      child: Text(
                        widget.value,
                        style: GoogleFonts.montserrat(fontSize: 14),
                      ),
                    )
            ],
          )
        ],
      ),
    );
  }
}
