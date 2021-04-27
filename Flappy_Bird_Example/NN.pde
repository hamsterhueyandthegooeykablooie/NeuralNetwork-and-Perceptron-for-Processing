class NN {
  private int num_of_inputs;
  private int num_of_hidden;
  private int num_of_outputs;

  private int num_of_weights;
  private int num_of_biases;

  private float[] inputs;
  private float[] biases;
  private float[] weights;
  private int[] hidden;
  private float[] outputs;

  private float[] hidden_outputs;
  private float[] next_hidden_outputs;
  private int hidden_weights;
  private int hidden_biases;

  float mutationRate;

  NN(float[] inps, int[] hids, int numO) {
    inputs = inps;
    num_of_inputs = inputs.length;

    hidden = hids;
    for (int i = 0; i < hidden.length; i++) {
      num_of_hidden += hidden[i];
    }

    num_of_outputs = numO;

    initialize();
  }

  void mutate(NN toMutate, float mutRate) {
    mutationRate = mutRate;
    for (int x = 0; x < toMutate.weights.length; x++) {
      if ((random(0, 100))<mutationRate) {
        toMutate.weights[x] += random(-0.5, 0.5);
      }
    }
    for (int x = 0; x < toMutate.biases.length; x++) {
      if (random(0, 100)<mutationRate) {
        toMutate.biases[x] += random(-0.5, 0.5);
      }
    }
  }

  void transfer(NN toTransfer, NN toTransferTo) {
    for (int i = 0; i < toTransfer.weights.length; i++) {
      toTransferTo.weights[i] = toTransfer.weights[i];
    }
    for (int i = 0; i < toTransfer.biases.length; i++) {
      toTransferTo.biases[i] = toTransfer.biases[i];
    }
  }

  void breed(NN parentone, NN parenttwo, int wo, int wt, int bo, int bt, float mutRate, NN child) {
    transfer(parentone, child);
    for (int i = wo; i < wt; i++) {
      child.weights[i] = parenttwo.weights[i];
    }
    for (int i = bo; i < bt; i++) {
      child.biases[i] = parenttwo.biases[i];
    }
    mutationRate = mutRate;
    mutate(child, mutationRate);
  } 

  void initialize() {
    num_of_weights = 0;
    num_of_weights += inputs.length*hidden[0];
    if (hidden.length > 1) {
      for (int i = 1; i < hidden.length; i++) {
        num_of_weights += hidden[i-1]*hidden[i];
      }
    }
    num_of_weights += num_of_outputs*hidden[hidden.length-1];

    num_of_biases = num_of_hidden+num_of_outputs;

    next_hidden_outputs = new float[hidden[0]];
    hidden_outputs = new float[hidden[0]];
    weights = new float[num_of_weights];
    biases = new float[num_of_biases];
    outputs = new float[num_of_outputs];
    hidden_weights = 0;
    hidden_biases = 0;
  }

  void randomize() {
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }
    for (int i = 0; i < biases.length; i++) {
      biases[i] = random(-1, 1);
    }
  }

  void compute() { 
    next_hidden_outputs = new float[hidden[0]];
    hidden_outputs = new float[hidden[0]];
    outputs = new float[num_of_outputs];

    hidden_outputs = new float[hidden[0]];

    if (hidden.length == 1) {
      for (int i = 0; i < hidden[0]; i++) {
        for (int x = 0; x < num_of_inputs; x++) {
          hidden_outputs[i] += inputs[x]*weights[x+(i*num_of_inputs)];
        }
        hidden_outputs[i] += biases[i];
        if (hidden_outputs[i] < 0) {
          hidden_outputs[i] = 0;
        }
      }

      for (int i = 0; i < num_of_outputs; i++) {
        for (int x = 0; x < hidden[0]; x++) {
          outputs[i] += hidden_outputs[x]*weights[(num_of_inputs*hidden[0])+x];
        }
        outputs[i] += biases[hidden[0]+i];
        outputs[i] = (float)Math.tanh(outputs[i]);
      }
    }

    if (hidden.length > 1) {
      for (int i = 0; i < hidden[0]; i++) {
        for (int x = 0; x < num_of_inputs; x++) {
          hidden_outputs[i] += inputs[x]*weights[x+(i*num_of_inputs)];
        }
        hidden_outputs[i] += biases[i];
        if (hidden_outputs[i] < 0) {
          hidden_outputs[i] = 0;
        }
      }

      hidden_weights = (hidden[0]*inputs.length);
      hidden_biases = hidden[0];

      for (int i = 1; i < hidden.length; i++) {
        next_hidden_outputs = new float[hidden[i]];
        for (int x = 0; x < hidden[i]; x++) {
          for (int j = 0; j < hidden[i-1]; j++) {
            next_hidden_outputs[x] += hidden_outputs[j]*weights[(hidden_weights)];
            hidden_weights ++;
          }
          next_hidden_outputs[x] += biases[hidden_biases];
          if (next_hidden_outputs[x] < 0) {
            next_hidden_outputs[x] = 0;
          }
          hidden_biases++;
        }
        hidden_outputs = next_hidden_outputs;
      }

      for (int i = 0; i < num_of_outputs; i++) {
        for (int x = 0; x < hidden[hidden.length-1]; x++) {
          outputs[i] += hidden_outputs[x]*weights[hidden_weights];
          hidden_weights++;
        }
        outputs[i] += biases[hidden_biases];
        outputs[i] = (float)Math.tanh(outputs[i]);
        hidden_biases++;
      }
    }
  }
}

