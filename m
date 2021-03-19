Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD8F341FF0
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 15:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhCSOpC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhCSOou (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 10:44:50 -0400
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 07:44:49 PDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE254C06175F;
        Fri, 19 Mar 2021 07:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1616164909; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XLJSCMYbXCEQfOU0MChUvvHsgAw00nWPzH8o9JZ3rfTsg5hOsZMyhjmjZI2WbaitWD
    4PKXU2Kii6jc3XT3pGYaUQEBIOtDr8mzqYZkSR2XSSkdnTe4G+xjuC4URor92qFVGXJc
    vx245Ro+iWNOfnjzg4KW8CSHWjrgTXt0aOurKyDuDASEOw4NvjPeqV9jeePvNNZ/USoj
    JIapptVSr2rNGAS1bZ1jqc49YWX3b3G3Ru+0DTiVC4wWy7jFCpTh5LuR0dGtY74PjgCm
    mOV4+vo9FiU9BN1NWkpMGBv+D2Osr99EZ8yG7awTLC6tm8TptECe1FafIOdnzy6mFDvu
    aBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616164909;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dg+zQ0cEU08MZtHY4Nwodi8+yW4jqmw2enJsKeahBTQ=;
    b=cHCHoOIf8E04mngdLv+8VlXjGruKtcvCGvnYW8DbCjF7r4ckg4/lJOC2k6Yg7SgBAw
    eseVhBKyA6O5Lu/TDfa49czlGJ5YA9TNuPLWhaQDx2933pMaDV4LUqg1Dd9vD6bbz3lo
    WpPlgmVOULKfEYd0UybQvkb5WxwN7uVMWbUH+iLw693+09aynzy3ZmSAKCZOeniqFGiF
    K3XHHvZXgF8EFQ8nAXOWwohDIqFfZpSUwnMjWItRLosZ8cO9qSH56HQ2f6KzA/7oz8cS
    nCoSAQtJh1xK8B3c3aPGsFjTLfZ9Hhce/Xr9n1LzAu3M6X3qZemr6ZsdFRIG3yKOgFgo
    lbAA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616164909;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=dg+zQ0cEU08MZtHY4Nwodi8+yW4jqmw2enJsKeahBTQ=;
    b=eSg46fl3fixlukH4mJdGpDr3oWh81RJ8jtfOPGppAvb62a9SdffgHr9+B2LHTINvJ4
    cWMtHDDcvgjXMhkGu23DF6W7+YgZlrUv+F3dD/W3KkRJ/PiaXucVzgee783uK8S3xM7M
    CHanf/TFT24AYvhSGAMTD3sY7akfgu+2zWOb9Cu4EM2cHaFkuCe+0Mp1v5tSopX0DnTd
    vowoJdzAH8zn/Mgukb7U+Q3ritDRKJ4mTTmqLQIoq5xNoUoKKIkjCdfpb0cIAXJSfsBb
    n8/TFVRj2wYrPbVJX9dMNo86LlqGrT6bUd/4xMXhSpbbKuYHCFNzboNf+uOtui0G6Ca9
    xS6g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS325Pjw=="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 47.21.0 SBL|AUTH)
    with ESMTPSA id k0a44fx2JEfmBAX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 19 Mar 2021 15:41:48 +0100 (CET)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Olaf Hering <olaf@aepfle.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2] tools/hv: async name resolution in kvp_daemon
