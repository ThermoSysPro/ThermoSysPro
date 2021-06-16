within ThermoSysPro.FlueGases.Volumes;
model VolumeDTh
  "Mixing flue gases volume with 1 inlets and 3 outlets and thermal input"
  parameter Modelica.SIunits.Volume V=1 "Volume";
  parameter Modelica.SIunits.AbsolutePressure P0=1e5
    "Initial fluid pressure (active if dynamic_mass_balance=true and steady_state=false)";
  parameter Modelica.SIunits.Temperature T0=400
    "Initial fluid temperature (active if steady_state=false)";
  parameter Boolean dynamic_mass_balance=false
    "true: dynamic mass balance equation - false: static mass balance equation";
  parameter Boolean dynamic_composition_balance=false
    "true: dynamic fluid composition balance equation - false: static fluid composition balance equation";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, h0)";
  parameter Modelica.SIunits.Density p_rho=0 "If > 0, fixed fluid density";
  parameter Modelica.SIunits.SpecificEnthalpy hr=2501569 "Water/steam reference specific enthalpy at 0.01°C";
  parameter Real Xco20 = 0.0  "CO2 mass fraction (active if steady_state=false)";
  parameter Real Xh2o0 = 0.05 "H20 mass fraction (active if steady_state=false)";
  parameter Real Xo20 = 0.23 "O2 mass fraction (active if steady_state=false)";
  parameter Real Xso20 = 0 "SO2 mass fraction (active if steady_state=false)";

public
  Modelica.SIunits.Temperature T(start=500) "Fluid temperature";
  Modelica.SIunits.AbsolutePressure P(start=1.e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  Modelica.SIunits.Density rho(start=1) "Fluid density";
  Modelica.SIunits.SpecificHeatCapacity cp(start=1000)
    "Fluid specific heat capacity";
  Real Xco2 "CO2 mass fraction";
  Real Xh2o "H20 mass fraction";
  Real Xo2 "O2 mass fraction";
  Real Xso2 "SO2 mass fraction";
  Real Xn2 "N2 mass fraction";
  Modelica.SIunits.MassFlowRate BQ
    "Right hand side of the mass balance equation";
  Modelica.SIunits.Power BH "Right hand side of the energybalance equation";
  Modelica.SIunits.MassFlowRate BXco2
    "Right hand side of the CO2 balance equation";
  Modelica.SIunits.MassFlowRate BXh2o
    "Right hand side of the H2O balance equation";
  Modelica.SIunits.MassFlowRate BXo2
    "Right hand side of the O2 balance equation";
  Modelica.SIunits.MassFlowRate BXso2
    "Right hand side of the SO2 balance equation";
  Modelica.SIunits.SpecificEnthalpy he(start=100000)
    "Fluid specific enthalpy at inlet";
  Modelica.SIunits.SpecificEnthalpy hs1(start=100000)
    "Fluid specific enthalpy at outlet #1";
  Modelica.SIunits.SpecificEnthalpy hs2(start=100000)
    "Fluid specific enthalpy at outlet #2";
  Modelica.SIunits.SpecificEnthalpy hs3(start=100000)
    "Fluid specific enthalpy at outlet #3";

  Connectors.FlueGasesInlet Ce
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FlueGasesOutlet Cs1
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Connectors.FlueGasesOutlet Cs2
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  Connectors.FlueGasesOutlet Cs3
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  Thermal.Connectors.ThermalPort Cth annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));

initial equation
  if steady_state then
    if dynamic_mass_balance then
      der(P) = 0;
    end if;

    der(h) = 0;
  else
    if dynamic_mass_balance then
      P = P0;
    end if;

    h = ThermoSysPro.Properties.FlueGases.FlueGases_h(P0, T0, Xco20, Xh2o0, Xo20, Xso20);
  end if;

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

