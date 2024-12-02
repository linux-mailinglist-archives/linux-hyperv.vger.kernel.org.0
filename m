Return-Path: <linux-hyperv+bounces-3383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70139DFED2
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 11:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63F52816FA
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8A1FC10E;
	Mon,  2 Dec 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="JfQBi91v";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="48z6gCSB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B91FC0FC;
	Mon,  2 Dec 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733135158; cv=pass; b=L2IKgGgFGS8eH/YuFmPO1qotqM5mzNut/tzI0TeDCbxpwtWrE8nsZ9Gj41BxotP/rJn4Njq681uaFwU0gTduDhu+wQzqVATF7B14TfF8/naP1JCSRQAPGQ/82DGSXEywuVtV3QwWGky1gYhXzgR51JDbzFiR1BpHX+NBEe42HIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733135158; c=relaxed/simple;
	bh=Amtrq3uG37yLQGZx5M//8x249jchyIj0eGx+jG6DnC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q524XXfEKkvgeqg2qYojeaWYRKUgDfCeOl9VmaNXCVO+/TjhSn9XqsSYsmDkKiBW4hLJYpbSGdNC75rW7FcEZELxb2e6MDiZuHtbo5qgvpTrAkN6S8/3OqlpjPG0j/BCmHMK38tvG0XTiCF37G+JdBMgA0yPi8GH9Eb3Xs+T6aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=JfQBi91v; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=48z6gCSB; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1733134960; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KaOPbF/TuU/VCGQHz9i8/pvudX45CL7HeG1iuP3xY6/f9geMfhxV0XshFc1dOHUvzA
    yhKPG/eKVSUXpCXHYZ/wVPBeWVsBfDR2MU/+iaOrkzuIAy+GLC7h6OvtfvgRSUddfhhG
    1CSgg845642x4eHD6IF3z3zelLepaCicytc4OzvKCbqWKaAe3ig2JUIOKYSBHaKxeIr+
    fYwZDr3oy9qUkQqPkCMvYsh6vYdZ5kHuJN4zGC5iZnl2KNTgVoHK8NN662SyBIcx26Zl
    /FhYWv9y33x8x+3v+8dm3EeZbzS5eip3ZuXhINqU4UUi8HFaLGDsJ+OHmciK+DgDx41k
    BvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733134960;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=eMtgIuevZVFUMoAvNCXgsF1FZH8gzDNbszmiv3MyIi4=;
    b=HFGeSc8mvb9kJgPDU5UwnA0r+PT5/mo81iDpuJVi9u3znY0vhPxzXQyr2rAlEXiD7r
    AlItk+ZFSTl6tEGCaho49QTCR8bm3Dg0emx047e71WSlG1xVGfrp3Jn0lbUKv+NvRnZz
    wSlBfj3c1QByI7cPwdp2rhCm4sdkLELJndTB/c2KIAGNrMxuEE8+lXxRDCgZc1K+DyQT
    MoG4276x+A3YkXRqWjN8KKanIyYr1baItGydnGOiiDTQR7l0mhj061vrg0jzhj8xnmdL
    LnPFvQNMDVMo4HWMl3HyeECVLUk4Rhi9uXUE6JgiVr8vsQdIAiNc9+gG95I9z9SO/mru
    QPpA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733134960;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=eMtgIuevZVFUMoAvNCXgsF1FZH8gzDNbszmiv3MyIi4=;
    b=JfQBi91vlvjRLUbyNlXgjElDU6Lwz/JiLNB7uWS5dwREgRZlNz03xYqNfSSJwinx/x
    UmMRZEAhq/Ro4amDl8nRYfr2gBrGCRmbWjBEs9UUPzWp07pNA3/pajVGVT0CSlfqhUZa
    lOQiKDhm9eEQyIl77m64w+f+5izf7RO55/bP798UbKiMMJX4YONkbOSXGnysSAgqQPW7
    EUgrgbKxl+uesSeGHoMCLTGsJXtsoO/Kay8g48io5Z3tlSydK1SnVlZLkelVNjwmLBFy
    hJ++x4T8YwqlmzU7rmlxQMN8SwHSVKDpxZ63PGu30UL8xEHFXmpVHy1IhNifX9doNPEr
    LyJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733134960;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=eMtgIuevZVFUMoAvNCXgsF1FZH8gzDNbszmiv3MyIi4=;
    b=48z6gCSBrBX87T42AUE4R0UAxrt83UBwqUyjgyzgS3o9Em9FmdF6tE3cPU1p8JPJCk
    cTxsB6VtSS8bBBF4bzCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSUMjanMCZmxMwm2OGJkumVDfIDOsNMxne61spO"
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd65250B2AMeokn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Dec 2024 11:22:40 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] tools/hv: update route parsing in kvp daemon
Date: Mon,  2 Dec 2024 11:19:55 +0100
Message-ID: <20241202102235.9701-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

