Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F66C6EB802
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Apr 2023 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDVIkC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 22 Apr 2023 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDVIkC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 22 Apr 2023 04:40:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A5871994;
        Sat, 22 Apr 2023 01:40:00 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 0569E21C2545; Sat, 22 Apr 2023 01:40:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0569E21C2545
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1682152800;
        bh=VEMv19VsFYu0/sUIM41GNUHBY0LwuKMqLTFv9LCfBjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rB8VNgiRTaa8tbB7LjOquBfI4zSk9kx1fOvK3itSJemJhlSslv5R58yOrGPQkVGeP
         eMDTCAu9teBork4qL42KCHvdShoPAGgrbjwx1kB12ctdj3Nws5mtmghkpEibHxedbc
         EdKKKStbC3BI37rZgavdcb2c1vuMXhauzUXYbTPY=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2] hv/hv_kvp_daemon: Add support for keyfile config based  connection profile in NM
Date:   Sat, 22 Apr 2023 01:39:43 -0700
Message-Id: <1682152783-21787-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To:  =?ISO-8859-1?Q?=20<=1B[200~<ZDdbfiMD?= =?ISO-8859-1?Q?8iq2OH9s@liuwe-d?=
        =?ISO-8859-1?Q?evbox-debian-v2>?= =?ISO-8859-1?Q?=1B[201~>?=
References:  =?ISO-8859-1?Q?=20<=1B[200~<ZDdbfiMD?= =?ISO-8859-1?Q?8iq2OH9s@liuwe-d?=
        =?ISO-8859-1?Q?evbox-debian-v2>?= =?ISO-8859-1?Q?=1B[201~>?=
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ifcfg config file support in NetworkManger is deprecated. This patch
provides support for the new keyfile config format for connection
profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
to generate the new network configuration in keyfile
format(.ini-style format) instead of ifcfg format.
This configuration is stored in a temp file which is further translated
using the hv_set_ifconfig.sh script. This script is implemented by
individual distros based on the network management commands supported.
For example, RHEL's implementation could be found here:
https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
Debian's implementation could be found here:
https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig

The next part of this support is to let the Distro vendors consume
these modified implementations to the new configuration format.

Tested-on: Rhel9, Rhel 8.6 (Hyper-V, Azure)
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---

Changes in v2:
 * Corrected the patch description to exclude bugzilla reference

---
 tools/hv/hv_kvp_daemon.c    | 252 ++++++++++++++++--------------------
 tools/hv/hv_set_ifconfig.sh |  42 +++---
 2 files changed, 136 insertions(+), 158 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 27f5e7dfc2f7..7f68f9f69fda 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1004,46 +1004,6 @@ static int kvp_mac_to_ip(struct hv_kvp_ipaddr_value *kvp_ip_val)
 	return error;
 }
 
-static int expand_ipv6(char *addr, int type)
-{
-	int ret;
-	struct in6_addr v6_addr;
-
-	ret = inet_pton(AF_INET6, addr, &v6_addr);
-
-	if (ret != 1) {
-		if (type == NETMASK)
-			return 1;
-		return 0;
-	}
-
-	sprintf(addr, "%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:"
-		"%02x%02x:%02x%02x:%02x%02x",
-		(int)v6_addr.s6_addr[0], (int)v6_addr.s6_addr[1],
-		(int)v6_addr.s6_addr[2], (int)v6_addr.s6_addr[3],
-		(int)v6_addr.s6_addr[4], (int)v6_addr.s6_addr[5],
-		(int)v6_addr.s6_addr[6], (int)v6_addr.s6_addr[7],
-		(int)v6_addr.s6_addr[8], (int)v6_addr.s6_addr[9],
-		(int)v6_addr.s6_addr[10], (int)v6_addr.s6_addr[11],
-		(int)v6_addr.s6_addr[12], (int)v6_addr.s6_addr[13],
-		(int)v6_addr.s6_addr[14], (int)v6_addr.s6_addr[15]);
-
-	return 1;
-
-}
-
-static int is_ipv4(char *addr)
-{
-	int ret;
-	struct in_addr ipv4_addr;
-
-	ret = inet_pton(AF_INET, addr, &ipv4_addr);
-
-	if (ret == 1)
-		return 1;
-	return 0;
-}
-
 static int parse_ip_val_buffer(char *in_buf, int *offset,
 				char *out_buf, int out_len)
 {
@@ -1092,80 +1052,80 @@ static int kvp_write_file(FILE *f, char *s1, char *s2, char *s3)
 	return 0;
 }
 
-
-static int process_ip_string(FILE *f, char *ip_string, int type)
+static int kvp_subnet_to_plen(char *subnet_addr_str)
 {
-	int error = 0;
-	char addr[INET6_ADDRSTRLEN];
-	int i = 0;
-	int j = 0;
-	char str[256];
-	char sub_str[13];
-	int offset = 0;
+	int plen = 0;
+	struct in_addr subnet_addr4;
+	struct in6_addr subnet_addr6;
 
-	memset(addr, 0, sizeof(addr));
+	/*
+	 * Convert subnet address to binary representation
+	 */
+	if (inet_pton(AF_INET, subnet_addr_str, &subnet_addr4) == 1) {
 
-	while (parse_ip_val_buffer(ip_string, &offset, addr,
-					(MAX_IP_ADDR_SIZE * 2))) {
+		uint32_t subnet_mask = ntohl(subnet_addr4.s_addr);
 
-		sub_str[0] = 0;
-		if (is_ipv4(addr)) {
-			switch (type) {
-			case IPADDR:
-				snprintf(str, sizeof(str), "%s", "IPADDR");
-				break;
-			case NETMASK:
-				snprintf(str, sizeof(str), "%s", "NETMASK");
-				break;
-			case GATEWAY:
-				snprintf(str, sizeof(str), "%s", "GATEWAY");
-				break;
-			case DNS:
-				snprintf(str, sizeof(str), "%s", "DNS");
-				break;
-			}
+		while (subnet_mask & 0x80000000) {
 
-			if (type == DNS) {
-				snprintf(sub_str, sizeof(sub_str), "%d", ++i);
-			} else if (type == GATEWAY && i == 0) {
-				++i;
-			} else {
-				snprintf(sub_str, sizeof(sub_str), "%d", i++);
-			}
+			plen++;
+			subnet_mask <<= 1;
+		}
+	} else if (inet_pton(AF_INET6, subnet_addr_str, &subnet_addr6) == 1) {
 
+		const uint8_t *subnet_mask = subnet_addr6.s6_addr;
+		int i = 0;
 
-		} else if (expand_ipv6(addr, type)) {
-			switch (type) {
-			case IPADDR:
-				snprintf(str, sizeof(str), "%s", "IPV6ADDR");
-				break;
-			case NETMASK:
-				snprintf(str, sizeof(str), "%s", "IPV6NETMASK");
-				break;
-			case GATEWAY:
-				snprintf(str, sizeof(str), "%s",
-					"IPV6_DEFAULTGW");
-				break;
-			case DNS:
-				snprintf(str, sizeof(str), "%s",  "DNS");
-				break;
-			}
+		while (i < 16 && subnet_mask[i] == 0xff) {
 
-			if (type == DNS) {
-				snprintf(sub_str, sizeof(sub_str), "%d", ++i);
-			} else if (j == 0) {
-				++j;
-			} else {
-				snprintf(sub_str, sizeof(sub_str), "_%d", j++);
+			plen += 8;
+			i++;
+		}
+		if (i < 16) {
+
+			uint8_t mask_byte = subnet_mask[i];
+
+			while (mask_byte & 0x80) {
+
+				plen++;
+				mask_byte <<= 1;
 			}
-		} else {
-			return  HV_INVALIDARG;
 		}
+	} else {
+		return -1;
+	}
 
-		error = kvp_write_file(f, str, sub_str, addr);
-		if (error)
+	return plen;
+}
+
+static int process_ip_string(FILE *f, char *ip_string, char *subnet)
+{
+	int error = 0;
+	char addr[INET6_ADDRSTRLEN];
+	char subnet_addr[INET6_ADDRSTRLEN];
+	int i = 0;
+	int ip_offset = 0, subnet_offset = 0;
+	int plen;
+
+	memset(addr, 0, sizeof(addr));
+	memset(subnet_addr, 0, sizeof(subnet_addr));
+
+	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
+					(MAX_IP_ADDR_SIZE * 2)) &&
+					parse_ip_val_buffer(subnet,
+					&subnet_offset, subnet_addr,
+					(MAX_IP_ADDR_SIZE * 2))) {
+
+		plen = kvp_subnet_to_plen((char *)subnet_addr);
+		if (plen < 0)
+			return plen;
+
+		error = fprintf(f, "address%d=%s/%d\n", ++i, (char *)addr,
+							plen);
+		if (error < 0)
 			return error;
+
 		memset(addr, 0, sizeof(addr));
+		memset(subnet_addr, 0, sizeof(subnet_addr));
 	}
 
 	return 0;
@@ -1199,26 +1159,29 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 *
 	 * Here is the format of the ip configuration file:
 	 *
-	 * HWADDR=macaddr
-	 * DEVICE=interface name
-	 * BOOTPROTO=<protocol> (where <protocol> is "dhcp" if DHCP is configured
-	 *                       or "none" if no boot-time protocol should be used)
+	 * [ethernet]
+	 * mac-address=macaddr
+	 * [connection]
+	 * interface-name=interface name
+	 *
+	 * [ipv4]
+	 * method=<protocol> (where <protocol> is "auto" if DHCP is configured
+	 *                       or "manual" if no boot-time protocol should be used)
 	 *
-	 * IPADDR0=ipaddr1
-	 * IPADDR1=ipaddr2
-	 * IPADDRx=ipaddry (where y = x + 1)
+	 * address1=ipaddr1/plen
+	 * address2=ipaddr2/plen
 	 *
-	 * NETMASK0=netmask1
-	 * NETMASKx=netmasky (where y = x + 1)
+	 * gateway=gateway1;gateway2
 	 *
-	 * GATEWAY=ipaddr1
-	 * GATEWAYx=ipaddry (where y = x + 1)
+	 * dns=dns1;dns2
 	 *
-	 * DNSx=ipaddrx (where first DNS address is tagged as DNS1 etc)
+	 * [ipv6]
+	 * address1=ipaddr1/plen
+	 * address2=ipaddr2/plen
 	 *
-	 * IPV6 addresses will be tagged as IPV6ADDR, IPV6 gateway will be
-	 * tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
-	 * IPV6NETMASK.
+	 * gateway=gateway1;gateway2
+	 *
+	 * dns=dns1;dns2
 	 *
 	 * The host can specify multiple ipv4 and ipv6 addresses to be
 	 * configured for the interface. Furthermore, the configuration
@@ -1248,12 +1211,20 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 		goto setval_error;
 	}
 
-	error = kvp_write_file(file, "HWADDR", "", mac_addr);
-	free(mac_addr);
+	error = fprintf(file, "\n[connection]\n");
+	if (error < 0)
+		goto setval_error;
+
+	error = kvp_write_file(file, "interface-name", "", if_name);
 	if (error)
 		goto setval_error;
 
-	error = kvp_write_file(file, "DEVICE", "", if_name);
+	error = fprintf(file, "\n[ethernet]\n");
+	if (error < 0)
+		goto setval_error;
+
+	error = kvp_write_file(file, "mac-address", "", mac_addr);
+	free(mac_addr);
 	if (error)
 		goto setval_error;
 
@@ -1263,36 +1234,43 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * proceed to parse and pass the IPv6 information to the
 	 * disto-specific script hv_set_ifconfig.
 	 */
-	if (new_val->dhcp_enabled) {
-		error = kvp_write_file(file, "BOOTPROTO", "", "dhcp");
-		if (error)
-			goto setval_error;
+	if (new_val->addr_family == ADDR_FAMILY_IPV6) {
 
+		error = fprintf(file, "\n[ipv6]\n");
+		if (error < 0)
+			goto setval_error;
 	} else {
-		error = kvp_write_file(file, "BOOTPROTO", "", "none");
-		if (error)
+
+		error = fprintf(file, "\n[ipv4]\n");
+		if (error < 0)
 			goto setval_error;
+
+		if (new_val->dhcp_enabled) {
+			error = kvp_write_file(file, "method", "", "auto");
+			if (error < 0)
+				goto setval_error;
+		} else {
+			error = kvp_write_file(file, "method", "", "manual");
+			if (error < 0)
+				goto setval_error;
+		}
 	}
 
 	/*
 	 * Write the configuration for ipaddress, netmask, gateway and
-	 * name servers.
+	 * name services
 	 */
-
-	error = process_ip_string(file, (char *)new_val->ip_addr, IPADDR);
-	if (error)
+	error = process_ip_string(file, (char *)new_val->ip_addr,
+					(char *)new_val->sub_net);
+	if (error < 0)
 		goto setval_error;
 
-	error = process_ip_string(file, (char *)new_val->sub_net, NETMASK);
-	if (error)
+	error = fprintf(file, "gateway=%s\n", (char *)new_val->gate_way);
+	if (error < 0)
 		goto setval_error;
 
-	error = process_ip_string(file, (char *)new_val->gate_way, GATEWAY);
-	if (error)
-		goto setval_error;
-
-	error = process_ip_string(file, (char *)new_val->dns_addr, DNS);
-	if (error)
+	error = fprintf(file, "dns=%s\n", (char *)new_val->dns_addr);
+	if (error < 0)
 		goto setval_error;
 
 	fclose(file);
diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
index d10fe35b7f25..22238767ef7e 100755
--- a/tools/hv/hv_set_ifconfig.sh
+++ b/tools/hv/hv_set_ifconfig.sh
@@ -20,26 +20,29 @@
 #
 # Here is the format of the ip configuration file:
 #
-# HWADDR=macaddr
-# DEVICE=interface name
-# BOOTPROTO=<protocol> (where <protocol> is "dhcp" if DHCP is configured
-#                       or "none" if no boot-time protocol should be used)
+# [ethernet]
+# mac-address=macaddr
+# [connection]
+# interface-name=interface name
 #
-# IPADDR0=ipaddr1
-# IPADDR1=ipaddr2
-# IPADDRx=ipaddry (where y = x + 1)
+# [ipv4]
+# method=<protocol> (where <protocol> is "auto" if DHCP is configured
+#                       or "manual" if no boot-time protocol should be used)
 #
-# NETMASK0=netmask1
-# NETMASKx=netmasky (where y = x + 1)
+# address1=ipaddr1/plen
+# address=ipaddr2/plen
 #
-# GATEWAY=ipaddr1
-# GATEWAYx=ipaddry (where y = x + 1)
+# gateway=gateway1;gateway2
 #
-# DNSx=ipaddrx (where first DNS address is tagged as DNS1 etc)
+# dns=dns1;
 #
-# IPV6 addresses will be tagged as IPV6ADDR, IPV6 gateway will be
-# tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
-# IPV6NETMASK.
+# [ipv6]
+# address1=ipaddr1/plen
+# address2=ipaddr1/plen
+#
+# gateway=gateway1;gateway2
+#
+# dns=dns1;dns2
 #
 # The host can specify multiple ipv4 and ipv6 addresses to be
 # configured for the interface. Furthermore, the configuration
@@ -50,13 +53,10 @@
 
 
 
-echo "IPV6INIT=yes" >> $1
-echo "NM_CONTROLLED=no" >> $1
-echo "PEERDNS=yes" >> $1
-echo "ONBOOT=yes" >> $1
-
+sed '/\[connection]\/a autoconnect=true' $1
 
-cp $1 /etc/sysconfig/network-scripts/
+chmod 600 $1
+cp $1 /etc/NetworkManager/system-connections/
 
 
 interface=$(echo $1 | awk -F - '{ print $2 }')
-- 
2.37.2

