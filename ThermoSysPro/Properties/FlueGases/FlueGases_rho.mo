within ThermoSysPro.Properties.FlueGases;
function FlueGases_rho "Density"
  input Modelica.SIunits.AbsolutePressure PMF "Flue gases average pressure";
  input Modelica.SIunits.Temperature TMF "Flue gases average temperature";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.Density rho "Density";

protected
  ThermoSysPro.Properties.ModelicaMediaFlueGases.ThermodynamicState state;
  Real Xn2 "N2 mass fraction";

algorithm
  Xn2 := 1 - Xco2 - Xh2o - Xo2 - Xso2;

  /* Computation of the thermodynamic state */
//  state :=ThermoSysPro.Properties.ModelicaMediaFlueGases.setState_pTX(PMF, TMF, {Xn2,Xo2,Xh2o,Xco2,Xso2});
  state.p := PMF;
  state.T := TMF;
  state.X := {Xn2,Xo2,Xh2o,Xco2,Xso2};

  /* Computation of the density */
  //rho := state.p/((state.X*ThermoSysPro.Properties.ModelicaMediaFlueGases.data.R)*state.T);
  rho := ThermoSysPro.Properties.ModelicaMediaFlueGases.density(state)
  annotation (smoothOrder=2,  Icon(graphics={
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

end FlueGases_rho;
