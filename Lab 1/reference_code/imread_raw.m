function im=imread_raw(filename, nrow, ncol) 
%reads .raw image
    fin=fopen(filename,'r');
    I=fread(fin,nrow*ncol,'uint8=>uint8'); 
    Z=reshape(I,nrow,ncol);
    im=Z';
    fclose(fin);
end