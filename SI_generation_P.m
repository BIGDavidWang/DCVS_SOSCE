function SI = SI_generation_P(Ref1,Ref2)


block_size = 8;
L = 1;

frame1 = AR_extrap(Ref1,Ref2,block_size,L);
frame2 = Backward_AR_extrap(Ref1,Ref2,block_size,L);

SI = (frame1+frame2)/2;

end