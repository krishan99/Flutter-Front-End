import 'package:business_app/theme/themes.dart';
import 'package:flutter/material.dart';

enum SlideableListCellSize { big, medium, small }

class SlideableListCell extends StatelessWidget {
  static const double borderRadius = 20;
  final bool isSelected;
  final bool isActive;
  final String title;
  final String subheading;
  final String body;
  final String primaryText;
  final String secondaryText;
  final Future<bool> Function() onPrimarySwipe;
  final Future<bool> Function() onSecondarySwipe;
  final Function onTap;
  final SlideableListCellSize relativeSize;

  SlideableListCell(
      {
        Key key,
        this.relativeSize = SlideableListCellSize.big,
        this.isActive,
        @required this.title,
        this.subheading,
        this.body,
        this.isSelected = false,
        this.onPrimarySwipe,
        this.onSecondarySwipe,
        this.onTap,
        this.primaryText = "Active",
        this.secondaryText = "Delete",
      }
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: (isSelected)
                  ? Border.all(
                      width: 1, color: MyStyles.of(context).colors.accent)
                  : null,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              child: Dismissible(
                key: GlobalKey(),
                confirmDismiss: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    return onSecondarySwipe();
                  } else {
                    return onPrimarySwipe();
                  }
                },
                
                background: Container(
                  padding: EdgeInsets.all(15),
                  color: MyStyles.of(context).colors.secondary,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    secondaryText,
                    style: MyStyles.of(context).textThemes.buttonActionText3,
                  ),
                ),
                secondaryBackground: Container(
                  padding: EdgeInsets.all(15),
                  color: MyStyles.of(context).colors.accent,
                  alignment: Alignment.centerRight,
                  child: Text(
                    primaryText,
                    style: MyStyles.of(context).textThemes.buttonActionText3,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: MyStyles.of(context).colors.background1,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  
                  child: Container(
                    padding: EdgeInsets.only(bottom: (relativeSize == SlideableListCellSize.big) ? 20 : 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text(title,
                                  textAlign: TextAlign.left,
                                  style: MyStyles.of(context)
                                      .textThemes
                                      .bodyText1),
            
                              () {
                                if (isActive != null) {
                                  return Expanded(
                                    child: Text(
                                      (isActive) ? "Active" : "Inactive",
                                      textAlign: TextAlign.end,
                                      style: (isActive)
                                          ? MyStyles.of(context).textThemes.active
                                          : MyStyles.of(context)
                                              .textThemes
                                              .disabled,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              }()
                            ],
                          ),

                          () {
                            if (subheading != null) {
                              return Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  subheading,
                                  style: MyStyles.of(context).textThemes.bodyText2,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }(),
                          
                          SizedBox(height: 5),
                          Text(
                            body,
                            maxLines: (relativeSize == SlideableListCellSize.small) ? 1 : null,
                            style: MyStyles.of(context).textThemes.bodyText3,
                          )
                        ]),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