After recent changes in the VM network stack, the host fails to
display the IP addresses of the VM. As a result the "IP Addresses"
column in the "Networking" tab in the Windows Hyper-V Manager is
empty. This is caused by a change in the expected output of the
"ip route show" command. Previously the gateway address was shown
in the third row. Now the gateway addresses might be split into
several lines of output. As a result, the string "ra" instead of
an IP address is sent to the host.

To me more specific, a VM with the wellknown wicked network
managing tool still shows the expected output in recent openSUSE
Tumbleweed snapshots:

ip a show dev uplink;ip -4 route show;ip -6 route show
2: uplink: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state ...
    link/ether 00:15:5d:d0:93:08 brd ff:ff:ff:ff:ff:ff
    inet 1.2.3.4/22 brd 1.2.3.255 scope global uplink
       valid_lft forever preferred_lft forever
    inet6 fe80::215:5dff:fed0:9308/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
default via 1.2.3.254 dev uplink proto dhcp
1.2.3.0/22 dev uplink proto kernel scope link src 1.2.3.4
fe80::/64 dev uplink proto kernel metric 256 pref medium
default via fe80::26fc:4e00:3b:74 dev uplink proto ra metric 1024 exp...
default via fe80::6a22:8e00:fb:14f8 dev uplink proto ra metric 1024 e...

A similar VM, but with NetworkManager as network managing tool:

ip a show dev eth0;ip -4 route show;ip -6 route show
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP...
    link/ether 00:15:5d:d0:93:0b brd ff:ff:ff:ff:ff:ff
    inet 1.2.3.8/22 brd 1.2.3.255 scope global dynamic noprefixroute ...
       valid_lft 1022sec preferred_lft 1022sec
    inet6 fe80::215:5dff:fed0:930b/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
default via 1.2.3.254 dev eth0 proto dhcp src 1.2.3.8 metric 100
1.2.3.0/22 dev eth0 proto kernel scope link src 1.2.3.8 metric 100
fe80::/64 dev eth0 proto kernel metric 1024 pref medium
default proto ra metric 20100 pref medium
        nexthop via fe80::6a22:8e00:fb:14f8 dev eth0 weight 1
        nexthop via fe80::26fc:4e00:3b:74 dev eth0 weight 1

Adjust the route parsing to use a single line for each line of
output. Also use a single shell invocation to retrieve both IPv4
and IPv6 information. The actual IP addresses are expected after
the "via" keyword.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/hv/hv_kvp_daemon.c | 108 ++++++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 24 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..63b44b191320 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -24,6 +24,7 @@
 
 #include <sys/poll.h>
 #include <sys/utsname.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -677,6 +678,88 @@ static void kvp_process_ipconfig_file(char *cmd,
 	pclose(file);
 }
 
