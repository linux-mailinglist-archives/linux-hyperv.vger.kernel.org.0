Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD66F7C91
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 May 2023 07:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjEEFv3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 May 2023 01:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEFv2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 May 2023 01:51:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53C941FE1;
        Thu,  4 May 2023 22:51:26 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id DB02320EA25D; Thu,  4 May 2023 22:51:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB02320EA25D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683265885;
        bh=RkYIlRpSGE3RkwByOMK1BBL7I2+pvXPyV2rSwbVWbgE=;
        h=From:To:Cc:Subject:Date:From;
        b=DPKyhacKJTGP09xQiYct3033LSZl8mkNnioERU8XDvVvKh2Q+srmTEdSeYquCREek
         sQplfvVy82Qq2RftBAHnQe4UU4cb0tzau7lI5U0FiWeyqz7QUmfj2LRpEcZ1W3hKQX
         jiyRk9DM33J2P4nnXt53VTh8o8lPKkQwGOCt9QSQ=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>
Subject: [PATCH v3] hv/hv_kvp_daemon: Add support for keyfile config based connection profile in NM
Date:   Thu,  4 May 2023 22:51:15 -0700
Message-Id: <1683265875-3706-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ifcfg config file support in NetworkManger is deprecated. This patch
provides support for the new keyfile config format for connection
profiles in NetworkManager. The patch modifies the hv_kvp_daemon code
to generate the new network configuration in keyfile
format(.ini-style format) along with a ifcfg format configuration.
The ifcfg format configuration is also retained to support easy
backward compatibility for distro vendors. These configurations are
stored in temp files which are further translated using the
hv_set_ifconfig.sh script. This script is implemented by individual
distros based on the network management commands supported.
For example, RHEL's implementation could be found here:
https://gitlab.com/redhat/centos-stream/src/hyperv-daemons/-/blob/c9s/hv_set_ifconfig.sh
Debian's implementation could be found here:
https://github.com/endlessm/linux/blob/master/debian/cloud-tools/hv_set_ifconfig

The next part of this support is to let the Distro vendors consume
these modified implementations to the new configuration format.

Tested-on: Rhel9(Hyper-V, Azure)(nm and ifcfg files verified)
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---

Changes in v3:
 * Corrected the patch description to include information about new
   changes to persist ifcfg file format too
 * Code changes to support population of ifcfg format configuration
   file along with keyfiles
 * Renamed the new temp keyfile configuration to
   <interface>.nmconnection

---
 tools/hv/hv_kvp_daemon.c    | 224 ++++++++++++++++++++++++++++++++----
 tools/hv/hv_set_ifconfig.sh |  39 ++++++-
 2 files changed, 234 insertions(+), 29 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 27f5e7dfc2f7..ae1e2eb10428 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1171,11 +1171,91 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
 	return 0;
 }
 
