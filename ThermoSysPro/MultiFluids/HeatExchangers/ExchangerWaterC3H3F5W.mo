within ThermoSysPro.MultiFluids.HeatExchangers;
model ExchangerWaterC3H3F5W
  "Static water - C3H3F5 heat exchanger with fixed delta power"
  parameter Modelica.SIunits.Power DW = 0
    "Power exchanged between the hot and the cold fluids";
  parameter ThermoSysPro.Units.DifferentialPressure DPc
    "Total pressure loss for the hot fluid (% of the fluid pressure at the inlet)";
  parameter ThermoSysPro.Units.DifferentialPressure DPf
    "Total pressure loss for the cold fluid (% of the fluid pressure at the inlet)";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Integer modec=0
    "IF97 region of the water for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow for continuous flow reversal";

public
  Modelica.SIunits.Temperature Tec
    "Fluid temperature at the inlet of the hot side";
  Modelica.SIunits.Temperature Tsc
    "Fluid temperature at the outlet of the hot side";
  Modelica.SIunits.Temperature Tef
    "Fluid temperature at the inlet of the cold side";
  Modelica.SIunits.Temperature Tsf
    "Fluid temperature at the outlet of the cold side";
  Modelica.SIunits.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Modelica.SIunits.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";

public
  WaterSteam.Connectors.FluidInlet Ec
                          annotation (Placement(transformation(extent={{-68,-70},
            {-48,-50}}, rotation=0)));
  WaterSteam.Connectors.FluidInlet Ef
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  WaterSteam.Connectors.FluidOutlet Sf
                          annotation (Placement(transformation(extent={{88,-9},
            {108,11}}, rotation=0)));
  WaterSteam.Connectors.FluidOutlet Sc
                          annotation (Placement(transformation(extent={{48,-70},
            {68,-50}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
equation

  /* Flow reversal for the hot fluid */
  if continuous_flow_reversal then
    0 = noEvent(if (Qc > Qeps) then Ec.h - Ec.h_vol else if (Qc < -Qeps) then
        Sc.h - Sc.h_vol else Ec.h - 0.5*((Ec.h_vol - Sc.h_vol)*Modelica.Math.sin(pi
        *Qc/2/Qeps) + Ec.h_vol + Sc.h_vol));
  else
    0 = if (Qc > 0) then Ec.h - Ec.h_vol else Sc.h - Sc.h_vol;
  end if;

  /* Flow reversal for the cold fluid */
  if continuous_flow_reversal then
    0 = noEvent(if (Qf > Qeps) then Ef.h - Ef.h_vol else if (Qf < -Qeps) then
        Sf.h - Sf.h_vol else Ef.h - 0.5*((Ef.h_vol - Sf.h_vol)*Modelica.Math.sin(pi
        *Qf/2/Qeps) + Ef.h_vol + Sf.h_vol));
  else
    0 = if (Qf > 0) then Ef.h - Ef.h_vol else Sf.h - Sf.h_vol;
  end if;

  /* Mass flow rates */
  Ec.Q = Sc.Q;
  Qc = Ec.Q;

  Ef.Q = Sf.Q;
  Qf = Ef.Q;

  /* Power exchanged between the hot and cold fluids */
  DW = Qf*(Sf.h - Ef.h);
  DW = Qc*(Ec.h - Sc.h);

  /* Pressure losses */
  Sc.P = if (Qc > 0) then Ec.P - DPc*Ec.P/100 else Ec.P + DPc*Ec.P/100;
  Sf.P = if (Qf > 0) then Ef.P - DPf*Ef.P/100 else Ef.P + DPf*Ef.P/100;

  /* Fluid thermodynamic properties for the hot fluid */
  proce = ThermoSysPro.Properties.Fluid.Ph(Ec.P, Ec.h, modec, 1);
  procs = ThermoSysPro.Properties.Fluid.Ph(Sc.P,Sc.h, modec, 1);

  Tec = proce.T;
  Tsc = procs.T;

  /* Fluid thermodynamic properties for the cold fluid */
  profe = ThermoSysPro.Properties.Fluid.Ph(Ef.P, Ef.h, 0, 2);
  profs = ThermoSysPro.Properties.Fluid.Ph(Sf.P, Sf.h, 0, 2);

  Tef = profe.T;
  Tsf = profs.T;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.CrossDiag), Line(
          points={{-56,-50},{-56,4},{0,-28},{60,6},{60,-50}},
          color={0,0,255},
          thickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.CrossDiag), Line(
          points={{-58,-50},{-58,2},{-2,-34},{58,2},{58,-50}},
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
<li>Baligh El Hefni </li>
</ul>
</html>"));
end ExchangerWaterC3H3F5W;
