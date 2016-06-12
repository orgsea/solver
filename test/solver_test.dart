// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:solver/solver.dart';
import 'package:test/test.dart';

void main() {
  group('[fitness]',() {
    test('given gene of "0000 1010 0000 1010 0000" gives answer of 0', () {
      expect(fitness("00001010000010100000"), 0);
    });

    test('given gene of "0001 1010 0000 1010 0000" gives answer of 0.023809523809523808', () {
      expect(fitness("00011010000010100000"), 0.023809523809523808);
    });
  });

  group('[tokenise]', () {
    test('will return a list', () {
      expect(tokenise("00010101000001010000"), new isInstanceOf<List>());
    });

    test('list contains 5 items', () {
      expect(tokenise("00010101000001010000").length, 5);
    });

    test('list contains 5 items of ["0001", "0101", "0000", "0101", "0000"]', () {
      expect(tokenise("00010101000001010000"), ["0001", "0101", "0000", "0101", "0000"]);
    });
  });

  group('[compile]', () {
    test('["0001", "1010", "0000", "1010", "0000"] is compiled to ["1", "+", "0", "+", "0"]', () {
      expect(compile(["0001", "1010", "0000", "1010", "0000"]), ["1", "+", "0", "+", "0"]);
    });
  });

  group('[eval]', () {
    test('["1", "+", "0", "+", "0"] evals to 1.0', () {
      expect(eval(["1", "+", "0", "+", "0"]), 1.0);
    });
  });

  group('[mutate]', () {
    test('changes gene', () {
      var gene = "00010101000001010000";
      expect(mutate(gene), isNot(gene));
    });
  });

  group('[initalise]', () {
    test('generates a list of length 6', () {
      expect(initialise().length, 6);
    });
  });

  group('[crossover]', () {
    test('crossover returns a string of same length as both params passed in', () {
      var gene = "00010101000001010000";
      expect(crossover(gene, gene).length, gene.length);
    });
  });
}