equation
  assert(V > 0, "Volume non-positive");

  /* Unconnected connectors */
  if (cardinality(Ce) == 0) then
    Ce.Q = 0;
    Ce.T = 400;
    Ce.Xco2 = 0.20;
    Ce.Xh2o = 0.05;
    Ce.Xo2 = 0.25;
    Ce.Xso2 = 0;
    Ce.b = true;
  end if;

  if (cardinality(Cs1) == 0) then
    Cs1.Q = 0;
    Cs1.a = true;
  end if;

  if (cardinality(Cs2) == 0) then
    Cs2.Q = 0;
    Cs2.a = true;
  end if;

  if (cardinality(Cs3) == 0) then
    Cs3.Q = 0;
    Cs3.a = true;
  end if;

  /* Mass balance equation */
  BQ = Ce.Q - Cs1.Q - Cs2.Q - Cs3.Q;

  if dynamic_mass_balance then
    V*(ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2)*der(P)
     + ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2)*der(h - Xh2o*hr)) = BQ;
  else
    0 = BQ;
  end if;

  P = Ce.P;
  P = Cs1.P;
  P = Cs2.P;
  P = Cs3.P;

  /* Energy balance equation */
  BH = Ce.Q*(he - Ce.Xh2o*hr) - Cs1.Q*(hs1 - Cs1.Xh2o*hr) - Cs2.Q*(hs2 - Cs2.Xh2o*hr) - Cs3.Q*(hs3 - Cs3.Xh2o*hr) + Cth.W;

  if dynamic_mass_balance then
    V*(((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2) - 1)*der(P)
     + ((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2) + rho)*der(h - Xh2o*hr)) = BH;
  else
    V*rho*der(h - Xh2o*hr) = BH;
  end if;

  Cs1.T = T;
  Cs2.T = T;
  Cs3.T = T;
  Cth.T = T;

  /* Fluid composition balance equations */
  BXco2 = Ce.Xco2*Ce.Q - Cs1.Xco2*Cs1.Q - Cs2.Xco2*Cs2.Q - Cs3.Xco2*Cs3.Q;
  BXh2o = Ce.Xh2o*Ce.Q - Cs1.Xh2o*Cs1.Q - Cs2.Xh2o*Cs2.Q - Cs3.Xh2o*Cs3.Q;
  BXo2 = Ce.Xo2*Ce.Q - Cs1.Xo2*Cs1.Q - Cs2.Xo2*Cs2.Q - Cs3.Xo2*Cs3.Q;
  BXso2 = Ce.Xso2*Ce.Q - Cs1.Xso2*Cs1.Q - Cs2.Xso2*Cs2.Q - Cs3.Xso2*Cs3.Q;

  if dynamic_composition_balance then
    V*rho*der(Xco2) + Xco2*BQ = BXco2;
    V*rho*der(Xh2o) + Xh2o*BQ = BXh2o;
    V*rho*der(Xo2) + Xo2*BQ = BXo2;
    V*rho*der(Xso2) + Xso2*BQ = BXso2;
  else
    Xco2*BQ = BXco2;
    Xh2o*BQ = BXh2o;
    Xo2*BQ = BXo2;
    Xso2*BQ = BXso2;
  end if;

  Xn2 = 1 - Xco2 - Xh2o - Xo2 - Xso2;

  Cs1.Xco2 = Xco2;
  Cs1.Xh2o = Xh2o;
  Cs1.Xo2 = Xo2;
  Cs1.Xso2 = Xso2;

  Cs2.Xco2 = Xco2;
  Cs2.Xh2o = Xh2o;
  Cs2.Xo2 = Xo2;
  Cs2.Xso2 = Xso2;

  Cs3.Xco2 = Xco2;
  Cs3.Xh2o = Xh2o;
  Cs3.Xo2 = Xo2;
  Cs3.Xso2 = Xso2;

  /* Fluid thermodynamic properties */
  he = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce.T, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  hs1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs1.T, Cs1.Xco2, Cs1.Xh2o, Cs1.Xo2, Cs1.Xso2);
  hs2 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs2.T, Cs2.Xco2, Cs2.Xh2o, Cs2.Xo2, Cs2.Xso2);
  hs3 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs3.T, Cs3.Xco2, Cs3.Xh2o, Cs3.Xo2, Cs3.Xso2);

  //T = ThermoSysPro.Properties.FlueGases.FlueGases_T(P, h, Xco2, Xh2o, Xo2, Xso2);
  h = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, T, Xco2, Xh2o, Xo2, Xso2);

  cp = ThermoSysPro.Properties.FlueGases.FlueGases_cp(P, T, Xco2, Xh2o, Xo2, Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.FlueGases.FlueGases_rho(P, T, Xco2, Xh2o, Xo2, Xso2);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Backward),
        Line(points={{-60,0},{-90,0}}, color={0,0,255}),
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Line(points={{0,90},{0,60}}, color={0,0,255}),
        Line(points={{0,-60},{0,-92}}, color={0,0,255})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Backward),
        Line(points={{-60,0},{-90,0}}, color={0,0,255}),
        Line(points={{60,0},{90,0}}, color={0,0,255}),
        Line(points={{0,90},{0,60}}, color={0,0,255}),
        Line(points={{0,-60},{0,-92}}, color={0,0,255})}),
    Window(
      x=0.16,
      y=0.27,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end VolumeDTh;
