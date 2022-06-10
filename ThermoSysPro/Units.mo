within ThermoSysPro;
package Units "Additional SI and non-SI units"

  package SI
    "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;

    // Space and Time (chapter 1 of ISO 31-1992)

    type Angle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");
    type SolidAngle = Real (final quantity="SolidAngle", final unit="sr");
    type Length = Real (final quantity="Length", final unit="m");
    type PathLength = Length;
    type Position = Length;
    type Distance = Length (min=0);
    type Breadth = Length(min=0);
    type Height = Length(min=0);
    type Thickness = Length(min=0);
    type Radius = Length(min=0);
    type Diameter = Length(min=0);
    type Area = Real (final quantity="Area", final unit="m2");
    type Volume = Real (final quantity="Volume", final unit="m3");
    type Time = Real (final quantity="Time", final unit="s");
    type Duration = Time;
    type AngularVelocity = Real (
        final quantity="AngularVelocity",
        final unit="rad/s");
    type AngularAcceleration = Real (final quantity="AngularAcceleration", final unit=
               "rad/s2");
    type Velocity = Real (final quantity="Velocity", final unit="m/s");
    type Acceleration = Real (final quantity="Acceleration", final unit="m/s2");

    // Periodic and related phenomens (chapter 2 of ISO 31-1992)
    type Period = Real (final quantity="Time", final unit="s");
    type Frequency = Real (final quantity="Frequency", final unit="Hz");
    type AngularFrequency = Real (final quantity="AngularFrequency", final unit=
            "rad/s");
    type Wavelength = Real (final quantity="Wavelength", final unit="m");
    type Wavelenght = Wavelength;
    // For compatibility reasons only
    type WaveNumber = Real (final quantity="WaveNumber", final unit="m-1");
    type CircularWaveNumber = Real (final quantity="CircularWaveNumber", final unit=
               "rad/m");
    type AmplitudeLevelDifference = Real (final quantity=
            "AmplitudeLevelDifference", final unit="dB");
    type PowerLevelDifference = Real (final quantity="PowerLevelDifference",
          final unit="dB");
    type DampingCoefficient = Real (final quantity="DampingCoefficient", final unit=
               "s-1");
    type LogarithmicDecrement = Real (final quantity="LogarithmicDecrement",
          final unit="1/S");
    type AttenuationCoefficient = Real (final quantity="AttenuationCoefficient",
          final unit="m-1");
    type PhaseCoefficient = Real (final quantity="PhaseCoefficient", final unit=
            "m-1");
    type PropagationCoefficient = Real (final quantity="PropagationCoefficient",
          final unit="m-1");
    // added to ISO-chapter
    type Damping = DampingCoefficient;

    // Mechanics (chapter 3 of ISO 31-1992)
    type Mass = Real (
        quantity="Mass",
        final unit="kg",
        min=0);
    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0.0);
    type RelativeDensity = Real (
        final quantity="RelativeDensity",
        final unit="1",
        min=0.0);
    type SpecificVolume = Real (
        final quantity="SpecificVolume",
        final unit="m3/kg",
        min=0.0);
    type LinearDensity = Real (
        final quantity="LinearDensity",
        final unit="kg/m",
        min=0);
    type SurfaceDensity = Real (
        final quantity="SurfaceDensity",
        final unit="kg/m2",
        min=0);
    type Momentum = Real (final quantity="Momentum", final unit="kg.m/s");
    type Impulse = Real (final quantity="Impulse", final unit="N.s");
    type AngularMomentum = Real (final quantity="AngularMomentum", final unit=
            "kg.m2/s");
    type AngularImpulse = Real (final quantity="AngularImpulse", final unit=
            "N.m.s");
    type MomentOfInertia = Real (final quantity="MomentOfInertia", final unit=
            "kg.m2");
    type Inertia = MomentOfInertia;
    type Force = Real (final quantity="Force", final unit="N");
    type TranslationalSpringConstant=Real(final quantity="TranslationalSpringConstant", final unit="N/m");
    type TranslationalDampingConstant=Real(final quantity="TranslationalDampingConstant", final unit="N.s/m");
    type Weight = Force;
    type Torque = Real (final quantity="Torque", final unit="N.m");
    type ElectricalTorqueConstant = Real(final quantity="ElectricalTorqueConstant", final unit= "N.m/A");
    type MomentOfForce = Torque;
    type ImpulseFlowRate = Real (final quantity="ImpulseFlowRate", final unit="N");
    type AngularImpulseFlowRate = Real (final quantity="AngularImpulseFlowRate", final unit= "N.m");
    type RotationalSpringConstant=Real(final quantity="RotationalSpringConstant", final unit="N.m/rad");
    type RotationalDampingConstant=Real(final quantity="RotationalDampingConstant", final unit="N.m.s/rad");
    type Pressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar");
    type AbsolutePressure = Pressure (min=0.0, nominal = 1e5);
    type PressureDifference = Pressure;
    type BulkModulus = AbsolutePressure;
    type Stress = Real (final unit="Pa");
    type NormalStress = Stress;
    type ShearStress = Stress;
    type Strain = Real (final quantity="Strain", final unit="1");
    type LinearStrain = Strain;
    type ShearStrain = Strain;
    type VolumeStrain = Real (final quantity="VolumeStrain", final unit="1");
    type PoissonNumber = Real (final quantity="PoissonNumber", final unit="1");
    type ModulusOfElasticity = Stress;
    type ShearModulus = Stress;
    type SecondMomentOfArea = Real (final quantity="SecondMomentOfArea", final unit=
               "m4");
    type SecondPolarMomentOfArea = SecondMomentOfArea;
    type SectionModulus = Real (final quantity="SectionModulus", final unit="m3");
    type CoefficientOfFriction = Real (final quantity="CoefficientOfFriction",
          final unit="1");
    type DynamicViscosity = Real (
        final quantity="DynamicViscosity",
        final unit="Pa.s",
        min=0);
    type KinematicViscosity = Real (
        final quantity="KinematicViscosity",
        final unit="m2/s",
        min=0);
    type SurfaceTension = Real (final quantity="SurfaceTension", final unit="N/m");
    type Work = Real (final quantity="Work", final unit="J");
    type Energy = Real (final quantity="Energy", final unit="J");
    type EnergyDensity = Real (final quantity="EnergyDensity", final unit="J/m3");
    type PotentialEnergy = Energy;
    type KineticEnergy = Energy;
    type Power = Real (final quantity="Power", final unit="W");
    type EnergyFlowRate = Power;
    type EnthalpyFlowRate = Real (final quantity="EnthalpyFlowRate", final unit=
            "W");
    type Efficiency = Real (
        final quantity="Efficiency",
        final unit="1",
        min=0);
    type MassFlowRate = Real (quantity="MassFlowRate", final unit="kg/s");
    type VolumeFlowRate = Real (final quantity="VolumeFlowRate", final unit=
            "m3/s");
    // added to ISO-chapter 3
    type MomentumFlux = Real (final quantity="MomentumFlux", final unit="N");
    type AngularMomentumFlux = Real (final quantity="AngularMomentumFlux", final unit=
               "N.m");

    // Heat (chapter 4 of ISO 31-1992)
    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0.0,
        start = 288.15,
        nominal = 300,
        displayUnit="degC")
      "Absolute temperature (use type TemperatureDifference for relative temperatures)"                   annotation(absoluteValue=true);
    type Temp_K = ThermodynamicTemperature;
    type Temperature = ThermodynamicTemperature;
    type TemperatureDifference = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K") annotation(absoluteValue=false);
    type TemperatureSlope = Real (final quantity="TemperatureSlope",
        final unit="K/s");
    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit="1/K");
    type QuadraticTemperatureCoefficient = Real(final quantity = "QuadraticTemperatureCoefficient", final unit="1/K2");
    type LinearExpansionCoefficient = Real (final quantity=
            "LinearExpansionCoefficient", final unit="1/K");
    type CubicExpansionCoefficient = Real (final quantity=
            "CubicExpansionCoefficient", final unit="1/K");
    type RelativePressureCoefficient = Real (final quantity=
            "RelativePressureCoefficient", final unit="1/K");
    type PressureCoefficient = Real (final quantity="PressureCoefficient", final unit=
               "Pa/K");
    type Compressibility = Real (final quantity="Compressibility", final unit=
            "1/Pa");
    type IsothermalCompressibility = Compressibility;
    type IsentropicCompressibility = Compressibility;
    type Heat = Real (final quantity="Energy", final unit="J");
    type HeatFlowRate = Real (final quantity="Power", final unit="W");
    type HeatFlux = Real (final quantity="HeatFlux", final unit="W/m2");
    type DensityOfHeatFlowRate = Real (final quantity="DensityOfHeatFlowRate",
          final unit="W/m2");
    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");
    type CoefficientOfHeatTransfer = Real (final quantity=
            "CoefficientOfHeatTransfer", final unit="W/(m2.K)");
    type SurfaceCoefficientOfHeatTransfer = CoefficientOfHeatTransfer;
    type ThermalInsulance = Real (final quantity="ThermalInsulance", final unit=
            "m2.K/W");
    type ThermalResistance = Real (final quantity="ThermalResistance", final unit=
           "K/W");
    type ThermalConductance = Real (final quantity="ThermalConductance", final unit=
               "W/K");
    type ThermalDiffusivity = Real (final quantity="ThermalDiffusivity", final unit=
               "m2/s");
    type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");
    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");
    type SpecificHeatCapacityAtConstantPressure = SpecificHeatCapacity;
    type SpecificHeatCapacityAtConstantVolume = SpecificHeatCapacity;
    type SpecificHeatCapacityAtSaturation = SpecificHeatCapacity;
    type RatioOfSpecificHeatCapacities = Real (final quantity=
            "RatioOfSpecificHeatCapacities", final unit="1");
    type IsentropicExponent = Real (final quantity="IsentropicExponent", final unit=
               "1");
    type Entropy = Real (final quantity="Entropy", final unit="J/K");
    type EntropyFlowRate = Real (final quantity="EntropyFlowRate", final unit="J/(K.s)");
    type SpecificEntropy = Real (final quantity="SpecificEntropy",
                                 final unit="J/(kg.K)");
    type InternalEnergy = Heat;
    type Enthalpy = Heat;
    type HelmholtzFreeEnergy = Heat;
    type GibbsFreeEnergy = Heat;
    type SpecificEnergy = Real (final quantity="SpecificEnergy",
                                final unit="J/kg");
    type SpecificInternalEnergy = SpecificEnergy;
    type SpecificEnthalpy = SpecificEnergy;
    type SpecificHelmholtzFreeEnergy = SpecificEnergy;
    type SpecificGibbsFreeEnergy = SpecificEnergy;
    type MassieuFunction = Real (final quantity="MassieuFunction", final unit=
            "J/K");
    type PlanckFunction = Real (final quantity="PlanckFunction", final unit="J/K");
    // added to ISO-chapter 4
    type DerDensityByEnthalpy = Real (final unit="kg.s2/m5");
    type DerDensityByPressure = Real (final unit="s2/m2");
    type DerDensityByTemperature = Real (final unit="kg/(m3.K)");
    type DerEnthalpyByPressure = Real (final unit="J.m.s2/kg2");
    type DerEnergyByDensity = Real (final unit="J.m3/kg");
    type DerEnergyByPressure = Real (final unit="J.m.s2/kg");
    type DerPressureByDensity = Real (final unit="Pa.m3/kg");
    type DerPressureByTemperature = Real (final unit="Pa/K");

    // Electricity and Magnetism (chapter 5 of ISO 31-1992)
    type ElectricCurrent = Real (final quantity="ElectricCurrent", final unit="A");
    type Current = ElectricCurrent;
    type CurrentSlope = Real(final quantity="CurrentSlope", final unit="A/s");
    type ElectricCharge = Real (final quantity="ElectricCharge", final unit="C");
    type Charge = ElectricCharge;
    type VolumeDensityOfCharge = Real (
        final quantity="VolumeDensityOfCharge",
        final unit="C/m3",
        min=0);
    type SurfaceDensityOfCharge = Real (
        final quantity="SurfaceDensityOfCharge",
        final unit="C/m2",
        min=0);
    type ElectricFieldStrength = Real (final quantity="ElectricFieldStrength",
          final unit="V/m");
    type ElectricPotential = Real (final quantity="ElectricPotential", final unit=
           "V");
    type Voltage = ElectricPotential;
    type PotentialDifference = ElectricPotential;
    type ElectromotiveForce = ElectricPotential;
    type VoltageSecond = Real (final quantity="VoltageSecond", final unit="V.s")
      "Voltage second";
    type VoltageSlope = Real(final quantity="VoltageSlope", final unit="V/s");
    type ElectricFluxDensity = Real (final quantity="ElectricFluxDensity", final unit=
               "C/m2");
    type ElectricFlux = Real (final quantity="ElectricFlux", final unit="C");
    type Capacitance = Real (
        final quantity="Capacitance",
        final unit="F",
        min=0);
    type CapacitancePerArea =
                Real (final quantity="CapacitancePerArea", final unit="F/m2")
      "Capacitance per area";
    type Permittivity = Real (
        final quantity="Permittivity",
        final unit="F/m",
        min=0);
    type PermittivityOfVacuum = Permittivity;
    type RelativePermittivity = Real (final quantity="RelativePermittivity",
          final unit="1");
    type ElectricSusceptibility = Real (final quantity="ElectricSusceptibility",
          final unit="1");
    type ElectricPolarization = Real (final quantity="ElectricPolarization",
          final unit="C/m2");
    type Electrization = Real (final quantity="Electrization", final unit="V/m");
    type ElectricDipoleMoment = Real (final quantity="ElectricDipoleMoment",
          final unit="C.m");
    type CurrentDensity = Real (final quantity="CurrentDensity", final unit=
            "A/m2");
    type LinearCurrentDensity = Real (final quantity="LinearCurrentDensity",
          final unit="A/m");
    type MagneticFieldStrength = Real (final quantity="MagneticFieldStrength",
          final unit="A/m");
    type MagneticPotential = Real (final quantity="MagneticPotential", final unit="A");
    type MagneticPotentialDifference = Real (final quantity=
            "MagneticPotential", final unit="A");
    type MagnetomotiveForce = Real (final quantity="MagnetomotiveForce", final unit=
               "A");
    type CurrentLinkage = Real (final quantity="CurrentLinkage", final unit="A");
    type MagneticFluxDensity = Real (final quantity="MagneticFluxDensity", final unit=
               "T");
    type MagneticFlux = Real (final quantity="MagneticFlux", final unit="Wb");
    type MagneticVectorPotential = Real (final quantity="MagneticVectorPotential",
            final unit="Wb/m");
    type Inductance = Real (
        final quantity="Inductance",
        final unit="H");
    type SelfInductance = Inductance(min=0);
    type MutualInductance = Inductance;
    type CouplingCoefficient = Real (final quantity="CouplingCoefficient", final unit=
               "1");
    type LeakageCoefficient = Real (final quantity="LeakageCoefficient", final unit=
               "1");
    type Permeability = Real (final quantity="Permeability", final unit="H/m");
    type PermeabilityOfVacuum = Permeability;
    type RelativePermeability = Real (final quantity="RelativePermeability",
          final unit="1");
    type MagneticSusceptibility = Real (final quantity="MagneticSusceptibility",
          final unit="1");
    type ElectromagneticMoment = Real (final quantity="ElectromagneticMoment",
          final unit="A.m2");
    type MagneticDipoleMoment = Real (final quantity="MagneticDipoleMoment",
          final unit="Wb.m");
    type Magnetization = Real (final quantity="Magnetization", final unit="A/m");
    type MagneticPolarization = Real (final quantity="MagneticPolarization",
          final unit="T");
    type ElectromagneticEnergyDensity = Real (final quantity="EnergyDensity",
          final unit="J/m3");
    type PoyntingVector = Real (final quantity="PoyntingVector", final unit=
            "W/m2");
    type Resistance = Real (
        final quantity="Resistance",
        final unit="Ohm");
    type Resistivity = Real (final quantity="Resistivity", final unit="Ohm.m");
    type Conductivity = Real (final quantity="Conductivity", final unit="S/m");
    type Reluctance = Real (final quantity="Reluctance", final unit="H-1");
    type Permeance = Real (final quantity="Permeance", final unit="H");
    type PhaseDifference = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");
    type Impedance = Resistance;
    type ModulusOfImpedance = Resistance;
    type Reactance = Resistance;
    type QualityFactor = Real (final quantity="QualityFactor", final unit="1");
    type LossAngle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");
    type Conductance = Real (
        final quantity="Conductance",
        final unit="S");
    type Admittance = Conductance;
    type ModulusOfAdmittance = Conductance;
    type Susceptance = Conductance;
    type InstantaneousPower = Real (final quantity="Power", final unit="W");
    type ActivePower = Real (final quantity="Power", final unit="W");
    type ApparentPower = Real (final quantity="Power", final unit="VA");
    type ReactivePower = Real (final quantity="Power", final unit="var");
    type PowerFactor = Real (final quantity="PowerFactor", final unit="1");

    // added to ISO-chapter 5
    type Transconductance = Real (final quantity="Transconductance", final unit=
            "A/V2");
    type InversePotential = Real (final quantity="InversePotential", final unit=
            "1/V");
    type ElectricalForceConstant = Real (
         final quantity="ElectricalForceConstant",
         final unit = "N/A");

    // Light and Related Electromagnetic Radiations (chapter 6 of ISO 31-1992)
    type RadiantEnergy = Real (final quantity="Energy", final unit="J");
    type RadiantEnergyDensity = Real (final quantity="EnergyDensity", final unit=
            "J/m3");
    type SpectralRadiantEnergyDensity = Real (final quantity=
            "SpectralRadiantEnergyDensity", final unit="J/m4");
    type RadiantPower = Real (final quantity="Power", final unit="W");
    type RadiantEnergyFluenceRate = Real (final quantity=
            "RadiantEnergyFluenceRate", final unit="W/m2");
    type RadiantIntensity = Real (final quantity="RadiantIntensity", final unit=
            "W/sr");
    type Radiance = Real (final quantity="Radiance", final unit="W/(sr.m2)");
    type RadiantExtiance = Real (final quantity="RadiantExtiance", final unit=
            "W/m2");
    type Irradiance = Real (final quantity="Irradiance", final unit="W/m2");
    type Emissivity = Real (final quantity="Emissivity", final unit="1");
    type SpectralEmissivity = Real (final quantity="SpectralEmissivity", final unit=
               "1");
    type DirectionalSpectralEmissivity = Real (final quantity=
            "DirectionalSpectralEmissivity", final unit="1");
    type LuminousIntensity = Real (final quantity="LuminousIntensity", final unit=
           "cd");
    type LuminousFlux = Real (final quantity="LuminousFlux", final unit="lm");
    type QuantityOfLight = Real (final quantity="QuantityOfLight", final unit=
            "lm.s");
    type Luminance = Real (final quantity="Luminance", final unit="cd/m2");
    type LuminousExitance = Real (final quantity="LuminousExitance", final unit=
            "lm/m2");
    type Illuminance = Real (final quantity="Illuminance", final unit="lx");
    type LightExposure = Real (final quantity="LightExposure", final unit="lx.s");
    type LuminousEfficacy = Real (final quantity="LuminousEfficacy", final unit=
            "lm/W");
    type SpectralLuminousEfficacy = Real (final quantity=
            "SpectralLuminousEfficacy", final unit="lm/W");
    type LuminousEfficiency = Real (final quantity="LuminousEfficiency", final unit=
               "1");
    type SpectralLuminousEfficiency = Real (final quantity=
            "SpectralLuminousEfficiency", final unit="1");
    type CIESpectralTristimulusValues = Real (final quantity=
            "CIESpectralTristimulusValues", final unit="1");
    type ChromaticityCoordinates = Real (final quantity="CromaticityCoordinates",
            final unit="1");
    type SpectralAbsorptionFactor = Real (final quantity=
            "SpectralAbsorptionFactor", final unit="1");
    type SpectralReflectionFactor = Real (final quantity=
            "SpectralReflectionFactor", final unit="1");
    type SpectralTransmissionFactor = Real (final quantity=
            "SpectralTransmissionFactor", final unit="1");
    type SpectralRadianceFactor = Real (final quantity="SpectralRadianceFactor",
          final unit="1");
    type LinearAttenuationCoefficient = Real (final quantity=
            "AttenuationCoefficient", final unit="m-1");
    type LinearAbsorptionCoefficient = Real (final quantity=
            "LinearAbsorptionCoefficient", final unit="m-1");
    type MolarAbsorptionCoefficient = Real (final quantity=
            "MolarAbsorptionCoefficient", final unit="m2/mol");
    type RefractiveIndex = Real (final quantity="RefractiveIndex", final unit="1");

    // Acoustics (chapter 7 of ISO 31-1992)
    type StaticPressure = AbsolutePressure;
    type SoundPressure = StaticPressure;
    type SoundParticleDisplacement = Real (final quantity="Length", final unit=
            "m");
    type SoundParticleVelocity = Real (final quantity="Velocity", final unit=
            "m/s");
    type SoundParticleAcceleration = Real (final quantity="Acceleration", final unit=
               "m/s2");
    type VelocityOfSound = Real (final quantity="Velocity", final unit="m/s");
    type SoundEnergyDensity = Real (final quantity="EnergyDensity", final unit=
            "J/m3");
    type SoundPower = Real (final quantity="Power", final unit="W");
    type SoundIntensity = Real (final quantity="SoundIntensity", final unit=
            "W/m2");
    type AcousticImpedance = Real (final quantity="AcousticImpedance", final unit=
           "Pa.s/m3");
    type SpecificAcousticImpedance = Real (final quantity=
            "SpecificAcousticImpedance", final unit="Pa.s/m");
    type MechanicalImpedance = Real (final quantity="MechanicalImpedance", final unit=
               "N.s/m");
    type SoundPressureLevel = Real (final quantity="SoundPressureLevel", final unit=
               "dB");
    type SoundPowerLevel = Real (final quantity="SoundPowerLevel", final unit=
            "dB");
    type DissipationCoefficient = Real (final quantity="DissipationCoefficient",
          final unit="1");
    type ReflectionCoefficient = Real (final quantity="ReflectionCoefficient",
          final unit="1");
    type TransmissionCoefficient = Real (final quantity="TransmissionCoefficient",
            final unit="1");
    type AcousticAbsorptionCoefficient = Real (final quantity=
            "AcousticAbsorptionCoefficient", final unit="1");
    type SoundReductionIndex = Real (final quantity="SoundReductionIndex", final unit=
               "dB");
    type EquivalentAbsorptionArea = Real (final quantity="Area", final unit="m2");
    type ReverberationTime = Real (final quantity="Time", final unit="s");
    type LoudnessLevel = Real (final quantity="LoudnessLevel", final unit=
            "phon");
    type Loudness = Real (final quantity="Loudness", final unit="sone");
    type LoundnessLevel = Real (final quantity="LoundnessLevel", final unit=
            "phon") "Obsolete type, use LoudnessLevel instead!";
    type Loundness = Real (final quantity="Loundness", final unit="sone")
      "Obsolete type, use Loudness instead!";

    // Physical chemistry and molecular physics (chapter 8 of ISO 31-1992)
    type RelativeAtomicMass = Real (final quantity="RelativeAtomicMass", final unit=
               "1");
    type RelativeMolecularMass = Real (final quantity="RelativeMolecularMass",
          final unit="1");
    type NumberOfMolecules = Real (final quantity="NumberOfMolecules", final unit=
           "1");
    type AmountOfSubstance = Real (
        final quantity="AmountOfSubstance",
        final unit="mol",
        min=0);
    type MolarMass = Real (final quantity="MolarMass", final unit="kg/mol",min=0);
    type MolarVolume = Real (final quantity="MolarVolume", final unit="m3/mol", min=0);
    type MolarDensity = Real (final quantity="MolarDensity", unit="mol/m3");
    type MolarEnergy = Real (final quantity="MolarEnergy", final unit="J/mol", nominal=2e4);
    type MolarInternalEnergy = MolarEnergy;
    type MolarHeatCapacity = Real (final quantity="MolarHeatCapacity", final unit=
           "J/(mol.K)");
    type MolarEntropy = Real (final quantity="MolarEntropy", final unit=
            "J/(mol.K)");
    type MolarEnthalpy = MolarEnergy;
    type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit=
            "mol/s");
    type NumberDensityOfMolecules = Real (final quantity=
            "NumberDensityOfMolecules", final unit="m-3");
    type MolecularConcentration = Real (final quantity="MolecularConcentration",
          final unit="m-3");
    type MassConcentration = Real (final quantity="MassConcentration", final unit=
           "kg/m3");
    type MassFraction = Real (final quantity="MassFraction", final unit="1",
                              min=0, max=1);
    type Concentration = Real (final quantity="Concentration", final unit=
            "mol/m3");
    type VolumeFraction = Real (final quantity="VolumeFraction", final unit="1");
    type MoleFraction = Real (final quantity="MoleFraction", final unit="1",
                              min = 0, max = 1);
    type ChemicalPotential = Real (final quantity="ChemicalPotential", final unit=
           "J/mol");
    type AbsoluteActivity = Real (final quantity="AbsoluteActivity", final unit=
            "1");
    type PartialPressure = AbsolutePressure;
    type Fugacity = Real (final quantity="Fugacity", final unit="Pa");
    type StandardAbsoluteActivity = Real (final quantity=
            "StandardAbsoluteActivity", final unit="1");
    type ActivityCoefficient = Real (final quantity="ActivityCoefficient", final unit=
               "1");
    type ActivityOfSolute = Real (final quantity="ActivityOfSolute", final unit=
            "1");
    type ActivityCoefficientOfSolute = Real (final quantity=
            "ActivityCoefficientOfSolute", final unit="1");
    type StandardAbsoluteActivityOfSolute = Real (final quantity=
            "StandardAbsoluteActivityOfSolute", final unit="1");
    type ActivityOfSolvent = Real (final quantity="ActivityOfSolvent", final unit=
           "1");
    type OsmoticCoefficientOfSolvent = Real (final quantity=
            "OsmoticCoefficientOfSolvent", final unit="1");
    type StandardAbsoluteActivityOfSolvent = Real (final quantity=
            "StandardAbsoluteActivityOfSolvent", final unit="1");
    type OsmoticPressure = Real (
        final quantity="Pressure",
        final unit="Pa",
        displayUnit="bar",
        min=0);
    type StoichiometricNumber = Real (final quantity="StoichiometricNumber",
          final unit="1");
    type Affinity = Real (final quantity="Affinity", final unit="J/mol");
    type MassOfMolecule = Real (final quantity="Mass", final unit="kg");
    type ElectricDipoleMomentOfMolecule = Real (final quantity=
            "ElectricDipoleMomentOfMolecule", final unit="C.m");
    type ElectricPolarizabilityOfAMolecule = Real (final quantity=
            "ElectricPolarizabilityOfAMolecule", final unit="C.m2/V");
    type MicrocanonicalPartitionFunction = Real (final quantity=
            "MicrocanonicalPartitionFunction", final unit="1");
    type CanonicalPartitionFunction = Real (final quantity=
            "CanonicalPartitionFunction", final unit="1");
    type GrandCanonicalPartitionFunction = Real (final quantity=
            "GrandCanonicalPartitionFunction", final unit="1");
    type MolecularPartitionFunction = Real (final quantity=
            "MolecularPartitionFunction", final unit="1");
    type StatisticalWeight = Real (final quantity="StatisticalWeight", final unit=
           "1");
    type MeanFreePath = Length;
    type DiffusionCoefficient = Real (final quantity="DiffusionCoefficient",
          final unit="m2/s");
    type ThermalDiffusionRatio = Real (final quantity="ThermalDiffusionRatio",
          final unit="1");
    type ThermalDiffusionFactor = Real (final quantity="ThermalDiffusionFactor",
          final unit="1");
    type ThermalDiffusionCoefficient = Real (final quantity=
            "ThermalDiffusionCoefficient", final unit="m2/s");
    type ElementaryCharge = Real (final quantity="ElementaryCharge", final unit=
            "C");
    type ChargeNumberOfIon = Real (final quantity="ChargeNumberOfIon", final unit=
           "1");
    type FaradayConstant = Real (final quantity="FaradayConstant", final unit=
            "C/mol");
    type IonicStrength = Real (final quantity="IonicStrength", final unit=
            "mol/kg");
    type DegreeOfDissociation = Real (final quantity="DegreeOfDissociation",
          final unit="1");
    type ElectrolyticConductivity = Real (final quantity=
            "ElectrolyticConductivity", final unit="S/m");
    type MolarConductivity = Real (final quantity="MolarConductivity", final unit=
           "S.m2/mol");
    type TransportNumberOfIonic = Real (final quantity="TransportNumberOfIonic",
          final unit="1");

    // Atomic and Nuclear Physics (chapter 9 of ISO 31-1992)
    type ProtonNumber = Real (final quantity="ProtonNumber", final unit="1");
    type NeutronNumber = Real (final quantity="NeutronNumber", final unit="1");
    type NucleonNumber = Real (final quantity="NucleonNumber", final unit="1");
    type AtomicMassConstant = Real (final quantity="Mass", final unit="kg");
    type MassOfElectron = Real (final quantity="Mass", final unit="kg");
    type MassOfProton = Real (final quantity="Mass", final unit="kg");
    type MassOfNeutron = Real (final quantity="Mass", final unit="kg");
    type HartreeEnergy = Real (final quantity="Energy", final unit="J");
    type MagneticMomentOfParticle = Real (final quantity=
            "MagneticMomentOfParticle", final unit="A.m2");
    type BohrMagneton = MagneticMomentOfParticle;
    type NuclearMagneton = MagneticMomentOfParticle;
    type GyromagneticCoefficient = Real (final quantity="GyromagneticCoefficient",
            final unit="A.m2/(J.s)");
    type GFactorOfAtom = Real (final quantity="GFactorOfAtom", final unit="1");
    type GFactorOfNucleus = Real (final quantity="GFactorOfNucleus", final unit=
            "1");
    type LarmorAngularFrequency = Real (final quantity="AngularFrequency", final unit=
               "s-1");
    type NuclearPrecessionAngularFrequency = Real (final quantity=
            "AngularFrequency", final unit="s-1");
    type CyclotronAngularFrequency = Real (final quantity="AngularFrequency",
          final unit="s-1");
    type NuclearQuadrupoleMoment = Real (final quantity="NuclearQuadrupoleMoment",
            final unit="m2");
    type NuclearRadius = Real (final quantity="Length", final unit="m");
    type ElectronRadius = Real (final quantity="Length", final unit="m");
    type ComptonWavelength = Real (final quantity="Length", final unit="m");
    type MassExcess = Real (final quantity="Mass", final unit="kg");
    type MassDefect = Real (final quantity="Mass", final unit="kg");
    type RelativeMassExcess = Real (final quantity="RelativeMassExcess", final unit=
               "1");
    type RelativeMassDefect = Real (final quantity="RelativeMassDefect", final unit=
               "1");
    type PackingFraction = Real (final quantity="PackingFraction", final unit="1");
    type BindingFraction = Real (final quantity="BindingFraction", final unit="1");
    type MeanLife = Real (final quantity="Time", final unit="s");
    type LevelWidth = Real (final quantity="LevelWidth", final unit="J");
    type Activity = Real (final quantity="Activity", final unit="Bq");
    type SpecificActivity = Real (final quantity="SpecificActivity", final unit=
            "Bq/kg");
    type DecayConstant = Real (final quantity="DecayConstant", final unit="s-1");
    type HalfLife = Real (final quantity="Time", final unit="s");
    type AlphaDisintegrationEnergy = Real (final quantity="Energy", final unit=
            "J");
    type MaximumBetaParticleEnergy = Real (final quantity="Energy", final unit=
            "J");
    type BetaDisintegrationEnergy = Real (final quantity="Energy", final unit="J");

    // Nuclear Reactions and Ionizing Radiations (chapter 10 of ISO 31-1992)
    type ReactionEnergy = Real (final quantity="Energy", final unit="J");
    type ResonanceEnergy = Real (final quantity="Energy", final unit="J");
    type CrossSection = Real (final quantity="Area", final unit="m2");
    type TotalCrossSection = Real (final quantity="Area", final unit="m2");
    type AngularCrossSection = Real (final quantity="AngularCrossSection", final unit=
               "m2/sr");
    type SpectralCrossSection = Real (final quantity="SpectralCrossSection",
          final unit="m2/J");
    type SpectralAngularCrossSection = Real (final quantity=
            "SpectralAngularCrossSection", final unit="m2/(sr.J)");
    type MacroscopicCrossSection = Real (final quantity="MacroscopicCrossSection",
            final unit="m-1");
    type TotalMacroscopicCrossSection = Real (final quantity=
            "TotalMacroscopicCrossSection", final unit="m-1");
    type ParticleFluence = Real (final quantity="ParticleFluence", final unit=
            "m-2");
    type ParticleFluenceRate = Real (final quantity="ParticleFluenceRate", final unit=
               "s-1.m2");
    type EnergyFluence = Real (final quantity="EnergyFluence", final unit="J/m2");
    type EnergyFluenceRate = Real (final quantity="EnergyFluenceRate", final unit=
           "W/m2");
    type CurrentDensityOfParticles = Real (final quantity=
            "CurrentDensityOfParticles", final unit="m-2.s-1");
    type MassAttenuationCoefficient = Real (final quantity=
            "MassAttenuationCoefficient", final unit="m2/kg");
    type MolarAttenuationCoefficient = Real (final quantity=
            "MolarAttenuationCoefficient", final unit="m2/mol");
    type AtomicAttenuationCoefficient = Real (final quantity=
            "AtomicAttenuationCoefficient", final unit="m2");
    type HalfThickness = Real (final quantity="Length", final unit="m");
    type TotalLinearStoppingPower = Real (final quantity=
            "TotalLinearStoppingPower", final unit="J/m");
    type TotalAtomicStoppingPower = Real (final quantity=
            "TotalAtomicStoppingPower", final unit="J.m2");
    type TotalMassStoppingPower = Real (final quantity="TotalMassStoppingPower",
          final unit="J.m2/kg");
    type MeanLinearRange = Real (final quantity="Length", final unit="m");
    type MeanMassRange = Real (final quantity="MeanMassRange", final unit="kg/m2");
    type LinearIonization = Real (final quantity="LinearIonization", final unit=
            "m-1");
    type TotalIonization = Real (final quantity="TotalIonization", final unit="1");
    type Mobility = Real (final quantity="Mobility", final unit="m2/(V.s)");
    type IonNumberDensity = Real (final quantity="IonNumberDensity", final unit=
            "m-3");
    type RecombinationCoefficient = Real (final quantity=
            "RecombinationCoefficient", final unit="m3/s");
    type NeutronNumberDensity = Real (final quantity="NeutronNumberDensity",
          final unit="m-3");
    type NeutronSpeed = Real (final quantity="Velocity", final unit="m/s");
    type NeutronFluenceRate = Real (final quantity="NeutronFluenceRate", final unit=
               "s-1.m-2");
    type TotalNeutronSourceDensity = Real (final quantity=
            "TotalNeutronSourceDesity", final unit="s-1.m-3");
    type SlowingDownDensity = Real (final quantity="SlowingDownDensity", final unit=
               "s-1.m-3");
    type ResonanceEscapeProbability = Real (final quantity=
            "ResonanceEscapeProbability", final unit="1");
    type Lethargy = Real (final quantity="Lethargy", final unit="1");
    type SlowingDownArea = Real (final quantity="Area", final unit="m2");
    type DiffusionArea = Real (final quantity="Area", final unit="m2");
    type MigrationArea = Real (final quantity="Area", final unit="m2");
    type SlowingDownLength = Real (final quantity="SLength", final unit="m");
    type DiffusionLength = Length;
    type MigrationLength = Length;
    type NeutronYieldPerFission = Real (final quantity="NeutronYieldPerFission",
          final unit="1");
    type NeutronYieldPerAbsorption = Real (final quantity=
            "NeutronYieldPerAbsorption", final unit="1");
    type FastFissionFactor = Real (final quantity="FastFissionFactor", final unit=
           "1");
    type ThermalUtilizationFactor = Real (final quantity=
            "ThermalUtilizationFactor", final unit="1");
    type NonLeakageProbability = Real (final quantity="NonLeakageProbability",
          final unit="1");
    type Reactivity = Real (final quantity="Reactivity", final unit="1");
    type ReactorTimeConstant = Real (final quantity="Time", final unit="s");
    type EnergyImparted = Real (final quantity="Energy", final unit="J");
    type MeanEnergyImparted = Real (final quantity="Energy", final unit="J");
    type SpecificEnergyImparted = Real (final quantity="SpecificEnergy", final unit=
               "Gy");
    type AbsorbedDose = Real (final quantity="AbsorbedDose", final unit="Gy");
    type DoseEquivalent = Real (final quantity="DoseEquivalent", final unit="Sv");
    type AbsorbedDoseRate = Real (final quantity="AbsorbedDoseRate", final unit=
            "Gy/s");
    type LinearEnergyTransfer = Real (final quantity="LinearEnergyTransfer",
          final unit="J/m");
    type Kerma = Real (final quantity="Kerma", final unit="Gy");
    type KermaRate = Real (final quantity="KermaRate", final unit="Gy/s");
    type MassEnergyTransferCoefficient = Real (final quantity=
            "MassEnergyTransferCoefficient", final unit="m2/kg");
    type Exposure = Real (final quantity="Exposure", final unit="C/kg");
    type ExposureRate = Real (final quantity="ExposureRate", final unit=
            "C/(kg.s)");

    // chapter 11 is not defined in ISO 31-1992

    // Characteristic Numbers (chapter 12 of ISO 31-1992)
    type ReynoldsNumber = Real (final quantity="ReynoldsNumber", final unit="1");
    type EulerNumber = Real (final quantity="EulerNumber", final unit="1");
    type FroudeNumber = Real (final quantity="FroudeNumber", final unit="1");
    type GrashofNumber = Real (final quantity="GrashofNumber", final unit="1");
    type WeberNumber = Real (final quantity="WeberNumber", final unit="1");
    type MachNumber = Real (final quantity="MachNumber", final unit="1");
    type KnudsenNumber = Real (final quantity="KnudsenNumber", final unit="1");
    type StrouhalNumber = Real (final quantity="StrouhalNumber", final unit="1");
    type FourierNumber = Real (final quantity="FourierNumber", final unit="1");
    type PecletNumber = Real (final quantity="PecletNumber", final unit="1");
    type RayleighNumber = Real (final quantity="RayleighNumber", final unit="1");
    type NusseltNumber = Real (final quantity="NusseltNumber", final unit="1");
    type BiotNumber = NusseltNumber;
    // The Biot number (Bi) is used when
    // the Nusselt number is reserved
    // for convective transport of heat.
    type StantonNumber = Real (final quantity="StantonNumber", final unit="1");
    type FourierNumberOfMassTransfer = Real (final quantity=
            "FourierNumberOfMassTransfer", final unit="1");
    type PecletNumberOfMassTransfer = Real (final quantity=
            "PecletNumberOfMassTransfer", final unit="1");
    type GrashofNumberOfMassTransfer = Real (final quantity=
            "GrashofNumberOfMassTransfer", final unit="1");
    type NusseltNumberOfMassTransfer = Real (final quantity=
            "NusseltNumberOfMassTransfer", final unit="1");
    type StantonNumberOfMassTransfer = Real (final quantity=
            "StantonNumberOfMassTransfer", final unit="1");
    type PrandtlNumber = Real (final quantity="PrandtlNumber", final unit="1");
    type SchmidtNumber = Real (final quantity="SchmidtNumber", final unit="1");
    type LewisNumber = Real (final quantity="LewisNumber", final unit="1");
    type MagneticReynoldsNumber = Real (final quantity="MagneticReynoldsNumber",
          final unit="1");
    type AlfvenNumber = Real (final quantity="AlfvenNumber", final unit="1");
    type HartmannNumber = Real (final quantity="HartmannNumber", final unit="1");
    type CowlingNumber = Real (final quantity="CowlingNumber", final unit="1");

    // Solid State Physics (chapter 13 of ISO 31-1992)
    type BraggAngle = Angle;
    type OrderOfReflexion = Real (final quantity="OrderOfReflexion", final unit=
            "1");
    type ShortRangeOrderParameter = Real (final quantity="RangeOrderParameter",
          final unit="1");
    type LongRangeOrderParameter = Real (final quantity="RangeOrderParameter",
          final unit="1");
    type DebyeWallerFactor = Real (final quantity="DebyeWallerFactor", final unit=
           "1");
    type CircularWavenumber = Real (final quantity="CircularWavenumber", final unit=
               "m-1");
    type FermiCircularWavenumber = Real (final quantity="FermiCircularWavenumber",
            final unit="m-1");
    type DebyeCircularWavenumber = Real (final quantity="DebyeCircularWavenumber",
            final unit="m-1");
    type DebyeCircularFrequency = Real (final quantity="AngularFrequency", final unit=
               "s-1");
    type DebyeTemperature = ThermodynamicTemperature;
    type SpectralConcentration = Real (final quantity="SpectralConcentration",
          final unit="s/m3");
    type GrueneisenParameter = Real (final quantity="GrueneisenParameter", final unit=
               "1");
    type MadelungConstant = Real (final quantity="MadelungConstant", final unit=
            "1");
    type DensityOfStates = Real (final quantity="DensityOfStates", final unit=
            "J-1/m-3");
    type ResidualResistivity = Real (final quantity="ResidualResistivity", final unit=
               "Ohm.m");
    type LorenzCoefficient = Real (final quantity="LorenzCoefficient", final unit=
           "V2/K2");
    type HallCoefficient = Real (final quantity="HallCoefficient", final unit=
            "m3/C");
    type ThermoelectromotiveForce = Real (final quantity=
            "ThermoelectromotiveForce", final unit="V");
    type SeebeckCoefficient = Real (final quantity="SeebeckCoefficient", final unit=
               "V/K");
    type PeltierCoefficient = Real (final quantity="PeltierCoefficient", final unit=
               "V");
    type ThomsonCoefficient = Real (final quantity="ThomsonCoefficient", final unit=
               "V/K");
    type RichardsonConstant = Real (final quantity="RichardsonConstant", final unit=
               "A/(m2.K2)");
    type FermiEnergy = Real (final quantity="Energy", final unit="eV");
    type GapEnergy = Real (final quantity="Energy", final unit="eV");
    type DonorIonizationEnergy = Real (final quantity="Energy", final unit="eV");
    type AcceptorIonizationEnergy = Real (final quantity="Energy", final unit=
            "eV");
    type ActivationEnergy = Real (final quantity="Energy", final unit="eV");
    type FermiTemperature = ThermodynamicTemperature;
    type ElectronNumberDensity = Real (final quantity="ElectronNumberDensity",
          final unit="m-3");
    type HoleNumberDensity = Real (final quantity="HoleNumberDensity", final unit=
           "m-3");
    type IntrinsicNumberDensity = Real (final quantity="IntrinsicNumberDensity",
          final unit="m-3");
    type DonorNumberDensity = Real (final quantity="DonorNumberDensity", final unit=
               "m-3");
    type AcceptorNumberDensity = Real (final quantity="AcceptorNumberDensity",
          final unit="m-3");
    type EffectiveMass = Mass;
    type MobilityRatio = Real (final quantity="MobilityRatio", final unit="1");
    type RelaxationTime = Time;
    type CarrierLifeTime = Time;
    type ExchangeIntegral = Real (final quantity="Energy", final unit="eV");
    type CurieTemperature = ThermodynamicTemperature;
    type NeelTemperature = ThermodynamicTemperature;
    type LondonPenetrationDepth = Length;
    type CoherenceLength = Length;
    type LandauGinzburgParameter = Real (final quantity="LandauGinzburgParameter",
            final unit="1");
    type FluxiodQuantum = Real (final quantity="FluxiodQuantum", final unit="Wb");

    type TimeAging = Real (final quantity="1/Modelica.SIunits.Time",final unit="1/s");
    type ChargeAging = Real (final quantity="1/Modelica.SIunits.ElectricCharge",final unit="1/(A.s)");

   // Other types not defined in ISO 31-1992
    type PerUnit = Real(unit = "1");
    type DimensionlessRatio = Real(unit = "1");

   // Complex types for electrical systems (not defined in ISO 31-1992)
    operator record ComplexCurrent =
      Complex(redeclare ThermoSysPro.Units.SI.Current re,
               redeclare ThermoSysPro.Units.SI.Current im)
      "Complex electrical current";
    operator record ComplexCurrentSlope =
      Complex(redeclare ThermoSysPro.Units.SI.CurrentSlope re,
               redeclare ThermoSysPro.Units.SI.CurrentSlope im)
      "Complex current slope";
    operator record ComplexCurrentDensity =
      Complex(redeclare ThermoSysPro.Units.SI.CurrentDensity re,
               redeclare ThermoSysPro.Units.SI.CurrentDensity im)
      "Complex electrical current density";
    operator record ComplexElectricPotential =
      Complex(redeclare ThermoSysPro.Units.SI.ElectricPotential re,
               redeclare ThermoSysPro.Units.SI.ElectricPotential im)
      "Complex electric potential";
    operator record ComplexPotentialDifference =
      Complex(redeclare ThermoSysPro.Units.SI.PotentialDifference re,
               redeclare ThermoSysPro.Units.SI.PotentialDifference im)
      "Complex electric potential difference";
    operator record ComplexVoltage =
      Complex(redeclare ThermoSysPro.Units.SI.Voltage re,
               redeclare ThermoSysPro.Units.SI.Voltage im)
      "Complex electrical voltage";
    operator record ComplexVoltageSlope =
      Complex(redeclare ThermoSysPro.Units.SI.VoltageSlope re,
               redeclare ThermoSysPro.Units.SI.VoltageSlope im)
      "Complex voltage slope";
    operator record ComplexElectricFieldStrength =
      Complex(redeclare ThermoSysPro.Units.SI.ElectricFieldStrength re,
               redeclare ThermoSysPro.Units.SI.ElectricFieldStrength im)
      "Complex electric field strength";
    operator record ComplexElectricFluxDensity =
      Complex(redeclare ThermoSysPro.Units.SI.ElectricFluxDensity re,
               redeclare ThermoSysPro.Units.SI.ElectricFluxDensity im)
      "Complex electric flux density";
    operator record ComplexElectricFlux =
      Complex(redeclare ThermoSysPro.Units.SI.ElectricFlux re,
               redeclare ThermoSysPro.Units.SI.ElectricFlux im)
      "Complex electric flux";
    operator record ComplexMagneticFieldStrength =
      Complex(redeclare ThermoSysPro.Units.SI.MagneticFieldStrength re,
               redeclare ThermoSysPro.Units.SI.MagneticFieldStrength im)
      "Complex magnetic field strength";
    operator record ComplexMagneticPotential =
      Complex(redeclare ThermoSysPro.Units.SI.MagneticPotential re,
               redeclare ThermoSysPro.Units.SI.MagneticPotential im)
      "Complex magnetic potential";
    operator record ComplexMagneticPotentialDifference =
      Complex(redeclare ThermoSysPro.Units.SI.MagneticPotentialDifference re,
               redeclare ThermoSysPro.Units.SI.MagneticPotentialDifference im)
      "Complex magnetic potential difference";
    operator record ComplexMagnetomotiveForce =
      Complex(redeclare ThermoSysPro.Units.SI.MagnetomotiveForce re,
               redeclare ThermoSysPro.Units.SI.MagnetomotiveForce im)
      "Complex magneto motive force";
    operator record ComplexMagneticFluxDensity =
      Complex(redeclare ThermoSysPro.Units.SI.MagneticFluxDensity re,
               redeclare ThermoSysPro.Units.SI.MagneticFluxDensity im)
      "Complex magnetic flux density";
    operator record ComplexMagneticFlux =
      Complex(redeclare ThermoSysPro.Units.SI.MagneticFlux re,
               redeclare ThermoSysPro.Units.SI.MagneticFlux im)
      "Complex magnetic flux";
    operator record ComplexReluctance =
      Complex(redeclare ThermoSysPro.Units.SI.Reluctance re,
               redeclare ThermoSysPro.Units.SI.Reluctance im)
                                                         "Complex reluctance"
      annotation (Documentation(info="<html>
<p>
Since magnetic material properties like reluctance and permeance often are anisotropic resp. salient,
a special operator instead of multiplication (compare: tensor vs. vector) is required.
<a href=\"modelica://Modelica.Magnetic.FundamentalWave\">Modelica.Magnetic.FundamentalWave</a> uses a
special record <a href=\"modelica://Modelica.Magnetic.FundamentalWave.Types.Salient\">Salient</a>
which is only valid in the rotor-fixed coordinate system.
</p>
<p>
<b>Note:</b> To avoid confusion, no magnetic material properties should be defined as Complex units.
</p>
</html>"));
    operator record ComplexImpedance =
      Complex(redeclare Resistance re,
               redeclare Reactance im) "Complex electrical impedance";
    operator record ComplexAdmittance =
      Complex(redeclare Conductance re,
               redeclare Susceptance im) "Complex electrical admittance";
    operator record ComplexPower =
      Complex(redeclare ActivePower re,
               redeclare ReactivePower im) "Complex electrical power";
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-66,78},{-66,-40}},
            color={64,64,64}),
          Ellipse(
            extent={{12,36},{68,-38}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,78},{-66,-40}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-66,-4},{-66,6},{-16,56},{-16,46},{-66,-4}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-46,16},{-40,22},{-2,-40},{-10,-40},{-46,16}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,26},{58,-28}},
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{68,2},{68,-46},{64,-60},{58,-68},{48,-72},{18,-72},{18,-64},
                {46,-64},{54,-60},{58,-54},{60,-46},{60,-26},{64,-20},{68,-6},{68,
                2}},
            lineColor={64,64,64},
            smooth=Smooth.Bezier,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This package provides predefined types, such as <i>Mass</i>, <i>Angle</i>, <i>Time</i>, based on the international standard on units, e.g., </p>
