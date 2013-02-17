TWEAK_NAME = NoChineseSNS
NoChineseSNS_OBJCC_FILES = Tweak.mm
SYSROOT=/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk
NoChineseSNS_CFLAGS = -F$(SYSROOT)/System/Library/CoreServices
NoChineseSNS_FRAMEWORKS = UIKit Foundation StoreKit
NoChineseSNS_PRIVATE_FRAMEWORKS = UIKit Foundation Preferences PhotoLibrary
export ARCHS = armv7
export TARGET = iphone:clang::6.0

LDFLAGS += -march=armv7
include theos/makefiles/common.mk
include theos/makefiles/tweak.mk

sync: stage
	rsync -z _/Library/MobileSubstrate/DynamicLibraries/* root@192.168.3.3:/Library/MobileSubstrate/DynamicLibraries/
	ssh root@192.168.3.3 killall SpringBoard
	
sync2: stage
	rsync -z _/Library/MobileSubstrate/DynamicLibraries/* root@192.168.0.7:/Library/MobileSubstrate/DynamicLibraries/
	ssh root@192.168.0.7 killall SpringBoard

sync3: stage
	rsync -z _/Library/MobileSubstrate/DynamicLibraries/* root@10.0.1.10:/Library/MobileSubstrate/DynamicLibraries/
	ssh root@10.0.1.10 killall SpringBoard