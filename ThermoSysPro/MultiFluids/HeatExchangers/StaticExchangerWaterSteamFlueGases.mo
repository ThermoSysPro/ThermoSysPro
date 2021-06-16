within ThermoSysPro.MultiFluids.HeatExchangers;
model StaticExchangerWaterSteamFlueGases
  "Static heat exchanger water/steam - flue gases"
  parameter Integer exchanger_type=1
    "Exchanger type - 1: Efficiency is fixed - 2: delta power is fixed - 3: heat transfer is fixed";
  parameter Real EffEch = 0.9 "Thermal exchange efficiency";
  parameter Modelica.SIunits.Power W0=0
    "Power exchanged (active if exchanger_type=2)";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer K = 100
    "Global heat transfer coefficient (active if exchanger_type=3)";
  parameter Modelica.SIunits.Area S = 10
    "Global heat exchange surface (active if exchanger_type=3)";
  parameter Real Kdpf = 10 "Pressure loss coefficient on the flue gas side";
  parameter Real Kdpe = 10 "Pressure loss coefficient on the water/steam side";
  parameter Integer exchanger_conf=1
    "Exchanger configuration - 1: counter-current. 2: co-current";
  parameter Integer mode=0
    "IF97 region of the water. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Modelica.SIunits.AbsolutePressure Pef(start=3e5)
    "Flue gas pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Psf(start=2.5e5)
    "Flue gas pressure at the outlet";
  Modelica.SIunits.Temperature Tef(start=600)
    "Flue gas temperature at the inlet";
  Modelica.SIunits.Temperature Tsf(start=400)
    "Flue gas temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hef(start=6e5)
    "Flue gas specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hsf(start=3e5)
    "Flue gas specific enthalpy at the outlet";
  Modelica.SIunits.MassFlowRate Qf(start=10) "Flue gas mass flow rate";
  Modelica.SIunits.AbsolutePressure Pee(start=2e6)
    "Water pressure at the inlet";
  Modelica.SIunits.AbsolutePressure Pse(start=2e6)
    "Water pressure at the outlet";
  Modelica.SIunits.Temperature Tee(start=400) "Water temperature at the inlet";
  Modelica.SIunits.Temperature Tse( start=450)
    "Water temperature at the outlet";
  ThermoSysPro.Units.DifferentialTemperature DT1 "Delta T at the inlet";
  ThermoSysPro.Units.DifferentialTemperature DT2 "Delta T at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hse(start=20e5)
    "Water specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hee(start=3e5)
    "Water specific enthalpy at the outlet";
  Modelica.SIunits.MassFlowRate Qe(start=10) "Water mass flow rate";
  Modelica.SIunits.Density rhoe(start=700) "Water density";
  Modelica.SIunits.Density rhof(start=0.9) "Fluie gas density";
  Modelica.SIunits.SpecificHeatCapacity Cpf(start=1000)
    "Flue gas specific heat capacity";
  Modelica.SIunits.SpecificHeatCapacity Cpe(start=4200)
    "Water specific heat capacity";
  Modelica.SIunits.Power W(start=1e8) "Exchanger power";

  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Cws2 "Water outlet"
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Cws1 "Water inlet"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Cfg1
    annotation (Placement(transformation(extent={{-10,80},{10,100}}, rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Cfg2
    annotation (Placement(transformation(extent={{-11,-100},{10,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proee
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proes
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proem
    annotation (Placement(transformation(extent={{60,80},{80,100}}, rotation=0)));
equation
  /* Flue gas inlet */
  Pef = Cfg1.P;
  Tef = Cfg1.T;
  Qf = Cfg1.Q;

  /* Flue gas outlet */
  Psf = Cfg2.P;
  Tsf = Cfg2.T;
  Qf = Cfg2.Q;

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
  Qe = Cws2.Q;

  /* Flow reversal */
  0 = if (Qe > 0) then Cws1.h - Cws1.h_vol else Cws2.h - Cws2.h_vol;

  if (exchanger_conf == 1) then
     /* Counter-current exchanger */
     DT1 = Tef - Tse;
     DT2 = Tsf - Tee;
  elseif (exchanger_conf == 2) then
     /* Co-current exchanger */
     DT1 = Tef - Tee;
     DT2 = Tsf - Tse;
  else
     DT1 = 0;
     DT2 = 0;
     assert(false, "StaticExchangerFlueGasesWaterSteam: incorrect exchanger configuration");
  end if;

  /* Power exchanged between the hot and the cold sides */
  if (exchanger_type == 1) then
     W = noEvent(min(Qe*Cpe, Qf*Cpf))*EffEch*(Tef - Tee);
     W = Qf*(Hef - Hsf);
     W = Qe*(Hse - Hee);
  elseif (exchanger_type == 2) then
     W = W0;
     W = Qf*(Hef - Hsf);
     W = Qe*(Hse - Hee);
  else
     DT2 = if (exchanger_conf == 1) then DT1*Modelica.Math.exp(-K*S*(1/(Qf*Cpf) - 1/(Qe*Cpe))) else
                                         DT1*Modelica.Math.exp(-K*S*(1/(Qf*Cpf) + 1/(Qe*Cpe)));
     W = Qf*Cpf*(Tef - Tsf);
     W = Qe*(Hse - Hee);
  end if;

  /* Pressure losses */
  Pef = Psf + Kdpf*ThermoSysPro.Functions.ThermoSquare(Qf, eps)/rhof;
  Pee = Pse + Kdpe*ThermoSysPro.Functions.ThermoSquare(Qe, eps)/rhoe;

  /* Flue gas specific enthalpy at the inlet */
  Hef = ThermoSysPro.Properties.FlueGases.FlueGases_h(Pef, Tef, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Flue gas specific enthalpy at the outlet */
  Hsf = ThermoSysPro.Properties.FlueGases.FlueGases_h(Psf, Tsf, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Flue gas specific heat capacity */
  Cpf = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Pef, Tef, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Flue gas specific density */
  rhof = ThermoSysPro.Properties.FlueGases.FlueGases_rho(Pef, Tef, Cfg1.Xco2, Cfg1.Xh2o, Cfg1.Xo2, Cfg1.Xso2);

  /* Water/steam thermodynamic properties */
  proee = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pee, Hee, mode);
  Tee = proee.T;

  proem = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Pee + Pse)/2,(Hee + Hse)/2,mode);
  rhoe = proem.d;
  Cpe = noEvent(if proee.x <= 0.0 or proee.x >= 1.0 then proee.cp else 1e6);

  proes = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Pse, Hse, mode);
  Tse = proes.T;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-50},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,80},{100,50}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Line(
          points={{-94,-2},{-44,-2},{-24,46},{16,-48},{36,-2},{90,-2}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-28,72},{34,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "HotFlueGases"),
        Text(
          extent={{-34,8},{42,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "WaterSteam"),
        Text(
          extent={{-30,-58},{32,-74}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "HotFlueGases")}),
                            Icon(graphics={
        Rectangle(
          extent={{-100,80},{100,50}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-94,-2},{-44,-2},{-24,46},{16,-48},{36,-2},{90,-2}},
          color={0,0,0},
          thickness=0.5),
        Text(
          extent={{-34,8},{42,-6}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "WaterSteam"),
        Rectangle(
          extent={{-100,-50},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-30,-58},{32,-74}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "HotFlueGases"),
        Text(
          extent={{-30,72},{32,56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "HotFlueGases")}),
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
end StaticExchangerWaterSteamFlueGases;
