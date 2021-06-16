within ThermoSysPro.FlueGases.HeatExchangers;
model StaticFluegasesFluegasesExchangerKS
  "Static flue gases/flue gases heat exchanger with fixed K and S"
  parameter Modelica.SIunits.CoefficientOfHeatTransfer K=100
    "Global heat exchange coefficient";
  parameter Modelica.SIunits.Area S=10 "Heat exchange surface";
  parameter Real DPc= 0.1
    "Pressure losses in the hot fluid as a percent of the pressure at the inlet";
  parameter Real DPf= 0.1
    "Pressure losses in the cold fluid as a percent of the pressure at the inlet";

public
  Modelica.SIunits.Power W "Power exchanged";
  Modelica.SIunits.Temperature Tec(start=400)
    "Temperature of the hot fluid at the inlet";
  Modelica.SIunits.Temperature Tsc(start=300)
    "Temperature of the hot fluid at the outlet";
  Modelica.SIunits.Temperature Tef(start=300)
    "Temperature of the cold fluid at the inlet";
  Modelica.SIunits.Temperature Tsf(start=400)
    "Temperature of the cold fluid at the outlet";
  ThermoSysPro.Units.DifferentialTemperature DT1 "Delta T at the inlet";
  ThermoSysPro.Units.DifferentialTemperature DT2 "Delta T at the outlet";
  Modelica.SIunits.SpecificHeatCapacity Cpf
    "Specific heat capacity of the cold fluid";
  Modelica.SIunits.SpecificHeatCapacity Cpc
    "Specific heat capacity of the hot fluid";
  Modelica.SIunits.MassFlowRate Qc(start=100) "Mass flow rate of the hot fluid";
  Modelica.SIunits.MassFlowRate Qf(start=100)
    "Mass flow rate of the cold fluid";
  Real Kcor "Corrective term for the global heat exchange coefficient";

  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Sc
    annotation (Placement(transformation(extent={{50,-70},{70,-50}}, rotation=0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ec
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet Ef
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet Sf
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  InstrumentationAndControl.Connectors.InputReal Kcorr "K_correction"
    annotation (Placement(transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation

  if (cardinality(Kcorr) == 0) then
    Kcorr.signal = 1;
  end if;

  Kcor = Kcorr.signal;

  /* Flue gases temperature at both ends of the exchanger */
  Tec = Ec.T;
  Tsc = Sc.T;
  Tef = Ef.T;
  Tsf = Sf.T;

  /* Flue gases mass flow rates at both ends of the exchanger */
  Qc = Ec.Q;
  Qf = Ef.Q;
  Sc.Q = Ec.Q;
  Sf.Q = Ef.Q;

  /* Hot flue gases composition */
  Sc.Xco2 = Ec.Xco2;
  Sc.Xh2o = Ec.Xh2o;
  Sc.Xo2 = Ec.Xo2;
  Sc.Xso2 = Ec.Xso2;

  /* Cold flue gases composition */
  Sf.Xco2 = Ef.Xco2;
  Sf.Xh2o = Ef.Xh2o;
  Sf.Xo2 = Ef.Xo2;
  Sf.Xso2 = Ef.Xso2;

  /* Presure losses */
  Sc.P = if (Qc > 0) then Ec.P - DPc*Ec.P/100 else Ec.P + DPc*Ec.P/100;
  Sf.P = if (Qf > 0) then Ef.P - DPf*Ef.P/100 else Ef.P + DPf*Ef.P/100;

 /* Hypothesis : counter-current exchanger */
  DT1 = Tec - Tsf;
  DT2 = Tsc - Tef;
  DT2 = DT1*Modelica.Math.exp(-Kcor*K*S*(1/(Qc*Cpc) - 1/(Qf*Cpf)));

  /* Power exchanged */
  W = Qc*Cpc*(Tec-Tsc);
  W = Qf*Cpf*(Tsf-Tef);

 /* Average specific heat capacities */
  Cpf = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Ef.P, (Tef + Tsf)/2, Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);
  Cpc = ThermoSysPro.Properties.FlueGases.FlueGases_cp(Ec.P, (Tec + Tsc)/2, Ec.Xco2, Ec.Xh2o, Ec.Xo2, Ec.Xso2);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward)}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end StaticFluegasesFluegasesExchangerKS;
