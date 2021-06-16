within ThermoSysPro.WaterSolution.HeatExchangers;
model ExchangerEfficiency
  "H2O/LiBr solution heat exchanger with prescribed efficiency"
  parameter Real Eff=0.9
    "Thermal exchange efficiency (between 0 and 1 =W/Wmax)";
  parameter Modelica.SIunits.AbsolutePressure DPc=0
    "Pressure loss in the hot fluid as a percent of the pressure at the inlet";
  parameter Modelica.SIunits.AbsolutePressure DPf=0
    "Pressure loss in the cold fluid as a percent of the pressure at the inlet";

public
  Modelica.SIunits.Power W(start=1e6) "Power exchanged";
  Modelica.SIunits.Temperature Tec(start=500)
    "Hot fluid temperature at the inlet";
  Modelica.SIunits.Temperature Tsc(start=400)
    "Hot fluid temperature at the outlet";
  Modelica.SIunits.Temperature Tef(start=350)
    "Cold fluid temperature at the inlet";
  Modelica.SIunits.Temperature Tsf(start=450)
    "Cold fluid temperature at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hec(start=5e5)
    "Hot fluid specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hsc(start=2e5)
    "Hot fluid specific enthalpy at the outlet";
  Modelica.SIunits.SpecificEnthalpy Hef(start=1e5)
    "Cold fluid specific enthalpy at the inlet";
  Modelica.SIunits.SpecificEnthalpy Hsf(start=4e5)
    "Cold fluid specific enthalpy at the outlet";
  Modelica.SIunits.Power Wmax(start=1e6) "Maximum exchangeable power";
  Modelica.SIunits.Power Wmaxf(start=1e6)
    "Maximum power acceptable by the cold fluid";
  Modelica.SIunits.Power Wmaxc(start=1e6)
    "Maximum power releasable by the hot fluid";
  Modelica.SIunits.SpecificEnthalpy Hmaxf(start=1e5)
    "Maximum specific enthalpy reachable by the cold fluid";
  Modelica.SIunits.SpecificEnthalpy Hminc(start=1e5)
    "Minimum specific enthalpy reachable by the hot fluid";
  Real Xc(start=0.5) "H2O mass fraction in the hot fluid";
  Real Xf(start=0.5) "H2O mass fraction in the cold fluid";
  Modelica.SIunits.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Modelica.SIunits.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";
  Modelica.SIunits.SpecificEnthalpy Hliq(start=4e5)
    "Liquid water specific enthalpy at the cold inlet";
  ThermoSysPro.Units.DifferentialTemperature DTc_ec(start=10)
    "Difference with the cristallisation temperature at the hot inlet";
  ThermoSysPro.Units.DifferentialTemperature DTc_sc(start=10)
    "Difference with the cristallisation temperature at the hot outlet";
  ThermoSysPro.Units.DifferentialTemperature DTc_ef(start=10)
    "Difference with the cristallisation temperature at the cold inlet";
  ThermoSysPro.Units.DifferentialTemperature DTc_sf(start=10)
    "Difference with the cristallisation temperature at the cold outlet";

  ThermoSysPro.WaterSolution.Connectors.WaterSolutionInlet Ef
    annotation (Placement(transformation(extent={{-110,-8},{-90,12}}, rotation=
            0)));
  ThermoSysPro.WaterSolution.Connectors.WaterSolutionInlet Ec
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}}, rotation=
           0)));
  ThermoSysPro.WaterSolution.Connectors.WaterSolutionOutlet Sc
    annotation (Placement(transformation(extent={{48,-70},{68,-50}}, rotation=0)));
  ThermoSysPro.WaterSolution.Connectors.WaterSolutionOutlet Sf
    annotation (Placement(transformation(extent={{90,-8},{110,12}}, rotation=0)));
equation

  /* Mass flow rates */
  Ec.Q = Sc.Q;
  Ef.Q = Sf.Q;

  Qc = Ec.Q;
  Qf = Ef.Q;

 /* H2O mass fractions */
  Ec.Xh2o = Sc.Xh2o;
  Ef.Xh2o = Sf.Xh2o;

  Xc = Ec.Xh2o;
  Xf = Ef.Xh2o;

 /* Specific enthalpies at the inlet and at the outlet */
  Hec = ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Tec, Xc);
  Hef = ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Tef, Xf);
  W = Qf*(Hsf - Hef);
  W = Qc*(Hec - Hsc);

  Hliq = ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(1e5, Tef, 1);

  /* Temperatures at the inlet and at the outlet */
  Tec = Ec.T;
  Tsc = Sc.T;
  Tef = Ef.T;
  Tsf = Sf.T;

  /* Temperature differences with cristallisation */
  DTc_ec = ThermoSysPro.Properties.WaterSolution.DTcristal_TX(Ec.T, Xc);
  DTc_sc = ThermoSysPro.Properties.WaterSolution.DTcristal_TX(Sc.T, Xc);
  DTc_ef = ThermoSysPro.Properties.WaterSolution.DTcristal_TX(Ef.T, Xf);
  DTc_sf = ThermoSysPro.Properties.WaterSolution.DTcristal_TX(Sf.T, Xf);

  /* Temperatures at the outlet */
  Tsf = ThermoSysPro.Properties.WaterSolution.Temperature_hX(Hsf, Xf);
  Tsc = ThermoSysPro.Properties.WaterSolution.Temperature_hX(Hsc, Xc);

  /* Pressures */
  Sc.P = if (Qc > 0) then Ec.P - DPc*Ec.P/100 else Ec.P + DPc*Ec.P/100;
  Sf.P = if (Qf > 0) then Ef.P - DPf*Ef.P/100 else Ef.P + DPf*Ef.P/100;

  /* Hypothesis : counter-current heat exchanger */

  /* Maximum exchangeable power on the cold side */
  Hmaxf = ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Tec, Xf);
  Wmaxf = Qf * (Hmaxf - Hef);

  /* Maximum exchangeable power on the hot side */
  Hminc = ThermoSysPro.Properties.WaterSolution.SpecificEnthalpy_TX(Tef, Xc);
  Wmaxc = Qc * (Hec - Hminc);

  /* Power exchanged */
  Wmax = min(Wmaxf, Wmaxc);
  W = Eff*Wmax;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-56,-50},{-56,2},{2,2},{60,2},{60,-50}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-50,66},{46,-2}},
          lineColor={0,0,255},
          textString=
               "E"),
        Line(points={{-100,60},{100,-60}}, color={0,0,255})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-58,-50},{-58,0},{0,0},{58,0},{58,-50}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-50,66},{46,-2}},
          lineColor={0,0,255},
          textString=
               "E"),
        Line(points={{-100,60},{100,-60}}, color={0,0,255})}),
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
end ExchangerEfficiency;
