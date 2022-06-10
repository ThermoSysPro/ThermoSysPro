within ThermoSysPro.Fluid.Combustion.BoundaryConditions;
model FuelSourcePQ "Fuel source with fixed pressure and mass flow rate"
  parameter Units.SI.AbsolutePressure P0=1e5
    "Fuel pressure (active if pressure input port is not connected)";
  parameter Units.SI.MassFlowRate Q0=10
    "Fuel mass flow rate (active if mass flow input port is not connected)";
  parameter Units.SI.Temperature T0=300 "Fuel temperature";
  parameter Units.SI.SpecificEnergy LHV=48e6 "Lower heating value";
  parameter Units.SI.SpecificHeatCapacity Cp=1e3
    "Fuel specific heat capacity at 273.15K";
  parameter Real Hum=0.0 "Fuel humidity (%)";
  parameter Real Xc=0.75 "C mass fraction";
  parameter Real Xh=0.25 "H mass fraction";
  parameter Real Xo=0 "O mass fraction";
  parameter Real Xn=0 "N mass fraction";
  parameter Real Xs=0 "S mass fraction";
  parameter Real Xashes=0 "Ashes mass fraction";
  parameter Real Vol=0 "Volatile matter mass fraction";
  parameter Units.SI.Density rho=0.72 "Fuel density";

public
  Units.SI.MassFlowRate Q "Fuel mass flow rate";
  Units.SI.AbsolutePressure P "Fuel pressure";
  Units.SI.Temperature T(start=300) "Fuel temperature";

  Interfaces.Connectors.FuelOutlet C annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=90,
        origin={100,0})));
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IMassFlow
    annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal IPressure
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
equation

  Q = C.Q;
  C.P = P;
  C.T = T;
  C.LHV = LHV;
  C.cp = Cp;
  C.rho = rho;

  /* Fuel composition */
  C.hum = Hum;
  C.Xc = Xc;
  C.Xh = Xh;
  C.Xo = Xo;
  C.Xn = Xn;
  C.Xs = Xs;
  C.Xashes = Xashes;
  C.VolM = Vol;

  /* Mass flow rate */
  if (cardinality(IMassFlow) == 0) then
    IMassFlow.signal = Q0;
  end if;

  Q = IMassFlow.signal;

  /* Pressure */
  if (cardinality(IPressure) == 0) then
    IPressure.signal = P0;
  end if;

  P = IPressure.signal;

  /* Temperature */
  T = T0;

  annotation (Diagram(graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.CrossDiag),
        Text(extent={{-30,60},{-12,40}}, textString=
                                             "Q"),
        Text(
          extent={{-64,26},{-40,6}},
          lineColor={0,0,255},
          textString=
               "P")}),Icon(graphics={
        Text(
          extent={{-38,60},{-4,40}},
          lineColor={0,0,255},
          textString=
               "Q"),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.CrossDiag),
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Text(
          extent={{-64,26},{-40,6}},
          lineColor={0,0,255},
          textString=
               "P")}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FuelSourcePQ;
