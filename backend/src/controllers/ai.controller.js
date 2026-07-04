const OpenAI = require("openai");

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

exports.generateLesson = async (req, res) => {
  try {
    const { classe, discipline, lecon, duree } = req.body;

    const response = await client.chat.completions.create({
      model: "gpt-4o-mini",
      messages: [
        {
          role: "system",
          content:
            "Tu es un expert pédagogique du primaire au Cameroun. Génère des fiches structurées selon les programmes officiels."
        },
        {
          role: "user",
          content: `
Classe: ${classe}
Discipline: ${discipline}
Leçon: ${lecon}
Durée: ${duree}

Donne une fiche de préparation complète (objectifs, déroulement, évaluation).`
        }
      ]
    });

    res.json({
      result: response.choices[0].message.content
    });

  } catch (error) {
    res.status(500).json({
      error: "Erreur IA",
      details: error.message
    });
  }
};
