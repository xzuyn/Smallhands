package net.sallylabs;

import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.client.gui.screens.Screen;

public class LegacySmallhandsConfigScreen extends SmallhandsConfigScreen {
    public LegacySmallhandsConfigScreen(Screen parent) {
        super(parent);
    }

    @Override
    public void render(GuiGraphics graphics, int mouseX, int mouseY, float delta) {
        renderBackground(graphics);
        super.render(graphics, mouseX, mouseY, delta);
    }
}
