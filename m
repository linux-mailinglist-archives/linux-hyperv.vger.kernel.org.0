Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA77E3600
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Oct 2019 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409530AbfJXOxU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Oct 2019 10:53:20 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:33798 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409522AbfJXOxU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Oct 2019 10:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1571928798;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=0mp4UnfMmFBuAFZUwVWAjKo0HN743MLM5cwfxhfpVk0=;
        b=Nw1GQz9jiGSQNi7TAYWR/0CCpMMHrmYhxmQU73QOYACcGXLJMNX7tPevrIjR1OWxvY
        S5IA2By8AOpBD32oqnrPbU+nvOFl49lcGjlFmiFjt1o0vKfT8ikdoQdPGB2K+VS6JIFh
        SpUzxbzN8mFb0qjdQ4g0sU8gMp8R88uS86YDIUH9pGDWn22OPfVeoBmgOCLv6r9yqO4P
        obOpc0VTWZB/Ldp2hqbBEJXceDOPPB8QKhdIWz+JJW3CgMTV4E6bfgcWL00I+yeU3P4m
        2+CCEiP5yR5ApO84NJp6c3ox3+0G5Phr5WRkbdQm4WTspYkhX4VjqsvklJDKGON2aDrn
        m8Yg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuz7MdiQehTvc3KJf+T+odQ=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.28.1 DYNA|AUTH)
        with ESMTPSA id e01a77v9OEoBcWQ
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 24 Oct 2019 16:50:11 +0200 (CEST)
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Olaf Hering <olaf@aepfle.de>
Subject: [PATCH v1] tools/hv: async name resolution in kvp_daemon
Date:   Thu, 24 Oct 2019 16:49:43 +0200
Message-Id: <20191024144943.26199-1-olaf@aepfle.de>
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
 tools/hv/Makefile        |  2 ++
 tools/hv/hv_kvp_daemon.c | 69 ++++++++++++++++++++++++++++++++----------------
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
index e9ef4ca6a655..22cf1c4dbf5c 100644
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
+
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
+
+	if (ret > HV_KVP_EXCHANGE_MAX_VALUE_SIZE)
+		tmp[HV_KVP_EXCHANGE_MAX_VALUE_SIZE - 1] = '\0';
+	*str_ptr = tmp;
 
-	gethostname(buffer, length);
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_family = AF_INET; /*Get only ipv4 addrinfo. */
-	hints.ai_socktype = SOCK_STREAM;
-	hints.ai_flags = AI_CANONNAME;
+out:
+	pthread_exit(NULL);
+}
+
+static void kvp_obtain_domain_name(char **str_ptr)
+{
+	pthread_t t;
 
-	error = getaddrinfo(buffer, NULL, &hints, &info);
-	if (error != 0) {
-		snprintf(buffer, length, "getaddrinfo failed: 0x%x %s",
-			error, gai_strerror(error));
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
@@ -1412,11 +1439,7 @@ int main(int argc, char *argv[])
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
@@ -1571,7 +1594,7 @@ int main(int argc, char *argv[])
 
 		switch (hv_msg->body.kvp_enum_data.index) {
 		case FullyQualifiedDomainName:
-			strcpy(key_value, full_domain_name);
+			strcpy(key_value, full_domain_name ? : "");
 			strcpy(key_name, "FullyQualifiedDomainName");
 			break;
 		case IntegrationServicesVersion:
