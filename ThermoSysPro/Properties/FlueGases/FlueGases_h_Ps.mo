within ThermoSysPro.Properties.FlueGases;
function FlueGases_h_Ps "Specific enthalpy"
  //extends ThermoSysPro.Properties.FlueGases.unSafeForJacobian;

  input Modelica.SIunits.AbsolutePressure PMF "Flue gases average pressure";
  input Modelica.SIunits.SpecificEntropy SMF
    "Flue gases average specific entropy";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";

protected
  ThermoSysPro.Properties.ModelicaMediaFlueGases.ThermodynamicState state;
  ThermoSysPro.Properties.ModelicaMediaFlueGases.ThermodynamicState state0;
  Modelica.SIunits.SpecificEntropy S0;
  Real Xn2 "N2 mass fraction";
  constant Real Hlat=2501.5999019e3 "Phase transition energy";
  constant Real Slat=9.157461e3 "Phase transition entropy";

algorithm
  Xn2 := 1 - Xco2 - Xh2o - Xo2 - Xso2;

  /* Computation of the reference thermodynamic state */
  state0.p :=0.006112*1e5;
  state0.T :=273.16;
  state0.X :={Xn2,Xo2,Xh2o,Xco2,Xso2};
//  state0 := ThermoSysPro.Properties.ModelicaMediaFlueGases.setState_pTX(0.006112*1e5, 273.16, {Xn2,Xo2,Xh2o,Xco2,Xso2});
  S0 :=ThermoSysPro.Properties.ModelicaMediaFlueGases.specificEntropy(state0);

  /* Computation of the thermodynamic state */
  state :=ThermoSysPro.Properties.ModelicaMediaFlueGases.setState_psX(PMF, SMF + S0 - Xh2o*Slat, {Xn2,Xo2,Xh2o,Xco2,Xso2});

  /* Computation of the specific enthalpy minus a reference at (0.006112 bars, 0.01°C) */
  h := ThermoSysPro.Properties.ModelicaMediaFlueGases.specificEnthalpy(state)
       -ThermoSysPro.Properties.ModelicaMediaFlueGases.specificEnthalpy(state0) + Xh2o*Hlat;

  annotation (smoothOrder=2,Icon(graphics),
              Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end FlueGases_h_Ps;
