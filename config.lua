
Config = {
    dog_anim = {
        sit = {
            dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
            anim = "idle_b"
        },
        laydown = {
            dict = "creatures@rottweiler@amb@sleep_in_kennel@",
            anim = "sleep_in_kennel"
        },    
      
    },

    employerNpc = {
        [1] = {
            active = false,
            employer_coords = vector3(147.23443, -1903.69, 23.531667),
            employer_heading =  350.06881,
            employer_model = `a_f_y_eastsa_01`,
            employer_handler = nil,
            employer_name = 'Lady',
            
            draw_text_label = 'E - Talk With Lady',

            dog_coords = vector3(148.22146, -1904.339, 23.531667),
            dog_heading = 28.438611,

            dog_model =  `a_c_rottweiler`,
            dog_handler = nil,

            possible_prices = { 100, 200, 300 },
            price = 100,
        
                            -- 10m     20m      30m
            possible_times = { 15000, 20000, 30000 },
            time = 0,
        
            possible_dialogs = {
                [1] = {
                    { label = "Hello, do you need a dog sitter?", owner = "player" },
                    { label = "Do you want me to walk your dog? ", owner = "player" },
                },
                [2] = {

                    { label = "Yeah that's exactly what I needed", owner = "npc"},
                    { label = "Yeah that's exactly what I needed but I don't have time to tour", owner = "npc"},
                    { label = "Yes my dog needs a walk ", owner = "npc"}
                },
                [3] = {

                    {label = "How can I help you", owner = "player"},
                    {label = "I want to help you ", owner = "player"},
                },
                [4] = {
                    {label = "That would be great please I'll pay for it when the collar is back ", owner = "npc"},
                    {label = "Thank you please take good care of him I'll pay for him when he gets back", owner = "npc"},
                },

            },
            dialogs = {
                [1] = "", 
                [2] = "",
                [3] = "",
                [4] = "",
            },

        },
        [2] = {
            active = false,
            employer_coords = vector3(191.91096, -1883.319, 25.056726),
            employer_heading =  155.06881,
            employer_model = `a_f_y_eastsa_01`,
            employer_handler = nil,
            employer_name = 'Lady',
            
            draw_text_label = 'E - Talk With Lady',

            dog_coords = vector3(193.27159, -1883.964, 25.056732),
            dog_heading = 155.438611,

            dog_model =  `a_c_rottweiler`,
            dog_handler = nil,

            possible_prices = { 100, 200, 300 },
            price = 100,
    
                            -- 10m     20m      30m
            possible_times = { 5000, 10000, 15000 },
            time = 0,
                 
            possible_dialogs = {
                [1] = {
                    { label = "Hello, do you need a dog sitter?", owner = "player" },
                    { label = "Do you want me to walk your dog? ?", owner = "player" },
                },
                [2] = {

                    { label = "Yeah that's exactly what I needed", owner = "npc"},
                    { label = "Yeah that's exactly what I needed but I don't have time to tour", owner = "npc"},
                    { label = "Yes my dog needs a walk ", owner = "npc"}
                },
                [3] = {

                    {label = "How can I help you", owner = "player"},
                    {label = "I want to help you ", owner = "player"},
                },
                [4] = {
                    {label = "That would be great please I'll pay for it when the collar is back ", owner = "npc"},
                    {label = "Thank you please take good care of him I'll pay for him when he gets back", owner = "npc"},
                },

            },
            dialogs = {
                [1] = "", 
                [2] = "",
                [3] = "",
                [4] = "",
            },

        },

    }
}