Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B39FB465
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2019 16:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKMP5R (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Nov 2019 10:57:17 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:21788 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMP5R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Nov 2019 10:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573660634;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=/LGnKiYy7wgg2UQ6QDBC/em5eo8m26dky6ZlAzfrAsc=;
        b=cyuf7T9i12p7uQf9BiRFWm9pDXkuuF3wpZ5PVtdyTo8ANoAJYOHxkzzeZJ1ZHiYg9u
        Dh6Dat1TVQEoTzm9KhHqaxj9lH5h1Tu1vW6QW6TmwRyuOigpUJavGV4yud98/t4GE0Ea
        v8vzNfVMJ+HwQ8C6FxnRSjhWVmwnXhrsJxrdyDbuEB+IsgZ7uzhKZQPKMmNAtxbKfVWQ
        XaJ/FWFaavSjiDCII08nL2jYxd8UGn4rf5Ah672+8lXv+wAqur3WkuLPcI2qAfXy5oEM
        uzUJhFJTpjvHSB6vh6rDGIeySER0WGNdciy64oyvOyK1CcTR1HdkVrLCJBFkinMlYkDO
        cSag==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS325Pjw=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id 20735bvADFsBGfU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 16:54:11 +0100 (CET)
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Olaf Hering <olaf@aepfle.de>
Subject: [PATCH v2] tools/hv: async name resolution in kvp_daemon
Date:   Wed, 13 Nov 2019 16:54:00 +0100
Message-Id: <20191113155400.25456-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
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
- link with -pthread instead of -lpthread
- consider some errors from getaddrinfo fatal, log them via syslog
- update also hostname in the loop

 tools/hv/Makefile        |  2 ++
 tools/hv/hv_kvp_daemon.c | 83 ++++++++++++++++++++++++++++++++++--------------
 2 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index b57143d9459c..9bbab96ac06d 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -22,6 +22,8 @@ ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
 
+$(OUTPUT)hv_kvp_daemon: LDFLAGS += -pthread
+
 all: $(ALL_PROGRAMS)
 
 export srctree OUTPUT CC LD CFLAGS
diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index e9ef4ca6a655..b930506a9632 100644
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
@@ -1327,27 +1328,67 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
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
 
-	gethostname(buffer, length);
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_INET; /*Get only ipv4 addrinfo. */
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_flags = AI_CANONNAME;
+	do {
+		if (gethostname(hostname, sizeof(hostname) - 1) < 0)
+			goto out;
 
-	error = getaddrinfo(buffer, NULL, &hints, &info);
-	if (error != 0) {
-		snprintf(buffer, length, "getaddrinfo failed: 0x%x %s",
-			error, gai_strerror(error));
+		ret = getaddrinfo(hostname, NULL, &hints, &info);
+		switch (ret) {
+		case 0:
+			break;
+		case EAI_BADFLAGS:
+		case EAI_MEMORY:
+		case EAI_OVERFLOW:
+		case EAI_SOCKTYPE:
+		case EAI_SYSTEM:
+			/* Permanent failure */
+			syslog(LOG_ERR, "getaddrinfo failed: %d %s",
+				ret, gai_strerror(ret));
+			goto out;
+		default:
+			/* Temporary failure, aim for success. */
+			sleep(1);
+		}
+	} while (ret);
+
+	ret = asprintf(&tmp, "%s", info->ai_canonname);
+	freeaddrinfo(info);
+	if (ret <= 0)
+		goto out;
+
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
@@ -1412,11 +1453,7 @@ int main(int argc, char *argv[])
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
@@ -1571,7 +1608,7 @@ int main(int argc, char *argv[])
 
 		switch (hv_msg->body.kvp_enum_data.index) {
 		case FullyQualifiedDomainName:
-			strcpy(key_value, full_domain_name);
+			strcpy(key_value, full_domain_name ? : "");
 			strcpy(key_name, "FullyQualifiedDomainName");
 			break;
 		case IntegrationServicesVersion:
