NeuralNetwork-and-Perceptron-for-Processing

This project contains two classes, the Neural Network class and the Perceptron class. The difference between the two is that a Neural Network has hidden layers, whereas a perceptron does not. The perceptron class should be used only for linearly seperable tasks. The Neural Network class is much more powerful, but you shouldn't use if when you could be using a perceptron.

The Neural Network (NN) class takes 3 arguements, a float[] of inputs, an int[] of hidden layers, and an int of outputs. For example, you might call it likes this:
NN nn;
float[] inputs = {2, 3};
int[] hidden = {4, 3};
nn = new NN(inputs, hidden, 2);
nn.randomize(); <------- This function randomizes the weights and biases in the Neural Network

If you're using this program to play a game, you'll need to constantly update the inputs you're giving the class. For example:
void brain() {
  inputs[0] = x;
  inputs[1] = y;
  nn.compute(); <------- This function runs the Neural Networks calculations. That means you'll typically want to run the brain() function in draw().
}

The perceptron class takes 2 arguements, a float[] of inputs and an int of outputs. You might call it like this:
Perceptron perceptron;
float[] inputs = {2, 3};
perceptron = new Perceptron(inputs, 1);
perceptron.randomize(); <------- This function randomizes the weights and biases in the Perceptron


If you're using this program to play a game, you'll need to constantly update the inputs you're giving the class. For example:
void brain() {
  inputs[0] = x;
  inputs[1] = y;
  perceptron.compute(); <------- This function runs the Perceptrons calculations. That means you'll typically want to run the brain() function in draw();
}

You can then pull the outputs like this:
nn.outputs[0] = myVar; <------- The array outputs[] has the number of object that you called in the last number of the constructor.
if (nn.outputs[0] > 0.5) {
  doSomething();
}
Or, if you're using the perceptron:
perceptron.outputs[0] = myVar;
if (perceptron.outputs[0] > 0.5) {
  doSomething();
}

IMPORTANT: outputs will always be returned as a number between -1 and 1. This is because we use the tanH activation function.

Lastly, both the Neural Network and the Perceptron have a few functions:

mutate(): Takes two arguements: the NN/Percetron you want to mutate, float - the chance of each of the weights and biases being mutated (must be between 0 and 100);

transfer(); Takes two arguements: the NN/Perceptron you are transferring, and the NN/Perceptron you are transferring to. Use this instead of "nn = othernn" because the latter often leads to problems;

Takes 8 arguements: the first parent which is an NN/Perceptron, the second parent which is an NN/Perceptron, int - the index of the weights[] float where you want to being to splice the weights from the second parent, int - the index where you want to stop splicing the weights of the second parent, int - the index of the biases[] float where you want to being to splice the biases from the second parent, int - the index where you want to stop splicing the biases of the second parent, float - the mutation rate of the weights and biases after performing cross-breeding (works the same as the mutate() function), lastly, the NN/Perceptron that you want to be the child of the first two parents.

Enjoy!
