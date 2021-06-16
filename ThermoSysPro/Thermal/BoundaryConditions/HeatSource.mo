within ThermoSysPro.Thermal.BoundaryConditions;
model HeatSource "Heat source"
  parameter Modelica.SIunits.Temperature T0[:]={300}
    "Source temperature (active if option_temperature=1)";
  parameter Modelica.SIunits.Power W0[:]={2e6}
    "Heat power emitted by the source (active if option_temperature=2)";
  parameter Integer option_temperature=1
    "1:temperature fixed - 2:heat power fixed";

protected
  parameter Integer N=size(T0,1);

public
  ThermoSysPro.Thermal.Connectors.ThermalPort C[N]     annotation (Placement(
        transformation(extent={{-10,-108},{10,-88}}, rotation=0)));
  InstrumentationAndControl.Connectors.InputReal ISignal
    annotation (Placement(transformation(
        origin={0,50},
        extent={{10,-10},{-10,10}},
        rotation=90)));
equation

  if (cardinality(ISignal) == 0) then
    if (option_temperature == 1) then
      C.T = T0;
    elseif (option_temperature == 2) then
      C.W = -W0;
    else
      assert(false, "HeatSource : incorrect option");
    end if;

    ISignal.signal = 0;
  else
    if (option_temperature == 1) then
      C.T = fill(ISignal.signal, N);
    elseif (option_temperature == 2) then
      C.W = fill(-ISignal.signal, N);
    else
      assert(false, "HeatSource : incorrect option");
    end if;
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-40,40},{40,-38}}, textString=
                                             "C"),
        Line(points={{0,-40},{0,-88}}),
        Line(points={{0,-88},{12,-68}}),
        Line(points={{0,-88},{-14,-68}})}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,127,0},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-40},{0,-88}}),
        Line(points={{0,-88},{-14,-68}}),
        Line(points={{0,-88},{12,-68}}),
        Text(extent={{-40,40},{40,-38}}, textString=
                                             "C")}),
    Window(
      x=0.33,
      y=0.21,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end HeatSource;
