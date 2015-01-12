#import "SharedConfigurations.h"

@implementation SharedConfigurations

@synthesize callbackId;
@synthesize notificationCallbackId;
@synthesize callback;

+ (void)addSharedConfigEntryFromNative:(NSString*)configKey value:(NSString*)configValue;
{
	NSString *configKeyString = (NSString *)configKey;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
	[prefs setValue:configValue forKey:configKeyString];
	
	[prefs synchronize];
}

- (void)addSharedConfigEntry:(CDVInvokedUrlCommand*)command;
{
	self.callbackId = command.callbackId;
	NSMutableDictionary* options = [command.arguments objectAtIndex:0];
	
    id configKey = [options objectForKey:@"configKey"];
    id configValue = [options objectForKey:@"value"];
	
	if ([configKey isKindOfClass:[NSString class]] && [configValue isKindOfClass:[NSString class]]) {
		NSString *configKeyString = (NSString *)configKey;
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
		[prefs setValue:configValue forKey:configKeyString];
		
		[prefs synchronize];
		
		[self successWithMessage:@"OK"];
	}else{
		[self successWithMessage:@"WRONG PARAMETERS"];
	}
}

- (void)getSharedConfigEntry:(CDVInvokedUrlCommand*)command;
{
	self.callbackId = command.callbackId;
	
	id storedConfigObj = nil;
	NSString* storedConfig = @"";
	
    NSMutableDictionary* options = [command.arguments objectAtIndex:0];
	
    id configKey = [options objectForKey:@"configKey"];
	
	if ([configKey isKindOfClass:[NSString class]]) {
		NSString *configKeyString = (NSString *)configKey;
		
		NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];  //load NSUserDefaults
		storedConfigObj = [prefs objectForKey:configKeyString];
		if(storedConfigObj != nil){
			storedConfig = (NSString *)storedConfigObj;
		}
	}
	
    [self successWithMessage:storedConfig];
}

-(void)successWithMessage:(NSString *)message
{
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:message];
    
    [self.commandDelegate sendPluginResult:commandResult callbackId:self.callbackId];
}

-(void)failWithMessage:(NSString *)message withError:(NSError *)error
{
    NSString        *errorMessage = (error) ? [NSString stringWithFormat:@"%@ - %@", message, [error localizedDescription]] : message;
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMessage];
    
    [self.commandDelegate sendPluginResult:commandResult callbackId:self.callbackId];
}

@end
