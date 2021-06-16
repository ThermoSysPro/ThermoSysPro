within ThermoSysPro.WaterSteam.Boilers;
model ElectricBoiler "Electric boiler"
  parameter Modelica.SIunits.Power W=1e6 "Electrical power";
  parameter Real eta = 100 "Boiler efficiency (percent)";
  parameter ThermoSysPro.Units.DifferentialPressure deltaP=0 "Pressure loss";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Modelica.SIunits.Temperature Te(start=300) "Inlet temperature";
  Modelica.SIunits.Temperature Ts(start=500) "Outlet temperature";
  Modelica.SIunits.MassFlowRate Q(start=100) "Mass flow";
  Modelica.SIunits.SpecificEnthalpy deltaH
    "Specific enthalpy variation between the outlet and the inlet";

public
  Connectors.FluidInlet Ce
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  Connectors.FluidOutlet Cs
                          annotation (Placement(transformation(extent={{90,-8},
            {110,12}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
equation

  Ce.P - Cs.P = deltaP;

  Ce.Q = Cs.Q;
  Q = Ce.Q;

  Cs.h - Ce.h = deltaH;

  /* Flow reversal */
  0 = if (Q > 0) then Ce.h - Ce.h_vol else Cs.h - Cs.h_vol;

  /* Specific enthalpy variation between the outlet and the inlet */
  W*eta/100 = Q*deltaH;

  /* Fluid thermodynamic properties */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ce.P, Ce.h, mode);
  pros = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cs.P, Cs.h, mode);

  Te = proe.T;
  Ts = pros.T;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{22,54},{-30,2},{30,2},{-24,-52},{-28,-56}},
          color={255,0,0},
          thickness=0.5),
        Polygon(
          points={{-26,-50},{-22,-54},{-28,-56},{-26,-50}},
          lineColor={255,0,0},
          lineThickness=0.5,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-26,-48},{-20,-54},{-28,-56},{-26,-48}},
          lineColor={255,0,0},
          lineThickness=1,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{22,54},{-30,2},{30,2},{-24,-52},{-28,-56}},
          color={255,0,0},
          thickness=1)}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end ElectricBoiler;
