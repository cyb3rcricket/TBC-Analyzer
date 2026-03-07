<%@ Page Language="C#" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>TBC Sentiment Analyzer – What Do You Love About Burning Crusade?</title>
        <style>
            body {
                background-color: #0a0f0a;
                color: #e0e0e0;
                font-family: 'Segoe UI', Tahoma, sans-serif;
                margin: 0;
                padding: 0;
                overflow-x: hidden;
            }

            .container {
                max-width: 800px;
                margin: 0 auto;
                padding: 60px 20px;
            }

            .hero {
                text-align: center;
                margin-bottom: 50px;
            }

            .hero h1 {
                color: #00ff9d;
                text-shadow: 0 0 20px #00ff9d;
                font-size: 3em;
                text-transform: uppercase;
                margin: 0;
            }

            .hero p {
                color: #ffd700;
                font-size: 1.2em;
                text-transform: uppercase;
                letter-spacing: 3px;
                margin-top: 10px;
            }

            .question-card {
                background: #111a11;
                border-left: 5px solid #00ff9d;
                border-radius: 8px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            }

            .question-text {
                color: #ffd700;
                font-size: 1.25em;
                font-weight: bold;
                margin-bottom: 20px;
                display: block;
            }

            .rbl-options {
                width: 100%;
            }

            .rbl-options input[type="radio"] {
                margin-right: 15px;
                accent-color: #00ff9d;
                transform: scale(1.3);
                cursor: pointer;
            }

            .rbl-options label {
                font-size: 1.1em;
                color: #ccc;
                cursor: pointer;
                line-height: 2;
                transition: color 0.2s;
            }

            .rbl-options label:hover {
                color: #fff;
            }

            .submit-btn {
                display: block;
                width: 100%;
                background: #00ff9d;
                color: #0a0f0a;
                border: none;
                padding: 20px;
                font-size: 1.5em;
                font-weight: bold;
                border-radius: 10px;
                cursor: pointer;
                text-transform: uppercase;
                box-shadow: 0 0 15px #00ff9d;
                transition: all 0.3s;
                margin-top: 40px;
            }

            .submit-btn:hover {
                background: #ffd700;
                box-shadow: 0 0 25px #ffd700;
                transform: translateY(-2px);
            }

            .validation-msg {
                color: #ff4444;
                font-weight: bold;
                margin-top: 10px;
                display: block;
            }

            .summary-box {
                background: #2a0a0a;
                border: 1px solid #ff4444;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                color: #ff4444;
            }

            /* Results Panel Styles */
            .results-card {
                background: #111a11;
                border: 2px solid #00ff9d;
                border-radius: 15px;
                padding: 40px;
                text-align: center;
                box-shadow: 0 0 30px rgba(0, 255, 157, 0.2);
            }

            .passion-score {
                font-size: 5em;
                color: #ffd700;
                font-weight: bold;
                text-shadow: 0 0 25px #ffd700;
                margin: 20px 0;
            }

            .score-label {
                font-size: 1.5em;
                color: #00ff9d;
                text-transform: uppercase;
                letter-spacing: 2px;
            }

            .cat-box {
                text-align: left;
                margin-top: 40px;
            }

            .cat-row {
                margin-bottom: 20px;
            }

            .cat-name {
                color: #ffd700;
                font-weight: bold;
                text-transform: uppercase;
                font-size: 0.9em;
                margin-bottom: 8px;
                display: block;
            }

            .progress-bg {
                background: #000;
                height: 30px;
                border-radius: 15px;
                overflow: hidden;
                border: 1px solid #333;
            }

            .progress-fill {
                height: 100%;
                background: linear-gradient(90deg, #008f58, #00ff9d);
                box-shadow: 0 0 15px #00ff9d;
                width: 0%;
                transition: width 1.5s ease-out;
                text-align: right;
                line-height: 30px;
                color: #000;
                padding-right: 15px;
                font-weight: bold;
            }

            .analysis-text {
                font-size: 1.2em;
                line-height: 1.7;
                color: #e0e0e0;
                margin: 40px 0;
                padding: 30px;
                background: #0a0f0a;
                border-radius: 10px;
                border-top: 3px solid #ffd700;
                text-align: left;
            }

            .reset-btn {
                background: transparent;
                color: #ffd700;
                border: 2px solid #ffd700;
                padding: 15px 40px;
                font-size: 1.1em;
                font-weight: bold;
                border-radius: 8px;
                cursor: pointer;
                text-transform: uppercase;
                transition: 0.3s;
            }

            .reset-btn:hover {
                background: #ffd700;
                color: #0a0f0a;
                box-shadow: 0 0 20px #ffd700;
            }
        </style>

        <script runat="server">
        protected void btnSubmit_Click(object sender, EventArgs e)
            {
                if (!Page.IsValid) return;

            // Categories: RaidGod, PvPLegend, OutlandExplorer, ClassPurist, LoreAddict
            double raid = 0, pvp = 0, exp = 0, cls = 0, lore = 0;

                // Scoring Logic using a mapping function for conciseness and clarity
                ProcessScore(rblQ1.SelectedValue, "RaidGod", "LoreAddict", "ClassPurist", "RaidGod", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ2.SelectedValue, "OutlandExplorer", "LoreAddict", "OutlandExplorer", "RaidGod", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ3.SelectedValue, "PvPLegend", "OutlandExplorer", "ClassPurist", "PvPLegend", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ4.SelectedValue, "LoreAddict", "RaidGod", "PvPLegend", "LoreAddict", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ5.SelectedValue, "LoreAddict", "OutlandExplorer", "OutlandExplorer", "RaidGod", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ6.SelectedValue, "OutlandExplorer", "RaidGod", "PvPLegend", "ClassPurist", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ7.SelectedValue, "ClassPurist", "PvPLegend", "ClassPurist", "RaidGod", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ8.SelectedValue, "RaidGod", "OutlandExplorer", "ClassPurist", "ClassPurist", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ9.SelectedValue, "PvPLegend", "LoreAddict", "LoreAddict", "PvPLegend", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ10.SelectedValue, "RaidGod", "LoreAddict", "RaidGod", "OutlandExplorer", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ11.SelectedValue, "OutlandExplorer", "PvPLegend", "OutlandExplorer", "OutlandExplorer", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ12.SelectedValue, "RaidGod", "PvPLegend", "LoreAddict", "ClassPurist", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ13.SelectedValue, "OutlandExplorer", "LoreAddict", "RaidGod", "OutlandExplorer", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ14.SelectedValue, "ClassPurist", "PvPLegend", "RaidGod", "RaidGod", ref raid, ref pvp, ref exp, ref cls, ref lore);
                ProcessScore(rblQ15.SelectedValue, "RaidGod", "PvPLegend", "OutlandExplorer", "LoreAddict", ref raid, ref pvp, ref exp, ref cls, ref lore);

            double totalPoints = raid + pvp + exp + cls + lore;
            int passionScore = (int)((totalPoints / 45.0) * 100);
                lblPassionScore.Text = passionScore + "%";

                // Set progress bars (Max points per category roughly 15-20)
                SetBar(barRaid, raid);
                SetBar(barPvP, pvp);
                SetBar(barExp, exp);
                SetBar(barClass, cls);
                SetBar(barLore, lore);

                // Analysis Paragraph
                lblAnalysis.Text = GetAnalysis(raid, pvp, exp, cls, lore);

                pnlSurvey.Visible = false;
                pnlResults.Visible = true;
            }

        private void ProcessScore(string val, string a, string b, string c, string d, ref double r, ref double p, ref double e, ref double cl, ref double l)
            {
            string winner = (val == "A") ? a : (val == "B") ? b : (val == "C") ? c : d;
                if (winner == "RaidGod") r += 3;
                else if (winner == "PvPLegend") p += 3;
                else if (winner == "OutlandExplorer") e += 3;
                else if (winner == "ClassPurist") cl += 3;
                else if (winner == "LoreAddict") l += 3;
            }

        private void SetBar(HtmlGenericControl bar, double score)
            {
            int p = (int)Math.Min(100, (score / 15.0) * 100);
                bar.Style["width"] = p + "%";
                bar.InnerText = p + "%";
            }

        private string GetAnalysis(double raid, double pvp, double exp, double cls, double lore)
            {
                if (raid >= pvp && raid >= exp && raid >= cls && raid >= lore)
                    return "You are a true Raid God of the Burning Crusade. Standing amidst the chaos of 25-man encounters, you lived for precise DBM timers and the perfect rotation. Your heart still beats faster when you remember downing Illidan or Kael'thas for the very first time. For you, TBC was the absolute pinnacle of cooperative PvE perfection, proving definitively that you were totally prepared.";
                if (pvp >= raid && pvp >= exp && pvp >= cls && pvp >= lore)
                    return "You are a formidable PvP Legend. While others were out slaying dragons, you were calculating Resilience breakpoints and grinding rating in the Nagrand Arena. Your reflexes were honed by countless matches battling pillar-humping Resto Druids and burst-heavy Warlocks. The thrill of outplaying your opponents and acquiring Gladiator gear is what made Outland your true home.";
                if (exp >= raid && exp >= pvp && exp >= cls && exp >= lore)
                    return "You are a pure Outland Explorer. Your fondest memories involve taking to the skies on an epic flying mount for the first time, defying gravity above a shattered world. You immersed yourself endlessly in the alien beauty of Nagrand's floating islands and the harsh landscapes of Hellfire Peninsula. Every new zone was an adventure waiting to be uncovered, and you savored every moment of the journey.";
                if (cls >= raid && cls >= pvp && cls >= exp && cls >= lore)
                    return "You are a dedicated Class Purist. TBC was the golden era where your class identity finally found its perfect stride and viability. You obsessed over talent trees, unique macro setups, and optimizing the newly refined mechanics that let your specialization shine. You played not just to defeat bosses, but to master the very essence of your character's class fantasy.";

                return "You are a relentless Lore Addict. Scouring Outland for every shred of history, you immersed yourself profoundly in the tragedy of the Blood Elves and the plight of the Draenei. Lines of dialogue from Illidan and Kael'thas are permanently etched into your memory, driving your every quest. You didn't just play the expansion; you lived inside its living, breathing cosmic story.";
            }

        protected void btnReset_Click(object sender, EventArgs e)
            {
                Response.Redirect(Request.RawUrl);
            }
        </script>
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="container">
                <header class="hero">
                    <h1>TBC Sentiment Analyzer</h1>
                    <p>15 Questions &bull; Discover Your Burning Crusade Soul</p>
                </header>

                <asp:Panel ID="pnlSurvey" runat="server">
                    <asp:ValidationSummary ID="valSum" runat="server" CssClass="summary-box"
                        HeaderText="The Naaru demand answers! Please complete the following:" />

                    <!-- 15 Questions! Or should we play 20 questions? -->
                    <div class="question-card">
                        <span class="question-text">1. Which raid felt the most epic to you in TBC?</span>
                        <asp:RadioButtonList ID="rblQ1" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Karazhan – the opera, the prince, the whole haunted tower vibe
                            </asp:ListItem>
                            <asp:ListItem Value="B">B) Black Temple – standing on the bridge facing Illidan
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) Tempest Keep / The Eye – Kael'thas and the fel orbs
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) Serpentshrine Cavern – Lady Vashj underwater madness
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf1" runat="server" ControlToValidate="rblQ1"
                            ErrorMessage="Question 1 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">2. What did you love most about exploring Outland?</span>
                        <asp:RadioButtonList ID="rblQ2" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Flying on my epic mount for the first time</asp:ListItem>
                            <asp:ListItem Value="B">B) The alien, fel-corrupted beauty of the zones</asp:ListItem>
                            <asp:ListItem Value="C">C) Nagrand – the floating islands and music</asp:ListItem>
                            <asp:ListItem Value="D">D) Shadowmoon Valley – the shattered landscape and Black Temple
                                looming</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf2" runat="server" ControlToValidate="rblQ2"
                            ErrorMessage="Question 2 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">3. How did you spend your time in the Arena?</span>
                        <asp:RadioButtonList ID="rblQ3" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Sweating in 2v2 to get that Merciless Gladiator title
                            </asp:ListItem>
                            <asp:ListItem Value="B">B) Casually doing 10 games a week for points</asp:ListItem>
                            <asp:ListItem Value="C) Experimenting with 'double DPS' or weird comp variations</asp:ListItem>
                        <asp:ListItem Value=" D">D) I avoided it; the world was my battleground</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf3" runat="server" ControlToValidate="rblQ3"
                            ErrorMessage="Question 3 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">4. What was the most 'unforgettable' part of the lore?</span>
                        <asp:RadioButtonList ID="rblQ4" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) The fall of Shattrath and the Naaru's light</asp:ListItem>
                            <asp:ListItem Value="B) Illidan's tragic fall and his 'You are not prepared!' speech</asp:ListItem>
                        <asp:ListItem Value=" C">C) The betrayal of Kael'thas and the Sunwell's corruption
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) The return of the Draenei and the Eredar's dark secret
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf4" runat="server" ControlToValidate="rblQ4"
                            ErrorMessage="Question 4 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">5. Which faction did you grind reputation with first?</span>
                        <asp:RadioButtonList ID="rblQ5" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Scryers or Aldor – the legendary Shattrath rivalry</asp:ListItem>
                            <asp:ListItem Value="B">B) Netherwing – I needed that drake in my life</asp:ListItem>
                            <asp:ListItem Value="C">C) Kurenai / Mag'har – those Talbuks were stylish</asp:ListItem>
                            <asp:ListItem Value="D">D) Cenarion Expedition – Hippogryphs and nature's grace
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf5" runat="server" ControlToValidate="rblQ5"
                            ErrorMessage="Question 5 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">6. What was your favorite 5-man dungeon run?</span>
                        <asp:RadioButtonList ID="rblQ6" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Shattered Halls – zero-room-for-error speed runs</asp:ListItem>
                            <asp:ListItem Value="B">B) Magister's Terrace – Kael'thas was 'just a setback'
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) Shadow Labyrinth – Murmur's devastating sound waves
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) Slave Pens – simple, iconic, and efficient</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf6" runat="server" ControlToValidate="rblQ6"
                            ErrorMessage="Question 6 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">7. How did you feel about the Class changes in TBC?</span>
                        <asp:RadioButtonList ID="rblQ7" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Loved that hybrids (Paladin/Druid) finally became viable
                                tanks/DPS</asp:ListItem>
                            <asp:ListItem Value="B">B) Shaman/Paladin going cross-faction changed everything for me
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) Mastering the new Level 70 talent caps felt like true power
                            </asp:ListItem>
                            <asp:ListItem Value="D) The introduction of Heroism/Bloodlust made raiding so much more intense</asp:ListItem>
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID=" rf7" runat="server" ControlToValidate="rblQ7"
                                ErrorMessage="Question 7 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">8. What iconic weapon did you desire most?</span>
                        <asp:RadioButtonList ID="rblQ8" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Warglaives of Azzinoth – the ultimate status symbol
                            </asp:ListItem>
                            <asp:ListItem Value="B">B) Netherdrake – it's basically a weapon of coolness</asp:ListItem>
                            <asp:ListItem Value="C">C) Thori'dal, the Stars' Fury – the bow that needed no arrows
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) Dragonspine Trophy – hunters and rogues fighting for eternity
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf8" runat="server" ControlToValidate="rblQ8"
                            ErrorMessage="Question 8 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">9. Thoughts on the Isle of Quel'Danas?</span>
                        <asp:RadioButtonList ID="rblQ9" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Peak World PvP – the daily quest hubs were a warzone
                            </asp:ListItem>
                            <asp:ListItem Value="B">B) Loved the community progress feeling of unlocking the island
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) It was the best gold-making hub in the history of WoW
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) Sunwell Plateau looming over the island was pure intimidation
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf9" runat="server" ControlToValidate="rblQ9"
                            ErrorMessage="Question 9 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">10. Favorite World Boss encounter?</span>
                        <asp:RadioButtonList ID="rblQ10" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Doomwalker – standing at the gates of Black Temple</asp:ListItem>
                            <asp:ListItem Value="B">B) Lord Kazzak – the absolute chaos of the Throne of Kil'jaeden
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) The race between guilds to tag them first</asp:ListItem>
                            <asp:ListItem Value="D">D) Honestly, I preferred the safety of instanced raids
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf10" runat="server" ControlToValidate="rblQ10"
                            ErrorMessage="Question 10 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">11. What made Flying Mounts so special?</span>
                        <asp:RadioButtonList ID="rblQ11" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Finding hidden areas like the top of the Tempest Keep pipes
                            </asp:ListItem>
                            <asp:ListItem Value="B">B) Escaping gankers by just taking to the sky</asp:ListItem>
                            <asp:ListItem Value="C">C) The sheer cost of Epic Flying made it a monumental achievement
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) It made the world feel truly three-dimensional and grand
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf11" runat="server" ControlToValidate="rblQ11"
                            ErrorMessage="Question 11 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">12. Pick a favorite TBC Profession memory:</span>
                        <asp:RadioButtonList ID="rblQ12" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Engineering's iconic goggles and mote extractor</asp:ListItem>
                            <asp:ListItem Value="B">B) Blacksmithing's 'Stormherald' – the mace that stunned the world
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) Jewelcrafting – the brand new profession meta</asp:ListItem>
                            <asp:ListItem Value="D">D) Tailoring's 'Spellstrike' or 'Frozen Shadoweave' sets
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf12" runat="server" ControlToValidate="rblQ12"
                            ErrorMessage="Question 12 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">13. Which zone ambiance did you enjoy most?</span>
                        <asp:RadioButtonList ID="rblQ13" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Zangarmarsh – glowing mushrooms and the sound of rain
                            </asp:ListItem>
                            <asp:ListItem Value="B">B) Netherstorm – mana pipes and pink/purple cosmic energy
                            </asp:ListItem>
                            <asp:ListItem Value="C">C) Hellfire Peninsula – the non-stop battle against the Legion
                            </asp:ListItem>
                            <asp:ListItem Value="D">D) Shadowmoon Valley – green fel lava and the volcano</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf13" runat="server" ControlToValidate="rblQ13"
                            ErrorMessage="Question 13 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">14. What was the 'hardest' part of TBC?</span>
                        <asp:RadioButtonList ID="rblQ14" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) Managing 25 unique personalities in a raid team</asp:ListItem>
                            <asp:ListItem Value="B">B) Reaching the 2050 rating for the weapon</asp:ListItem>
                            <asp:ListItem Value="C">C) The brutal attunement questlines for BT/Hyjal</asp:ListItem>
                            <asp:ListItem Value="D">D) Farming primal materials in heavily contested zones
                            </asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf14" runat="server" ControlToValidate="rblQ14"
                            ErrorMessage="Question 14 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <div class="question-card">
                        <span class="question-text">15. Best TBC music track?</span>
                        <asp:RadioButtonList ID="rblQ15" runat="server" CssClass="rbl-options" RepeatLayout="Flow">
                            <asp:ListItem Value="A">A) The epic Karazhan organ music</asp:ListItem>
                            <asp:ListItem Value="B">B) The serene, haunting Nagrand ambient theme</asp:ListItem>
                            <asp:ListItem Value="C">C) The intense combat drums of the Blood Elves</asp:ListItem>
                            <asp:ListItem Value="D">D) The melancholy Draenei themes on Azuremyst</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="rf15" runat="server" ControlToValidate="rblQ15"
                            ErrorMessage="Question 15 is unanswered" Display="Dynamic" CssClass="validation-msg" />
                    </div>

                    <asp:Button ID="btnSubmit" runat="server" Text="Reveal My TBC Sentiment" CssClass="submit-btn"
                        OnClick="btnSubmit_Click" />
                </asp:Panel>

                <asp:Panel ID="pnlResults" runat="server" Visible="false">
                    <div class="results-card">
                        <span class="score-label">Burning Crusade Passion Score</span>
                        <div class="passion-score">
                            <asp:Label ID="lblPassionScore" runat="server" Text="0%" />
                        </div>

                        <div class="cat-box">
                            <div class="cat-row">
                                <span class="cat-name">Raid God</span>
                                <div class="progress-bg">
                                    <div id="barRaid" runat="server" class="progress-fill" style="width: 0%">0%</div>
                                </div>
                            </div>
                            <div class="cat-row">
                                <span class="cat-name">PvP Legend</span>
                                <div class="progress-bg">
                                    <div id="barPvP" runat="server" class="progress-fill" style="width: 0%">0%</div>
                                </div>
                            </div>
                            <div class="cat-row">
                                <span class="cat-name">Outland Explorer</span>
                                <div class="progress-bg">
                                    <div id="barExp" runat="server" class="progress-fill" style="width: 0%">0%</div>
                                </div>
                            </div>
                            <div class="cat-row">
                                <span class="cat-name">Class Purist</span>
                                <div class="progress-bg">
                                    <div id="barClass" runat="server" class="progress-fill" style="width: 0%">0%</div>
                                </div>
                            </div>
                            <div class="cat-row">
                                <span class="cat-name">Lore Addict</span>
                                <div class="progress-bg">
                                    <div id="barLore" runat="server" class="progress-fill" style="width: 0%">0%</div>
                                </div>
                            </div>
                        </div>

                        <div class="analysis-text">
                            <asp:Label ID="lblAnalysis" runat="server" />
                        </div>

                        <asp:Button ID="btnReset" runat="server" Text="Take the Survey Again" CssClass="reset-btn"
                            OnClick="btnReset_Click" CausesValidation="false" />
                    </div>
                </asp:Panel>
            </div>
        </form>
    </body>

    </html>