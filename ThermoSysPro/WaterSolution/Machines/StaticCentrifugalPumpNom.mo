within ThermoSysPro.WaterSolution.Machines;
model StaticCentrifugalPumpNom
  "Static centrigugal pump with nominal operating point"
  parameter Modelica.SIunits.MassFlowRate Qnom=1 "Nominal mass flow";
  parameter ThermoSysPro.Units.DifferentialPressure DPnom=1e5
    "Nominal pressure increase";
  parameter Real A=0.15 "x^2 coef. of the pump characteristics (A>0)";
  parameter Real B=0.35 "x coef. of the pump characteristics (B>0)";
  parameter Real eta=0.9 "Hydraulic efficiency";

public
  ThermoSysPro.Units.DifferentialPressure deltaP(start=1e5)
    "Pressure difference between the outlet and the inlet";
  Modelica.SIunits.SpecificEnthalpy He(start = 1e3)
    "Fluid specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hs(start = 1e3)
    "Fluid specific enthalpy at the outlet";
  Modelica.SIunits.Power W(start=1e6) "Mechanical power of the pump";

  Connectors.WaterSolutionInlet Ce
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}}, rotation=
           0)));
  Connectors.WaterSolutionOutlet Cs
    annotation (Placement(transformation(extent={{80,40},{100,60}}, rotation=0)));
equation

  Cs.Xh2o = Ce.Xh2o;
  Cs.Q = Ce.Q;

  deltaP = Cs.P - Ce.P;

  /* Fluid specific enthalpy at the inlet */
  He = ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Ce.T,Ce.Xh2o);

  /* Fluid specific enthalpy at the outlet */
  Hs = He + W/Ce.Q;

  /* Fluid temperature at the outlet */
  Cs.T = ThermoSysPro.Properties.WaterSolution.Temperature_hX(Hs,Cs.Xh2o);

  /* Fluid pressure at the outlet - The density is supposed to be constant */
  (deltaP/DPnom - 1) = - A * (Ce.Q/Qnom - 1) * abs(Ce.Q/Qnom - 1) - B * (Ce.Q/Qnom - 1);

  /* Pump mechanical power */
  W = Ce.Q*deltaP/eta;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{64,-18},{42,-64},{-22,-80},{-68,-60},{-90,-20},{-90,20},{-70,
              60},{-30,80},{90,80},{90,20},{54,20},{64,-18}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{64,-18},{42,-64},{-22,-80},{-68,-60},{-90,-20},{-90,20},{-70,
              60},{-30,80},{90,80},{90,20},{54,20},{64,-18}},
          lineColor={0,0,0},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.09,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Beno&icirc;t Bride </li>
</ul>
</html>"));
end StaticCentrifugalPumpNom;
