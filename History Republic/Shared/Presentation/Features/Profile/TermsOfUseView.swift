import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        ScrollView {
                   VStack(alignment: .leading, spacing: 16) {
                       Text("Política de Privacidad")
                           .font(.title2)
                           .bold()

                       Text("Fecha de entrada en vigor: 25 de julio de 2025")

                       Group {
                           Text("1. Introducción")
                               .font(.headline)
                           
                           Text("En History Republic nos comprometemos a proteger tu privacidad. Esta Política de Privacidad explica cómo recopilamos, usamos y protegemos tus datos personales cuando utilizas nuestra aplicación móvil History Republic (“la App”).")
                           Text("Al descargar, instalar o utilizar la App, aceptas esta Política de Privacidad. Si no estás de acuerdo, por favor no utilices la App.")
                       }

                       Group {
                           Text("2. Recopilación y uso de datos")
                               .font(.headline)
                           Text("Podemos recopilar los siguientes tipos de datos cuando te registras o utilizas la App:")
                           
                           Text("• Información personal: como tu nombre y correo electrónico al crear una cuenta.")
                           Text("• Datos de uso: información sobre cómo usas la App, incluyendo interacciones y funciones utilizadas.")
                           Text("Utilizamos estos datos únicamente con fines educativos y funcionales, como permitir el inicio de sesión, mejorar el rendimiento y enviar notificaciones relacionadas con la App.")
                           Text("No utilizamos tus datos para publicidad ni para rastrearte en otras aplicaciones o sitios web de terceros.")
                       }

                       Group {
                           Text("3. Requisitos de edad")
                               .font(.headline)
                           Text("""
                           Debes tener al menos 13 años (o la edad mínima en tu jurisdicción) para crear una cuenta. Si eres menor, necesitas el consentimiento de un tutor legal.
                           """)
                       }

                       Group {
                           Text("4. Compartición de datos")
                               .font(.headline)
                           Text("No vendemos, alquilamos ni compartimos tus datos personales con terceros, salvo cuando:")
                           
                           Text("• Lo requiera la ley.")
                           Text("• Sea necesario para proteger nuestros derechos o los de otros usuarios.")
                       }

                       Group {
                           Text("5. Seguridad de los datos")
                               .font(.headline)
                           Text("""
                           Implementamos medidas de seguridad para proteger tus datos personales. Sin embargo, ningún sistema es completamente seguro y no garantizamos protección absoluta.
                           """)
                       }

                       Group {
                           Text("6. Servicios de terceros")
                               .font(.headline)
                           Text("""
                           La App no recopila cookies con fines de rastreo. El contenido web que se muestra no utiliza cookies de seguimiento. No usamos AppTrackingTransparency porque no realizamos ningún rastreo de usuarios.
                           """)
                       }

                       Group {
                           Text("7. Tus derechos")
                               .font(.headline)
                           
                           Text("Tienes derecho a:")
                           Text("• Acceder y actualizar tus datos personales.")
                           Text("• Solicitar la eliminación de tu cuenta y datos.")
                           Text("• Retirar tu consentimiento (si aplica).")
                           
                           Text("Para ejercer estos derechos, contáctanos en: historyrepublic.25@gmail.com")
                       }

                       Group {
                           Text("8. Cambios en esta política")
                               .font(.headline)
                           Text("""
                           Podemos actualizar esta Política de Privacidad. Cualquier cambio será notificado dentro de la App o por correo electrónico.
                           """)
                       }
                   }
                   .padding()
               }
               .navigationTitle("Política de Privacidad")
           
    }
}

#Preview {
    TermsOfUseView()
}
