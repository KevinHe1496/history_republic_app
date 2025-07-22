import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Condiciones de Uso")
                    .font(.title2)
                    .bold()

                Text("""
                Bienvenido/a a History Republic, una plataforma móvil que te permite aprender sobre los relatos épicos a lo largo de la historia de forma amena e interactiva. Al descargar, instalar o utilizar la Aplicación aceptas íntegramente estas Condiciones de Uso (“Condiciones”). Si no estás de acuerdo, por favor no utilices la Aplicación.
                """)

                Group {
                    Text("1. Aceptación y modificaciones")
                        .font(.headline)
                    Text("""
                    Estas Condiciones constituyen un contrato vinculante entre History Republic (“nosotros”) y tú como usuario. Podremos actualizar las Condiciones cuando sea necesario. Te avisaremos mediante notificación dentro de la app o correo electrónico. El uso continuado tras la modificación implica tu aceptación.
                    """)
                }

                Group {
                    Text("2. Requisitos de edad y registro")
                        .font(.headline)
                    Text("""
                    Debes tener al menos 13 años (o la edad mínima que exija tu jurisdicción) para crear una cuenta. Si eres menor, necesitas consentimiento de tu tutor legal. La información de registro debe ser veraz y mantenerse actualizada.
                    """)
                }

                Group {
                    Text("3. Licencia de uso")
                        .font(.headline)
                    Text("""
                    Te concedemos una licencia personal, limitada, no exclusiva e intransferible para instalar y usar la Aplicación con fines únicamente educativos y no comerciales. Queda prohibido: (a) comercializar, copiar o distribuir la Aplicación o su contenido; (b) ingeniería inversa; (c) eludir medidas de seguridad.
                    """)
                }

                Group {
                    Text("4. Propiedad intelectual")
                        .font(.headline)
                    Text("""
                    Todo el contenido es propiedad nuestra o de nuestros licenciantes y está protegido por leyes de copyright. Los nombres History Republic y su logotipo son marcas registradas.
                    """)
                }

                Group {
                    Text("5. Contenido educativo y descargo de responsabilidad")
                        .font(.headline)
                    Text("""
                    Nos esforzamos por ofrecer información rigurosa; sin embargo, no garantizamos que todo el contenido sea absolutamente exacto. La Aplicación es puramente educativa.
                    """)
                }

                Group {
                    Text("6. Contenido aportado por el usuario")
                        .font(.headline)
                    Text("""
                    Conservas tus derechos, pero nos concedes licencia mundial gratuita para mostrar tu contenido en la app. No publiques material ilegal, ofensivo o que infrinja derechos de terceros.
                    """)
                }

                Group {
                    Text("7. Conductas prohibidas")
                        .font(.headline)
                    Text("""
                    No se permite usar la Aplicación para fines comerciales sin autorización, extraer datos automáticamente (bots, scraping), acceder sin permiso a nuestros sistemas o violar leyes o estas Condiciones.
                    """)
                }


                Group {
                    Text("8. Privacidad")
                        .font(.headline)
                    Text("""
                    Consulta nuestra Política de Privacidad para saber cómo tratamos tus datos.
                    """)
                }

                Group {
                    Text("9. Limitación de responsabilidad")
                        .font(.headline)
                    Text("""
                    La Aplicación se ofrece “tal cual” y “según disponibilidad”. No asumimos responsabilidad por pérdidas indirectas o daños consecuentes.
                    """)
                }

                Group {
                    Text("10. Suspensión y terminación")
                        .font(.headline)
                    Text("""
                    Podremos suspender o cancelar tu acceso si incumples estas Condiciones.
                    """)
                }

            }
            .padding()
        }
        .navigationTitle("Condiciones de uso")
    }
}

#Preview {
    TermsOfUseView()
}
