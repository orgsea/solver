// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

/*
0000: 0
0001: 1
0010: 2
0011: 3
0100: 4
0101: 5
0110: 6
0111: 7
1000: 8
1001: 9
1010: +
1011: -
1100: *
1101: /
 */
import 'dart:math';

import 'package:math_expressions/math_expressions.dart';

double fitness(String gene) {
  var tokens = tokenise(gene);

  var val = eval(compile(tokens));

  if (val > 42.0) return -1.0;

  return val / 42.0;
}

List tokenise(String gene) {
  var items = [];
  var count = 0;
  var item = '';
  gene.split('').forEach((bit) {
    if (count == 4) {
      items.add(item);
      count = 0;
      item = '';
    }
    count++;
    item = '$item$bit';
  });

  items.add(item);

  return items;
}

List compile(List tokens) {
  var tokenMap = {
    '0000': '0',
    '0001': '1',
    '0010': '2',
    '0011': '3',
    '0100': '4',
    '0101': '5',
    '0110': '6',
    '0111': '7',
    '1000': '8',
    '1001': '9',
    '1010': '+',
    '1011': '-',
    '1100': '*',
    '1101': '/'
  };

  var exp = [];
  var isNum = true;
  tokens.map((item) => tokenMap.putIfAbsent(item, () => null)).toList().forEach((String item) {
    if(isNum && item != null && new RegExp(r'\d').hasMatch(item)) {
      exp.add(item);
      isNum = false;
    } else if(!isNum && item != null && ['+', '-', '*', '/'].contains(item)) {
      exp.add(item);
      isNum = true;
    }
  });
  if(isNum && exp.isNotEmpty) {
    exp.removeLast();
  }
  if(exp.isEmpty) {
    exp.add(0);
  }

  return exp;
}

double eval(List<String> tokens) {
  Parser p = new Parser();
  try {
    Expression exp = p.parse(tokens.join());

    var answer = exp.evaluate(EvaluationType.REAL, new ContextModel());

    return answer;
  } catch (e) {
    return -10.0;
  }
}

String mutate(String gene) {
  List sequence = gene.split('');

  var pos = new Random().nextInt(sequence.length);

  sequence[pos] = sequence[pos] == '1' ? '0' : '1';

  return sequence.join();
}

List<String> initialise() {
  var gene = '00000000000000000000';
  var genes = [];
  for (int i = 0; i < 6; i++) genes.add(mutate(gene));

  return genes;
}

String crossover(String gene1, String gene2) {
  var cp = gene1.length - (4 * 2);

  return '${gene1.substring(0, cp)}${gene2.substring(cp, gene2.length)}';
}

List<String> selection(List<String> genes) {
  Map<double, String> geneFitness = {};
  genes.forEach((gene) {
    geneFitness[fitness(gene)] = gene;
  });

  var largestKey = geneFitness.keys
      .reduce((first, second) => first < second ? second : first);
  var nextLargestKey = geneFitness.keys.reduce((first, second) =>
      first < second && second != largestKey ? second : first);

  String crossoverGene =
      crossover(geneFitness[largestKey], geneFitness[nextLargestKey]);

  List<String> newPop = [geneFitness[largestKey]];

  for (int i = 0; i < 5; i++) {
    newPop.add(mutate(crossoverGene));
  }

  return newPop;
}
