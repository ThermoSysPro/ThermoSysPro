within ThermoSysPro.Properties.WaterSolution;
function MassFraction_eq_PT
  "Equilibrium mass fraction of the H2O/LiBr solution as a function of T et Xh2o"
  input Modelica.SIunits.AbsolutePressure P "Pressure";
  input Modelica.SIunits.Temperature T "Temperature";

  output Real Xe "Equilibrium mass fraction";

protected
  Real lnP "ln de la pression en Pa";
  Real lnPlim "limite des zones du ln de la pression en Pa";
  Real Tinv "Inverse négatif de la température";

  Real A1 "Coefficient directeur zone inférieure";
  Real B1 "Ordonnée à l'origine zone inférieure";
  Real A2 "Coefficient directeur zone supérieure";
  Real B2 "Ordonnée à l'origine zone supérieure";
  Real a "Coefficient directeur de la loi ln P lim = a (-1/T) + b";
  Real b "Ordonnée à l'origine de la loi ln P lim = a (-1/T) + b";

algorithm
  /* Units conversions */
  lnP := log(P);
  Tinv := -1/T;

  /* Computation of the coefficients */
  A1 := 7.05850237E+03*Tinv*Tinv + 7.29531684E+01*Tinv + 2.64270714E-01;
  B1 := -2.19138115E+05*Tinv*Tinv - 2.18532823E+03*Tinv - 5.01454826E+00;
  A2 := 1.12723416E+04*Tinv*Tinv - 1.34083981E+01*Tinv + 4.63220115E-01;
  B2 := 3.49286405E+05*Tinv*Tinv - 4.15474563E+02*Tinv - 9.41938792E+00;

  /* Compuation of the zone limits */
  a := 5379.103071;
  b := 25.44182656;
  lnPlim := a * Tinv + b;

  /* Equilibrium pressure */
  if (lnP < lnPlim) then
    Xe := A1*lnP + B1;
  else
    Xe := A2*lnP + B2;
  end if;

  annotation (
    smoothOrder=2,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end MassFraction_eq_PT;
