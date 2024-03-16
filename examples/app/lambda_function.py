import logging

logger = logging.getLogger(__name__)


def lambda_handler(event, context):
    logger.info(event)

    return 'Hello from Lambda!'
