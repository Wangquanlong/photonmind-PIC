# photonmind-PIC
Accelerate the design of photonic integrated circuits (PICs) with machine learning.

## About
The PhotonMind platform creates compact, flexible models of photonic devices using numerically solved electromagnetic data and deep artificial neural networks (ANNs). This allows for orders-of-magnitude faster calculations for device-level optimizations and system-level simulations. The PhotonMind-PIC project aims to build a standard library of common photonic devices for open use.

**PhotonMind-PIC uses MATLAB.**

## Getting Started
The PhotonMind-PIC library in `pm-pic.mat` includes pretrained ANN models of common photonic devices. A model holds the weights and biases needed for inference when optimizing for a desired device. Each model is based on common designs in literature, with a range of variable parameters that can be used in the optimization process.

The following example demonstrates how to create a device from the `grating_coupler_SOI` model.

```
>> load('pm-pic.mat')
>> gc = Device(grating_coupler_SOI)

gc =

  Device with properties:

         model: [1×1 Model]
     constants: []
    conditions: []
       matches: []
      features: []
```

A blank device called `gc` has now been created. In order to solve for the parameters of the device, we must give it at least one condition:

```
>> gc.add_condition(2, 1.65e-6, 0.01e-6)
```

The first value passed into `add_condition` is the index of the output we tie the condition to. The deep neural network used to train the model, the tables shown in **The Library**, and the list produced by `Model.about` are all indexed in a consistent manner. The second and third values passed to the function are the target and tolerance values, respectively.

We then solve for the device parameters that meet this condition, using the built-in parametric sweep. Note that you can use your own optimization script instead, using `Model.infer` to run inference on the model. In this example, we solve using a sweep resolution of 5:

```
>> gc.solve(5)

Match #1
etch depth = 4.4e-08
duty cycle = 0.71
pitch = 7.2e-07
T_min = -0.23965
lam_T_min = 1.6546e-06

Match #2
etch depth = 1.1e-07
duty cycle = 0.65
pitch = 7.2e-07
T_min = -0.31615
lam_T_min = 1.6428e-06

Match #3
etch depth = 1.1e-07
duty cycle = 0.68
pitch = 7.2e-07
T_min = -0.34356
lam_T_min = 1.6523e-06
```

The information of each device that matches the condition is printed. As the resolution of the solver is increased, more matches will be found. From there, it may be helpful to add another condition (i.e., for `T_min`). Constants can also be set; for example, if your fabrication process does not allow for partial etching:

```
>> gc.add_constant(1, 0.22e-6)
```

This locks the first parameter (etch depth) to 0.22 μm when running the solver. As more variable parameters are added to each model, this will become more important.

## The Library
**Note:** These models are works in progress. The parameters of each device, simulation, and trained network may be changed at any time as we continue to improve on the platform. Many (if not all) of the constant parameters will become variable parameters. This will make the model useful for a broader range of applications. Please refer to the following list for detailed information on each model.

### grating_coupler_SOI
The silicon-on-insulator (SOI) grating coupler is a fundamental component in silicon photonics. It offers a convenient way to couple light between an optical fibre and a photonic chip; however, its performance is highly dependent on the wavelength, polarization, and angle of the incident light (among other factors). Should any of these factors change, a new design must be made—often taking many hours to do by conventional means. With PhotonMind-PIC and the `grating_coupler_SOI` model, new designs can be found instantaneously.

`grating_coupler_SOI` is a focusing grating that is trained using the following:

Variable Parameter | Range
------------------ | ----
Etch Depth | 0 to 0.22 μm
Duty Cycle | 0.4 to 0.7
Pitch | 0.4 to 0.7 μm

**Note:** The variable parameter boundaries are extended by 10% in training to achieve better accuracy.

Output | Unit | Type
------ | ---- | ----
Max Transmission | a.u. | 1x1 Double
Center Wavelength | m | 1x1 Double

Constant Parameter | Value
------------------ | -----
Wavelength Range | 1.4 to 1.7 μm
Excited Mode | TM0
Core Material | Silicon
Core Thickness | 0.22 μm
Top Cladding Material | Silicon Dioxide
Top Cladding Thickness | > Simulation Window
Bottom Cladding Material | Silicon Dioxide
Bottom Cladding Thickness | 2 μm
Radius of Grating | 25 μm
Waveguide Width | 0.5 μm
Fiber Angle | 13°
Fiber Height | 1 μm

**Note:** All material models are provided by the solver.

Simulation Parameter | Value
-------------------- | -----
Solver | Lumerical FDTD
Dimension | 3D
Mesh Size | 6 Mesh Points per Wavelength
Boundary Type | PML
Time | Autoshutoff

Training Results | Value
---------------- | -----
Test Error | 8.6%

### grating_coupler_SWG_SOI
The silicon-on-insulator (SOI) subwavelength grating (SWG) coupler offers reduced coupling reflections (i.e., insertion loss) for single-etch devices. Like `grating_coupler_SOI`, its performance is highly dependent on the wavelength, polarization, and angle of the incident light (among other factors). Should any of these factors change, a new design must be made—often taking many hours to do by conventional means. With PhotonMind-PIC and the `grating_coupler_SWG_SOI` model, new designs can be found instantaneously.

`grating_coupler_SWG_SOI` is a straight grating that is trained using the following:

Variable Parameter | Range
------------------ | ----
Fiber Angle | 8° to 25°
Pitch | 0.5 to 1.5 μm
Grating Duty Cycle | 0.4 to 0.8
SWG Fill Factor | 0.2 to 0.6

**Note:** The variable parameter boundaries are extended by 10% in training to achieve better accuracy.

Output | Unit | Type
------ | ---- | ----
Max Transmission | a.u. | 1x1 Double
Center Wavelength | m | 1x1 Double

Constant Parameter | Value
------------------ | -----
Wavelength Range | 1.2 to 1.8 μm
Excited Mode | TM0
Core Material | Silicon
Core Thickness | 0.22 μm
Top Cladding Material | Silicon Dioxide
Top Cladding Thickness | > Simulation Window
Bottom Cladding Material | Silicon Dioxide
Bottom Cladding Thickness | 3 μm
Fiber Height | 0 μm

**Note:** All material models are provided by the solver.

Simulation Parameter | Value
-------------------- | -----
Solver | Lumerical FDTD
Dimension | 2D
Mesh Size | 18 Mesh Points per Wavelength
Boundary Type | PML
Time | Autoshutoff

Training Results | Value
---------------- | -----
Test Error | 8.0%

### ring_resonator_SOI
*This model is currently being developed.*

## License
This project is licensed under the Apache-2.0 License - see the [LICENSE](LICENSE) file for details
