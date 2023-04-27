% per aquesta part necessitarem les imatges de la carpeta 'imatges_biomed'.
% També cal que us guardeu la funció imread_raw al directori on treballeu. 

% ========================================================================
%                1. LLEGIR IMATGE I EXAMINAR INTENSITATS DEL PIXEL  
% ========================================================================

%llegir imatge
im=imread_raw('BRAIN.raw',256,256);
%mida de la imatge
size_im=size(im)
% visualitzar la imatge i l'histograma. Utilitzeu el cursor per
% inspeccionar coordenades i valors de píxel
figure ('Position', [0, 0, 800, 400])
subplot(1,2,1); imagesc(im); title ('imatge sintètica')
subplot(1,2,2); imhist(im); title ('histograma')
colormap(gray(256));
close; 
%estudiar el perfil d'intensitats
xi=100;
figure ('Position', [0, 0, 800, 400])
subplot(1,2,1); imagesc(im); hold on; colormap (gray)
plot (xi*ones(1, size_im(1)), 1:size_im(2), 'r-', 'LineWidth', 2); title ('línia de perfil')
subplot (1,2,2); plot(1:size(im,1), im(:,xi)); title ('intensitat de la línia')
% fer el mateix amb una coordenada y.

% ========================================================================
% ACTIVITAT 2.1. Trobeu la mida de les dues elipses negres en nombre de
% píxels.
% ========================================================================

% ========================================================================
%                2. EQUALITZACIO 
% ========================================================================
im=imread_raw('ART1BIO.raw',256,256);
im=uint8(im); %makes pixel values 8bytes unsigned integer to work with

%Plots image and image histogram
[freq x]=imhist(im);
figure ('Position', [0, 0, 800, 400])
subplot(1,2,1); imagesc(im); title ('Imatge')
subplot(1,2,2); imhist(im); title ('Histograma')
axis([0,max(x),0,max(freq)*1.1]) %sets axis range for imhist
colormap(gray(256));

%EXEMPLE 1: Equalitzador per defecte
N=256
[im_eq, transformation]=histeq(im,N);
%plots it
[freq x]=imhist(im_eq);
figure ('Position', [0, 0, 1000, 400])
subplot(1,3,1); imagesc(im_eq); title ('Imatge equalitzada')
subplot(1,3,2); imhist(im_eq); title ('Histograma equalitzat')
axis([0,max(x),0,max(freq)*1.1]) %sets axis range for imhist
colormap(gray(256));
subplot(1,3,3); plot(transformation*255); title ('transformació')

%EXAMPLE 2: Podem customitzar l'equalitzador
target_hist1=[1 1]; %binarizes image at the median (50th percentile)
[im_eq, transformation]=histeq(im,target_hist1);
%replot...

target_hist2=[1:64]; %linearly enhances bright pixels
[im_eq, transformation]=histeq(im,target_hist2);
%replot...

% ========================================================================
% ACTIVITAT 2.2. Proveu diferents opcions d'equalitzador i mostreu les
% imatges resultants, els histogrames i les transformacions
% ========================================================================

% ========================================================================
%                3. FILTRE DE MEDIANA 
% ========================================================================

%reads image
im=imread_raw('CT.raw',256,256);
figure ('Position', [0, 0, 1300, 400])
subplot(131); imagesc(im); colormap(gray(256)); title ('original image');
subplot(132); title ('with noise');
subplot(133); title ('after median filter');