Date:   Fri, 19 Mar 2021 15:41:44 +0100
Message-Id: <20210319144145.4064-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The hostname is resolved just once since commit 58125210ab3b ("Tools:
hv: cache FQDN in kvp_daemon to avoid timeouts") to make sure the VM
responds within the timeout limits to requests from the host.

If for some reason getaddrinfo fails, the string returned by the
"FullyQualifiedDomainName" request contains some error string, which is
then used by tools on the host side.

Adjust the code to resolve the current hostname in a separate thread.
This thread loops until getaddrinfo returns success. During this time
all "FullyQualifiedDomainName" requests will be answered with an empty
string.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
v2:
 resend, the thread aims for success.

 tools/hv/Makefile        |  2 ++
 tools/hv/hv_kvp_daemon.c | 69 ++++++++++++++++++++++++++--------------
 2 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index b57143d9459c..3b5481015a84 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -22,6 +22,8 @@ ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
 
+$(OUTPUT)hv_kvp_daemon: LDFLAGS += -lpthread
+
 all: $(ALL_PROGRAMS)
 
 export srctree OUTPUT CC LD CFLAGS
diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1e6fd6ca513b..3951b927aa3d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -41,6 +41,7 @@
 #include <net/if.h>
 #include <limits.h>
 #include <getopt.h>
+#include <pthread.h>
 
 /*
  * KVP protocol: The user mode component first registers with the
@@ -85,7 +86,7 @@ static char *processor_arch;
 static char *os_build;
 static char *os_version;
 static char *lic_version = "Unknown version";
-static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
+static char *full_domain_name;
 static struct utsname uts_buf;
 
 /*
@@ -1327,27 +1328,53 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	return error;
 }
 
-
-static void
-kvp_get_domain_name(char *buffer, int length)
+/*
+ * Async retrival of Fully Qualified Domain Name because getaddrinfo takes an
+ * unpredictable amount of time to finish.
+ */
+static void *kvp_getaddrinfo(void *p)
 {
-	struct addrinfo	hints, *info ;
-	int error = 0;
+	char *tmp, **str_ptr = (char **)p;
+	char hostname[HOST_NAME_MAX + 1];
+	struct addrinfo	*info, hints = {
+		.ai_family = AF_INET, /* Get only ipv4 addrinfo. */
+		.ai_socktype = SOCK_STREAM,
+		.ai_flags = AI_CANONNAME,
+	};
+	int ret;
+
+	if (gethostname(hostname, sizeof(hostname) - 1) < 0)
+		goto out;
 
-	gethostname(buffer, length);
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_INET; /*Get only ipv4 addrinfo. */
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_flags = AI_CANONNAME;
+	do {
+		ret = getaddrinfo(hostname, NULL, &hints, &info);
+		if (ret)
+			sleep(1);
+	} while (ret);
+
+	ret = asprintf(&tmp, "%s", info->ai_canonname);
+	freeaddrinfo(info);
+	if (ret <= 0)
+		goto out;
 
-	error = getaddrinfo(buffer, NULL, &hints, &info);
-	if (error != 0) {
-		snprintf(buffer, length, "getaddrinfo failed: 0x%x %s",
-			error, gai_strerror(error));
+	if (ret > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)
+		tmp[HV_KVP_EXCHANGE_MAX_VALUE_SIZE - 1] = '\0';
+	*str_ptr = tmp;
+
+out:
+	pthread_exit(NULL);
+}
+
+static void kvp_obtain_domain_name(char **str_ptr)
+{
+	pthread_t t;
+
+	if (pthread_create(&t, NULL, kvp_getaddrinfo, str_ptr)) {
+		syslog(LOG_ERR, "pthread_create failed; error: %d %s",
+			errno, strerror(errno));
 		return;
 	}
-	snprintf(buffer, length, "%s", info->ai_canonname);
-	freeaddrinfo(info);
+	pthread_detach(t);
 }
 
 void print_usage(char *argv[])
@@ -1404,11 +1431,7 @@ int main(int argc, char *argv[])
 	 * Retrieve OS release information.
 	 */
 	kvp_get_os_info();
-	/*
-	 * Cache Fully Qualified Domain Name because getaddrinfo takes an
-	 * unpredictable amount of time to finish.
-	 */
-	kvp_get_domain_name(full_domain_name, sizeof(full_domain_name));
+	kvp_obtain_domain_name(&full_domain_name);
 
 	if (kvp_file_init()) {
 		syslog(LOG_ERR, "Failed to initialize the pools");
@@ -1573,7 +1596,7 @@ int main(int argc, char *argv[])
 
 		switch (hv_msg->body.kvp_enum_data.index) {
 		case FullyQualifiedDomainName:
-			strcpy(key_value, full_domain_name);
+			strcpy(key_value, full_domain_name ? : "");
 			strcpy(key_name, "FullyQualifiedDomainName");
 			break;
 		case IntegrationServicesVersion:
