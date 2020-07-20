import 'package:business_app/user_app/components/components.dart';
import 'package:flutter/material.dart';

import 'package:business_app/theme/themes.dart';
import 'package:business_app/business_app/models/queues.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

//When this file gets to big, split into multiple files.

class ActionButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final Color color;
  final double width;
  final double height;
  final Function onPressed;

  const ActionButton(
      {Key key,
      @required this.child,
      this.gradient,
      this.color = Colors.grey,
      this.width = 233,
      this.height = 55,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: gradient,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0.0, 3),
              blurRadius: 6,
            )
          ],
          borderRadius: BorderRadius.circular(30)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}

class AccentedActionButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Function onPressed;

  const AccentedActionButton(
      {Key key,
      @required this.text,
      this.height = 55,
      this.width = 233,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      width: width,
      height: height,
      child: Text(
        text,
        style: MyStyles.of(context).textThemes.buttonActionText1,
      ),
      gradient: MyStyles.of(context).colors.accentGradient,
      onPressed: onPressed,
    );
  }
}

enum StyleTextFieldType { email, password }

enum StyleTextFieldStatus { neutral, error }

class StyleTextField extends StatelessWidget {
  final IconData icon;
  final StyleTextFieldStatus status;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String Function(String) getErrorMessage;
  final String placeholderText;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  final bool obscureText;
  final int maxLines;
  final TextEditingController controller;

  StyleTextField(
    {Key key,
    this.controller,
    this.obscureText = false,
    this.textInputType,
    this.icon,
    this.getErrorMessage,
    this.status = StyleTextFieldStatus.neutral,
    this.onChanged,
    this.inputFormatters,
    this.onSubmitted,
    @required this.placeholderText,
    this.maxLines = 1}
  ) : super(key: key);


  factory StyleTextField.email({
    TextEditingController controller,
    StyleTextFieldStatus status = StyleTextFieldStatus.neutral,
    Function(String) onChanged,
    Function(String) onSubmitted,
  }) {
    return StyleTextField(
      controller: controller,
      icon: Icons.email,
      textInputType: TextInputType.emailAddress,
      status: status,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      placeholderText: "Email...",
      getErrorMessage: (text) {
        bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
        if (isValidEmail) {
          return null;
        } else {
          return "Email is not valid";
        }
      },
      maxLines: 1,
    );
  }

  factory StyleTextField.password({
    TextEditingController controller,
    String paceholderText,
    StyleTextFieldStatus status = StyleTextFieldStatus.neutral,
    Function(String) onChanged,
    Function(String) onSubmitted,
  }) {
    return StyleTextField(
      controller: controller,
      icon: Icons.panorama_fish_eye,
      textInputType: TextInputType.visiblePassword,
      obscureText: true,
      status: status,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      placeholderText: paceholderText ?? "Password...",
      getErrorMessage: (text) {
        if (text.length <= 5) {
          return "Password should contains more then 5 character";
        } else {
          return null;
        }
      },
      maxLines: 1,
    );
  }

  factory StyleTextField.phoneNumber({
    TextEditingController controller,
    String paceholderText,
    StyleTextFieldStatus status = StyleTextFieldStatus.neutral,
    Function(String) onChanged,
    Function(String) onSubmitted,
  }) {
    return StyleTextField(
      controller: controller,
      textInputType: TextInputType.phone,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      status: status,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      placeholderText: "Phone Number...",
      maxLines: 1,
    );
  }

  Color get borderColor {
    switch (status) {
      case StyleTextFieldStatus.neutral:
        return Colors.transparent;
      case StyleTextFieldStatus.error:
        return Colors.red;
    }
  }

  Color get iconColor {
    switch (status) {
      case StyleTextFieldStatus.neutral:
        return null;
      case StyleTextFieldStatus.error:
        return Colors.red;
    }
  }

  Alignment get textFieldFontAlignment {
    if (maxLines != null && maxLines <= 1) {
      return Alignment.center;
    } else {
      return Alignment.topLeft;
    }
  }