<p><code>   <b>type</b> Angle = Real(<b>final</b> quantity = &quot;Angle&quot;,</code></p>
<p><code>                     <b>final</b> unit     = &quot;rad&quot;,</code></p>
<p><code>                     displayUnit    = &quot;deg&quot;);</code> </p>
<p><br>Copyright &copy; 1998-2016, Modelica Association and DLR. </p>
<p>This package is copied from package Modelica.SIunits in Modelica package version 3.2.2.</p>
</html>",   revisions="<html>
<ul>
<li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
<li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
<li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Christian Schweiger:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
<li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
<li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Hubertus Tummescheit:<br/>Some chapters realized.</li>
</ul>
</html>"));
  end SI;

  package nonSI
    type Time_minute = Real(final quantity="Time", final unit="min");
    type Angle_deg =  Real (final quantity="Angle", final unit="deg") annotation (
       Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type AngularVelocity_rpm = Real (final quantity="Angular velocity", final unit="rev/min") annotation (Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type Temperature_degC =   Real (final quantity="ThermodynamicTemperature", final unit=
                                                                                        "degC")
       annotation (Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type Pressure_bar = Real (final quantity="Pressure", final unit="bar");
    type Power_kW = Real(final quantity="Power", final unit="kW");
    type Power_MW = Real(final quantity="Power", final unit="MW");
    type VolumeFlowRate_m3h = Real(final quantity="VolumeFlowRate", final unit="m3/h");
  end nonSI;

  package xSI "Additional SI units"
    type PressureLossCoefficient =Real (final quantity="Pressure loss coefficient", final unit="m-4")
                                                                annotation (
        Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type DerDensityByEnthalpy = Real (final unit="kg2/(m3.J)");
    type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final unit=
               "kg2.K/(m3.J)");
    type DerEnergyByTemperature = Real (final quantity="Derivative of the specific energy wrt. the temperature", final unit=
                                                                                                    "J/(kg.K)")
      annotation (Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final unit=
               "J/Pa");
    type DerEntropyByTemperature = Real (final quantity="DerEntropyByTemperature",
           final unit="J/K2");
    type DerEntropyByPressure = Real (final quantity="DerEntropyByPressure",
          final unit="J/(K.Pa)");
    type DerPressureByDensity = Real (final quantity="DerPressureByDensity",
          final unit="Pa.m3/kg");
    type DerPressureBySpecificVolume = Real (final quantity=
            "DerPressureBySpecificVolume", final unit="Pa.kg/m3");
    type DerPressureByTemperature = Real (final quantity=
            "DerPressureByTemperature", final unit="Pa/K");
    type DerVolumeByTemperature = Real (final quantity="DerVolumeByTemperature",
          final unit="m3/K");
    type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final unit=
               "m3/Pa");
    type Cv = Real (final quantity="Cv U.S.", final unit="m4/(s.N5)")
                                                                    annotation (
        Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type SonicConductance = Real (final quantity="Sonic conductance", final unit="m3/(s.Pa)")
                                                                annotation (
        Documentation(info="<html>
<p><b>Version 1.0</b></p>
</HTML>
"));
    type IdealGasConstant = Real (final quantity="Ideal gas constant", final unit="J/(kg.K)");
    type ViscousFriction = Real (final quantity="Viscous friction", final unit="N/(m/s)");
  end xSI;
  annotation (
    Icon(graphics={
        Text(
          extent={{-102,0},{24,-26}},
          lineColor={242,148,0},
          textString=
               "Thermo"),
        Text(
          extent={{-4,8},{68,-34}},
          lineColor={46,170,220},
          textString=
               "SysPro"),
        Polygon(
          points={{-62,2},{-58,4},{-48,8},{-32,12},{-16,14},{6,14},{26,12},{42,
              8},{52,2},{42,6},{28,10},{6,12},{-12,12},{-16,12},{-34,10},{-50,6},
              {-62,2}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-44,38},{-24,38},{-26,30},{-26,22},{-24,14},{-24,12},{-46,8},
              {-42,22},{-42,30},{-44,38}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,20},{-20,20},{-20,22},{-14,22},{-14,20},{-12,20},{-12,12},
              {-26,12},{-28,12},{-26,20}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-8,14},{-8,24},{-6,24},{-6,14},{-8,14}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,30},{-6,26}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,36},{-6,32}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,42},{-6,38}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-8,48},{-6,44}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-4,14},{-4,26},{-2,26},{-2,14},{-4,14}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,32},{-2,28}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,38},{-2,34}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,44},{-2,40}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-4,50},{-2,46}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-2,20},{8,20},{8,22},{10,22},{18,22},{18,12},{-4,14},{-2,20}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-62,2},{-58,4},{-48,8},{-36,10},{-18,12},{6,12},{26,10},{42,
              6},{52,0},{42,4},{28,8},{6,10},{-12,10},{-18,10},{-38,8},{-50,6},
              {-62,2}},
          lineColor={242,148,0},
          fillColor={242,148,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{22,12},{22,14},{22,16},{24,14},{20,18}},
          color={46,170,220},
          thickness=0.5),
        Line(
          points={{26,12},{26,14},{26,16},{28,14},{24,18}},
          color={46,170,220},
          thickness=0.5),
        Line(
          points={{30,10},{30,12},{30,14},{32,12},{28,16}},
          color={46,170,220},
          thickness=0.5),
        Polygon(
          points={{36,8},{36,30},{34,34},{36,38},{40,38},{40,8},{36,8}},
          lineColor={46,170,220},
          fillColor={46,170,220},
          fillPattern=FillPattern.Solid),
        Rectangle(extent={{-100,80},{80,-100}}, lineColor={0,0,255}),
        Line(
          points={{-100,80},{-80,100},{100,100},{100,-80},{80,-100}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{80,80},{100,100}},
          color={0,0,255},
          smooth=Smooth.None)}),
    Documentation(info="<html>
</html>"));

end Units;
