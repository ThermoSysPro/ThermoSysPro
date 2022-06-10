within ThermoSysPro.Fluid.BoundaryConditions;
model SourceP "Multi-fluid source with fixed pressure"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.AbsolutePressure P0=300000 "Source pressure";
  parameter Units.SI.Temperature T0=290
    "Source temperature (active if option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=option_temperature));
  parameter Units.SI.SpecificEnthalpy h0=100000
    "Source specific enthalpy (active if option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not option_temperature));
  parameter Boolean option_temperature=true
    "true: temperature is fixed - false: specific enthalpy is fixed";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

  parameter ThermoSysPro.Units.SI.MassFraction Xco2=0.01 "CO2 mass fraction"
    annotation (Evaluate=true, Dialog(
      enable=(ftype == FluidType.FlueGases),
      tab="Fluid",
      group="Composition values (active for flue gases only)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xh2o=0.05 "H2O mass fraction"
    annotation (Evaluate=true, Dialog(
      enable=(ftype == FluidType.FlueGases),
      tab="Fluid",
      group="Composition values (active for flue gases only)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xo2=0.22 "O2 mass fraction"
    annotation (Evaluate=true, Dialog(
      enable=(ftype == FluidType.FlueGases),
      tab="Fluid",
      group="Composition values (active for flue gases only)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xso2=0 "SO2 mass fraction"
    annotation (Evaluate=true, Dialog(
      enable=(ftype == FluidType.FlueGases),
      tab="Fluid",
      group="Composition values (active for flue gases only)"));

protected
  parameter Boolean flue_gases=(ftype == FluidType.FlueGases) "Flue gases";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.MassFlowRate Q "Fluid mass flow rate";
  Units.SI.AbsolutePressure P "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  Units.SI.Temperature T(start=300) "Fluid temperature";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IPressure
    "Fixed pressure"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));
  InstrumentationAndControl.Connectors.InputReal              ISpecificEnthalpyOrTemperature
    "Fixed specific enthalpy or temperature according to option_temperature"
    annotation (Placement(transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation

  Q = C.Q;
  C.P = P;

  C.h_vol_1 = h;
  C.diff_res_1 = 0;
  C.diff_on_1 = diffusion;

  C.ftype = ftype;

  if flue_gases then
    C.Xco2 = Xco2;
    C.Xh2o = Xh2o;
    C.Xo2 = Xo2;
    C.Xso2 = Xso2;
  else
    C.Xco2 = 0;
    C.Xh2o = 0;
    C.Xo2 = 0;
    C.Xso2 = 0;
  end if;

  if (cardinality(IPressure) == 0) then
    IPressure.signal = P0;
  end if;

  P = IPressure.signal;

  /* Specific enthalpy or temperature */
  if (cardinality(ISpecificEnthalpyOrTemperature) == 0) then
    if option_temperature then
      ISpecificEnthalpyOrTemperature.signal = T0;
    else
      ISpecificEnthalpyOrTemperature.signal = h0;
    end if;
  end if;

  if option_temperature then
    T = ISpecificEnthalpyOrTemperature.signal;
    h = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(P, T, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  else
    h = ISpecificEnthalpyOrTemperature.signal;
    T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  end if;

  /* Flow reversal */
  if continuous_flow_reversal then
    C.h = ThermoSysPro.Functions.SmoothCond(C.Q*C.diff_res_2, C.h_vol_1, C.h_vol_2, 1);
  else
    C.h = if (C.Q > 0) then C.h_vol_1 else C.h_vol_2;
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Text(extent={{-58,30},{-40,10}}, textString="P"),
        Text(extent={{-40,-40},{-10,-60}}, textString="h / T"),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0}),
        Text(extent={{-94,28},{98,-28}}, textString="P")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({127,255,0}, fill_color_singular)),
        Line(points={{90,0},{72,-10}}),
        Text(extent={{-94,28},{98,-28}}, textString="P"),
        Text(extent={{-58,30},{-40,10}}, textString="P"),
        Text(extent={{-40,-40},{-10,-60}}, textString="h / T")}),
    Window(
      x=0.45,
      y=0.01,
      width=0.35,
      height=0.49),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end SourceP;
