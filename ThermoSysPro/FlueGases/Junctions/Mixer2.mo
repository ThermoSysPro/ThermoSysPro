within ThermoSysPro.FlueGases.Junctions;
model Mixer2 "Flue gases mixer with two inlets"
  parameter Modelica.SIunits.SpecificEnthalpy hr=2501569 "Water/steam reference specific enthalpy at 0.01°C";

public
  Real alpha1 "Extraction coefficient for inlet 1 (<=1)";
  Modelica.SIunits.AbsolutePressure P(start=1e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Real Xco2 "CO2 mass fraction";
  Real Xh2o "H20 mass fraction";
  Real Xo2 "O2 mass fraction";
  Real Xso2 "SO2 mass fraction";
  Real Xn2 "N2 mass fraction";
  Modelica.SIunits.SpecificEnthalpy he1(start=100000)
    "Fluid specific enthalpy at inlet #1";
  Modelica.SIunits.SpecificEnthalpy he2(start=100000)
    "Fluid specific enthalpy at inlet #2";
  Modelica.SIunits.SpecificEnthalpy hs(start=100000)
    "Fluid specific enthalpy at the outlet";

public
  Connectors.FlueGasesInlet Ce2
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}},
          rotation=0)));
  Connectors.FlueGasesOutlet Cs            annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
public
  Connectors.FlueGasesInlet Ce1
    annotation (Placement(transformation(extent={{-50,90},{-30,110}}, rotation=
            0)));
  InstrumentationAndControl.Connectors.InputReal Ialpha1
    "Extraction coefficient for inlet 1 (<=1)"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}}, rotation=0)));
  InstrumentationAndControl.Connectors.OutputReal Oalpha1
    annotation (Placement(transformation(extent={{-20,50},{0,70}}, rotation=0)));
equation

  if (cardinality(Ialpha1) == 0) then
    Ialpha1.signal = 0.5;
  end if;

  /* Fluid pressure */
  P = Ce1.P;
  P = Ce2.P;
  P = Cs.P;

  /* Fluid temperature (singular if all flows = 0) */
  Cs.T = T;

  /* Fluid composition */
  Cs.Xco2 = Xco2;
  Cs.Xh2o = Xh2o;
  Cs.Xo2 = Xo2;
  Cs.Xso2 = Xso2;

  Xn2 = 1 - Xco2 - Xh2o - Xo2 - Xso2;

  /* Mass balance equation */
  0 = Ce1.Q + Ce2.Q - Cs.Q;

  /* Energy balance equation */
  //0 = Ce1.Q*he1 + Ce2.Q*he2 - Cs.Q*hs;
  0 = Ce1.Q*(he1 - Ce1.Xh2o*hr) + Ce2.Q*(he2 - Ce2.Xh2o*hr) - Cs.Q*(hs - Cs.Xh2o*hr);

  /* Fluid composition balance equations */
  0 = Ce1.Xco2*Ce1.Q + Ce2.Xco2*Ce2.Q - Cs.Xco2*Cs.Q;
  0 = Ce1.Xh2o*Ce1.Q + Ce2.Xh2o*Ce2.Q - Cs.Xh2o*Cs.Q;
  0 = Ce1.Xo2*Ce1.Q + Ce2.Xo2*Ce2.Q - Cs.Xo2*Cs.Q;
  0 = Ce1.Xso2*Ce1.Q + Ce2.Xso2*Ce2.Q - Cs.Xso2*Cs.Q;

  /* Mass flow at outlet 1 */
  if (cardinality(Ialpha1) <> 0) then
    Ce1.Q = Ialpha1.signal*Cs.Q;
  end if;

  alpha1 = Ce1.Q/Cs.Q;
  Oalpha1.signal = alpha1;

  /* Fluid thermodynamic properties */
  he1 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce1.T, Ce1.Xco2, Ce1.Xh2o, Ce1.Xo2, Ce1.Xso2);
  he2 = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Ce2.T, Ce2.Xco2, Ce2.Xh2o, Ce2.Xo2, Ce2.Xso2);
  hs = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, Cs.T, Cs.Xco2, Cs.Xh2o, Cs.Xo2, Cs.Xso2);

  h = ThermoSysPro.Properties.FlueGases.FlueGases_h(P, T, Xco2, Xh2o, Xo2, Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,-100},{-20,-100},{-20,-20},{100,-20},{100,20},{-20,20},{
              -20,100},{-60,100},{-60,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(extent={{-60,80},{-20,40}}, textString=
                                     "1"),
        Text(extent={{-60,-40},{-20,-80}}, textString=
                             "2")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,-100},{-20,-100},{-20,-20},{100,-20},{100,20},{-20,20},{
              -20,100},{-60,100},{-60,-100}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(extent={{-60,80},{-20,40}}, textString=
                                     "1"),
        Text(extent={{-60,-40},{-20,-80}}, textString=
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
</html>"));
end Mixer2;
