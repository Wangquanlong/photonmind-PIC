# photonmind-PIC
Accelerate the design of photonic integrated circuits (PICs) with machine learning.

## About
The PhotonMind platform creates compact, flexible models of photonic devices using numerically solved electromagnetic data and deep artificial neural networks (ANNs). This allows for orders-of-magnitude faster calculations for device-level optimizations and system-level simulations. The PhotonMind-PIC project aims to build a standard library of common photonic devices for open use.

## The Library
The PhotonMind-PIC library in `pm-pic.mat` includes pretrained ANN models of common photonic devices. A `Model` holds the weights and biases needed for inference when optimizing for a desired `Device`. Each model is based on common designs in literature, with a range of variable parameters that can be used in the optimization process.

**Note:** These models are works in progress. The parameters of each device, simulation, and trained network may be changed at any time as we continue to improve on the platform. Many (if not all) of the constant parameters will become variable parameters. This will make the model useful for a broader range of applications. Please refer to the following list for detailed information on each model.

### grating_coupler_SOI
The silicon-on-insulator (SOI) grating coupler is a fundamental component in silicon photonics. It offers a convenient way to couple light between an optical fibre and a photonic chip; however, its performance is highly dependent on the wavelength, polarization, and angle of the incident light (among other factors). Should any of these factors change, a new design must be made—often taking many hours to do by conventional means. With PhotonMind-PIC and the `grating_coupler_SOI` model, new designs can be found instantaneously.

![Image of grating_coupler_SOI](https://github.com/Dusandinho/photonmind-PIC/blob/master/model_images/grating_coupler_SOI.png?raw=true)

`grating_coupler_SOI` is a focusing grating that is trained with variable parameters in the table below.

Variable Parameter | Range
------------------ | ----
Etch Depth | 0 to 0.22 μm
Duty Cycle | 0.6 to 0.7
Pitch | 0.5 to 0.7 μm

Output | Unit | Type
------ | ---- | ----
Max Transmission | N/A | 1x1 Double
Center Wavelength | μm | 1x1 Double

Constant Parameter | Value
------------------ | -----
Core Material | Silicon
Core Thickness | 0.22 μm
Top Cladding Material | Air
Bottom Cladding Material | Silicon Dioxide
Bottom Cladding Thickness | 3 μm
Length | 25 μm
Width | 15 μm
Radius of Grating | 25 μm
Waveguide Width | 0.5 μm
Fiber Angle | 14°
Fiber–Grating Gap |
Excited Mode | TM0
Wavelength Range | 1.4 to 1.7 μm

Simulation Parameter | Value
-------------------- | -----
Solver | Lumerical FDTD
Dimension | 3D
Mesh Size |
Boundary Type | PML
Time | > Autoshutoff
