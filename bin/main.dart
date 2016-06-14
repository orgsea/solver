// Copyright (c) 2016, James Hurford. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:solver/solver.dart' as solver;

main(List<String> arguments) {
  List<String> population = solver.initialise();
  for (int i = 0; i < 1000000; i++) {
    population = solver.selection(population);
    if (solver.fitness(population[0]) == 1.0) {
      break;
    }
  }

  print(
      '${solver.compile(solver.tokenise(population[0]))}:'
      ' ${solver.eval(solver.compile(solver.tokenise(population[0])))}');
}
