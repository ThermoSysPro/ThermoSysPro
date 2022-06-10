within ThermoSysPro.Fluid.HeatExchangers;
model NTUWaterHeater "NTU water heater"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real lambdaE=0 "Pressure loss coefficient on the water side";
  parameter Units.SI.Area SCondDes=3000
    "Exchange surface for the condensation and deheating";
  parameter Units.SI.CoefficientOfHeatTransfer KCond=1
    "Heat transfer coefficient for the condensation";
  parameter Units.SI.Area SPurge=0 "Drain surface - if > 0: with drain cooling";
  parameter Units.SI.CoefficientOfHeatTransfer KPurge=1
    "Heat transfer coefficient for the drain cooling";
  parameter Units.SI.MassFlowRate gamma_diff_e=1e-4
    "Diffusion conductance for the water side (active if diffusion=true in neighbouring volumes)";
  parameter Boolean continuous_flow_reversal=false "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region_eeF=IF97Region.All_regions "IF97 region at the inlet of the water side (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_seF=IF97Region.All_regions "IF97 region at the outlet of the water side (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_evC=IF97Region.All_regions "IF97 region at the inlet of the vapor side (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_mF=IF97Region.All_regions "IF97 region in the drain (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_epC=IF97Region.All_regions "IF97 region at the inlet of the drain (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_spC=IF97Region.All_regions "IF97 region at the outlet of the drain (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_flash=IF97Region.All_regions "IF97 region in the flash zone of the drain (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer fluid=Integer(ftype) "Fluid number";
  parameter Integer mode_eeF=Integer(region_eeF) "IF97 region at the inlet of the water side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_seF=Integer(region_seF) "IF97 region at the outlet of the water side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_evC=Integer(region_evC) "IF97 region at the inlet of the vapor side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_mF=Integer(region_mF) "IF97 region in the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_epC=Integer(region_epC) "IF97 region at the inlet of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_spC=Integer(region_spC) "IF97 region at the outlet of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_flash=Integer(region_flash) "IF97 region in the flash zone of the drain. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Real eps=1.e-3 "Small number for pressure loss equation";

public
  Units.SI.AbsolutePressure P(start=10e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Units.SI.SpecificEnthalpy HsateC(start=300e3, min=0)
    "Saturation specific enthalpy of the water at the pressure of the vapor inlet";
  Units.SI.SpecificEnthalpy HsatvC(start=2500e3, min=0)
    "Saturation specific enthalpy of the vapor at the pressure of the vapor inlet";
  Units.SI.Area SDes(start=0) "Heat exchange surface for deheating";
  Units.SI.SpecificEnthalpy HeiF(start=200e3)
    "Fluid specific enthalpy after drain cooling";
  Units.SI.SpecificEnthalpy HDesF(start=200e3)
    "Fluid specific enthalpy after deheating";
  Units.SI.Temperature TeiF(start=400, min=0)
    "Fluid temperature after drain cooling";
  Units.SI.Temperature TsatC(start=400, min=0) "Saturation temperature";
  Units.SI.Power W(start=1) "Total heat power transfered to the cooling water";
  Units.SI.Power Wdes(start=1) "Energy transfer during deheating";
  Units.SI.Power Wcond(start=1) "Energy transfer during condensation";
  Units.SI.Power Wflash(start=1)
    "Energy transfer during partial vaporisation in the drain";
  Units.SI.Power Wpurge(start=1) "Energy transfer during drain cooling";
  Units.SI.SpecificEnthalpy Hep(start=3e5)
    "Mixing specific enthalpy of the drain and the condensate";
  Units.SI.Density rho(start=1e3, min=0) "Average water density";
  FluidType fluids[4] "Fluids mixing in volume";
  FluidType ftype_e "Fluid type for the water side";
  Integer fluid_e=Integer(ftype_e) "Fluid number for the water side";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Jep "Thermal power diffusion from the inlet of the drain";
  Units.SI.Power Jev "Thermal power diffusion from the inlet of the vapor side";
  Units.SI.Power Jsp "Thermal power diffusion from the outlet of the drain";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_ep
    "Diffusion conductance for the inlet of the drain";
  Units.SI.MassFlowRate gamma_ev
    "Diffusion conductance for the inlet of the vapor side";
  Units.SI.MassFlowRate gamma_sp
    "Diffusion conductance for the outlet of the drain";
  Real rep "Value of r(Q/gamma) for the inlet of the drain";
  Real rev "Value of r(Q/gamma) for inlet for the inlet of the vapor side";
  Real rsp "Value of r(Q/gamma) for the outlet of the drain";

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proeeF
    "Water inlet fluid properties (4F)"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proseF
    "Water outlet fluid properties (1F)"
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prospC
    "Drain outlet fluid properties (4C)"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Interfaces.Connectors.FluidInlet Ee "Water inlet"
    annotation (Placement(transformation(extent={{-90,-10},{-110,10}}, rotation=
           0)));
  Interfaces.Connectors.FluidOutlet Se "Water outlet" annotation (Placement(
        transformation(extent={{110,-10},{90,10}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ep "Drain inlet"
    annotation (Placement(transformation(extent={{-50,24},{-70,44}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sp "Drain outlet" annotation (Placement(
        transformation(extent={{-50,-43},{-70,-23}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ev "Vapor inlet"
    annotation (Placement(transformation(extent={{70,24},{50,44}}, rotation=0),
        iconTransformation(extent={{70,24},{50,44}})));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proevC
    "Vapor inlet fluid properties (1C)"
    annotation (Placement(transformation(extent={{-70,80},{-50,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsatC
    "Saturation conditions for the liquid phase"
    annotation (Placement(transformation(extent={{10,40},{30,60}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsatC
    "Saturation conditions for the vapor phase"
    annotation (Placement(transformation(extent={{-30,40},{-10,60}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promeF
    "Average water fluid properties (between 4F and 3F)"
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesmC
    "Deheating average fluid properties (between 1C and 2C)"
    annotation (Placement(transformation(extent={{50,80},{70,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promcF
    "Average deheating fluid properties (between 3F and 2F)"
    annotation (Placement(transformation(extent={{50,-100},{70,-80}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesF
    "Deheating inlet fluid properties (2F)"
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prodesmF
    "Average deheating fluid properties (between 2F and 1F)"
    annotation (Placement(transformation(extent={{20,-100},{40,-80}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prosp
    "Drain outlet fluid properties before cooling (near 3C)"
    annotation (Placement(transformation(extent={{-40,80},{-20,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prompC
    "Average fluid properties in the drain (between 3C and 4C)"
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph prompF
    "Average water fluid properties (between 4F and 3F)"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proecF
    "Water fluid properties (3F)"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph flashepC
    "Flash fluid properties (near 4C)"
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
equation

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  fluids[2] = Ev.ftype;
  fluids[3] = Ep.ftype;
  fluids[4] = Sp.ftype;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids), "NTUWaterHeater:  fluids mixing in water heater volume are not compatible with each other");

  /* Check that the fluid type is water/steam for the water side */
  assert((ftype_e == FluidType.WaterSteam) or (ftype_e == FluidType.WaterSteamSimple), "NTUWaterHeater: the fluid type for the water side must be water/steam");

  /* Unconnected connectors */
  if cardinality(Ep) == 0 then
    Ep.Q = 0;
    Ep.h = 1.e5;
    Ep.h_vol_1 = 1.e5;
    Ep.diff_res_1 = 0;
    Ep.diff_on_1 = false;
    Ep.ftype = ftype;
    Ep.Xco2 = 0;
    Ep.Xh2o = 0;
    Ep.Xo2 = 0;
    Ep.Xso2 = 0;
  end if;

  // Cooling pipe
  //-------------

  Ee.Q = Se.Q;

  Ee.h_vol_1 = Se.h_vol_1;
  Ee.h_vol_2 = Se.h_vol_2;

  Se.diff_on_1 = Ee.diff_on_1;
  Ee.diff_on_2 = Se.diff_on_2;

  Se.diff_res_1 = Ee.diff_res_1 + 1/gamma_diff_e;
  Ee.diff_res_2 = Se.diff_res_2 + 1/gamma_diff_e;

  Ee.ftype = Se.ftype;

  Ee.Xco2 = Se.Xco2;
  Ee.Xh2o = Se.Xh2o;
  Ee.Xo2  = Se.Xo2;
  Ee.Xso2 = Se.Xso2;

  ftype_e = Ee.ftype;

  /* Pressure loss equation in the water pipe */
  Ee.P - Se.P = lambdaE*ThermoSysPro.Functions.ThermoSquare(Ee.Q, eps)/rho;

  /* Heating power released to the cooling pipe */
  W = Se.Q*(Se.h - Ee.h);

  // Water/steam cavity
  //-------------------

  /* Fluid pressure */
  P = Ep.P;
  P = Ev.P;
  P = Sp.P;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Ep.h_vol_2 = h;
  Ev.h_vol_2 = h;
  Sp.h_vol_1 = h;

  /* Mass balance equation */
  0 = Ep.Q + Ev.Q - Sp.Q;

  /* Energy balance equations */

  // Deheating zone
  //---------------

  /* Heat power, fluid specific enthalpy on the cold side and deheating surface */
  /* If deheating is present */
  if (HsatvC < Ev.h) then
    0 = Ev.Q*(Ev.h - HsatvC) - Ee.Q*(Se.h - HDesF) + J/3;
    Wdes = Ee.Q*(Se.h - HDesF);
    Wdes = noEvent(min(Ev.Q*prodesmC.cp, Ee.Q*prodesmF.cp)*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Ev.Q, Ee.Q, prodesmC.cp, prodesmF.cp, KCond/2, SDes, 1)*(proevC.T - prodesF.T));
  /* If deheating is absent */
  else
    Wdes = 1e-9;
    HDesF = Se.h;
    SDes = 1e-9;
  end if;

  // Condensation zone
  //------------------

  /* Heat power, fluid specific enthalpy at the outlet of the condensation zone and vapor mass flow rate at the inlet */
  if noEvent(Ev.h < HsatvC) then
    0 = Ev.Q*(Ev.h - HsateC) + Wflash - Ee.Q*(HDesF - HeiF) + J/3;
  else
    0 = Ev.Q*(HsatvC - HsateC) + Wflash - Ee.Q*(HDesF - HeiF) + J/3;
  end if;

  Wcond = Ee.Q*(HDesF - HeiF);
  Wcond = Ee.Q*promcF.cp*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Ev.Q, Ee.Q, 1.e20, promcF.cp, KCond, (SCondDes - SDes), 0.5)*(TsatC - TeiF);

  // Flash zone
  //-----------

  /* Heat power in case of partial vaporization in the drain */
  if (flashepC.x > 0) then
    Wflash = Ep.Q*(Ep.h - HsateC);
  else
    Wflash = 0;
  end if;

  /* Condition for partial vaporisation in the drain (flash) */
  if (flashepC.x > 0) then
    Hep = HsateC;
  else
    Sp.Q*Hep = HsateC*Ev.Q + Ep.h*Ep.Q;
  end if;

  // Drain cooling zone
  //-------------------

  /* Power, fluid specific enthalpy at the cold outlet and temperature of the drain outlet */
  if noEvent(SPurge > 0) then
    0 = Sp.Q*(Hep - Sp.h) - Ee.Q*(HeiF - Ee.h) + J/3;
    Wpurge = Ee.Q*(HeiF - Ee.h);
    Wpurge = noEvent(min(Sp.Q*prompC.cp, Ee.Q*prompF.cp)*ThermoSysPro.Correlations.Thermal.WBHeatExchangerEfficiency(Sp.Q, Ee.Q, prompC.cp, prompF.cp, KPurge, SPurge, 0)*(prosp.T - proeeF.T));
    TeiF = proecF.T;
  else
    HeiF = Ee.h;
    Wpurge = 0;
    Hep = Sp.h;
    TeiF = proeeF.T;
  end if;

  /* Fluid composition balance equations */
  0 = Ep.Xco2*Ep.Q + Ev.Xco2*Ev.Q - Sp.Xco2*Sp.Q;
  0 = Ep.Xh2o*Ep.Q + Ev.Xh2o*Ev.Q - Sp.Xh2o*Sp.Q;
  0 = Ep.Xo2*Ep.Q + Ev.Xo2*Ev.Q - Sp.Xo2*Sp.Q;
  0 = Ep.Xso2*Ep.Q + Ev.Xso2*Ev.Q - Sp.Xso2*Sp.Q;

  Sp.ftype = ftype;

  Sp.Xco2 = Xco2;
  Sp.Xh2o = Xh2o;
  Sp.Xo2  = Xo2;
  Sp.Xso2 = Xso2;

  /* Flow reversal */
  if continuous_flow_reversal then
    Sp.h = ThermoSysPro.Functions.SmoothCond(Sp.Q/gamma_sp, Sp.h_vol_1, Sp.h_vol_2, 1);
  else
    Sp.h = if (Sp.Q > 0) then Sp.h_vol_1 else Sp.h_vol_2;
  end if;

  /* Diffusion power */
  if diffusion then
    rep = if Ep.diff_on_1 then exp(-0.033*(Ep.Q*Ep.diff_res_1)^2) else 0;
    rev = if Ev.diff_on_1 then exp(-0.033*(Ev.Q*Ev.diff_res_1)^2) else 0;
    rsp = if Sp.diff_on_2 then exp(-0.033*(Sp.Q*Sp.diff_res_2)^2) else 0;

    gamma_ep = if Ep.diff_on_1 then 1/Ep.diff_res_1 else gamma0;
    gamma_ev = if Ev.diff_on_1 then 1/Ev.diff_res_1 else gamma0;
    gamma_sp = if Sp.diff_on_2 then 1/Sp.diff_res_2 else gamma0;

    Jep = if Ep.diff_on_1 then rep*gamma_ep*(Ep.h_vol_1 - Ep.h_vol_2) else 0;
    Jev = if Ev.diff_on_1 then rev*gamma_ev*(Ev.h_vol_1 - Ev.h_vol_2) else 0;
    Jsp = if Sp.diff_on_2 then rsp*gamma_sp*(Sp.h_vol_2 - Sp.h_vol_1) else 0;
  else
    rep = 0;
    rev = 0;
    rsp = 0;

    gamma_ep = gamma0;
    gamma_ev = gamma0;
    gamma_sp = gamma0;

    Jep = 0;
    Jev = 0;
    Jsp = 0;
  end if;

  J = Jep + Jev + Jsp;

  Ep.diff_res_2 = 0;
  Ev.diff_res_2 = 0;
  Sp.diff_res_1 = 0;

  Ep.diff_on_2 = diffusion;
  Ev.diff_on_2 = diffusion;
  Sp.diff_on_1 = diffusion;

  /* Fluid thermodynamic properties */
  proeeF = ThermoSysPro.Properties.Fluid.Ph(Ee.P, Ee.h, mode_eeF, fluid_e);
  proseF = ThermoSysPro.Properties.Fluid.Ph(Se.P, Se.h, mode_seF, fluid_e);
  promeF = ThermoSysPro.Properties.Fluid.Ph((Ee.P + Se.P)/2,(Ee.h + Se.h)/2, mode_eeF, fluid_e);
  proevC = ThermoSysPro.Properties.Fluid.Ph(Ev.P, Ev.h, mode_evC, fluid);
  prospC = ThermoSysPro.Properties.Fluid.Ph(Sp.P, Sp.h, mode_spC, fluid);
  prosp = ThermoSysPro.Properties.Fluid.Ph(Ev.P, Hep, mode_spC, fluid);
  prodesF = ThermoSysPro.Properties.Fluid.Ph(Se.P, HDesF, mode_seF, fluid_e);
  prompC = ThermoSysPro.Properties.Fluid.Ph(Ev.P, (Hep + Sp.h)/2, mode_spC, fluid);
  prodesmC = ThermoSysPro.Properties.Fluid.Ph(Ev.P, (vsatC.h + Ev.h)/2, mode_evC, fluid);
  prompF = ThermoSysPro.Properties.Fluid.Ph(Ee.P, (Ee.h + HeiF)/2, mode_eeF, fluid_e);
  promcF = ThermoSysPro.Properties.Fluid.Ph((Ee.P + Se.P)/2, (HeiF + HDesF)/2, mode_mF, fluid_e);
  prodesmF = ThermoSysPro.Properties.Fluid.Ph(Se.P, (HDesF + Se.h)/2, mode_seF, fluid_e);
  proecF = ThermoSysPro.Properties.Fluid.Ph(Ee.P, HeiF, mode_eeF, fluid_e);
  flashepC = ThermoSysPro.Properties.Fluid.Ph(Ev.P, Ep.h, mode_flash, fluid);

  /* Fluid density */
  rho = promeF.d;

  /* Saturation point at the vapor inlet pressure */
  (lsatC, vsatC) = ThermoSysPro.Properties.Fluid.Water_sat_P(Ev.P, fluid);

  TsatC  = lsatC.T;
  HsateC = lsatC.h;
  HsatvC = vsatC.h;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.01), graphics={
        Ellipse(
          extent={{-100,-30},{-36,32}},
          lineColor={0,0,0},
          lineThickness=0,
          fillColor= DynamicSelect({85,170,255},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-30},{102,32}},
          lineColor={0,0,0},
          lineThickness=0,
          fillColor= DynamicSelect({85,170,255},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,32},{74,-30}},
          lineColor={0,0,0},
          fillColor=DynamicSelect({85,170,255},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(
          points={{-70,32},{74,32},{74,32}},
          color={0,0,0}),
        Line(
          points={{-70,-30},{74,-30},{74,-30}},
          color={0,0,0},
          thickness=0),
        Line(
          points={{74,32},{74,-30}},
          color={0,0,0},
          thickness=0),
        Line(
          points={{74,0},{102,0}},
          color={0,0,0},
          thickness=0),
        Rectangle(
          extent={{-58,-14},{74,-16}},
          lineColor={0,0,0},
          lineThickness=0,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,16},{74,14}},
          lineColor={0,0,0},
          lineThickness=0,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-78,-16},{-44,16}},
          lineColor={0,0,0},
          lineThickness=0,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-76,-14},{-48,14}},
          lineColor={0,0,0},
          lineThickness=0,
          fillColor= DynamicSelect({85,170,255},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,14},{72,-14}},
          lineColor={0,0,0},
          fillColor= DynamicSelect({85,170,255},
          if diffusion then fill_color_singular
          else fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(
          points={{-96,-12},{74,-12}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{-92,-18},{74,-18}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Line(
          points={{-86,-24},{74,-24}},
          color={0,0,127},
          pattern=LinePattern.Dash),
        Text(
          extent={{-112,22},{-90,12}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Water inlet"),
        Text(
          extent={{88,22},{112,8}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Water outlet"),
        Text(
          extent={{48,58},{72,44}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Steam inlet"),
        Text(
          extent={{-72,56},{-50,44}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Drain inlet"),
        Text(
          extent={{-70,-46},{-46,-58}},
          lineColor={0,0,0},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Drain outlet")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.01), graphics={
        Line(
          points={{-40,-40},{20,-24}},
          color={0,0,255},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-40,-20},{-20,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-20,0},{20,0}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{60,0},{80,20}},
          color={255,0,0},
          thickness=0.5),
        Text(
          extent={{76,28},{84,20}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "1C"),
        Text(
          extent={{56,10},{64,2}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "2C"),
        Text(
          extent={{-24,8},{-16,0}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "3C"),
        Text(
          extent={{-44,-10},{-36,-18}},
          lineColor={255,0,0},
          lineThickness=0,
          textString=
               "4C"),
        Text(
          extent={{76,-10},{82,-16}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "1F"),
        Text(
          extent={{58,-18},{64,-24}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "2F"),
        Text(
          extent={{-22,-38},{-16,-44}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "3F"),
        Text(
          extent={{-42,-44},{-36,-50}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "4F"),
        Line(
          points={{20,0},{60,0}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.Filled,Arrow.None}),
        Line(
          points={{20,-24},{80,-8}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-40,8},{-24,2}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "Drain"),
        Text(
          extent={{66,-18},{82,-24}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "Deheating"),
        Text(
          extent={{-36,-18},{-16,-24}},
          lineColor={0,0,0},
          lineThickness=0,
          textString=
               "Drain cooling"),
        Line(
          points={{-26,4},{-22,0}},
          color={0,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-40,-20},{-40,-40}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{-20,0},{-20,-34}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{60,0},{60,-14}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Line(
          points={{80,20},{80,-8}},
          color={0,0,0},
          pattern=LinePattern.Dot),
        Text(
          extent={{48,50},{74,44}},
          lineColor={0,0,255},
          textString=
               "Vapor inlet"),
        Text(
          extent={{-74,52},{-48,46}},
          lineColor={0,0,255},
          textString=
               "Drain inlet"),
        Text(
          extent={{-74,-16},{-48,-22}},
          lineColor={0,0,255},
          textString=
               "Drain outlet"),
        Text(
          extent={{-114,18},{-88,12}},
          lineColor={0,0,255},
          textString=
               "Water inlet"),
        Text(
          extent={{86,18},{112,12}},
          lineColor={0,0,255},
          textString=
               "Water outlet"),
        Text(
          extent={{12,-10},{34,-18}},
          lineColor={0,0,255},
          lineThickness=0,
          textString=
               "Condensation"),
        Text(
          extent={{-26,-4},{-12,-8}},
          lineColor={0,0,255},
          lineThickness=0,
          textString=
               "Flash")}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.5.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end NTUWaterHeater;
