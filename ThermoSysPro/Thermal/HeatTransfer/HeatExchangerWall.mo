within ThermoSysPro.Thermal.HeatTransfer;
model HeatExchangerWall "Heat exchanger wall"
  parameter Real ntubes=1 "Number of pipes in parallel";
  parameter Units.SI.Length L=1 "Tube length";
  parameter Units.SI.Diameter D=0.2 "Internal tube diameter";
  parameter Units.SI.Thickness e=2.e-3 "Wall thickness";
  parameter Units.SI.ThermalConductivity lambda=26 "Wall thermal conductivity";
  parameter Integer Ns=1 "Number of sections inside the wall";
  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Units.SI.SpecificHeatCapacity cpw=1000
    "Wall specific heat capacity (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.Density rhow=7800
    "Wall density (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from T0 (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.Temperature T0=350
    "Initial temperature (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Units.SI.Length dx=L/Ns "Section length";
  parameter Units.SI.Mass dM=ntubes*rhow*pi*((D + 2*e)^2 - D^2)/4*dx
    "Wall section mass";

public
  Units.SI.Power dW1[Ns](start=fill(3.e5, Ns), nominal=fill(3.e5, Ns))
    "Power in section i of side 1";
  Units.SI.Power dW2[Ns](start=fill(3.e5, Ns), nominal=fill(3.e5, Ns))
    "Power in section i of side 2";
  Units.SI.Temperature Tp1[Ns](start=fill(300, Ns))
    "Wall temperature in section i of side 1";
  Units.SI.Temperature Tp2[Ns](start=fill(300, Ns))
    "Wall temperature in section i of side 2";
  Units.SI.Temperature Tp[Ns](start=fill(300, Ns))
    "Average wall temperature in section i";

  ThermoSysPro.Thermal.Connectors.ThermalPort WT2[Ns] "Side 2"
    annotation (Placement(transformation(extent={{-10,10},{10,30}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort WT1[Ns] "Side 1"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}}, rotation=
            0)));
initial equation
  if dynamic_energy_balance then
    if steady_state then
      for i in 1:Ns loop
        der(Tp[i]) = 0;
      end for;
    else
      for i in 1:Ns loop
        Tp[i] = T0;
      end for;
    end if;
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
    dW2[i] = 2*pi*dx*ntubes*lambda*(Tp2[i] - Tp[i])/(Modelica.Math.log(1 + e/(e + D)));

    /* Thermal inertia */
    if dynamic_energy_balance then
      dM*cpw*der(Tp[i]) = dW2[i] + dW1[i];
    else
      0 = dW2[i] + dW1[i];
    end if;

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
               "Internal")}),
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
               "External")}),
    DymolaStoredErrors,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 9.4.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Guillaume Larrignon </li>
</ul>
</html>"));
end HeatExchangerWall;
