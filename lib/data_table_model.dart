class DataTableModel {
  String aircraftName = '';

  Map startingFuel = Map();
  Map reduction = Map();

  List lffcSpeed = [];
  List alt = [];

  Map climbPerform = Map();
  Map descendPerform = Map();
  Map lffc = Map();

  DataTableModel() {
    aircraftName = 'Mig33';

    startingFuel['config 1'] = 5000;
    startingFuel['config 2'] = 3000;

    alt.add(0.5);
    alt.add(1);

    reduction['SUTTO'] = 250;

    climbPerform[0.5] = {'time': 25, 'distance': 54, 'fuel': 98};
    climbPerform[alt[1]] = {'time': 45, 'distance': 85, 'fuel': 14};

    descendPerform[alt[0]] = {'time': 789, 'distance': 54, 'fuel': 74};
    descendPerform[alt[1]] = {'time': 3, 'distance': 54, 'fuel': 958};
    lffc[0.5] = {500: 2.5, 600: 3.5, 700: 4.5};
    lffc[-1] = {};

    @override
    String toString() {
      return aircraftName;
    }
  }
}