  EdgeInsets get insets {
    if (icon == null) {
      return EdgeInsets.only(left: 10);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            alignment: textFieldFontAlignment,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyStyles.of(context).colors.background1,
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2))
                ]),
            padding: insets,
            child: FormField<String>(
              validator: getErrorMessage,
              initialValue: placeholderText,
              autovalidate: true,
              builder: (FormFieldState<String> state) {
                return Column(
                  children: [
                    TextFormField(
                      controller: controller,
                      keyboardType: textInputType,
                      obscureText: obscureText,
                      inputFormatters: inputFormatters,
                      onChanged: (text) {
                        print(text);
                        onChanged(text);
                        state.didChange(text);
                      },
                      onFieldSubmitted: onSubmitted,
                      maxLines: maxLines,
                      cursorColor: Colors.blue,
                      style: MyStyles.of(context)
                          .textThemes
                          .placeholder
                          .copyWith(color: Colors.grey[900]),
                      textAlign: TextAlign.left,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        prefixIcon: (icon != null)
                            ? Icon(icon, color: iconColor)
                            : null,
                        hintStyle: MyStyles.of(context).textThemes.placeholder,
                        border: InputBorder.none,
                        hintText: placeholderText,
                      )
                    ),

                    if(state.errorText != null && controller.text.isNotEmpty)
                      Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        child: Text(
                          state.errorText,
                          textAlign: TextAlign.center,
                          style: MyStyles.of(context).textThemes.errorSubText
                        ),
                      )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QueueCell extends SlideableListCell {
  final Queue queue;
  final Future<bool> Function() onOpen;
  final Future<bool> Function() onDelete;

  QueueCell({Key key, @required this.queue, this.onOpen, this.onDelete, Function onTap})
    : super(
      key: key,
      title: queue.name,
      subheading: (){
        switch (queue.state) {
          case QueueState.active:
            //final numInLine = queue.numWaiting;
            final numInLine = -1;
            switch (numInLine) {
              case 0:
                return "Queue is Empty";
              case 1:
                return "1 Person is in Line";
              default:
                return "$numInLine People are in Line.";
            }
            break;
          case QueueState.inactive:
            return null;
        }
      }(),
      body: queue.description,
      isActive: () {
        switch (queue.state) {
          case QueueState.active:
            return true;
          case QueueState.inactive:
            return false;
        }
      }(),
      isSelected: false,
      primaryText: "Open",
      onPrimarySwipe: onOpen,
      onSecondarySwipe: onDelete,
      relativeSize: SlideableListCellSize.big,
      onTap: onTap,
  );
}

enum QueueEntryCellSize {
  medium, small
}

class QueueEntryCell extends SlideableListCell {
  final QueuePerson queueEntry;
  final Future<bool> Function() onDelete;
  final Future<bool> Function() onNotify;
  
  QueueEntryCell({Key key, this.onDelete, this.onNotify, this.queueEntry, Function onTap, QueueEntryCellSize size})
    : super(
        key: key,
        isSelected: (){
          switch (queueEntry.state) {
            case QueueEntryState.pendingNotification:
            case QueueEntryState.notified:
              return true;
            case QueueEntryState.waiting:
            case QueueEntryState.pendingDeletion:          
            case QueueEntryState.deleted:          
              return false;
          }
        }(),
        primaryText: "Notify",
        onPrimarySwipe: onNotify,
        onSecondarySwipe: onDelete,
        title: queueEntry.name,
        body: queueEntry.note ?? "",
        relativeSize: (){
          switch (size) {
            case QueueEntryCellSize.small:
              return SlideableListCellSize.small;
            case QueueEntryCellSize.medium:
              return SlideableListCellSize.medium;
        }
      }(),
      onTap: onTap,
    );
}

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

//TODO: Have "SilvePersistentHeader" resize to allow smaller button while scrolling down. Using Temp Button rn.
class SlideableList extends StatefulWidget {
  final List<Widget> cells;
  final SliverPersistentHeader header;
  final Function onPlusTap;

  const SlideableList({Key key,this.onPlusTap, @required this.header, @required this.cells}) : super(key: key);

  @override
  _SlideableListState createState() => _SlideableListState();
}

class _SlideableListState extends State<SlideableList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AccentedActionButton(
        text: "+",
        width: 50,
        height: 50,
        onPressed: widget.onPlusTap,
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          child: CustomScrollView(slivers: <Widget>[
            widget.header,
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              if (index != 0) {
                return null;
              }

              return Container(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyStyles.of(context).colors.background1,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                        children: 
                          <Widget>[
                              SizedBox(
                                height: 15,
                              )
                          ] +
                          widget.cells.map((cell) {
                            return Container(
                              padding:EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: cell
                            );
                          }).toList()
                      ),
                    ),
                  ],
                ),
              );
            })),
          ]),
        ),
      ),
    );
  }
}