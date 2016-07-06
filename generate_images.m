% generate images for zooniverse platform
path_preproc = '/media/yassinebha/database24/MAVEN_06_2016/fmri_preprocess_INSCAPE_REST/';
files_in = niak_grab_qc_fmri_preprocess(path_preproc);
folder_out = '/media/yassinebha/database24/MAVEN_06_2016/qc_report2/';

for ss = 1:length(fieldnames(files_in.func))
    subj_id = fieldnames(files_in.func){ss};
    %% Generate the image for the structural scan
    fprintf('%s : Generating slices of the anatomical scan...\n',subj_id);
    in_a.source = files_in.anat.(subj_id);
    in_a.target = files_in.template;
    out_a = [folder_out 'summary_' subj_id '_anat.jpg'];
    opt_a.coord = [-30 , -65 , -15 ; 
                   -8 , -25 ,  10 ;  
                    30 ,  45 ,  60];
    opt_a.colorbar = false;
    opt_a.colormap = 'gray';
    opt_a.limits = 'adaptative';
    opt_a.title = '';
    opt_a.flag_decoration = false;
    niak_brick_vol2img(in_a,out_a,opt_a);
    end

    %% Generate the image for the template
    if ~strcmp(out.template,'gb_niak_omitted')
        if opt.flag_verbose
            fprintf('Generating slices of the template...\n');
        end
        in_v.source = in.template;
        in_v.target = in.template;
        out_v = out.template;
        opt_v.coord = opt.coord;
        opt_v.colorbar = false;
        opt_v.colormap = 'gray';
        opt_v.limits = 'adaptative';
        opt_v.title = sprintf('       template, %s',opt.id);
        niak_brick_vol2img(in_v,out_v,opt_v);
    end

    %% Generate the image for the functional scan
    if ~strcmp(out.func,'gb_niak_omitted')
        if opt.flag_verbose
            fprintf('Generating slices of the functional scan...\n');
        end
        in_v.source = in.func;
        in_v.target = in.template;
        out_v = out.func;
        opt_v.coord = opt.coord;
        opt_v.colorbar = false;
        opt_v.colormap = 'jet';
        opt_v.limits = 'adaptative';
        opt_v.title = sprintf('functional scan, %s',opt.id);
        niak_brick_vol2img(in_v,out_v,opt_v);
    end

    
    ## bash command convert to gif: "convert summary_template.jpg  summary_X0010001_anat.jpg summary_template.jpg -delay 2 -morph 3 morph.gif"
    ## bash command to resize :  "mogrify -resize 450x450 morph.gif"
