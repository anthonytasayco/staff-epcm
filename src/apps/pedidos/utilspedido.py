# -*- coding: utf-8 -*-
from django.utils.encoding import force_unicode
import re
from apps.pedidos.models import Pedido, DetallePedido
from apps.custom_auth.models import Direccion, Distrito, Usuario


def obtenerpedido(request):
    pedido = None
    pedido_id = request.session.get('pedido', '')
    if pedido_id != '':
        pedido = Pedido.objects.filter(codigo=pedido_id).first()
    return pedido


def equivalencia_payu(cad):
    djson =  {
        "ERROR": u"Ocurrió un error general.",
        "APPROVED": u"La transacción fue aprobada.",
        "ANTIFRAUD_REJECTED": u"La transacción fue rechazada por el sistema anti-fraude.",
        "PAYMENT_NETWORK_REJECTED": u"La red financiera rechazó la transacción.",
        "ENTITY_DECLINED": u"La transacción fue declinada por el banco o por la red financiera debido a un error.",
        "INTERNAL_PAYMENT_PROVIDER_ERROR": u"Ocurrió un error en el sistema intentando procesar el pago.",
        "INACTIVE_PAYMENT_PROVIDER": u"El proveedor de pagos no se encontraba activo.",
        "DIGITAL_CERTIFICATE_NOT_FOUND": u"La red financiera reportó un error en la autenticación.",
        "INVALID_EXPIRATION_DATE_OR_SECURITY_CODE": u"El código de seguridad o la fecha de expiración estaba inválido.",
        "INVALID_RESPONSE_PARTIAL_APPROVAL": u"Tipo de respuesta no válida. La entidad aprobó parcialmente la transacción y debe ser cancelada automáticamente por el sistema.",
        "INSUFFICIENT_FUNDS": u"La cuenta no tenía fondos suficientes.",
        "CREDIT_CARD_NOT_AUTHORIZED_FOR_INTERNET_TRANSACTIONS": u"La tarjeta de crédito no estaba autorizada para transacciones por Internet.",
        "INVALID_TRANSACTION": u"La red financiera reportó que la transacción fue inválida.",
        "INVALID_CARD": u"La tarjeta es inválida.",
        "EXPIRED_CARD": u"La tarjeta ya expiró.",
        "RESTRICTED_CARD": u"La tarjeta presenta una restricción.",
        "CONTACT_THE_ENTITY": u"Debe contactar al banco.",
        "REPEAT_TRANSACTION": u"Se debe repetir la transacción.",
        "ENTITY_MESSAGING_ERROR": u"La red financiera reportó un error de comunicaciones con el banco.",
        "BANK_UNREACHABLE": u"El banco no se encontraba disponible.",
        "EXCEEDED_AMOUNT": u"La transacción excede un monto establecido por el banco.",
        "NOT_ACCEPTED_TRANSACTION": u"La transacción no fue aceptada por el banco por algún motivo.",
        "ERROR_CONVERTING_TRANSACTION_AMOUNTS": u"Ocurrió un error convirtiendo los montos a la moneda de pago.",
        "EXPIRED_TRANSACTION": u"La transacción expiró.",
        "PENDING_TRANSACTION_REVIEW": u"La transacción fue detenida y debe ser revisada, esto puede ocurrir por filtros de seguridad.",
        "PENDING_TRANSACTION_CONFIRMATION": u"La transacción está pendiente de ser confirmada.",
        "PENDING_TRANSACTION_TRANSMISSION": u"La transacción está pendiente para ser trasmitida a la red financiera. Normalmente esto aplica para transacciones con medios de pago en efectivo.",
        "PAYMENT_NETWORK_BAD_RESPONSE": u"El mensaje retornado por la red financiera es inconsistente.",
        "PAYMENT_NETWORK_NO_CONNECTION": u"No se pudo realizar la conexión con la red financiera.",
        "PAYMENT_NETWORK_NO_RESPONSE": u"La red financiera no respondió.",
        "FIX_NOT_REQUIRED": u"Clínica de transacciones: Código de manejo interno.",
        "AUTOMATICALLY_FIXED_AND_SUCCESS_REVERSAL": u"Clínica de transacciones: Código de manejo interno.",
        "AUTOMATICALLY_FIXED_AND_UNSUCCESS_REVERSAL": u"Clínica de transacciones: Código de manejo interno.",
        "AUTOMATIC_FIXED_NOT_SUPPORTED": u"Clínica de transacciones: Código de manejo interno.",
        "NOT_FIXED_FOR_ERROR_STATE": u"Clínica de transacciones: Código de manejo interno.",
        "ERROR_FIXING_AND_REVERSING": u"Clínica de transacciones: Código de manejo interno.",
        "ERROR_FIXING_INCOMPLETE_DATA": u"Clínica de transacciones: Código de manejo interno.",
        "DECLINED_TEST_MODE_NOT_ALLOWED": u"MODO DE PRUEBA DECLINADA NO PERMITIDO"
    }
    try:
        val = djson[cad]
    except:
        val = ''
    return val