+static int kvp_subnet_to_plen(char *subnet_addr_str)
+{
+	int plen = 0;
+	struct in_addr subnet_addr4;
+	struct in6_addr subnet_addr6;
+
+	/*
+	 * Convert subnet address to binary representation
+	 */
+	if (inet_pton(AF_INET, subnet_addr_str, &subnet_addr4) == 1) {
+
+		uint32_t subnet_mask = ntohl(subnet_addr4.s_addr);
+
+		while (subnet_mask & 0x80000000) {
+
+			plen++;
+			subnet_mask <<= 1;
+		}
+	} else if (inet_pton(AF_INET6, subnet_addr_str, &subnet_addr6) == 1) {
+
+		const uint8_t *subnet_mask = subnet_addr6.s6_addr;
+		int i = 0;
+
+		while (i < 16 && subnet_mask[i] == 0xff) {
+
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
+			}
+		}
+	} else {
+		return -1;
+	}
+
+	return plen;
+}
+
+static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet)
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
+			return error;
+
+		memset(addr, 0, sizeof(addr));
+		memset(subnet_addr, 0, sizeof(subnet_addr));
+	}
+
+	return 0;
+}
+
 static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 {
 	int error = 0;
 	char if_file[PATH_MAX];
-	FILE *file;
+	char nm_file[PATH_MAX];
+	FILE *ifcfg_file, *nmfile;
 	char cmd[PATH_MAX];
 	char *mac_addr;
 	int str_len;
@@ -1197,7 +1277,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * in a given distro to configure the interface and so are free
 	 * ignore information that may not be relevant.
 	 *
-	 * Here is the format of the ip configuration file:
+	 * Here is the ifcfg format of the ip configuration file:
 	 *
 	 * HWADDR=macaddr
 	 * DEVICE=interface name
@@ -1220,6 +1300,32 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
 	 * IPV6NETMASK.
 	 *
+	 * Here is the keyfile format of the ip configuration file:
+	 *
+	 * [ethernet]
+	 * mac-address=macaddr
+	 * [connection]
+	 * interface-name=interface name
+	 *
+	 * [ipv4]
+	 * method=<protocol> (where <protocol> is "auto" if DHCP is configured
+	 *                       or "manual" if no boot-time protocol should be used)
+	 *
+	 * address1=ipaddr1/plen
+	 * address2=ipaddr2/plen
+	 *
+	 * gateway=gateway1;gateway2
+	 *
+	 * dns=dns1;dns2
+	 *
+	 * [ipv6]
+	 * address1=ipaddr1/plen
+	 * address2=ipaddr2/plen
+	 *
+	 * gateway=gateway1;gateway2
+	 *
+	 * dns=dns1;dns2
+	 *
 	 * The host can specify multiple ipv4 and ipv6 addresses to be
 	 * configured for the interface. Furthermore, the configuration
 	 * needs to be persistent. A subsequent GET call on the interface
@@ -1227,12 +1333,26 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * call.
 	 */
 
+	/*
+	 * We are populating both ifcfg and nmconnection files
+	 */
 	snprintf(if_file, sizeof(if_file), "%s%s%s", KVP_CONFIG_LOC,
 		"/ifcfg-", if_name);
 
-	file = fopen(if_file, "w");
+	ifcfg_file = fopen(if_file, "w");
 
-	if (file == NULL) {
+	if (ifcfg_file == NULL) {
+		syslog(LOG_ERR, "Failed to open config file; error: %d %s",
+				errno, strerror(errno));
+		return HV_E_FAIL;
+	}
+
+	snprintf(nm_file, sizeof(if_file), "%s%s%s%s", KVP_CONFIG_LOC,
+		"/", if_name, ".nmconnection");
+
+	nmfile = fopen(nm_file, "w");
+
+	if (nmfile == NULL) {
 		syslog(LOG_ERR, "Failed to open config file; error: %d %s",
 				errno, strerror(errno));
 		return HV_E_FAIL;
@@ -1248,12 +1368,28 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 		goto setval_error;
 	}
 
-	error = kvp_write_file(file, "HWADDR", "", mac_addr);
-	free(mac_addr);
+	error = kvp_write_file(ifcfg_file, "HWADDR", "", mac_addr);
+	if (error < 0)
+		goto setval_error;
+
+	error = kvp_write_file(ifcfg_file, "DEVICE", "", if_name);
+	if (error < 0)
+		goto setval_error;
+
+	error = fprintf(nmfile, "\n[connection]\n");
+	if (error < 0)
+		goto setval_error;
+
+	error = kvp_write_file(nmfile, "interface-name", "", if_name);
 	if (error)
 		goto setval_error;
 
-	error = kvp_write_file(file, "DEVICE", "", if_name);
+	error = fprintf(nmfile, "\n[ethernet]\n");
+	if (error < 0)
+		goto setval_error;
+
+	error = kvp_write_file(nmfile, "mac-address", "", mac_addr);
+	free(mac_addr);
 	if (error)
 		goto setval_error;
 
@@ -1263,47 +1399,88 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	 * proceed to parse and pass the IPv6 information to the
 	 * disto-specific script hv_set_ifconfig.
 	 */
+
+	/*
+	 * First populate the ifcfg file format
+	 */
 	if (new_val->dhcp_enabled) {
-		error = kvp_write_file(file, "BOOTPROTO", "", "dhcp");
+		error = kvp_write_file(ifcfg_file, "BOOTPROTO", "", "dhcp");
 		if (error)
 			goto setval_error;
-
 	} else {
-		error = kvp_write_file(file, "BOOTPROTO", "", "none");
+		error = kvp_write_file(ifcfg_file, "BOOTPROTO", "", "none");
 		if (error)
 			goto setval_error;
 	}
 
-	/*
-	 * Write the configuration for ipaddress, netmask, gateway and
-	 * name servers.
-	 */
-
-	error = process_ip_string(file, (char *)new_val->ip_addr, IPADDR);
+	error = process_ip_string(ifcfg_file, (char *)new_val->ip_addr,
+					IPADDR);
 	if (error)
 		goto setval_error;
 
-	error = process_ip_string(file, (char *)new_val->sub_net, NETMASK);
+	error = process_ip_string(ifcfg_file, (char *)new_val->sub_net,
+					NETMASK);
 	if (error)
 		goto setval_error;
 
-	error = process_ip_string(file, (char *)new_val->gate_way, GATEWAY);
+	error = process_ip_string(ifcfg_file, (char *)new_val->gate_way,
+					GATEWAY);
 	if (error)
 		goto setval_error;
 
-	error = process_ip_string(file, (char *)new_val->dns_addr, DNS);
+	error = process_ip_string(ifcfg_file, (char *)new_val->dns_addr, DNS);
 	if (error)
 		goto setval_error;
 
-	fclose(file);
+	if (new_val->addr_family == ADDR_FAMILY_IPV6) {
+
+		error = fprintf(nmfile, "\n[ipv6]\n");
+		if (error < 0)
+			goto setval_error;
+	} else {
+
+		error = fprintf(nmfile, "\n[ipv4]\n");
+		if (error < 0)
+			goto setval_error;
+
+		if (new_val->dhcp_enabled) {
+			error = kvp_write_file(nmfile, "method", "", "auto");
+			if (error < 0)
+				goto setval_error;
+		} else {
+			error = kvp_write_file(nmfile, "method", "", "manual");
+			if (error < 0)
+				goto setval_error;
+		}
+	}
+
+	/*
+	 * Write the configuration for ipaddress, netmask, gateway and
+	 * name services
+	 */
+	error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
+					(char *)new_val->sub_net);
+	if (error < 0)
+		goto setval_error;
+
+	error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
+	if (error < 0)
+		goto setval_error;
+
+	error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
+	if (error < 0)
+		goto setval_error;
+
+	fclose(nmfile);
+	fclose(ifcfg_file);
 
 	/*
 	 * Now that we have populated the configuration file,
 	 * invoke the external script to do its magic.
 	 */
 
-	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s",
-			   "hv_set_ifconfig", if_file);
+	str_len = snprintf(cmd, sizeof(cmd), KVP_SCRIPTS_PATH "%s %s %s",
+			   "hv_set_ifconfig", if_file, nm_file);
 	/*
 	 * This is a little overcautious, but it's necessary to suppress some
 	 * false warnings from gcc 8.0.1.
@@ -1323,7 +1500,8 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 
 setval_error:
 	syslog(LOG_ERR, "Failed to write config file");
-	fclose(file);
+	fclose(ifcfg_file);
+	fclose(nmfile);
 	return error;
 }
 
diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
index d10fe35b7f25..ae5a7a8249a2 100755
--- a/tools/hv/hv_set_ifconfig.sh
+++ b/tools/hv/hv_set_ifconfig.sh
@@ -18,12 +18,12 @@
 #
 # This example script is based on a RHEL environment.
 #
-# Here is the format of the ip configuration file:
+# Here is the ifcfg format of the ip configuration file:
 #
 # HWADDR=macaddr
 # DEVICE=interface name
 # BOOTPROTO=<protocol> (where <protocol> is "dhcp" if DHCP is configured
-#                       or "none" if no boot-time protocol should be used)
+# 			or "none" if no boot-time protocol should be used)
 #
 # IPADDR0=ipaddr1
 # IPADDR1=ipaddr2
@@ -41,6 +41,32 @@
 # tagged as IPV6_DEFAULTGW and IPV6 NETMASK will be tagged as
 # IPV6NETMASK.
 #
+# Here is the keyfile format of the ip configuration file:
+#
+# [ethernet]
+# mac-address=macaddr
+# [connection]
+# interface-name=interface name
+#
+# [ipv4]
+# method=<protocol> (where <protocol> is "auto" if DHCP is configured
+#                       or "manual" if no boot-time protocol should be used)
+#
+# address1=ipaddr1/plen
+# address=ipaddr2/plen
+#
+# gateway=gateway1;gateway2
+#
+# dns=dns1;
+#
+# [ipv6]
+# address1=ipaddr1/plen
+# address2=ipaddr1/plen
+#
+# gateway=gateway1;gateway2
+#
+# dns=dns1;dns2
+#
 # The host can specify multiple ipv4 and ipv6 addresses to be
 # configured for the interface. Furthermore, the configuration
 # needs to be persistent. A subsequent GET call on the interface
@@ -48,18 +74,19 @@
 # call.
 #
 
-
-
 echo "IPV6INIT=yes" >> $1
 echo "NM_CONTROLLED=no" >> $1
 echo "PEERDNS=yes" >> $1
 echo "ONBOOT=yes" >> $1
 
-
 cp $1 /etc/sysconfig/network-scripts/
 
+chmod 600 $2
+interface=$(echo $2 | awk -F - '{ print $2 }')
+filename="${2##*/}"
+
+sed '/\[connection\]/a autoconnect=true' $2 > /etc/NetworkManager/system-connections/${filename}
 
-interface=$(echo $1 | awk -F - '{ print $2 }')
 
 /sbin/ifdown $interface 2>/dev/null
 /sbin/ifup $interface 2>/dev/null
-- 
2.34.1

