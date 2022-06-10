within ThermoSysPro.Fluid.Volumes;
model VolumeITh "Mixing volume with 4 inlets, 4 outlets and 1 thermal input"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Units.SI.Volume V=1
    "Volume (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean dynamic_mass_balance=false
    "true: dynamic mass balance equation - false: static mass balance equation (active if the fluid is compressible and if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=isCompressible and dynamic_energy_balance));
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, h0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.AbsolutePressure P0=1e5
    "Initial fluid pressure (active if the fluid is compressible, and if dynamic_energy_balance=true and dynamic_mass_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=isCompressible and
          dynamic_energy_balance and dynamic_mass_balance and not steady_state));
  parameter Units.SI.SpecificEnthalpy h0=1e5
    "Initial fluid specific enthalpy (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter Boolean dynamic_composition_balance=false
    "<html>true: dynamic fluid composition balance equation <br>false: static fluid composition balance equation (active for flue gases)</html>" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.FlueGases), tab="Fluid", group="Fluid properties"));

  parameter ThermoSysPro.Units.SI.MassFraction Xco20=0.0
    "Initial CO2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xh2o0=0.05
    "Initial H20 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xo20=0.23
    "Initial O2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xso20=0
    "Initial SO2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));

protected
  constant Units.SI.SpecificEnthalpy hr=2501569
    "Water/steam reference specific enthalpy at 0.01°C";
  parameter Boolean flue_gases=(ftype == FluidType.FlueGases) "Flue gases";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start=1.e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  Units.SI.Density rho(start=998) "Fluid density";
  Units.SI.MassFlowRate BQ "Right hand side of the mass balance equation";
  Units.SI.Power BH "Right hand side of the energy balance equation";
  Units.SI.DerDensityByPressure ddph
    "density derivative wrt pressure at constant specific enthalpy";
  Units.SI.DerDensityByEnthalpy ddhp
    "density derivative wrt specific enthalpy at constant pressure";
  FluidType fluids[9] "Fluids mixing in volume";
  Units.SI.MassFlowRate BXco2 "Right hand side of the CO2 balance equation";
  Units.SI.MassFlowRate BXh2o "Right hand side of the H2O balance equation";
  Units.SI.MassFlowRate BXo2 "Right hand side of the O2 balance equation";
  Units.SI.MassFlowRate BXso2 "Right hand side of the SO2 balance equation";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je1 "Thermal power diffusion from inlet e1";
  Units.SI.Power Je2 "Thermal power diffusion from inlet e2";
  Units.SI.Power Je3 "Thermal power diffusion from inlet e3";
  Units.SI.Power Je4 "Thermal power diffusion from inlet e4";
  Units.SI.Power Js1 "Thermal power diffusion from outlet s1";
  Units.SI.Power Js2 "Thermal power diffusion from outlet s2";
  Units.SI.Power Js3 "Thermal power diffusion from outlet s3";
  Units.SI.Power Js4 "Thermal power diffusion from outlet s4";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e1 "Diffusion conductance for inlet e1";
  Units.SI.MassFlowRate gamma_e2 "Diffusion conductance for inlet e2";
  Units.SI.MassFlowRate gamma_e3 "Diffusion conductance for inlet e3";
  Units.SI.MassFlowRate gamma_e4 "Diffusion conductance for inlet e4";
  Units.SI.MassFlowRate gamma_s1 "Diffusion conductance for outlet s1";
  Units.SI.MassFlowRate gamma_s2 "Diffusion conductance for outlet s2";
  Units.SI.MassFlowRate gamma_s3 "Diffusion conductance for outlet s3";
  Units.SI.MassFlowRate gamma_s4 "Diffusion conductance for outlet s4";
  Real re1 "Value of r(Q/gamma) for inlet e1";
  Real re2 "Value of r(Q/gamma) for inlet e2";
  Real re3 "Value of r(Q/gamma) for inlet e3";
  Real re4 "Value of r(Q/gamma) for inlet e4";
  Real rs1 "Value of r(Q/gamma) for outlet s1";
  Real rs2 "Value of r(Q/gamma) for outlet s2";
  Real rs3 "Value of r(Q/gamma) for outlet s3";
  Real rs4 "Value of r(Q/gamma) for outlet s4";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce1 annotation (Placement(
        transformation(extent={{-110,70},{-90,90}},  rotation=0),
        iconTransformation(extent={{-110,70},{-90,90}})));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce2 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}},
                                                   rotation=0),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs1 annotation (
      Placement(transformation(extent={{90,70},{110,90}},  rotation=0),
        iconTransformation(extent={{90,70},{110,90}})));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs2 annotation (
      Placement(transformation(extent={{90,-10},{110,10}},   rotation=0),
        iconTransformation(extent={{90,-10},{110,10}})));
  Interfaces.Connectors.FluidInlet Ce3 annotation (Placement(transformation(
          extent={{-110,-90},{-90,-70}}), iconTransformation(extent={{-110,-90},
            {-90,-70}})));
  Interfaces.Connectors.FluidInlet Ce4 annotation (Placement(transformation(
          extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{
            10,-90}})));
  Interfaces.Connectors.FluidOutlet Cs3 annotation (Placement(transformation(
          extent={{90,-90},{110,-70}}), iconTransformation(extent={{90,-90},{110,
            -70}})));
  Interfaces.Connectors.FluidOutlet Cs4 annotation (Placement(transformation(
          extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,90},{10,110}})));
  Thermal.Connectors.ThermalPort              Cth
                           annotation (Placement(transformation(extent={{-10,
            -10},{10,10}}, rotation=0)));
