import 'package:fitnessapp/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final List<Map<String, String>> nutrientData = [
    {
      'Nutrients': 'Vitamin A',
      'Breakdown': '200ml',
      'Explanation': 'Too low for your body'
    },
    {
      'Nutrients': 'Vitamin C',
      'Breakdown': '500ml',
      'Explanation': 'Recommended daily intake'
    },
    {
      'Nutrients': 'Iron',
      'Breakdown': '5mg',
      'Explanation': 'Slightly low, consider supplements'
    },
    {
      'Nutrients': 'Calcium',
      'Breakdown': '1000mg',
      'Explanation': 'Good for bone health'
    },
  ];

  final Map<String, String> suggestion = {
    'Tithi': "OK",
    'SAKSHI': 'OK',
    'UMANG': 'OK',
    'SAHIL': 'OK'
  };

  double _nutrientContainerHeight = 0; // dynamically calculated height
  double _suggestionContainerHeight = 0; // dynamically calculated height

  @override
  void initState() {
    super.initState();
    // Calculate the heights based on the screen size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        final screenHeight = MediaQuery.of(context).size.height;
        _nutrientContainerHeight =
            screenHeight * 0.35; // 35% of the screen height
        _suggestionContainerHeight =
            screenHeight * 0.35; // 35% of the screen height
      });
    });
  }

  _toggleNutrientContainer() {
    setState(() {
      _nutrientContainerHeight = (_nutrientContainerHeight ==
              MediaQuery.of(context).size.height * 0.35)
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.35;
    });
  }

  _toggleSuggestionContainer() {
    setState(() {
      _suggestionContainerHeight = (_suggestionContainerHeight ==
              MediaQuery.of(context).size.height * 0.35)
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.35;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.lightGrayColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/icons/more_icon.png",
                width: 12,
                height: 12,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display the food image at the top of the page
            SizedBox(height: 35),
            // DataTable with a toggleable container height and gradient background
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade100, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.black12, width: 2),
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: double.infinity,
              height: _nutrientContainerHeight,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columnSpacing: 10.0,
                        headingRowHeight: 50.0,
                        dataRowHeight: 60.0,
                        columns: [
                          DataColumn(
                            label: Text(
                              'Nutrients',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Breakdown',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Explanation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                        rows: nutrientData.map((data) {
                          return DataRow(cells: [
                            DataCell(Padding(
                              padding: EdgeInsets.all(2),
                              child: Text(
                                data['Nutrients']!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            )),
                            DataCell(Padding(
                              padding: EdgeInsets.all(2),
                              child: Text(
                                data['Breakdown']!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            )),
                            DataCell(Padding(
                              padding: EdgeInsets.all(2),
                              child: Text(
                                data['Explanation']!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                      color: Colors.black26,
                    ),
                    onPressed: _toggleNutrientContainer,
                  ),
                ],
              ),
            ),
            // Cards Section with a toggleable container height and gradient background
            SizedBox(height: 50),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade100, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.black12, width: 2),
              ),
              height: _suggestionContainerHeight,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: suggestion.entries.map((entry) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black26, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                  )),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      entry.key,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: entry.value == "OK"
                                            ? Colors.green
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Text(
                                        entry.value,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                      color: Colors.black26,
                    ),
                    onPressed: _toggleSuggestionContainer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
