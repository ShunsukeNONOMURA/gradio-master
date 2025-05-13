import gradio as gr

def ui():
    subtitle_config = gr.Markdown("## tmp")

    from .processor import submit
    interface = gr.Interface(
        fn=submit,
        inputs=[
            "text", 
        ],
        outputs=["text"], 
        flagging_mode='never',
        examples=[
            ["https://www.google.com/"],
        ],
    )