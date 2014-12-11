package com.obsesif.utils
{
	import flash.errors.IllegalOperationError;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.LogFactory;
	import org.spicefactory.lib.logging.LogLevel;
	import org.spicefactory.lib.logging.impl.DefaultLogFactory;
	import org.spicefactory.lib.logging.impl.SOSAppender;

	/**
	 * This is the Logging Factory.
	 * Inititate once in your Main class:
	 * <code>LoggingFactory.getInstance();</code>
	 *
	 * @author Fabian Nöthe - hello@insnet.de - www.insnet.de
	 */
	public class LoggingFactory {
		private static var instance : LoggingFactory;
		private static var allowInstantiation : Boolean;

		public function LoggingFactory() : void {
			if (!allowInstantiation) {
				throw new IllegalOperationError("Error: Instantiation failed: Use LoggingFactory.getInstance() instead of new.");
			}
			var factory : LogFactory = new DefaultLogFactory();
			factory.setRootLogLevel(LogLevel.TRACE);

			/*
			 * Set loglevel for each package
			 *
			 * FATAL 	 Very severe error events that will presumably lead the application to abort.
			 * ERROR 	Error events that might still allow the application to continue running.
			 * WARN 	Potentially harmful situations.
			 * INFO 	Informational messages that highlight the progress of the application at coarse-grained level.
			 * DEBUG 	Fine-grained informational events that are most useful to debug an application.
			 * TRACE 	Very fine-grained information (represents the lowest rank of all levels).
			 */
			factory.addLogLevel("core", LogLevel.TRACE);
			//factory.addLogLevel("view", LogLevel.TRACE);

			var sosAppender : SOSAppender = new SOSAppender();
			sosAppender.init();
			sosAppender.threshold = LogLevel.TRACE;

			factory.addAppender(sosAppender);

			LogContext.factory = factory;
		}

		public static function getInstance() : LoggingFactory {
			if (instance == null) {
				allowInstantiation = true;
				instance = new LoggingFactory();
				allowInstantiation = false;
			}
			return instance;
		}
	}
}
