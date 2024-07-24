import '../controllers/provider/prediction.dart';

class PredictionCard {
  final int id;
  final String prop;
  final String title, description, image;

  PredictionCard({required this.id, required this.prop, required this.title, required this.description, required this.image});
}

// list of products
// for our demo
List<PredictionCard> predictions = [
  PredictionCard(
    id: 1,
    prop:MyPredictionProvider.modelData=="dermascopy"? MyPredictionProvider.akiec : MyPredictionProvider.ak_bcc,
    title:MyPredictionProvider.modelData=="dermascopy"? "Actinic keratoses" : "Actinic keratoses /BCC",
    image: "lib/assets/images/akiec.png",
    description:MyPredictionProvider.modelData=="dermascopy"?
    "Actinic keratoses are dry scaly patches of skin that have been damaged by the sun.\nThe patches are not usually serious. But there's a small chance they could become skin cancer, so it's important to avoid further damage to your skin."
    :"Actinic keratoses /BCC",
  ),
  PredictionCard(
    id: 2,
    prop:MyPredictionProvider.modelData=="dermascopy"?  MyPredictionProvider.bcc : MyPredictionProvider.eczema,
    title: "Eczema",
    image: "lib/assets/images/bcc.png",
    description:MyPredictionProvider.modelData=="dermascopy"?
    "Basal cell carcinoma is a type of skin cancer. Basal cell carcinoma begins in the basal cells — a type of cell within the skin that produces new skin cells as old ones die off."
    : "Eczema",
  ),
  PredictionCard(
    id: 3,
    prop:MyPredictionProvider.modelData=="dermascopy"? MyPredictionProvider.bkl : MyPredictionProvider.nf,
    title:MyPredictionProvider.modelData=="dermascopy"? "Benign keratosis":"Nail Fungus",
    image: "lib/assets/images/bkl.png",
    description:MyPredictionProvider.modelData=="dermascopy"?
    "A seborrheic keratosis (seb-o-REE-ik ker-uh-TOE-sis) is a common noncancerous (benign) skin growth. People tend to get more of them as they get older."
    :"Nail Fungus",
  ),
  PredictionCard(
    id: 4,
    prop: MyPredictionProvider.modelData=="dermascopy"? MyPredictionProvider.df : MyPredictionProvider.plp,
    title:MyPredictionProvider.modelData == "dermascopy"? "Dermatofibroma": "Psoriasis Lichen Planus",
    image: "lib/assets/images/df.png",
    description:MyPredictionProvider.modelData == "dermascopy"?
    "Dermatofibromas are harmless growths within the skin that usually have a small diameter. They can vary in color but are typically pink to light brown in light skin and dark brown or black in dark skin. They may appear for example, when shaving."
    : "Psoriasis Lichen Planus",
  ),
  PredictionCard(
    id: 5,
    prop: MyPredictionProvider.modelData=="dermascopy"? MyPredictionProvider.mel: MyPredictionProvider.sk,
    title:MyPredictionProvider.modelData=="dermascopy"? "Melanoma": "Seborrheic Keratoses",
    image: "lib/assets/images/mel.png",
    description:MyPredictionProvider.modelData=="dermascopy"?
    "Melanoma, the most serious type of skin cancer, develops in the cells (melanocytes) that produce melanin — the pigment that gives your skin its color. Melanoma can also form in your eyes and, rarely,inside your body, such as in your nose or throat."
    : "Seborrheic Keratoses",
  ),
  PredictionCard(
    id: 6,
    prop: MyPredictionProvider.modelData=="dermascopy"? MyPredictionProvider.nv : MyPredictionProvider.tr,
    title: MyPredictionProvider.modelData=="dermascopy"? "Melanocytic nevi" : "Tinea Ringworm",
    image: "lib/assets/images/nv.png",
    description:MyPredictionProvider.modelData=="dermascopy"?
    "Giant congenital melanocytic nevus is a skin condition characterized by an abnormally dark, noncancerous skin patch (nevus) that is composed of pigment-producing cells called melanocytes. It is present from birth (congenital) or is noticeable soon after birth."
    : "Tinea Ringworm",
  ),
  PredictionCard(
    id: 7,
    prop: MyPredictionProvider.modelData=="dermascopy"? MyPredictionProvider.vasc : MyPredictionProvider.wm,
    title: MyPredictionProvider.modelData=="dermascopy"? "Vascular lesions" : "Warts Molluscum",
    image: "lib/assets/images/vasc.png",
    description: MyPredictionProvider.modelData=="dermascopy"?
    "Vascular lesions are relatively common abnormalities of the skin and underlying tissues, more commonly known as birthmarks. There are three major categories of vascular lesions: Hemangiomas, Vascular Malformations, and Pyogenic Granulomas."
    : "Warts Molluscum",
  ),
];