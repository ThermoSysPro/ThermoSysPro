within ThermoSysPro.WaterSteam.Machines;
model Compressor "Heat pump compressor "
  parameter Real pi=10.0 "Compression factor (Ps/Pe)";
  parameter Real eta=0.85 "Isentropic efficiency";
  parameter Modelica.SIunits.Power W_fric=0.0
    "Power losses due to hydrodynamic friction (percent)";

public
  Modelica.SIunits.Power W "Mechanical power delivered to the compressor";
  Modelica.SIunits.MassFlowRate Q "Mass flow rate";
  Modelica.SIunits.SpecificEnthalpy His
    "Fluid specific enthalpy after isentropic compression";
  Modelica.SIunits.AbsolutePressure Pe(start=10e5) "Inlet pressure";
  Modelica.SIunits.AbsolutePressure Ps(start=10e5) "Outlet pressure";
  Modelica.SIunits.Temperature Te "Inlet temperature";
  Modelica.SIunits.Temperature Ts "Outlet temperature";
  Real xm(start=1.0) "Average vapor mass fraction";

  Connectors.FluidInlet C1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FluidOutlet C2                annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps props
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
equation

  C1.Q = C2.Q;

  Pe = C1.P;
  Ps = C2.P;

  Q = C1.Q;

  /* No flow reversal */
  0 = C1.h - C1.h_vol;

  /* Mechnical power delivered to the compressor */
  W = Q*(C2.h - C1.h) / (1 - W_fric/100);

  /* Compression factor */
  pi = Ps/Pe;

  /* Average vapor mass fraction */
  xm = (proe.x + pros.x)/2.0;

  /* Compression efficiency */
  His - C1.h = max(xm, 0.01)*eta*(C2.h - C1.h);

  /* Fluid thermodynamic properties before the compression */
  proe = ThermoSysPro.Properties.Fluid.Ph(Pe, C1.h, 0, 2);
  Te = proe.T;

  /* Fluid thermodynamic properties after the compression */
  pros = ThermoSysPro.Properties.Fluid.Ph(Ps, C2.h, 0, 2);
  Ts = pros.T;

  /* Fluid thermodynamic properties after the identropic compression */
  props = ThermoSysPro.Properties.Fluid.Ps(Ps, proe.s, 0, 2);
  His = props.h;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid), Line(points={{-60,80},{60,20},{60,-20},
              {-60,-80}}, color={0,0,255})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid), Line(points={{-60,80},{60,20},{60,-20},
              {-60,-80}}, color={0,0,255})}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2013</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Beno&icirc;t Bride</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end Compressor;
