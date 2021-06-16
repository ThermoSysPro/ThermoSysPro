within ThermoSysPro.Functions;
function SmoothCond "Smooth conditional function"
  input Real cond;
  input Real x1;
  input Real x2;
  input Real alpha=100;

  output Real y;

algorithm
  y := SmoothStep(cond, alpha)*x1 + SmoothStep(-cond, alpha)*x2;

  annotation (smoothOrder=2, Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>"));
end SmoothCond;
