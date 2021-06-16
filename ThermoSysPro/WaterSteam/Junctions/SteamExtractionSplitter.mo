within ThermoSysPro.WaterSteam.Junctions;
model SteamExtractionSplitter "Splitter for steam extraction"
  parameter Real alpha = 1
    "Vapor mass fraction at the extraction/Vapor mass fraction at the inlet (0 <= alpha <= 1)";
  parameter Integer mode_e=0
    "IF97 region at the inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Real x_ex(start=0.99) "Vapor mass fraction at the extraction outlet";
  Modelica.SIunits.AbsolutePressure P(start=10e5) "Fluid pressure";
  Modelica.SIunits.SpecificEnthalpy h(start=10e5) "Fluid specific enthalpy";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  Connectors.FluidInlet Ce
    annotation (Placement(transformation(extent={{-113,-10},{-93,10}}, rotation=
           0)));
  Connectors.FluidOutlet Cs      annotation (Placement(transformation(extent={{
            93,-10},{113,10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  Connectors.FluidOutlet Cex "Extraction outlet"
                                 annotation (Placement(transformation(extent={{
            30,-110},{50,-90}}, rotation=0)));
equation

  /* Fluid pressure */
  P = Ce.P;
  P = Cs.P;
  P = Cex.P;

  /* Fluid specific enthalpy (singular if all flows = 0) */
  Ce.h_vol = h;
  Cs.h_vol = h;
  Cex.h_vol = if noEvent(x_ex < 1) then (1 - x_ex)*lsat.h + x_ex*vsat.h else h;

  /* Mass balance equation */
  0 = Ce.Q - Cs.Q - Cex.Q;

  /* Energy balance equation */
  0 = Ce.Q*Ce.h - Cs.Q*Cs.h - Cex.Q*Cex.h;

  /* Fluid thermodynamic properties at the inlet */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(P, Ce.h, mode_e);

  /* Fluid thermodynamic properties at the saturation point */
  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(P);

  /* Vapor mass fraction at the extraction outlet */
  x_ex = alpha*proe.x;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,30},{-100,-30},{-40,-30},{20,-100},{20,-100},{60,-100},
              {70,-100},{0,-30},{100,-30},{100,30},{-100,30}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-100,28},{-100,-32},{-40,-32},{20,-102},{20,-102},{60,-102},
              {70,-102},{0,-32},{100,-32},{100,28},{-100,28}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
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
end SteamExtractionSplitter;
