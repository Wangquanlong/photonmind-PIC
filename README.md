# photonmind-PIC
Accelerate the design of photonic integrated circuits (PICs) with machine learning.

The PhotonMind platform creates compact, flexible models of photonic devices using finite-difference time-domain (FDTD) electromagnetic data and deep artificial neural networks (ANNs). This allows for orders-of-magnitude faster calculations for device-level optimizations and system-level simulations. The PhotonMind-PIC project aims to build a standard library of common photonic devices for open use.

## The Library
The PhotonMind-PIC library in `pm-pic.mat` includes pretrained ANN models of common photonic devices. A `Model` holds the weights and biases needed for inference when optimizing for a desired `Device`. Each model is based on common designs in literature, with a range of variable parameters that can be used in the optimization process.

**Note:** These models are works in progress. The parameters of each device, simulation, and trained network may be changed at any time as we continue to improve on the platform. Please refer to the following list for detailed information on each model.

### grating_coupler_SOI
The silicon-on-insulator (SOI) grating coupler is a fundamental component in silicon photonics. It offers a convenient way to couple light between an optical fibre and the photonic chip; however, its performance is highly dependent on the wavelength, polarization, and angle of the incident light—among other ßfactors. PhotonMind-PIC uses the following variable parameters to optimize for different required outputs.

Variable Parameter | Range
--------- | -----
Etch Depth | 0 to 0.22 μm
Duty Cycle | 0.4 to 0.8
Pitch | 0.5 to 0.7 μm

Output | Unit | Type
------ | ---- | ---------
Max Transmission | N/A | 1x1 Double
Center Wavelength | μm | 1x1 Double

**Note:** As we improve on this platform, many (if not all) of the constant parameters will become variable parameters. This will make the model useful for a broader range of applications.

Constant Parameter | Value
--------- | -----
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
Excited Mode | TM0
Bandwidth | 1.4 to 1.7 μm