% ========================================================================
% ACTIVITAT 2.3. Afegiu soroll impulsional a la imatge i comproveu que
% aquest desapareix quan utilitzem el filtre de mediana (utilitzeu les
% comandes de la primera part de la pràctica
% ========================================================================

% ========================================================================
%                4. FILTRE PASSA-BAIX 
% ========================================================================
%reads image
im=imread_raw('CEREBRO.raw',256,256);
figure ('Position', [0, 0, 800, 400])
subplot(121); imagesc(im); colormap(gray(256)); title ('original image');
subplot(122); title ('after low-passfilter');

% ========================================================================
% ACTIVITAT 2.4. Utilitzeu dues versions del filtre passa-baix (uniforme
% 3x3, i gaussià i observeu el resultat. 
% ========================================================================

% ========================================================================
%                5. FILTRE PASSA-ALT 
% ========================================================================
%reads image
im=imread_raw('BRAIN.raw',256,256);
figure ('Position', [0, 0, 800, 400])
subplot(121); imagesc(im); colormap(gray(256)); title ('original image');
subplot(122); title ('after high-passfilter');

% ========================================================================
% ACTIVITAT 2.5. Utilitzeu varies versions del filtre passa-alt (laplaciana
% i direccionals.
% ========================================================================

% ========================================================================
%                6. FFT 
% ========================================================================

%reads image
im=imread_raw('CEREBRO.raw',256,256);
[j, i]=meshgrid(1:256,1:256); %creates matrix of coordinates

%EXAMPLE 1: Fourier Transform and Inverse Transform
%applies FFT
im_f=fft2(im);
%applies inverse FFT
im_rest=ifft2(im_f);

figure ('Position', [0, 0, 1000, 400])
subplot(1,3,1); imagesc(im); title ('original')
subplot(1,3,2); imagesc(abs(fftshift(im_f)), [0 2000]); title ('fft')
subplot(1,3,3); imagesc(abs(im_rest)); title ('ifft')
colormap(gray(256));

%EXAMPLE 2: Low-Pass Spatial Filter using FT shifts 0-frequency harmonics
%to the center of image
im_f_trimmed=fftshift(im_f);
%keeps central part of fft harmonics (low frequency)
R=64;
im_f_trimmed(sqrt((i-128).^2+(j-128).^2)>R)=0; % es pot fer d'altres maneres
%restores image after undoing frequency shift (ifftshift)
im_rest=ifft2(ifftshift(im_f_trimmed));
subplot(1,3,1); imagesc(im); title ('original')
subplot(1,3,2); imagesc(abs(im_f_trimmed), [0 2000]); title ('fft filtrada')
subplot(1,3,3); imagesc(abs(im_rest)); title ('fft inversa')
colormap(gray(256));
% ========================================================================
% ACTIVITAT 2.6. Visualitzeu el comportament del filtre utilitzant diferents radis.
% ========================================================================

% ========================================================================
%                7. SISTEMES I RESTAURACIO 
% ========================================================================

im=imread_raw('ZUBAL56b.raw',256,256);
im_f=fft2(im);
im_f_trimmed = fftshift(im_f);

blur = imread_raw('CIRC.RAW', 256, 256);
blur_f=fft2(blur);
blur_f_trimmed = fftshift(blur_f);

figure ('Position', [0, 0, 1000, 600])
subplot(231); imagesc(im); title ('original e(x,y)')
subplot(232); imagesc(abs(im_f_trimmed), [0, 10000]); title ('FT de la original E(x,y)')
subplot(234); imagesc(blur); title ('resposta sistema h(x,y)')
subplot(235); imagesc(abs(blur_f_trimmed)); title ('FT de la resposta H(u,v)')
colormap(gray);

% PRIMER SIMULEM LA RESPOSTA DEL SISTEMA E(u,v)*H(u,v)
S_f= im_f.*blur_f;
%S_f_trimmed = fftshift(S_f);
s_out = ifft2(S_f);
s_out_trimmed = ifftshift(s_out);
subplot(233); imagesc(s_out_trimmed); title ('Imatge sortida s(x,y)')

% per restaurar faig la divisió
S_restore = S_f./blur_f;
s_restore = ifft2(S_restore);
s_restore_trimmed = ifftshift(s_restore);
subplot(236); imagesc(s_restore); title ('Imatge restaurada ê(x,y)')

% ========================================================================
% ACTIVITAT 2.7. Repetiu el procediment amb l'efecte del moviment
% utilitzant com a sistema la imatge 'SEGMENTB.RAW'
% ========================================================================
