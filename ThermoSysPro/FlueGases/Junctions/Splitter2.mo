within ThermoSysPro.FlueGases.Junctions;
model Splitter2 "Flue gases splitter with two outlets"
  parameter Modelica.SIunits.SpecificEnthalpy hr=2501569 "Water/steam reference specific enthalpy at 0.01°C";

public
  Real alpha1 "Extraction coefficient for outlet 1 (<=1)";
  Modelica.SIunits.AbsolutePressure P(start=1e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=1e5) "Fluid specific enthalpy";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Real Xco2 "CO2 mass fraction";
  Real Xh2o "H20 mass fraction";
  Real Xo2 "O2 mass fraction";
  Real Xso2 "SO2 mass fraction";
  Real Xn2 "N2 mass fraction";
  Modelica.SIunits.SpecificEnthalpy he(start=100000)
    "Fluid specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy hs1(start=100000)
    "Fluid specific enthalpy at outlet #1";
  Modelica.SIunits.SpecificEnthalpy hs2(start=100000)
    "Fluid specific enthalpy at outlet #2";

public
  Connectors.FlueGasesInlet Ce
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FlueGasesOutlet Cs1
    annotation (Placement(transformation(extent={{30,90},{50,110}}, rotation=0)));
  Connectors.FlueGasesOutlet Cs2
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}, rotation=
            0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha1
    "Extraction coefficient for outlet 1 (<=1)"
    annotation (Placement(transformation(extent={{0,50},{20,70}}, rotation=0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha1
    annotation (Placement(transformation(extent={{60,50},{80,70}}, rotation=0)));
equation

  if (cardinality(Ialpha1) == 0) then
    Ialpha1.signal = 0.5;
  end if;

  /* Fluid pressure */
  P = Ce.P;
  P = Cs1.P;
  P = Cs2.P;

  /* Fluid temperature (singular if all flows = 0) */
  Cs1.T = T;
  Cs2.T = T;

  /* Fluid composition */
  Cs1.Xco2 = Xco2;
  Cs1.Xh2o = Xh2o;
  Cs1.Xo2 = Xo2;
  Cs1.Xso2 = Xso2;

  Cs2.Xco2 = Xco2;
  Cs2.Xh2o = Xh2o;
  Cs2.Xo2 = Xo2;
  Cs2.Xso2 = Xso2;

  Xn2 = 1 - Xco2 - Xh2o - Xo2 - Xso2;

  /* Mass balance equation */
  0 = Ce.Q - Cs1.Q - Cs2.Q;

  /* Energy balance equation */
  0 = Ce.Q*(he - Ce.Xh2o*hr) - Cs1.Q*(hs1 - Cs1.Xh2o*hr) - Cs2.Q*(hs2 - Cs2.Xh2o*hr);

  /* Fluid composition balance equations */
  0 = Ce.Xco2*Ce.Q - Cs1.Xco2*Cs1.Q - Cs2.Xco2*Cs2.Q;
  0 = Ce.Xh2o*Ce.Q - Cs1.Xh2o*Cs1.Q - Cs2.Xh2o*Cs2.Q;
  0 = Ce.Xo2*Ce.Q - Cs1.Xo2*Cs1.Q - Cs2.Xo2*Cs2.Q;
  0 = Ce.Xso2*Ce.Q - Cs1.Xso2*Cs1.Q - Cs2.Xso2*Cs2.Q;

  /* Mass flow at outlet 1 */
  if (cardinality(Ialpha1) <> 0) then
    Cs1.Q = Ialpha1.signal*Ce.Q;
  end if;

  alpha1 = Cs1.Q/Ce.Q;
  Oalpha1.signal = alpha1;

  /* Fluid thermodynamic properties */
  he = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce.T, Ce.Xco2, Ce.Xh2o, Ce.Xo2, Ce.Xso2);
  hs1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs1.T, Cs1.Xco2, Cs1.Xh2o, Cs1.Xo2, Cs1.Xso2);
  hs2 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs2.T, Cs2.Xco2, Cs2.Xh2o, Cs2.Xo2, Cs2.Xso2);

  h = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, T, Xco2, Xh2o, Xo2, Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{60,100},{60,-100},{20,-100},{20,-20},{-100,-20},{-100,20},{
              20,20},{20,100},{60,100}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(extent={{20,80},{60,40}}, textString=
                                     "1"),
        Text(extent={{20,-40},{60,-80}}, textString=
                             "2")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{60,100},{60,-100},{20,-100},{20,-20},{-100,-20},{-100,20},{
              20,20},{20,100},{60,100}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(extent={{20,80},{60,40}}, textString=
                                     "1"),
        Text(extent={{20,-40},{60,-80}}, textString=
                             "2")}),
    Window(
      x=0.33,
      y=0.09,
      width=0.71,
      height=0.88),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"),
    DymolaStoredErrors);
end Splitter2;