class Perceptron {
  private float[] inputs;
  private float[] outputs;
  private float[] weights;
  private float[] biases;

  private int num_of_inputs;
  private int num_of_outputs;

  float mutationRate;

  Perceptron(float[] inps, int numO) {
    inputs = inps;
    num_of_inputs = inputs.length;

    num_of_outputs = numO;
    outputs = new float[num_of_outputs];

    initialize();
  }

  void mutate(Perceptron toMutate, float mutRate) {
    mutationRate = mutRate;
    for (int x = 0; x < toMutate.weights.length; x++) {
      if ((random(0, 100))<mutationRate) {
        toMutate.weights[x] += random(-0.5, 0.5);
      }
    }
    for (int x = 0; x < toMutate.biases.length; x++) {
      if (random(0, 100)<mutationRate) {
        toMutate.biases[x] += random(-0.5, 0.5);
      }
    }
  }

  void transfer(Perceptron toTransfer, Perceptron toTransferTo) {
    for (int i = 0; i < toTransfer.weights.length; i++) {
      toTransferTo.weights[i] = toTransfer.weights[i];
    }
    for (int i = 0; i < toTransfer.biases.length; i++) {
      toTransferTo.biases[i] = toTransfer.biases[i];
    }
  }

  void breed(Perceptron parentone, Perceptron parenttwo, int wo, int wt, int bo, int bt, float mutRate, Perceptron child) {
    transfer(parentone, child);
    for (int i = wo; i < wt; i++) {
      child.weights[i] = parenttwo.weights[i];
    }
    for (int i = bo; i < bt; i++) {
      child.biases[i] = parenttwo.biases[i];
    }
    mutationRate = mutRate;
    mutate(child, mutationRate);
  } 

  void initialize() {
    weights = new float[num_of_inputs*num_of_outputs];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = 0;
    }   
    biases = new float[num_of_outputs];
    for (int i = 0; i < biases.length; i++) {
      biases[i] = 0;
    }
  }

  void randomize() {
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(-1, 1);
    }   
    biases = new float[num_of_outputs];
    for (int i = 0; i < biases.length; i++) {
      biases[i] = random(-1, 1);
    }
  }

  void compute() {
    outputs = new float[num_of_outputs];
    for (int i = 0; i < num_of_outputs; i++) {
      for (int j = 0; j < num_of_inputs; j++) {
        outputs[i] += inputs[j]*weights[j+(i*num_of_inputs)];
      }
      outputs[i] += biases[i];
      outputs[i] = (float)Math.tanh(outputs[i]);
    }
  }
}
