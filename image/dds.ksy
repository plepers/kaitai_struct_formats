meta:
  id: dds
  file-extension: dds
  title: DirectDraw Surface container file format (compressed texture)
  endian: le
seq:
  - id: magic
    contents: [0x44, 0x44, 0x53, 0x20]
  - id: header
    type: header
  - id: header_dx10
    type: header_dx10
    if: header.ddspf.four_cc == four_cc::dx10
  - id: data 
    size-eos: true
types:
  header:
    seq: 
      - id : size
        type: u4
      - id : flags
        type: u4
      - id : height
        type: u4
      - id : width
        type: u4
      - id : pitch_or_linear_size
        type: u4
      - id : depth
        type: u4
      - id : mip_map_count
        type: u4
      - id : reserved1
        size: 44
      - id : ddspf
        type: pixelformat
      - id : caps
        type: u4
      - id : caps2
        type: u4
      - id : caps3
        type: u4
      - id : caps4
        type: u4
      - id : reserved2
        type: u4
    instances:
      # FLAGS
      ddsd_caps:
        value: (flags & 0x1)!=0
      ddsd_height:
        value: (flags & 0x2)!=0
      ddsd_width:
        value: (flags & 0x4)!=0
      ddsd_pitch:
        value: (flags & 0x8)!=0
      ddsd_pixelformat:
        value: (flags & 0x1000)!=0
      ddsd_mipmapcount:
        value: (flags & 0x20000)!=0
      ddsd_linearsize:
        value: (flags & 0x80000)!=0
      ddsd_depth:
        value: (flags & 0x800000)!=0
      # CAPS
      ddscaps_complex :
        value : (caps & 0x8)!=0
      ddscaps_mipmap  :
        value : (caps & 0x400000)!=0
      ddscaps_texture :
        value : (caps & 0x1000)!=0
      # CAPS2
      ddscaps2_cubemap :
        value: (caps2 & 0x200)!=0
      ddscaps2_cubemap_positivex :
        value: (caps2 & 0x400)!=0
      ddscaps2_cubemap_negativex :
        value: (caps2 & 0x800)!=0
      ddscaps2_cubemap_positivey :
        value: (caps2 & 0x1000)!=0
      ddscaps2_cubemap_negativey :
        value: (caps2 & 0x2000)!=0
      ddscaps2_cubemap_positivez :
        value: (caps2 & 0x4000)!=0
      ddscaps2_cubemap_negativez :
        value: (caps2 & 0x8000)!=0
      ddscaps2_volume :
        value: (caps2 & 0x200000)!=0
  header_dx10:
    seq:
      - id: dxgi_format
        type: u4 
        enum: dxgi_format 
      - id: resource_dimension
        type: u4 
        enum: d3d10_resource_dimension 
      - id: misc_flag
        type: u4
      - id: array_size
        type: u4
      - id: misc_flags2
        type: u4
    instances:
      resource_misc_texturecube:
        value: (misc_flag & 0x4)!=0
      alpha_mode:
        value: (misc_flags2 & 0x3)
        enum: d3d10_alpha_mode 
  pixelformat:
    seq:
      - id: size
        type : u4
      - id: flags
        type : u4
      - id: four_cc
        type : u4
        enum : four_cc
      - id: rgb_bit_count
        type : u4
      - id: r_bit_mask
        type : u4
      - id: g_bit_mask
        type : u4
      - id: b_bit_mask
        type : u4
      - id: a_bit_mask
        type : u4
    instances:
      ddpf_alphapixels:
        value: (flags & 0x1)!=0
      ddpf_alpha      :
        value: (flags & 0x2)!=0
      ddpf_fourcc     :
        value: (flags & 0x4)!=0
      ddpf_rgb        :
        value: (flags & 0x40)!=0
      ddpf_yuv        :
        value: (flags & 0x200)!=0
      ddpf_luminance  :
        value: (flags & 0x20000)!=0
