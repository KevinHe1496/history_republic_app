//
//  TermsOfUseView.swift
//  History Republic
//
//  Created by Andy Heredia on 3/7/25.
//

import SwiftUI

struct TermsOfUseView: View {
    /// Para cerrar la vista al pulsar “Cerrar”
        @Environment(\.dismiss) private var dismiss
        
        /// Texto completo de las condiciones
        private let termsText = """
        **Condiciones de Uso**
        
        Bienvenido/a a **History Republic** , una plataforma móvil que te permite **aprender sobre los relatos épicos a lo largo de la historia** de forma amena e interactiva. Al descargar, instalar o utilizar la Aplicación aceptas íntegramente estas Condiciones de Uso (“Condiciones”). Si no estás de acuerdo, por favor no utilices la Aplicación.

        **1. Aceptación y modificaciones**  
        1.1. Estas Condiciones constituyen un contrato vinculante entre **History Republic** (“nosotros”) y tú como usuario.  
        1.2. Podremos actualizar las Condiciones cuando sea necesario. Te avisaremos mediante notificación dentro de la app o correo electrónico. El uso continuado tras la modificación implica tu aceptación.

        **2. Requisitos de edad y registro**  
        2.1. Debes tener **al menos 13 años** (o la edad mínima que exija tu jurisdicción) para crear una cuenta.  
        2.2. Si eres menor, necesitas consentimiento de tu tutor legal.  
        2.3. La información de registro debe ser veraz y mantenerse actualizada.

        **3. Licencia de uso**  
        3.1. Te concedemos una **licencia personal, limitada, no exclusiva e intransferible** para instalar y usar la Aplicación con fines únicamente **educativos y no comerciales**.  
        3.2. Queda prohibido: (a) comercializar, copiar o distribuir la Aplicación o su contenido; (b) ingeniería inversa; (c) eludir medidas de seguridad.

        **4. Propiedad intelectual**  
        4.1. Todo el contenido es propiedad nuestra o de nuestros licenciantes y está protegido por leyes de copyright.  
        4.2. Los nombres *History Republic* y su logotipo son marcas registradas.

        **5. Contenido educativo y descargo de responsabilidad**  
        5.1. Nos esforzamos por ofrecer información rigurosa; sin embargo, **no garantizamos** que todo el contenido sea absolutamente exacto.  
        5.2. La Aplicación es **puramente educativa**.

        **6. Contenido aportado por el usuario**  
        6.1. Conservas tus derechos, pero nos concedes licencia mundial gratuita para mostrar tu contenido en la app.  
        6.2. No publiques material ilegal, ofensivo o que infrinja derechos de terceros.

        **7. Conductas prohibidas**  
        - Usar la Aplicación para fines comerciales sin autorización.  
        - Extraer datos automáticamente (bots, scraping).  
        - Acceder sin permiso a nuestros sistemas.  
        - Violar leyes o estas Condiciones.

        **8. Servicios de pago y suscripciones**  
        8.1. Ciertas funciones premium pueden requerir suscripción mediante la App Store.  
        8.2. Los cobros y reembolsos se rigen por los Términos de Apple.

        **9. Privacidad**  
        Consulta nuestra Política de Privacidad para saber cómo tratamos tus datos.

        **10. Limitación de responsabilidad**  
        10.1. La Aplicación se ofrece “tal cual” y “según disponibilidad”.  
        10.2. No asumimos responsabilidad por pérdidas indirectas o daños consecuentes.

        **11. Suspensión y terminación**  
        Podremos suspender o cancelar tu acceso si incumples estas Condiciones.

        **12. Ley aplicable y jurisdicción**  
        Se rigen por las leyes de la República del Ecuador. Cualquier controversia se someterá a los juzgados de Quito.

        **13. Contacto**  
        support@historyrepublic.com

        Al continuar usando la Aplicación confirmas que has leído y aceptas estas Condiciones.
        """

    var body: some View {
        NavigationStack {
            ScrollView {
                // Usamos Markdown para formatear títulos y listas
                Text(.init(termsText))
                    .textSelection(.enabled)        // Permite copiar texto si se desea
                    .padding()
            }
            .navigationTitle("Condiciones de Uso")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TermsOfUseView()
}
