# ui ##############################################
import gradio as gr
from tools.template.ui import ui as template_ui

with gr.Blocks() as demo:
    title = gr.Markdown("# nonoshun ui tool")
    with gr.Tab('template'):
        template_ui()

if __name__ == "__main__":
    demo.launch(
        server_port = 57860
    )