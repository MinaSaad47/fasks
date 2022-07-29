import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final List<BottomNavigationBarItemWidget> items;
  final void Function(int) onTap;
  const BottomNavigationBarWidget({
    Key? key,
    required this.items,
    required this.onTap,
  })  : assert(items.length >= 2),
        super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            widget.items.length,
            (index) => Expanded(
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    widget.onTap(index);
                    selectedItem = index;
                  });
                },
                child: selectedItem == index
                    ? widget.items[index].selected
                    : widget.items[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BottomNavigationBarItemWidget extends StatelessWidget {
  bool isSelected = false;
  final String label;
  final IconData icon;
  BottomNavigationBarItemWidget({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  BottomNavigationBarItemWidget get selected =>
      BottomNavigationBarItemWidget(label: label, icon: icon)
        ..isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
        ),
        const SizedBox(height: 5),
        Icon(
          icon,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ],
    );
  }
}
