within ThermoSysPro.MultiFluids.HeatExchangers;
model SimpleEvaporatorWaterSteamFlueGases
  "Simple water/steam - flue gases evaporator"
  parameter Real Kdpf=10 "Flue gases pressure drop coefficient";
  parameter Real Kdpe=10 "Water/steam pressure drop coefficient";
  parameter Integer mode=0
    "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Modelica.SIunits.AbsolutePressure Pef(start=3e5)
    "Flue gases pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Psf(start=2.5e5)
    "Flue gases pressure at the outlet";
  Modelica.SIunits.Temperature Tef(start=600)
    "Flue gases temperature at the inlet";
  Modelica.SIunits.Temperature Tsf(start=400)
    "Flue gases temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hsf(start=3e5)
    "Flue gases specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hef(start=6e5)
    "Flue gases specific enthalpy at the inlet";
  Modelica.SIunits.MassFlowRate Qf(start=10) "Flue gases mass flow rate";
  Modelica.SIunits.AbsolutePressure Pee(start=2e6)
    "Water pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Pse(start=2e6)
    "Water pressure at the outlet";
  Modelica.SIunits.Temperature Tee(start=400) "Water temperature at the inlet";
  Modelica.SIunits.Temperature Tse(start=450) "Water temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hee(start=3e5)
    "Water specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hse(start=20e5)
    "Water specific enthalpy at the outlet";
  Modelica.SIunits.MassFlowRate Qe(start=10) "Water mass flow rate";
  Modelica.SIunits.Density rhof(start=0.9) "Flue gases density";
  Modelica.SIunits.Density rhoe(start=700) "Water density";
  Modelica.SIunits.Power W(start=1e8) "Power exchanged";

  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cws2
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cfg1
    annotation (Placement(transformation(extent={{-10,80},{10,100}}, rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg2
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proee
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proes
    annotation (Placement(transformation(extent={{-52,80},{-32,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proem
    annotation (Placement(transformation(extent={{-76,80},{-56,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{58,80},{78,100}}, rotation=0)));
equation
  /* Flue gases inlet */
  Pef = Cfg1.P;
  Tef = Cfg1.T;
  Qf = Cfg1.Q;

  /* Flue gases outlet */
  Psf = Cfg2.P;
  Tsf = Cfg2.T;
  Cfg1.Q = Cfg2.Q;

  Cfg2.Xco2 = Cfg1.Xco2;
  Cfg2.Xh2o = Cfg1.Xh2o;
  Cfg2.Xo2  = Cfg1.Xo2;
  Cfg2.Xso2 = Cfg1.Xso2;

  /* Water inlet */
  Pee = Cws1.P;
  Hee = Cws1.h;
  Qe = Cws1.Q;

  /* Water outlet */
  Pse = Cws2.P;
  Hse = Cws2.h;
  Cws1.Q = Cws2.Q;

  /* Flow reversal */
  0 = if (Qe > 0) then Cws1.h - Cws1.h_vol else Cws2.h - Cws2.h_vol;

  /* Pressure losses */
  Pef = Psf + Kdpf*ThermoSysPro.Functions.ThermoSquare(
                                                      Qf, eps)/rhof;
  Pee = Pse + Kdpe*ThermoSysPro.Functions.ThermoSquare(
                                                      Qe, eps)/rhoe;

  /* Power exchanged */
  W = Qf*(Hef - Hsf);
  W = Qe*(Hse - Hee);

  /* Flue gases specific ethalpy at the inlet */
  Hef =  ThermoSysPro.Properties.FlueGases.FlueGases_h(Pef, Tef, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Flue gases specific ethalpy at the outlet */
  Hsf =  ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Flue gases density */
  rhof = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pef, Tef, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Water/steam thermodynamic properties */
  proee = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pee, Hee, mode);
  Tee = proee.T;

  proem = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Pee + Pse)/2, (Hee + Hse)/2, mode);
  rhoe = proem.d;

  proes = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pse, Hse, mode);
  Tse = proes.T;

  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Pse);
  Hse= vsat.h;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-30,76},{28,66}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "Flue gases"),
        Polygon(
          points={{-94,12},{-80,12},{-80,56},{80,56},{80,12},{92,12},{92,6},{74,
              6},{74,50},{-74,50},{-74,6},{-94,6},{-94,12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-94,-12},{-80,-12},{-80,-56},{80,-56},{80,-12},{92,-12},{92,
              -6},{74,-6},{74,-50},{-74,-50},{-74,-6},{-94,-6},{-94,-12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-114,28},{-48,18}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "Water/Steam"),
        Polygon(
          points={{-94,3},{90,3},{90,-3},{-94,-3},{-94,3}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
                            Icon(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-94,12},{-80,12},{-80,56},{80,56},{80,12},{92,12},{92,6},{74,
              6},{74,50},{-74,50},{-74,6},{-94,6},{-94,12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-92,3},{92,3},{92,-3},{-92,-3},{-92,3}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-94,-12},{-80,-12},{-80,-56},{80,-56},{80,-12},{92,-12},{92,
              -6},{74,-6},{74,-50},{-74,-50},{-74,-6},{-94,-6},{-94,-12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end SimpleEvaporatorWaterSteamFlueGases;
