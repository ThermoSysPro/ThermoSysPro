within ThermoSysPro.Properties.FlueGases;
function FlueGases_s "Specific entropy"
  input Modelica.SIunits.AbsolutePressure PMF "Flue gases average pressure";
  input Modelica.SIunits.Temperature TMF "Flue gases average temperature";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.SpecificEntropy s "Specific entropy";

protected
  ThermoSysPro.Properties.ModelicaMediaFlueGases.ThermodynamicState state;
  ThermoSysPro.Properties.ModelicaMediaFlueGases.ThermodynamicState state0;
  Real Xn2 "N2 mass fraction";
  constant Real Slat=9.157461e3 "Phase transition entropy";

algorithm
  Xn2 := 1 - Xco2 - Xh2o - Xo2 - Xso2;

  /* Computation of the thermodynamic state */
  state.p :=PMF;
  state.T :=TMF;
  state.X :={Xn2,Xo2,Xh2o,Xco2,Xso2};
//  state :=ThermoSysPro.Properties.ModelicaMediaFlueGases.setState_pTX(PMF, TMF, {Xn2,Xo2,Xh2o,Xco2,Xso2});

  /* Computation of the reference thermodynamic state */
  state0.p :=0.006112*1e5;
  state0.T :=273.16;
  state0.X :={Xn2,Xo2,Xh2o,Xco2,Xso2};
//  state0 := ThermoSysPro.Properties.ModelicaMediaFlueGases.setState_pTX(0.006112*1e5, 273.16, {Xn2,Xo2,Xh2o,Xco2,Xso2});

  /* Computation of the specific entropy minus a reference at (0.006112 bars, 0.01°C) */
  s := ThermoSysPro.Properties.ModelicaMediaFlueGases.specificEntropy(state)
       -ThermoSysPro.Properties.ModelicaMediaFlueGases.specificEntropy(state0) + Xh2o*Slat;

  annotation (smoothOrder=2,Icon(graphics={
        Text(extent={{-136,102},{140,42}}, textString=
                                               "%name"),
        Ellipse(
          extent={{-100,40},{100,-100}},
          lineColor={255,127,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-84,-4},{84,-52}},
          lineColor={255,127,0},
          textString=
               "function")}),
                           Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end FlueGases_s;
