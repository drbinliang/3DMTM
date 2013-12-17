function MHI = computeMHI(GESTURE, t)

%% value of t
if nargin < 2
    t = length(GESTURE);
end

num_frames = length(GESTURE);

%%
ORIGINAL = GESTURE{1};
ORIGINAL_BIN_IMG = ORIGINAL;
ORIGINAL_BIN_IMG(ORIGINAL > 0) = 1;

if t == 1
    MHI = ORIGINAL_BIN_IMG;
    return;
end

%% generate binary images
CURRENT = GESTURE{t};
PREVIOUS = GESTURE{t - 1};

CURRENT_BIN_IMG = CURRENT;
CURRENT_BIN_IMG(CURRENT > 0) = 1;
PREVIOUS_BIN_IMG = PREVIOUS;
PREVIOUS_BIN_IMG(PREVIOUS > 0) = 1;

DIFF = frameDiff(CURRENT_BIN_IMG, PREVIOUS_BIN_IMG);

MHI = DIFF;
MHI(DIFF == 1) = num_frames;

TMP = max(0, computeMHI(GESTURE, t-1) -1);
MHI(DIFF ~= 1) = TMP(DIFF ~= 1);

end