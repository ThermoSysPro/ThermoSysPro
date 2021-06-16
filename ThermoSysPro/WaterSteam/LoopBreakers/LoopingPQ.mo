within ThermoSysPro.WaterSteam.LoopBreakers;
model LoopingPQ

  parameter Modelica.SIunits.AbsolutePressure P=1e5
    "Pression imposée en sortie";
  parameter Modelica.SIunits.MassFlowRate Q=1.0 "Débit imposé";

  ThermoSysPro.WaterSteam.Connectors.FluidInletI C1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI C2
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.LoopBreakers.LoopBreakerQ qLoopBreaker
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.PressureLosses.InvSingularPressureLoss
    pressureCloserWaterSteam
    annotation (Placement(transformation(extent={{20,-10},{40,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.RefP pressureReference
    annotation (Placement(transformation(extent={{60,-10},{80,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.RefQ massFlowSetWaterSteam
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Debit(
                                            k=Q)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Pression(
                                               k=P)
    annotation (Placement(transformation(extent={{20,30},{40,50}}, rotation=0)));
equation
  connect(Debit.y, massFlowSetWaterSteam.IMassFlow)
    annotation (Line(points={{-59,40},{-30,40},{-30,11}}));
  connect(Pression.y, pressureReference.IPressure)
    annotation (Line(points={{41,40},{70,40},{70,11}}));
  connect(C1, qLoopBreaker.C1) annotation (Line(points={{-100,0},{-80,0}}));
  connect(qLoopBreaker.C2, massFlowSetWaterSteam.C1)
    annotation (Line(points={{-60,0},{-40,0}}, color={0,0,255}));
  connect(massFlowSetWaterSteam.C2, pressureCloserWaterSteam.C1)
    annotation (Line(points={{-20,0},{20,0}}, color={0,0,255}));
  connect(pressureCloserWaterSteam.C2, pressureReference.C1)
    annotation (Line(points={{40,0},{60,0}}, color={0,0,255}));
  connect(pressureReference.C2, C2)
    annotation (Line(points={{80,0},{100,0}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.01), graphics),
                          Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.01), graphics={Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Bruno P&eacute;chin&eacute; </li>
</ul>
</html>"));
end LoopingPQ;
