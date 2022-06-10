within ThermoSysPro.Properties.Fluid.Interfaces;
function isCompatible "Determines whether fluids are comptaible"
  input FluidType ftype[:] "Fluid type";
  output Boolean compatible;

  /* The size of each dimension of the compatibility table must be equal to the
  number of elements in the FluidType enumeration */
protected
  Boolean compatibility_table[7, 7]=
  [true,  false, false, false, false, false, true;
   false, true,  false, false, false, false, false;
   false, false, true,  false, false, false, false;
   false, false, false, true,  false, false, false;
   false, false, false, false, true,  false, false;
   false, false, false, false, false, true,  false;
   true,  false, false, false, false, false, true];

algorithm

  compatible := true;

  for i in 1:size(ftype, 1) loop
    for j in i + 1:size(ftype, 1) loop
      compatible := compatible and compatibility_table[Integer(ftype[i]), Integer(ftype[j])];
    end for;
  end for;

  annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2020</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end isCompatible;