initial equation
  if dynamic_energy_balance and dynamic_mass_balance then
    if steady_state then
      der(P) = 0;
    else
      P = P0;
    end if;
  end if;

  if dynamic_energy_balance then
    if steady_state then
      der(h) = 0;
    else
      h = h0;
    end if;
  end if;

  if flue_gases then
    if dynamic_composition_balance then
      if steady_state then
        der(Xco2) = 0;
        der(Xh2o) = 0;
        der(Xo2) = 0;
        der(Xso2) = 0;
      else
        Xco2 = Xco20;
        Xh2o = Xh2o0;
        Xo2 = Xo20;
        Xso2 = Xso20;
      end if;
    end if;
  end if;

equation
  /* Check that volume is positive */
  if dynamic_energy_balance or dynamic_mass_balance then
    assert(V > 0, "Volume non-positive");
  end if;

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ce1.ftype;
  fluids[3] = Ce2.ftype;
  fluids[4] = Ce3.ftype;
  fluids[5] = Ce4.ftype;
  fluids[6] = Cs1.ftype;
  fluids[7] = Cs2.ftype;
  fluids[8] = Cs3.ftype;
  fluids[9] = Cs4.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "VolumeITh: fluids mixing in volume are not compatible with each other");

  /* Unconnected connectors */
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.h = 1.e5;
    Ce1.h_vol_1 = 1.e5;
    Ce1.diff_res_1 = 0;
    Ce1.diff_on_1 = false;
    Ce1.ftype = ftype;
    Ce1.Xco2 = 0;
    Ce1.Xh2o = 0;
    Ce1.Xo2 = 0;
    Ce1.Xso2 = 0;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.h = 1.e5;
    Ce2.h_vol_1 = 1.e5;
    Ce2.diff_res_1 = 0;
    Ce2.diff_on_1 = false;
    Ce2.ftype = ftype;
    Ce2.Xco2 = 0;
    Ce2.Xh2o = 0;
    Ce2.Xo2 = 0;
    Ce2.Xso2 = 0;
  end if;

  if (cardinality(Ce3) == 0) then
    Ce3.Q = 0;
    Ce3.h = 1.e5;
    Ce3.h_vol_1 = 1.e5;
    Ce3.diff_res_1 = 0;
    Ce3.diff_on_1 = false;
    Ce3.ftype = ftype;
    Ce3.Xco2 = 0;
    Ce3.Xh2o = 0;
    Ce3.Xo2 = 0;
    Ce3.Xso2 = 0;
  end if;

  if (cardinality(Ce4) == 0) then
    Ce4.Q = 0;
    Ce4.h = 1.e5;
    Ce4.h_vol_1 = 1.e5;
    Ce4.diff_res_1 = 0;
    Ce4.diff_on_1 = false;
    Ce4.ftype = ftype;
    Ce4.Xco2 = 0;
    Ce4.Xh2o = 0;
    Ce4.Xo2 = 0;
    Ce4.Xso2 = 0;
  end if;

  if (cardinality(Cs1) == 0) then
    Cs1.Q = 0;
    Cs1.h_vol_2 = 1.e5;
    Cs1.diff_res_2 = 0;
    Cs1.diff_on_2 = false;
  end if;

  if (cardinality(Cs2) == 0) then
    Cs2.Q = 0;
    Cs2.h_vol_2 = 1.e5;
    Cs2.diff_res_2 = 0;
    Cs2.diff_on_2 = false;
  end if;

  if (cardinality(Cs3) == 0) then
    Cs3.Q = 0;
    Cs3.h_vol_2 = 1.e5;
    Cs3.diff_res_2 = 0;
    Cs3.diff_on_2 = false;
  end if;

  if (cardinality(Cs4) == 0) then
    Cs4.Q = 0;
    Cs4.h_vol_2 = 1.e5;
    Cs4.diff_res_2 = 0;
    Cs4.diff_on_2 = false;
  end if;

  /* Mass balance equation */
  BQ = Ce1.Q + Ce2.Q + Ce3.Q + Ce4.Q - Cs1.Q - Cs2.Q - Cs3.Q - Cs4.Q;

  if isCompressible and dynamic_energy_balance and dynamic_mass_balance then
    V*(ddph*der(P) + ddhp*der(h - Xh2o*hr)) = BQ;
  else
    0 = BQ;
  end if;

  P = Ce1.P;
  P = Ce2.P;
  P = Ce3.P;
  P = Ce4.P;
  P = Cs1.P;
  P = Cs2.P;
  P = Cs3.P;
  P = Cs4.P;

  /* Energy balance equation */
  BH = Ce1.Q*(Ce1.h - Ce1.Xh2o*hr) + Ce2.Q*(Ce2.h - Ce2.Xh2o*hr) + Ce3.Q*(Ce3.h - Ce3.Xh2o*hr) + Ce4.Q*(Ce4.h - Ce4.Xh2o*hr) - Cs1.Q*(Cs1.h - Cs1.Xh2o*hr) - Cs2.Q*(Cs2.h - Cs2.Xh2o*hr) - Cs3.Q*(Cs3.h - Cs3.Xh2o*hr) - Cs4.Q*(Cs4.h - Cs4.Xh2o*hr) + Cth.W + J;

  if dynamic_energy_balance then
    if dynamic_mass_balance then
      V*(((h - Xh2o*hr)*ddph - 1)*der(P) + ((h - Xh2o*hr)*ddhp + rho)*der(h - Xh2o*hr)) = BH;
    else
      V*rho*der(h - Xh2o*hr) = BH;
    end if;
  else
    BH = 0;
  end if;

  Ce1.h_vol_2 = h;
  Ce2.h_vol_2 = h;
  Ce3.h_vol_2 = h;
  Ce4.h_vol_2 = h;
  Cs1.h_vol_1 = h;
  Cs2.h_vol_1 = h;
  Cs3.h_vol_1 = h;
  Cs4.h_vol_1 = h;

  /* Fluid composition balance equations */
  BXco2 = Ce1.Xco2*Ce1.Q + Ce2.Xco2*Ce2.Q + Ce3.Xco2*Ce3.Q + Ce4.Xco2*Ce4.Q - Cs1.Xco2*Cs1.Q - Cs2.Xco2*Cs2.Q - Cs3.Xco2*Cs3.Q - Cs4.Xco2*Cs4.Q;
  BXh2o = Ce1.Xh2o*Ce1.Q + Ce2.Xh2o*Ce2.Q + Ce3.Xh2o*Ce3.Q + Ce4.Xh2o*Ce4.Q - Cs1.Xh2o*Cs1.Q - Cs2.Xh2o*Cs2.Q - Cs3.Xh2o*Cs3.Q - Cs4.Xh2o*Cs4.Q;
  BXo2 = Ce1.Xo2*Ce1.Q + Ce2.Xo2*Ce2.Q + Ce3.Xo2*Ce3.Q + Ce4.Xo2*Ce4.Q - Cs1.Xo2*Cs1.Q - Cs2.Xo2*Cs2.Q - Cs3.Xo2*Cs3.Q - Cs4.Xo2*Cs4.Q;
  BXso2 = Ce1.Xso2*Ce1.Q + Ce2.Xso2*Ce2.Q + Ce3.Xso2*Ce3.Q + Ce4.Xso2*Ce4.Q - Cs1.Xso2*Cs1.Q - Cs2.Xso2*Cs2.Q - Cs3.Xso2*Cs3.Q - Cs4.Xso2*Cs4.Q;

  if flue_gases then
    if dynamic_composition_balance then
      V*rho*der(Xco2) + Xco2*BQ = BXco2;
      V*rho*der(Xh2o) + Xh2o*BQ = BXh2o;
      V*rho*der(Xo2)  + Xo2*BQ  = BXo2;
      V*rho*der(Xso2) + Xso2*BQ = BXso2;
    else
      Xco2*BQ = BXco2;
      Xh2o*BQ = BXh2o;
      Xo2*BQ  = BXo2;
      Xso2*BQ = BXso2;
    end if;
  else
    Xco2 = 0;
    Xh2o = 0;
    Xo2 = 0;
    Xso2 = 0;
  end if;

  Cs1.ftype = ftype;
  Cs2.ftype = ftype;
  Cs3.ftype = ftype;
  Cs4.ftype = ftype;

  Cs1.Xco2 = Xco2;
  Cs1.Xh2o = Xh2o;
  Cs1.Xo2  = Xo2;
  Cs1.Xso2 = Xso2;

  Cs2.Xco2 = Xco2;
  Cs2.Xh2o = Xh2o;
  Cs2.Xo2  = Xo2;
  Cs2.Xso2 = Xso2;

  Cs3.Xco2 = Xco2;
  Cs3.Xh2o = Xh2o;
  Cs3.Xo2  = Xo2;
  Cs3.Xso2 = Xso2;

  Cs4.Xco2 = Xco2;
  Cs4.Xh2o = Xh2o;
  Cs4.Xo2  = Xo2;
  Cs4.Xso2 = Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Cs1.h = ThermoSysPro.Functions.SmoothCond(Cs1.Q/gamma_s1, Cs1.h_vol_1, Cs1.h_vol_2, 1);
    Cs2.h = ThermoSysPro.Functions.SmoothCond(Cs2.Q/gamma_s2, Cs2.h_vol_1, Cs2.h_vol_2, 1);
    Cs3.h = ThermoSysPro.Functions.SmoothCond(Cs3.Q/gamma_s3, Cs3.h_vol_1, Cs3.h_vol_2, 1);
    Cs4.h = ThermoSysPro.Functions.SmoothCond(Cs4.Q/gamma_s4, Cs4.h_vol_1, Cs4.h_vol_2, 1);
  else
    Cs1.h = if (Cs1.Q > 0) then Cs1.h_vol_1 else Cs1.h_vol_2;
    Cs2.h = if (Cs2.Q > 0) then Cs2.h_vol_1 else Cs2.h_vol_2;
    Cs3.h = if (Cs3.Q > 0) then Cs3.h_vol_1 else Cs3.h_vol_2;
    Cs4.h = if (Cs4.Q > 0) then Cs4.h_vol_1 else Cs4.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    re1 = if Ce1.diff_on_1 then exp(-0.033*(Ce1.Q*Ce1.diff_res_1)^2) else 0;
    re2 = if Ce2.diff_on_1 then exp(-0.033*(Ce2.Q*Ce2.diff_res_1)^2) else 0;
    re3 = if Ce3.diff_on_1 then exp(-0.033*(Ce3.Q*Ce3.diff_res_1)^2) else 0;
    re4 = if Ce4.diff_on_1 then exp(-0.033*(Ce4.Q*Ce4.diff_res_1)^2) else 0;
    rs1 = if Cs1.diff_on_2 then exp(-0.033*(Cs1.Q*Cs1.diff_res_2)^2) else 0;
    rs2 = if Cs2.diff_on_2 then exp(-0.033*(Cs2.Q*Cs2.diff_res_2)^2) else 0;
    rs3 = if Cs3.diff_on_2 then exp(-0.033*(Cs3.Q*Cs3.diff_res_2)^2) else 0;
    rs4 = if Cs4.diff_on_2 then exp(-0.033*(Cs4.Q*Cs4.diff_res_2)^2) else 0;

    gamma_e1 = if Ce1.diff_on_1 then 1/Ce1.diff_res_1 else gamma0;
    gamma_e2 = if Ce2.diff_on_1 then 1/Ce2.diff_res_1 else gamma0;
    gamma_e3 = if Ce3.diff_on_1 then 1/Ce3.diff_res_1 else gamma0;
    gamma_e4 = if Ce4.diff_on_1 then 1/Ce4.diff_res_1 else gamma0;
    gamma_s1 = if Cs1.diff_on_2 then 1/Cs1.diff_res_2 else gamma0;
    gamma_s2 = if Cs2.diff_on_2 then 1/Cs2.diff_res_2 else gamma0;
    gamma_s3 = if Cs3.diff_on_2 then 1/Cs3.diff_res_2 else gamma0;
    gamma_s4 = if Cs4.diff_on_2 then 1/Cs4.diff_res_2 else gamma0;

    Je1 = if Ce1.diff_on_1 then re1*gamma_e1*(Ce1.h_vol_1 - Ce1.h_vol_2) else 0;
    Je2 = if Ce2.diff_on_1 then re2*gamma_e2*(Ce2.h_vol_1 - Ce2.h_vol_2) else 0;
    Je3 = if Ce3.diff_on_1 then re3*gamma_e3*(Ce3.h_vol_1 - Ce3.h_vol_2) else 0;
    Je4 = if Ce4.diff_on_1 then re4*gamma_e4*(Ce4.h_vol_1 - Ce4.h_vol_2) else 0;
    Js1 =  if Cs1.diff_on_2 then rs1*gamma_s1*(Cs1.h_vol_2 - Cs1.h_vol_1) else 0;
    Js2 = if Cs2.diff_on_2 then rs2*gamma_s2*(Cs2.h_vol_2 - Cs2.h_vol_1) else 0;
    Js3 = if Cs3.diff_on_2 then rs3*gamma_s3*(Cs3.h_vol_2 - Cs3.h_vol_1) else 0;
    Js4 = if Cs4.diff_on_2 then rs4*gamma_s4*(Cs4.h_vol_2 - Cs4.h_vol_1) else 0;
  else
    re1 = 0;
    re2 = 0;
    re3 = 0;
    re4 = 0;
    rs1 = 0;
    rs2 = 0;
    rs3 = 0;
    rs4 = 0;

    gamma_e1 = gamma0;
    gamma_e2 = gamma0;
    gamma_e3 = gamma0;
    gamma_e4 = gamma0;
    gamma_s1 = gamma0;
    gamma_s2 = gamma0;
    gamma_s3 = gamma0;
    gamma_s4 = gamma0;

    Je1 = 0;
    Je2 = 0;
    Je3 = 0;
    Je4 = 0;
    Js1 = 0;
    Js2 = 0;
    Js3 = 0;
    Js4 = 0;
  end if;

  J = Je1 + Je2 + Je3 + Je4 + Js1 + Js2 + Js3 + Js4;

  Ce1.diff_res_2 = 0;
  Ce2.diff_res_2 = 0;
  Ce3.diff_res_2 = 0;
  Ce4.diff_res_2 = 0;
  Cs1.diff_res_1 = 0;
  Cs2.diff_res_1 = 0;
  Cs3.diff_res_1 = 0;
  Cs4.diff_res_1 = 0;

  Ce1.diff_on_2 = diffusion;
  Ce2.diff_on_2 = diffusion;
  Ce3.diff_on_2 = diffusion;
  Ce4.diff_on_2 = diffusion;
  Cs1.diff_on_1 = diffusion;
  Cs2.diff_on_1 = diffusion;
  Cs3.diff_on_1 = diffusion;
  Cs4.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  if isCompressible and dynamic_mass_balance then
    ddph = ThermoSysPro.Properties.Fluid.Density_derp_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    ddhp = ThermoSysPro.Properties.Fluid.Density_derh_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  else
    ddph = 0;
    ddhp = 0;
  end if;

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);

  Cth.T = T;

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{90,0}}, color={0,0,255}),
        Line(points={{0,90},{0,-100}}, color={0,0,255},
          thickness=0.2),
        Ellipse(
          extent={{-40,80},{40,0}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255}),
        Ellipse(
          extent={{-40,0},{40,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255}),
        Line(points={{-90,80},{-60,80},{-40,46}}),
        Line(points={{-90,-80},{-60,-80},{-40,-46}}),
        Line(points={{92,80},{60,80},{40,46}}),
        Line(points={{92,-80},{60,-80},{40,-46}})}),
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{0,90},{0,-100}},
          color={28,108,200},
          thickness=0.2),
        Line(
          points={{-90,0},{90,0}},
          color={28,108,200},
          thickness=0.2),
        Ellipse(
          extent={{-40,80},{40,0}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid),
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Ellipse(
          extent={{-40,0},{40,-80}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid),
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.VerticalCylinder
          else FillPattern.Solid),
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static)),
        Line(points={{-90,80},{-60,80},{-40,46}}),
        Line(points={{92,80},{60,80},{40,46}}),
        Line(points={{-90,-80},{-60,-80},{-40,-46}}),
        Line(points={{92,-80},{60,-80},{40,-46}})}),
    Window(
      x=0.14,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 14.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end VolumeITh;
