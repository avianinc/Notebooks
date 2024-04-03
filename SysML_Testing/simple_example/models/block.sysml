package block {
    import ScalarValues::*;
    
    attribute def Length;
    attribute def Width;
    attribute def Height;
    attribute def Volume;
    
    par def Block {
        attribute length: Length;
        attribute width: Width;
        attribute heigth: Height;
        attribute volume: Volume;
    }
    
    part block_1 {
        attribute i_length: Real = 2;
        attribute i_width: Real = 2;
        attribute i_heigth: Real = 2;
        attribute volume: Real = 0;
    }
    
    analysis def VolumeAnalysis {
        subject block_1: Block
    }
}