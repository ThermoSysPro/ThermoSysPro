within ThermoSysPro.WaterSteam.Junctions;
model SteamDryer "Steam dryer"
  parameter Real eta=1
    "Vapor mass fraction at outlet (0 < eta <= 1 and eta > Vapor mass fraction at the inlet)";
  parameter Integer mode_e=0
    "IF97 region at the inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Modelica.SIunits.AbsolutePressure P(start=10e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";
  Real xe(start=1.0) "Vapor mass fraction at the inlet";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Connectors.FluidInlet Cev
    annotation (Placement(transformation(extent={{-109,30},{-89,50}}, rotation=
            0)));
  Connectors.FluidOutlet Csv               annotation (Placement(transformation(
          extent={{89,30},{109,50}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat1
    annotation (Placement(transformation(extent={{-100,-98},{-80,-78}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat1
    annotation (Placement(transformation(extent={{-76,-98},{-56,-78}}, rotation=
           0)));
  Connectors.FluidOutlet Csl               annotation (Placement(transformation(
          extent={{-9,-110},{11,-90}}, rotation=0)));

equation
  assert((eta > 0) and (eta <= 1), "SteamDryer - Parameter eta should be > 0 and <= 1");

  /* Fluid pressure */
  P = Cev.P;
  P = Csv.P;
  P = Csl.P;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Cev.h_vol = h;
  Csv.h_vol = h;

  Csl.h_vol = noEvent(if (xe > 0) then lsat1.h else Cev.h);

  /* Mass flow at the vapor outlet*/
  Csv.Q = noEvent(if (xe > 0) then Cev.Q*(1-eta*(1-xe)) else 0);

  /* Mass balance equation */
  0 = Cev.Q - Csv.Q - Csl.Q;

  /* Energy balance equation */
  0 = Cev.Q*Cev.h - Csv.Q*Csv.h - Csl.Q*Csl.h;

  /* Fluid thermodynamic properties */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cev.P, Cev.h, mode_e);

  /* Vapor mass fraction at the inlet */
  xe = proe.x;

  /* Fluid thermodynamic properties at the saturation point */
  (lsat1,vsat1) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Cev.P);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-98,40},{-18,-100},{22,-100},{102,40},{-98,40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,40},{-20,-100},{20,-100},{100,40},{-100,40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</h4>
<p><b>ThermoSysPro Version 3.2 </h4>
<p>This component model is documented in Sect. 14.9 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SteamDryer;
