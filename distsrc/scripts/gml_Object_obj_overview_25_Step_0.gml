switch (state)
{
    case 1:
        if (!instance_exists(obj_dialogue_cutscene))
        {
            with (instance_create(0, 0, obj_dialogue_cutscene))
            {
                if (global.language == "English")
                {
                    ds_priority_add(text_holder, "Standing now outside the palace, the Revolution holds its breath.", 1);
                    ds_priority_add(text_holder, "Months of hardship and warfare have led to this confrontation. They will finally reach Varic, or perish in the attempt.", 2);
                    ds_priority_add(text_holder, "Though nothing is assured, the Revolution's resolve has never been stronger.", 3);
                }
                else if (global.language == "French")
                {
                    ds_priority_add(text_holder, "Se tenant en dehors du palais, les révolutionnaires retiennent leur souffle.", 1);
                    ds_priority_add(text_holder, "Cette confrontation a lieu au terme de longs mois de privation et de combats. Ils peuvent finalement atteindre Varic ou périr en essayant.", 2);
                    ds_priority_add(text_holder, "Bien que rien ne soit déjà écrit, la détermination de la Révolution n’a jamais été si grande.", 3);
                }
                else if (global.language == "Italian")
                {
                    ds_priority_add(text_holder, "I membri della rivoluzione aspettano fuori dal palazzo con il fiato sospeso.", 1);
                    ds_priority_add(text_holder, "Mesi e mesi di difficoltà e battaglie li hanno portati fino a questo confronto. Finalmente raggiungeranno Varic o moriranno nel tentativo.", 2);
                    ds_priority_add(text_holder, "Anche se nulla è certo, la loro risolutezza non è mai stata tanto salda.", 3);
                }
                else if (global.language == "German")
                {
                    ds_priority_add(text_holder, "Die Revolutionäre stehen nun vor dem Palast und halten den Atem an.", 1);
                    ds_priority_add(text_holder, "Lange Monate von Entbehrungen und Kämpfen haben zu dieser Konfrontation geführt. Endlich werden sie Varic erreichen oder bei dem Versuch sterben.", 2);
                    ds_priority_add(text_holder, "Zwar ist noch nichts sicher, aber die Revolution ist entschlossener denn je.", 3);
                }
                else if (global.language == "Spanish")
                {
                    ds_priority_add(text_holder, "Ya fuera del palacio, la revolución contiene la respiración.", 1);
                    ds_priority_add(text_holder, "Meses de penurias y guerras han desembocado en este enfrentamiento. Por fin van a alcanzar a Varic, o perecerán en el intento.", 2);
                    ds_priority_add(text_holder, "Aunque nada está asegurado, la determinación de la revolución nunca ha sido más firme.", 3);
                }
                else if (global.language == "Japanese")
                {
                    ds_priority_add(text_holder, "宮殿の外に立つ革命軍は、全員が静かな覚悟と共に息を呑んだ。", 1);
                    ds_priority_add(text_holder, "何ヶ月にもわたる苦難と戦争が、この決戦に集約される。その結末は、ヴァリック王を倒すか、中途で死に倒れるかのみだ。", 2);
                    ds_priority_add(text_holder, "何も保証はなくとも、革命軍の決意はかつてないほど強力になっていた。", 3);
                }
                else if (global.language == "Korean")
                {
                    ds_priority_add(text_holder, "혁명군은 지금 궁전 밖에 서서 숨을 죽이고 있습니다.", 1);
                    ds_priority_add(text_holder, "수개월 동안의 고난과 전쟁이 이 대결로 이어졌습니다. 그들은 결국 배릭에게 도달하거나 시도하다 죽어갈 것입니다.", 2);
                    ds_priority_add(text_holder, "아무것도 장담할 수는 없지만, 혁명군의 결의는 그 어느 때보다도 강했습니다.", 3);
                }
                else if (global.language == "Chinese")
                {
                    ds_priority_add(text_holder, "现在站在宫殿外，革命者们屏住了呼吸。", 1);
                    ds_priority_add(text_holder, "数月的艰辛和战争导致了这种对抗。他们最终将要么推翻瓦里克，要么在尝试中灭亡。", 2);
                    ds_priority_add(text_holder, "虽然什么都不能确定，但革命的决心从未如此强烈。", 3);
                }
                
                text = ds_priority_delete_min(text_holder);
                actorpool1 = ds_priority_create();
                actor1 = -4;
                speaker = "";
                speakerpool = ds_priority_create();
                positionpool = ds_priority_create();
            }
            
            alarm[1] = 1;
            JJ = false;
        }
        
        break;
    
    case 2:
        if (JJ && !instance_exists(obj_dialogue_cutscene))
        {
            with (obj_irving)
            {
                path_start(path121, movespeed, path_action_stop, false);
                state = "moving";
            }
            
            JJ = false;
            alarm[1] = 1;
        }
        
        break;
    
    case 3:
        if (JJ)
        {
            alarm[5] = 60;
            alarm[1] = 1;
        }
        
        break;
}
