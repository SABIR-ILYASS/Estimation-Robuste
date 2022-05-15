function pn=penalisation(r,sig)
    pn=0.5*log(1+(r/sig).^2);
  end