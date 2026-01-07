const pptxgen = require('pptxgenjs');
const html2pptx = require('/Users/marko/.claude/plugins/marketplaces/anthropic-agent-skills/document-skills/pptx/scripts/html2pptx.js');
const path = require('path');

async function createPresentation() {
    const pptx = new pptxgen();
    pptx.layout = 'LAYOUT_16x9';
    pptx.author = 'Marko Bremer - Grupo Educativo';
    pptx.title = 'Plan de Sistematización - Protagonistas del Cambio';

    const slidesDir = path.join(__dirname, 'ppt-slides');

    const slides = [
        'slide-01-title.html',
        'slide-02-contexto.html',
        'slide-03-objetivo-general.html',
        'slide-04-objetivos-especificos.html',
        'slide-05a-fases-1-4.html',
        'slide-05b-fases-5-7.html',
        'slide-06-fase1.html',
        'slide-07-fase2.html',
        'slide-08-fase3.html',
        'slide-09-fase4.html',
        'slide-10-fase5.html',
        'slide-11-fase6.html',
        'slide-12-fase7.html',
        'slide-13-productos.html',
        'slide-14-roles.html',
        'slide-15-timeline.html',
        'slide-16-proximos-pasos.html',
        'slide-17-cierre.html'
    ];

    console.log('Converting HTML slides to PowerPoint...\n');

    for (let i = 0; i < slides.length; i++) {
        const slideFile = path.join(slidesDir, slides[i]);
        console.log(`Processing slide ${i+1}/${slides.length}: ${slides[i]}`);

        try {
            await html2pptx(slideFile, pptx);
            console.log(`  ✓ Converted successfully`);
        } catch (error) {
            console.error(`  ✗ Error: ${error.message}`);
            throw error;
        }
    }

    const outputFile = path.join(__dirname, 'Plan_Sistematizacion_Presentacion.pptx');
    await pptx.writeFile({ fileName: outputFile });

    console.log(`\n✓ Presentation created successfully: ${outputFile}`);
}

createPresentation().catch(error => {
    console.error('\n✗ Error creating presentation:', error);
    process.exit(1);
});
