%@author: Madeline Shao
%% Randomizing experiment with 2 conditions Experiment C
try
    Screen('Preference','SkipSyncTests',1);
    rng('shuffle'); %reseeds random number generator
    [window,rect]=Screen('OpenWindow',0) %window: name of window, %rect, coords of window
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %makes transparent
    HideCursor(); 

    window_w = rect(3);
    window_h = rect(4);
    center_x = window_w/2; %x center of screen
    center_y = window_h/2; %y center of screen

    ntrials = 10; % define number of trials  
    conditions = repmat([1 49], 1, 5);  % create a vector using repmat where 1 represents one condition (perfect oranges). 49 represents the other condition (moldy oranges). 
    order = Shuffle(conditions); % shuffle the above vector. 
           
    cd('Stimuli');
    mask = imread('mask.png');
    mask = mask(:,:,1);

    img1 = imread ('1.png'); 
    img1(:,:,4)  = mask;
    texture1(1) = Screen('MakeTexture', window, img1); 
    texture1(2) = Screen('MakeTexture', window, img1); 

    img49 = imread ('49.png'); 
    img49(:,:,4)  = mask;
    texture2(1) = Screen('MakeTexture', window, img49); 
    texture2(2) = Screen('MakeTexture', window, img49); 

    image_size =  size(img1);
    image_height = image_size(1);
    image_width = image_size(2);

    gridLocX = linspace(image_width, window_w - image_width, 2);
    gridLocY = linspace(center_y, center_y, 1);
        [x, y] = meshgrid(gridLocX, gridLocY); %grid of display points

        xy_rect = [x(:)'-image_width/2; y(:)'-image_height/2; x(:)'+image_width/2; y(:)'+image_height/2];

    for i = 1:ntrials
        if order(i)==1
            Screen('DrawTextures',window,texture1, [], xy_rect);
            Screen('Flip', window);
        else
            Screen('DrawTextures',window,texture2, [], xy_rect);
            Screen('Flip', window);
        end
        KbWait;
        Screen('Flip',window);          
        WaitSecs(0.5);
    end
    Screen('CloseAll');
catch
    Screen( 'CloseAll');
    rethrow(lasterror)
end
