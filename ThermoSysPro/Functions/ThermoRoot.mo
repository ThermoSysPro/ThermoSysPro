within ThermoSysPro.Functions;
function ThermoRoot "Thermodynamic root"
  input Real x;
  input Real dx;

  output Real y;

protected
  Real C3;
  Real C1;
  Real dx2;
  Real adx;
  Real sqrtdx;

algorithm
  adx := abs(dx);
  if (x > adx) then
    y := sqrt(x);
  else
    if (x < -adx) then
      y := -sqrt(-x);
    else
      dx2 := adx*adx;
      sqrtdx := sqrt(adx);
      C3 := -0.25/(sqrtdx*dx2);
      C1 := 0.5/sqrtdx - 3.0*C3*dx2;
      y := (C1 + C3*x*x)*x;
    end if;
  end if;

  annotation (smoothOrder=1,
    Window(
      x=0.2,
      y=0.17,
      width=0.6,
      height=0.6),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b> </p>
<p><b>ThermoSysPro Version 2.0</h4>
</html>"));
end ThermoRoot;
