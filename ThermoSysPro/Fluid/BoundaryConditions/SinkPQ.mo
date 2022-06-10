within ThermoSysPro.Fluid.BoundaryConditions;
model SinkPQ "MultiFluids sink with fixed pressure and mass flow rate"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Units.SI.AbsolutePressure P0=100000
    "Fluid pressure (active if IPressure connector is not connected)";
  parameter Units.SI.MassFlowRate Q0=100
    "Mass flow (active if IMassFlow connector is not connected)";
  parameter Units.SI.Temperature T0=290
    "Source temperature (active if option_temperature=true)"
    annotation (Evaluate=true, Dialog(enable=option_temperature));
  parameter Units.SI.SpecificEnthalpy h0=100000
    "Source specific enthalpy (active if option_temperature=false)"
    annotation (Evaluate=true, Dialog(enable=not option_temperature));
  parameter Boolean option_temperature=false
    "true:temperature fixed - false:specific enthalpy fixed";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter IF97Region region=IF97Region.All_regions "IF97 regions (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.MassFlowRate Q "Fluid mass flow rate";
  Units.SI.AbsolutePressure P "Fluid pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  Units.SI.Temperature T "Fluid temperature";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";
  Real Xco2(start=0.01)
    "CO2 mass fraction of the fluid crossing the boundary of the control volume";
  Real Xh2o(start=0.05)
    "H2O mass fraction of the fluid crossing the boundary of the control volume";
  Real Xo2(start=0.2)
    "O2 mass fraction of the fluid crossing the boundary of the control volume";
  Real Xso2(start=0)
    "SO2 mass fraction of the fluid crossing the boundary of the control volume";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IMassFlow
    "Fixed mass flow rate"
    annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IPressure
    "Fixed pressure"
    annotation (Placement(transformation(
        origin={50,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  InstrumentationAndControl.Connectors.InputReal              ISpecificEnthalpyOrTemperature
    "Fixed specific enthalpy or temperature according to option_temperature"
    annotation (Placement(transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
equation

  C.Q = Q;
  P = C.P;

  C.h_vol_2 = h;
  C.diff_res_2 = 0;
  C.diff_on_2 = diffusion;

  ftype = C.ftype;

  Xco2 = C.Xco2;
  Xh2o = C.Xh2o;
  Xo2 = C.Xo2;
  Xso2 = C.Xso2;

  /* Mass flow */
  if (cardinality(IMassFlow) == 0) then
    IMassFlow.signal = Q0;
  end if;

  Q = IMassFlow.signal;

  /* Pressure */
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

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{-40,0},{-54,10}}),
        Line(points={{-54,-10},{-40,0}}),
        Text(extent={{40,30},{60,10}}, textString=
                                           "P"),
        Text(extent={{12,60},{32,40}}, textString=
                                           "Q"),
        Text(extent={{10,-40},{30,-60}}, textString=
                                           "h"),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,0}),
        Text(
          extent={{-20,20},{22,-24}},
          lineColor={0,0,255},
          textString=
               "P Q")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({255,255,0}, fill_color_static)),
        Text(extent={{12,60},{32,40}}, textString=
                                           "Q"),
        Text(extent={{40,32},{60,12}}, textString=
                                           "P"),
        Line(points={{-90,0},{-40,0},{-54,10}}),
        Line(points={{-54,-10},{-40,0}}),
        Text(
          extent={{-20,22},{22,-24}},
          lineColor={0,0,255},
          textString=
               "P Q"),
        Text(extent={{12,-42},{42,-62}},   textString=
                                             "h / T")}),
    Window(
      x=0.23,
      y=0.15,
      width=0.81,
      height=0.71),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SinkPQ;
