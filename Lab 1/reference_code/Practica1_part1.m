
% Per fer aquesta part utilitzarem les imatges que teniu dintre de la
% carpeta 'exemples_imatges'

% ========================================================================
%                1. Visualització, histograma i Contrast  
% ========================================================================

% Llegir una imatge que té tres canals (R,G,B)
img = imread ('BerkeleyTower.png');
size (img) % mida de la matriu de la imatge
figure; imagesc(img) % visualitzem els tres canals junts

% creem una figura nova, si no posem aquesta línia es genera de forma
% automàtica, però no podrem controlar la mida i a vegades sobreescriu.
figure ('Color', 'white', 'Position', [0 0 1200 400]); 
subplot(131); imagesc(img(:,:,1)); title ('Red');
subplot(132); imagesc(img(:,:,2)); title ('Green');
subplot(133); imagesc(img(:,:,3)); title ('Blue');
colormap(gray(256))

% També podem visualitzar amb la eina imshow
figure ('Color', 'white', 'Position', [0 0 1200 400]); 
subplot(131); imshow(img(:,:,1)); title ('Red');
subplot(132); imshow(img(:,:,2)); title ('Green');
subplot(133); imshow(img(:,:,3)); title ('Blue');
colormap(gray(256))

% A partir d'ara treballarem sempre amb imatges d'un unic canal
img_gray = rgb2gray (img);
size(img_gray) % mida de la nova imatge. Observeu diferències?

% ========================================================================
% PREGUNTA 1.1 Indiqueu quina és la resolució espacial i de profunditat de la
% imatge img_gray
% ========================================================================

% HISTOGRAMA
imhist(img_gray) % funció bàsica que ens permet veure l'histograma de la imatge

% CANVIS LINEALS
linadj_img = imadjust(img_gray, [0.3, 0.7], []); % proveu de canviar els paràmetres
figure ('Color', 'white', 'Position', [0 0 1200 800]);
subplot(221); imshow (img_gray); title ('original gray image')
subplot (222); imhist (img_gray); title ('original histogram')
subplot (223); imshow (linadj_img); title ('adjusted image')
subplot (224); imhist (linadj_img); title ('adjusted histogram')

% EQUALITZACIO HISTOGRAMA
eq_img = histeq(img_gray);
figure ('Color', 'white', 'Position', [0 0 1200 800]);
subplot(221); imshow (img_gray); title ('original gray image')
subplot (222); imhist (img_gray); title ('original histogram')
subplot (223); imshow (eq_img); title ('equalized image')
subplot (224); imhist (eq_img); title ('equalized histogram')

% ========================================================================
% PREGUNTA 1.2. Experimenteu amb les modificacions de l'histograma
% utilitzant l'imatge 'Unequalized_Hawkes_Bay_NZ'
% ========================================================================

% ========================================================================
%                2. Filtres 
% ========================================================================

% FILTRE PAS BAIX
img = imread ('cameraman.tif');
img = im2double (img); % per si no ho és
f = ones(3,3)/9; 
img_lpf1 = filter2(f, img); 
figure ('Color', 'white', 'Position', [0 0 1200 800]);
subplot(221); imshow (img); title ('original')
subplot(222); imshow (img_lpf1); title ('filtrada pas baix (tot uns)')
% podem provar un altre filtre pas baix
f2 = [1 2 1; 2 4 2; 1 2 1]/16;
img_lpf2 = filter2(f2, img); 
subplot(223); imshow (img); title ('original')
subplot(224); imshow (img_lpf2); title ('filtrada pas baix (gaussià)')

% FILTRE PASSA ALT
f_hpf = [-1 -1 -1; -1 8 -1; -1 -1 -1];
img_hpf = filter2(f_hpf, img); 
figure ('Color', 'white', 'Position', [0 0 1200 800]);
subplot(221); imshow (img); title ('original')
subplot(222); imshow (img_hpf); title ('filtrada pas alt (laplacià)')
f_hpf_vertical = [-1 1 0; -1 1 0; -1 1 0];
img_hpf_vertical = filter2(f_hpf_vertical, img); 
subplot(223); imshow (img); title ('original')
subplot(224); imshow (img_hpf_vertical); title ('filtrada pas alt (vertical)')

% ========================================================================
% PREGUNTA 1.3. Proveu altres filtres creant diferents matrius
% ========================================================================

% FILTRE DE MEDIANA
img_spnoise = imnoise (img, 'salt & pepper', 0.02);
img_spnoise_lpf = filter2(f2, img_spnoise); % provo d'utilitzar el filtre gaussià
figure ('Color', 'white', 'Position', [0 0 1200 800]);
subplot(221); imshow (img_spnoise); title ('original with s&p noise')
subplot(222); imshow (img_spnoise_lpf); title ('after gaussian filter')
img_spnoise_medfilter= medfilt2(img_spnoise); 
subplot(223); imshow (img_spnoise); title ('original with s&p noise')
subplot(224); imshow (img_spnoise_medfilter); title ('after median filter')

% ========================================================================
% PREGUNTA 1.4. Canvieu el nivell de soroll i el kernel del filtre
% ========================================================================