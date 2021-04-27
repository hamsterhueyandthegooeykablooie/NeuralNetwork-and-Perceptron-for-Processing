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
