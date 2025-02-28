  import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildModelSelection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // color: Theme.of(context).primaryColor.withOpacity(0.1),
      // color: Colors.white.withOpacity(0.1),
      child: Row(
        children: [
          Text('Model:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(
            child: DropdownButton<String>(
              value: 'gpt4',
              isExpanded: true,
              underline: SizedBox(),
              items: [
                DropdownMenuItem(value: 'gpt3', child: Text('GPT-3.5')),
                DropdownMenuItem(value: 'gpt4', child: Text('GPT-4')),
                DropdownMenuItem(value: 'claude', child: Text('Claude')),
              ],
              onChanged: (value) {
                // Implement model change logic
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.info_outline, size: 20),
            onPressed: () {
              // Show model info
            },
          ),
        ],
      ),
    );
  }