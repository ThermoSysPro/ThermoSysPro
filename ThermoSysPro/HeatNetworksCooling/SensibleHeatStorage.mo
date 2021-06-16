within ThermoSysPro.HeatNetworksCooling;
model SensibleHeatStorage "Sensible heat storage"
  parameter Modelica.SIunits.Area S=1
    "Exchange surface between the water and the surface";
  parameter Modelica.SIunits.Area Samb=1 "Echange surface with the ambient air";
  parameter Modelica.SIunits.Volume V=1 "Storage volume";
  parameter Modelica.SIunits.SpecificHeatCapacity Cp=4000
    "PCM specific heat capacity";
  parameter Modelica.SIunits.ThermalConductivity Lambda=20
    "PCM thermal conductivity";
  parameter Modelica.SIunits.ThermalConductivity LambdaC=0.04
    "Insulation thermal conductivity";
  parameter Modelica.SIunits.Length ep=0.1 "PCM thickness";
  parameter Modelica.SIunits.Length epC=0.1 "Insulation thickness";
  parameter Modelica.SIunits.Density rhom=2000 "PCM density";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer h=20
    "Convective heat exchange coefficient with the water";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer ha=20
    "Convective heat exchange coefficient with the ambient air";
  parameter Modelica.SIunits.Temperature Tamb "Ambient air temperature";
  parameter Modelica.SIunits.Temperature Tss0
    "Initial storage temperature (active if steady_state=false)";
  parameter Real Fremp=0.5 "Volume fraction of the solid matrix in the storage";
  parameter Boolean steady_state=false
    "true: start from steady state - false: start from Tss0";
  parameter Integer mode_e=0
    "IF97 region at the inlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_s=0
    "IF97 region at the outlet. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Modelica.SIunits.MassFlowRate Q "Water mass flow rate";
  Modelica.SIunits.Mass m "PCM mass";
  Modelica.SIunits.Temperature Tss(start=293) "Storage average temperature";
  Modelica.SIunits.Temperature T1 "Water temperature at the inlet";
  Modelica.SIunits.Temperature T2 "Water temperature at the outlet";
  Modelica.SIunits.Power Ws "Stored power";
  Modelica.SIunits.Power We "Power exchanged with the water";
  Modelica.SIunits.Power Wa "Power exchanged with the ambient air";
  Modelica.SIunits.Temperature Tm(start=293) "Average temperature";
  Modelica.SIunits.AbsolutePressure Pm(start=1.e5) "Average pressure";
  Modelica.SIunits.SpecificEnthalpy hm(start=100000)
    "Average specific enthalpy";
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Ce
                                     annotation (Placement(transformation(
          extent={{-100,20},{-80,40}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cs
                                     annotation (Placement(transformation(
          extent={{80,-40},{100,-20}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    "Propriétés de l'eau"
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
initial equation
  if steady_state then
    der(Tss) = 0;
  else
    Tss = Tss0;
  end if;

equation

  /* Unconnected connectors */
  if (cardinality(Ce) == 0) then
    Ce.Q = 0;
    Ce.h = 1.e5;
    Ce.b = true;
  end if;
  if (cardinality(Cs) == 0) then
    Cs.Q = 0;
    Cs.h = 1.e5;
    Cs.a = true;
  end if;

  Ce.P = Cs.P;
  Ce.Q = Cs.Q;

  Q = Ce.Q;

  /* Flow reversal */
  0 = if (Q > 0) then hm - Ce.h_vol else hm - Cs.h_vol;

  /* Water average specific enthalpy */
  Pm = Ce.P;
  Tm = (T1 + T2)/2;
  hm = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(Pm, Tm, 0);

  /* Water temperature at the inlet and at the outlet */
  proe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ce.P, Ce.h, mode_e);
  pros = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Cs.P, Cs.h, mode_s);

  T1 = proe.T;
  T2 = pros.T;

  /* Storage differential equation */
  Ws = m*Cp*der(Tss);
  Ws = We + Wa;

  /* Power exchanged with the water */
  We = 1/(ep/Lambda + 1/h)*S*(Tm - Tss);
  We = Q*(Ce.h - Cs.h);

  /* Power exchanged with the ambient air */
  Wa = 1/(epC/LambdaC + 1/ha)*Samb*(Tamb - Tss);

  /* PCM mass */
  m = rhom*V*Fremp;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-80,50},{-40,100},{40,100},{80,52},{80,-50},{40,-100},{-40,
              -100},{-80,-48},{-80,50}},
          lineColor={0,0,0},
          fillColor={120,255,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          textString=
               "S")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{-80,50},{-40,100},{40,100},{80,52},{80,-50},{40,-100},{-40,
              -100},{-80,-48},{-80,50}},
          lineColor={0,0,0},
          fillColor={120,255,0},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          textString=
               "S")}),
    Window(
      x=0.16,
      y=0.03,
      width=0.81,
      height=0.9),
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
end SensibleHeatStorage;
