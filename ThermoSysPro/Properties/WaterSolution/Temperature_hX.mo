within ThermoSysPro.Properties.WaterSolution;
function Temperature_hX
  "Temperature of the H2O/LiBr solution as a function of h et Xh2o"
  input Modelica.SIunits.SpecificEnthalpy h
    "Specific enthazlpy of the solution";
  input Real X "Water mass fraction in the solution";

  output Modelica.SIunits.Temperature T "Temperature";

protected
  Real A0;
  Real A1;
  Real A2;

algorithm
  /* Computation of the coefficients */
  A0 := 7.073041837E+03*X*X*X*X*X - 2.659706323E+04*X*X*X*X + 3.968957688E+04*X*
    X*X - 2.942661413E+04*X*X + 1.084550019E+04*X - 1.311645958E+03;
  A1 := -5.155160151E-02*X*X*X*X*X + 1.831371685E-01*X*X*X*X - 2.547248076E-01*X
    *X*X + 1.733914006E-01*X*X - 5.828427688E-02*X + 8.271482051E-03;
  A2 := -2.816450830E-07*X*X*X*X*X*X + 1.181863048E-06*X*X*X*X*X -
    2.027614981E-06*X*X*X*X + 1.818359590E-06*X*X*X - 8.983047414E-07*X*X +
    2.318831106E-07*X - 2.454384671E-08;

  /* Temperature */
  T := A2*h*h + A1*h + A0;

  annotation (
    smoothOrder=2,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end Temperature_hX;
