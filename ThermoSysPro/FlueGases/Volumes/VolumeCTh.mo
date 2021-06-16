within ThermoSysPro.FlueGases.Volumes;
model VolumeCTh
  "Mixing flue gases volume with 3 inlets and 1 outlet and thermal input"
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
    "Fluid spécific heat capacity";
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
  Modelica.SIunits.SpecificEnthalpy he1(start=100000)
    "Fluid specific enthalpy at inlet #1";
  Modelica.SIunits.SpecificEnthalpy he2(start=100000)
    "Fluid specific enthalpy at inlet #2";
  Modelica.SIunits.SpecificEnthalpy he3(start=100000)
    "Fluid specific enthalpy at inlet #3";
  Modelica.SIunits.SpecificEnthalpy hs(start=100000)
    "Fluid specific enthalpy at the outlet";

  Connectors.FlueGasesInlet Ce1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FlueGasesOutlet Cs
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  Thermal.Connectors.ThermalPort Cth annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));
  Connectors.FlueGasesInlet Ce2
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Connectors.FlueGasesInlet Ce3
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));

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
  if (cardinality(Ce1) == 0) then
    Ce1.Q = 0;
    Ce1.T = 400;
    Ce1.Xco2 = 0.20;
    Ce1.Xh2o = 0.05;
    Ce1.Xo2 = 0.25;
    Ce1.Xso2 = 0;
    Ce1.b = true;
  end if;

  if (cardinality(Ce2) == 0) then
    Ce2.Q = 0;
    Ce2.T = 400;
    Ce2.Xco2 = 0.20;
    Ce2.Xh2o = 0.05;
    Ce2.Xo2 = 0.25;
    Ce2.Xso2 = 0;
    Ce2.b = true;
  end if;

  if (cardinality(Ce3) == 0) then
    Ce3.Q = 0;
    Ce3.T = 400;
    Ce3.Xco2 = 0.20;
    Ce3.Xh2o = 0.05;
    Ce3.Xo2 = 0.25;
    Ce3.Xso2 = 0;
    Ce3.b = true;
  end if;

  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.a = true;
  end if;

  /* Mass balance equation */
  BQ = Ce1.Q + Ce2.Q  + Ce3.Q - Cs.Q;

  if dynamic_mass_balance then
    V*(ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2)*der(P)
     + ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2)*der(h - Xh2o*hr)) = BQ;
  else
    0 = BQ;
  end if;

  P = Ce1.P;
  P = Ce2.P;
  P = Ce3.P;
  P = Cs.P;

  /* Energy balance equation */
  BH = Ce1.Q*(he1 - Ce1.Xh2o*hr) + Ce2.Q*(he2 - Ce2.Xh2o*hr) + Ce3.Q*(he3 - Ce3.Xh2o*hr) - Cs.Q*(hs - Cs.Xh2o*hr) + Cth.W;

  if dynamic_mass_balance then
    V*(((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(P, T, Xco2, Xh2o, Xo2, Xso2) - 1)*der(P)
     + ((h - Xh2o*hr)*ThermoSysPro.Properties.FlueGases.FlueGases_drhodh(P, T, Xco2, Xh2o, Xo2, Xso2) + rho)*der(h - Xh2o*hr)) = BH;
  else
    V*rho*der(h - Xh2o*hr) = BH;
  end if;

  Cs.T = T;
  Cth.T = T;

  /* Fluid composition balance equations */
  BXco2 = Ce1.Xco2*Ce1.Q + Ce2.Xco2*Ce2.Q + Ce3.Xco2*Ce3.Q - Cs.Xco2*Cs.Q;
  BXh2o = Ce1.Xh2o*Ce1.Q + Ce2.Xh2o*Ce2.Q + Ce3.Xh2o*Ce3.Q - Cs.Xh2o*Cs.Q;
  BXo2 = Ce1.Xo2*Ce1.Q + Ce2.Xo2*Ce2.Q + Ce3.Xo2*Ce3.Q - Cs.Xo2*Cs.Q;
  BXso2 = Ce1.Xso2*Ce1.Q + Ce2.Xso2*Ce2.Q + Ce3.Xso2*Ce3.Q - Cs.Xso2*Cs.Q;

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

  Cs.Xco2 = Xco2;
  Cs.Xh2o = Xh2o;
  Cs.Xo2 = Xo2;
  Cs.Xso2 = Xso2;

  /* Fluid thermodynamic properties */
  he1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce1.T, Ce1.Xco2, Ce1.Xh2o, Ce1.Xo2, Ce1.Xso2);
  he2 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce2.T, Ce2.Xco2, Ce2.Xh2o, Ce2.Xo2, Ce2.Xso2);
  he3 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce3.T, Ce3.Xco2, Ce3.Xh2o, Ce3.Xo2, Ce3.Xso2);
  hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs.T, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

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
end VolumeCTh;
