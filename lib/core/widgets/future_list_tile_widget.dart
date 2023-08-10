import 'package:flutter/material.dart';
import 'lottie_loading_widget.dart';

FutureBuilder futureDropDown(
    Future<List<String>> future, String? value, onChanged) {
  return FutureBuilder<List<String>>(
    future: future,
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return const CustomLoadingWidget();
      } else if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Text('NO DATA');
      } else if (snapshot.hasData && snapshot.data != null) {
        return Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            children: [
              DropdownButton<String>(
                value: value,
                onChanged: (newValue) {
                  onChanged(newValue);
                },
                items: snapshot.data!.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    },
  );
}
