within ThermoSysPro.HeatNetworksCooling;
model DesorberWaterLiBr "Water LiBr solution desorber with water heating"
  parameter Real Eff=0.65 "Thermal exchange efficiency (=W/Wmax)";
  parameter ThermoSysPro.Units.DifferentialPressure DPc=0
    "Pressure losses in the hot fluid a a percent of the pressure at the inlet";
  parameter Real Pth=0.15 "Thermal losses fraction (=losses/W)";

public
  Modelica.SIunits.Power W(start=1e6) "Power exchnaged with the solution";
  Modelica.SIunits.Power Wpth(start=1e6) "Thermal losses power";
  Modelica.SIunits.Power Wtot(start=1e6) "Hot water total power";
  Modelica.SIunits.Power Wmaxf(start=1e6)
    "Maximum power acceptable by the solution";
  Modelica.SIunits.Power Wmaxc(start=1e6)
    "Maximum power releasable by the hot water";
  Modelica.SIunits.Temperature Tsatc(start=400)
    "Hot water saturation temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hminc(start=1e5)
    "Minimum specific enthalpy reachable by the hot water";
  Real Xmin "Minimum mass fraction reachable by the solution";
  Modelica.SIunits.MassFlowRate Qs_min(start=100)
    "Minimum solution mass flow rate at the outlet";
  Modelica.SIunits.MassFlowRate Qv_max(start=100)
    "Maximum steam mass flow rate at the outlet";
  Modelica.SIunits.Power Wmax(start=1e6) "Maximum power exchangeable";
  ThermoSysPro.Units.DifferentialTemperature DTm(start=40)
    "Differences of the average temperatures between the hot and cold sides";

public
  ThermoSysPro.WaterSteam.Connectors.FluidInlet Ec
                          annotation (Placement(transformation(extent={{-84,-72},
            {-64,-52}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Svap
                          annotation (Placement(transformation(extent={{-10,80},
            {10,101}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutlet Sc
                          annotation (Placement(transformation(extent={{-82,50},
            {-62,70}}, rotation=0)));
  ThermoSysPro.WaterSolution.Connectors.WaterSolutionInlet Ef
    annotation (Placement(transformation(extent={{64,50},{84,70}}, rotation=0)));
  ThermoSysPro.WaterSolution.Connectors.WaterSolutionOutlet Sf
    annotation (Placement(transformation(extent={{-8,-100},{12,-80}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph provap
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
equation

  // Hypothesis : counter-current exchange

  Sc.Q = Ec.Q;
  Ef.P = Sf.P;
  Svap.P = Sf.P;

  /* Flow reversal */
  0 = if (Ec.Q > 0) then Ec.h - Ec.h_vol else Sc.h - Sc.h_vol;

  /* Maximum power exchangeable on the hot side */
  Tsatc = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(Sc.P);

  if (Tsatc > Ef.T) then
      Hminc = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(Sc.P, Ef.T, 0);
  elseif (Tsatc < Ef.T) then
      Hminc = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(Sc.P, Ef.T, 0);
  else
      Hminc = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(Sc.P, Ef.T, 1);
  end if;

  Wmaxc = Ec.Q*(Ec.h - Hminc);

  /* Maximum power exchangeable on the solution side */
  Xmin = ThermoSysPro.Properties.WaterSolution.MassFraction_eq_PT(Sf.P, proce.T);
  Qs_min = Ef.Q*(1 - Ef.Xh2o)/(1 - Xmin);
  Qv_max = Ef.Q*(1 - (1-Ef.Xh2o)/(1 - Xmin));
  Wmaxf = Ef.Q*ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Ef.T, Ef.Xh2o)
          - Qs_min * ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(proce.T, Xmin) + Qv_max*Svap.h;

  /* Power exchanged */
  Wmax = min(Wmaxf, Wmaxc);
  W = Eff*Wmax;
  Wpth = W*Pth;
  Wtot = W + Wpth;

  /* Water/steam properties */
  proce = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ec.P, Ec.h, 0);
  procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sc.P, Sc.h, 0);
  provap = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Svap.P, Svap.h, 0);

  /* Mass flow rate in the hot side : mass balance and LiBr balance */
  Sf.Q = Ef.Q*(1 - Ef.Xh2o)/(1 - Sf.Xh2o);
  Svap.Q = Ef.Q*(1 - (1-Ef.Xh2o)/(1 - Sf.Xh2o));

  /* Pressure losses in the hot side */
  Sc.P = if (Ec.Q > 0) then Ec.P - DPc*Ec.P/100 else Ec.P + DPc*Ec.P/100;

  /* Fluid properties at the outlet */
  Svap.h = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(Svap.P, Sf.T,2);
  Sf.Xh2o = ThermoSysPro.Properties.WaterSolution.MassFraction_eq_PT(Sf.P, Sf.T);

  /* Energy balance in the hot side */
  Sc.h = Ec.h - Wtot/Ec.Q;

  /* Energy balance in the solution side */
  W = Ef.Q*ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Ef.T, Ef.Xh2o)
      - Sf.Q * ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Sf.T, Sf.Xh2o)
      + Svap.Q*Svap.h;

  /* Difference between the average temperatures */
  DTm = (proce.T - procs.T) - (Sf.T - Ef.T);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-74,80},{-64,90},{64,90},{74,80},{74,-80},{64,-90},{-64,-90},
              {-74,-80},{-74,80}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{74,-10},{74,-80},{64,-90},{-64,-90},{-74,-80},{-74,-10},{-26,
              -10},{-4,66},{64,66},{64,54},{8,54},{26,-10},{74,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-64,60},{0,60},{0,-16},{0,-62},{-64,-62}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-12,68},{0,78},{14,68}},
          color={0,0,255},
          thickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-74,80},{-64,90},{64,90},{74,80},{74,-80},{64,-90},{-64,-90},
              {-74,-80},{-74,80}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{74,-10},{74,-80},{64,-90},{-64,-90},{-74,-80},{-74,-10},{-26,
              -10},{-4,66},{64,66},{64,54},{8,54},{26,-10},{74,-10}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-64,60},{0,60},{0,-16},{0,-62},{-64,-62}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-12,68},{0,78},{14,68}},
          color={0,0,255},
          thickness=0.5)}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
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
end DesorberWaterLiBr;