+static bool kvp_verify_ip_address(const void *address_string)
+{
+	char verify_buf[sizeof(struct in6_addr)];
+
+	if (inet_pton(AF_INET, address_string, verify_buf) == 1)
+		return true;
+	if (inet_pton(AF_INET6, address_string, verify_buf) == 1)
+		return true;
+	return false;
+}
+
+static void kvp_extract_routes(const char *line, void **output, size_t *remaining)
+{
+	static const char needle[] = "via ";
+	const char *match, *haystack = line;
+
+	while ((match = strstr(haystack, needle))) {
+		const char *address, *next_char;
+
+		/* Address starts after needle. */
+		address = match + strlen(needle);
+
+		/* The char following address is a space or end of line. */
+		next_char = strpbrk(address, " \t\\");
+		if (!next_char)
+			next_char = address + strlen(address) + 1;
+
+		/* Enough room for address and semicolon. */
+		if (*remaining >= (next_char - address) + 1) {
+			memcpy(*output, address, next_char - address);
+			/* Terminate string for verification. */
+			memcpy(*output + (next_char - address), "", 1);
+			if (kvp_verify_ip_address(*output)) {
+				/* Advance output buffer. */
+				*output += next_char - address;
+				*remaining -= next_char - address;
+
+				/* Each address needs a trailing semicolon. */
+				memcpy(*output, ";", 1);
+				*output += 1;
+				*remaining -= 1;
+			}
+		}
+		haystack = next_char;
+	}
+}
+
+static void kvp_get_gateway(void *buffer, size_t buffer_len)
+{
+	static const char needle[] = "default ";
+	FILE *f;
+	void *output = buffer;
+	char *line = NULL;
+	size_t alloc_size = 0, remaining = buffer_len - 1;
+	ssize_t num_chars;
+
+	/* Show route information in a single line, for each address family */
+	f = popen("ip --oneline -4 route show;ip --oneline -6 route show", "r");
+	if (!f) {
+		/* Convert buffer into C-String. */
+		memcpy(output, "", 1);
+		return;
+	}
+	while ((num_chars = getline(&line, &alloc_size, f)) > 0) {
+		/* Skip short lines. */
+		if (num_chars <= strlen(needle))
+			continue;
+		/* Skip lines without default route. */
+		if (memcmp(line, needle, strlen(needle)))
+			continue;
+		/* Remove trailing newline to simplify further parsing. */
+		if (line[num_chars - 1] == '\n')
+			line[num_chars - 1] = '\0';
+		/* Search routes after match. */
+		kvp_extract_routes(line + strlen(needle), &output, &remaining);
+	}
+	/* Convert buffer into C-String. */
+	memcpy(output, "", 1);
+	free(line);
+	pclose(f);
+}
+
 static void kvp_get_ipconfig_info(char *if_name,
 				 struct hv_kvp_ipaddr_value *buffer)
 {
@@ -685,30 +768,7 @@ static void kvp_get_ipconfig_info(char *if_name,
 	char *p;
 	FILE *file;
 
-	/*
-	 * Get the address of default gateway (ipv4).
-	 */
-	sprintf(cmd, "%s %s", "ip route show dev", if_name);
-	strcat(cmd, " | awk '/default/ {print $3 }'");
-
-	/*
-	 * Execute the command to gather gateway info.
-	 */
-	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
-				(MAX_GATEWAY_SIZE * 2), INET_ADDRSTRLEN, 0);
-
-	/*
-	 * Get the address of default gateway (ipv6).
-	 */
-	sprintf(cmd, "%s %s", "ip -f inet6  route show dev", if_name);
-	strcat(cmd, " | awk '/default/ {print $3 }'");
-
-	/*
-	 * Execute the command to gather gateway info (ipv6).
-	 */
-	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
-				(MAX_GATEWAY_SIZE * 2), INET6_ADDRSTRLEN, 1);
-
+	kvp_get_gateway(buffer->gate_way, sizeof(buffer->gate_way));
 
 	/*
 	 * Gather the DNS state.