enums:
  four_cc:
    0x31545844 : d3dfmt_dxt1
    0x33545844 : d3dfmt_dxt3
    0x35545844 : d3dfmt_dxt5
    0x55344342 : d3dfmt_bc4_unorm
    0x53344342 : d3dfmt_bc4_snorm
    0x32495441 : d3dfmt_bc5_unorm
    0x53354342 : d3dfmt_bc5_snorm
    0x47424752 : d3dfmt_r8g8_b8g8
    0x42475247 : d3dfmt_g8r8_g8b8
    0x32545844 : d3dfmt_dxt2
    0x34545844 : d3dfmt_dxt4
    0x59565955 : d3dfmt_uyvy
    0x32595559 : d3dfmt_yuy2
    0x30315844 : dx10 
    36         : d3dfmt_a16b16g16r16
    110        : d3dfmt_q16w16v16u16
    111        : d3dfmt_r16f
    112        : d3dfmt_g16r16f
    113        : d3dfmt_a16b16g16r16f
    114        : d3dfmt_r32f
    115        : d3dfmt_g32r32f
    116        : d3dfmt_a32b32g32r32f
    117        : d3dfmt_cxv8u8
  dxgi_format:
    0 :   dxgi_unknown                     
    1 :   dxgi_r32g32b32a32_typeless       
    2 :   dxgi_r32g32b32a32_float          
    3 :   dxgi_r32g32b32a32_uint           
    4 :   dxgi_r32g32b32a32_sint           
    5 :   dxgi_r32g32b32_typeless          
    6 :   dxgi_r32g32b32_float             
    7 :   dxgi_r32g32b32_uint              
    8 :   dxgi_r32g32b32_sint              
    9 :   dxgi_r16g16b16a16_typeless       
    10 :  dxgi_r16g16b16a16_float          
    11 :  dxgi_r16g16b16a16_unorm          
    12 :  dxgi_r16g16b16a16_uint           
    13 :  dxgi_r16g16b16a16_snorm          
    14 :  dxgi_r16g16b16a16_sint           
    15 :  dxgi_r32g32_typeless             
    16 :  dxgi_r32g32_float                
    17 :  dxgi_r32g32_uint                 
    18 :  dxgi_r32g32_sint                 
    19 :  dxgi_r32g8x24_typeless           
    20 :  dxgi_d32_float_s8x24_uint        
    21 :  dxgi_r32_float_x8x24_typeless    
    22 :  dxgi_x32_typeless_g8x24_uint     
    23 :  dxgi_r10g10b10a2_typeless        
    24 :  dxgi_r10g10b10a2_unorm           
    25 :  dxgi_r10g10b10a2_uint            
    26 :  dxgi_r11g11b10_float             
    27 :  dxgi_r8g8b8a8_typeless           
    28 :  dxgi_r8g8b8a8_unorm              
    29 :  dxgi_r8g8b8a8_unorm_srgb         
    30 :  dxgi_r8g8b8a8_uint               
    31 :  dxgi_r8g8b8a8_snorm              
    32 :  dxgi_r8g8b8a8_sint               
    33 :  dxgi_r16g16_typeless             
    34 :  dxgi_r16g16_float                
    35 :  dxgi_r16g16_unorm                
    36 :  dxgi_r16g16_uint                 
    37 :  dxgi_r16g16_snorm                
    38 :  dxgi_r16g16_sint                 
    39 :  dxgi_r32_typeless                
    40 :  dxgi_d32_float                   
    41 :  dxgi_r32_float                   
    42 :  dxgi_r32_uint                    
    43 :  dxgi_r32_sint                    
    44 :  dxgi_r24g8_typeless              
    45 :  dxgi_d24_unorm_s8_uint           
    46 :  dxgi_r24_unorm_x8_typeless       
    47 :  dxgi_x24_typeless_g8_uint        
    48 :  dxgi_r8g8_typeless               
    49 :  dxgi_r8g8_unorm                  
    50 :  dxgi_r8g8_uint                   
    51 :  dxgi_r8g8_snorm                  
    52 :  dxgi_r8g8_sint                   
    53 :  dxgi_r16_typeless                
    54 :  dxgi_r16_float                   
    55 :  dxgi_d16_unorm                   
    56 :  dxgi_r16_unorm                   
    57 :  dxgi_r16_uint                    
    58 :  dxgi_r16_snorm                   
    59 :  dxgi_r16_sint                    
    60 :  dxgi_r8_typeless                 
    61 :  dxgi_r8_unorm                    
    62 :  dxgi_r8_uint                     
    63 :  dxgi_r8_snorm                    
    64 :  dxgi_r8_sint                     
    65 :  dxgi_a8_unorm                    
    66 :  dxgi_r1_unorm                    
    67 :  dxgi_r9g9b9e5_sharedexp          
    68 :  dxgi_r8g8_b8g8_unorm             
    69 :  dxgi_g8r8_g8b8_unorm             
    70 :  dxgi_bc1_typeless                
    71 :  dxgi_bc1_unorm                   
    72 :  dxgi_bc1_unorm_srgb              
    73 :  dxgi_bc2_typeless                
    74 :  dxgi_bc2_unorm                   
    75 :  dxgi_bc2_unorm_srgb              
    76 :  dxgi_bc3_typeless                
    77 :  dxgi_bc3_unorm                   
    78 :  dxgi_bc3_unorm_srgb              
    79 :  dxgi_bc4_typeless                
    80 :  dxgi_bc4_unorm                   
    81 :  dxgi_bc4_snorm                   
    82 :  dxgi_bc5_typeless                
    83 :  dxgi_bc5_unorm                   
    84 :  dxgi_bc5_snorm                   
    85 :  dxgi_b5g6r5_unorm                
    86 :  dxgi_b5g5r5a1_unorm              
    87 :  dxgi_b8g8r8a8_unorm              
    88 :  dxgi_b8g8r8x8_unorm              
    89 :  dxgi_r10g10b10_xr_bias_a2_unorm  
    90 :  dxgi_b8g8r8a8_typeless           
    91 :  dxgi_b8g8r8a8_unorm_srgb         
    92 :  dxgi_b8g8r8x8_typeless           
    93 :  dxgi_b8g8r8x8_unorm_srgb         
    94 :  dxgi_bc6h_typeless               
    95 :  dxgi_bc6h_uf16                   
    96 :  dxgi_bc6h_sf16                   
    97 :  dxgi_bc7_typeless                
    98 :  dxgi_bc7_unorm                   
    99 :  dxgi_bc7_unorm_srgb              
    100 : dxgi_ayuv                        
    101 : dxgi_y410                        
    102 : dxgi_y416                        
    103 : dxgi_nv12                        
    104 : dxgi_p010                        
    105 : dxgi_p016                        
    106 : dxgi_420_opaque                  
    107 : dxgi_yuy2                        
    108 : dxgi_y210                        
    109 : dxgi_y216                        
    110 : dxgi_nv11                        
    111 : dxgi_ai44                        
    112 : dxgi_ia44                        
    113 : dxgi_p8                          
    114 : dxgi_a8p8                        
    115 : dxgi_b4g4r4a4_unorm              
    130 : dxgi_p208                        
    131 : dxgi_v208                        
    132 : dxgi_v408                        
    0xffffffff : dxgi_force_uint   
  d3d10_resource_dimension :
    0: d3d10_resource_dimension_unknown
    1: d3d10_resource_dimension_buffer
    2: d3d10_resource_dimension_texture1d
    3: d3d10_resource_dimension_texture2d
    4: d3d10_resource_dimension_texture3d
  d3d10_alpha_mode:
    0: d3d10_alpha_mode_unknown
    1: d3d10_alpha_mode_straight
    2: d3d10_alpha_mode_premultiplied
    3: d3d10_alpha_mode_opaque
    4: d3d10_alpha_mode_custom
