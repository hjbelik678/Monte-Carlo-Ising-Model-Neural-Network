# Computational Physics: Neural Network Memory Simulation
## Henry Belik

This project simulates neural network behavior for the storage and retrieval of memory using a modified Monte Carlo simulation. The model leverages biological principles of the human brain to process and recognize patterns, specifically simple character-based images.

## Project Overview

### Biological Inspiration
The structure of the human brain serves as the fundamental model for this neural network. In this model:
* **Dendrites** serve as the "input" nodes of a neuron.
* **Axons** serve as the "output" nodes.
* Neurons within the brain are highly connected, with each neuron typically connected to 10,000 others.
* These neurons communicate via slight electrical pulses.

### Memory Storage and Retrieval
In this simulation, "memories" are stored as specific energy levels. The system processes information by:
1. Converting sensory inputs into usable data for the brain.
2. Comparing these inputs against previously encoded "memories"
3. Testing different "memories" over and over to determine the best fit.

## Methodology

### Modified Monte Carlo Simulation
While traditional Monte Carlo simulations rely on random measurements, this model is modified so that each trial is not random. Instead, elements are deliberately changed, and the same steps are performed repeatedly to observe the system's behavior.

### Inputs and Processing
* **Data Representation:** We use simple arrays of two characters (`+` and `-`) that represent letters of the alphabet.
* **Conversion:** When inputted, plus signs (`+`) are assigned a value of +1, while minus signs (`-`) or spaces are assigned -1.
* **Interaction Energy:** We calculate the latent energy inherent to the array using an analogy of electrical charges, where like charges repel and opposite charges attract.

### The Repeated Step
To converge on a "memory," the system iterates through the input lattice. Between each sweep:
* A single element is changed.
* The simulation aims to reach the lowest possible lattice energy.
* The initial latent energy of the unchanged array acts as a "grounding point" (the memory), which guides the system toward the correct letter representation.
