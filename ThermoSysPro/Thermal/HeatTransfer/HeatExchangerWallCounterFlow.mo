within ThermoSysPro.Thermal.HeatTransfer;
model HeatExchangerWallCounterFlow "Heat exchanger wall counter flow "
  parameter Modelica.SIunits.Length L=1 "Tube length";
  parameter Modelica.SIunits.Diameter D=0.2 "Internal tube diameter";
  parameter Modelica.SIunits.Thickness e=2.e-3 "Wall thickness";
  parameter Modelica.SIunits.ThermalConductivity lambda=26
    "Wall thermal conductivity";
  parameter Integer Ns=1 "Number of sections inside the wall";
  parameter Modelica.SIunits.SpecificHeatCapacity cpw=1000
    "Wall specific heat capacity";
  parameter Modelica.SIunits.Density rhow=7800 "Wall density";
  parameter Modelica.SIunits.Temperature T0=350
    "Initial temperature (active if steady_state=false)";
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0";
  parameter Real ntubes=1 "Number of pipes in parallel";

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Modelica.SIunits.Length dx=L/Ns "Section length";
  parameter Modelica.SIunits.Mass dM=ntubes*rhow*pi*((D + 2*e)^2 - D^2)/4*dx
    "Wall section mass";

public
  Modelica.SIunits.Power dW1[Ns](start=fill(3.e5, Ns), nominal=fill(3.e5, Ns))
    "Power in section i of side 1";
  Modelica.SIunits.Power dW2[Ns](start=fill(3.e5, Ns), nominal=fill(3.e5, Ns))
    "Power in section i of side 2";
  Modelica.SIunits.Temperature Tp1[Ns](start=fill(300, Ns))
    "Wall temperature in section i of side 1";
  Modelica.SIunits.Temperature Tp2[Ns](start=fill(300, Ns))
    "Wall temperature in section i of side 2";
  Modelica.SIunits.Temperature Tp[Ns](start=fill(300, Ns))
    "Average wall temperature in section i";

  ThermoSysPro.Thermal.Connectors.ThermalPort WT2[Ns] "Side 2"
    annotation (Placement(transformation(extent={{-10,10},{10,30}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort WT1[Ns] "Side 1"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}}, rotation=
            0)));
initial equation
  if steady_state then
    for i in 1:Ns loop
      der(Tp[i]) = 0;
    end for;

  else
    for i in 1:Ns loop
      Tp[i] = T0;
    end for;
  end if;

equation

  WT1.T = Tp1;
  WT1.W = dW1;

  WT2.T = Tp2;
  WT2.W = dW2;

  for i in 1:Ns loop
    /* Heat transfer on side 1 (internal) */
    dW1[i] = 2*pi*dx*ntubes*lambda*(Tp1[i] - Tp[i])/(Modelica.Math.log(1 + e/D));

    /* Heat transfer on side 2 (external) */
    dW2[Ns-i+1] = 2*pi*dx*ntubes*lambda*(Tp2[Ns-i+1] - Tp[i])/(Modelica.Math.log(1 + e/(e + D)));

    /* Thermal inertia */
    dM*cpw*der(Tp[i]) = dW2[Ns-i+1] + dW1[i];
  end for;

  annotation (
    Icon(graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,40},{-20,20}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "2"),
        Text(
          extent={{-80,-20},{-20,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "1"),
        Text(
          extent={{20,40},{98,20}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "External"),
        Text(
          extent={{20,-20},{98,-40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Internal"),
        Line(
          points={{62,45},{100,45}},
          color={255,0,0},
          thickness=0.5),
        Line(
          points={{-100,-45},{-62,-45}},
          color={0,0,255},
          thickness=0.5),
        Polygon(
          points={{-80,-35},{-60,-45},{-80,-55},{-80,-35}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{80,55},{60,45},{80,35},{80,55}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(graphics={
        Rectangle(
          extent={{-100,10},{100,-10}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-80,30},{-20,10}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Side 2"),
        Text(
          extent={{-80,-10},{-20,-30}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Side 1"),
        Text(
          extent={{20,-10},{98,-30}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Internal"),
        Text(
          extent={{20,30},{98,10}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid,
          textString=
               "External"),
        Line(
          points={{-98,-26},{-80,-26}},
          color={0,0,255},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{96,30},{78,30}},
          color={255,0,0},
          thickness=0.5,
          arrow={Arrow.None,Arrow.Filled})}),
    DymolaStoredErrors,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2014</h4></p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Guillaume Larrignon </li>
</ul>
</html>"));
end HeatExchangerWallCounterFlow;
