Return-Path: <linux-hyperv+bounces-1765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4287E23C
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 03:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3950C1F21024
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 02:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40C1CD23;
	Mon, 18 Mar 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aGHg4Ibm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC28814;
	Mon, 18 Mar 2024 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710729954; cv=none; b=kayX09RcNUd9MVFSjgmvtBsCEsOQLxyUXr89kYPfPOScCNOqqNV3laRs5U+myiIqk15w5JwhsV75Nw9Bgz46BYqUfBqVANJ3OSPYbGmBYQVBaVKYjENzaP4gEI99BlhfgoOgx/pqCIyhVtibR6tvLZc7xtYqNTAyAB5f87Le9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710729954; c=relaxed/simple;
	bh=CxnsZd7rbZMrQtDk4mHIEY+JTsHd4K0H9jn4yBsFhgA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UfQvNfKaijpS66YtNx18nJn1SuxnbXfY+FB3w5L8PQxa4Jfw0J4wf+UH3MIFioeQb0N0TjExh55tYkhwPafL0NnFO4z4mUbkH8trO3QGb4L0shn9qcM9z6gn6QWvhVDivsOisBNFPyh2I2qVx4xoDe9ZKH6kbB/xCdiaHItwXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aGHg4Ibm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 9520020B74C0; Sun, 17 Mar 2024 19:45:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9520020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710729952;
	bh=rvVWLQiGsfQNZCfj9wc8a/tjixWzO4wJ12FE9seR5i0=;
	h=From:To:Cc:Subject:Date:From;
	b=aGHg4Ibmiv0G8KbRHkwOe0IIbzq898ovzRbPS+o53r7SRV+7evZfzenjmQWK8BgvU
	 fB8gbpfq2EYvEs9hd7dxsBzAg4KehjuEd9+g9E5YgVvobpyu2pOwkmYsAFKHRcujbz
	 TW8rkQfgzmIcsZLiDD8yf7NrUkcE+GOqJ7mbhuR8=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>,
	Ani Sinha <anisinha@redhat.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v3] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for keyfile format
Date: Sun, 17 Mar 2024 19:45:51 -0700
Message-Id: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

If the network configuration strings are passed as a combination of IPv and
IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile
configuration format.
With these changes, the keyfile config generation logic scans through the
list twice to generate IPv4 and IPv6 sections for the configuration files
to handle this support.

Testcases ran:Rhel 9, Hyper-V VMs
              (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v3
 * Introduced a macro for the output string size
 * Added cound checks and used strncpy instead of strncpy
 * Rearranged code to reduce total lines of code
---
 tools/hv/hv_kvp_daemon.c | 177 ++++++++++++++++++++++++++++++---------
 1 file changed, 136 insertions(+), 41 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 318e2dad27e0..156cef99d361 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -76,6 +76,12 @@ enum {
 	DNS
 };
 
+enum {
+	IPV4 = 1,
+	IPV6,
+	IP_TYPE_MAX
+};
+
 static int in_hand_shake;
 
 static char *os_name = "";
@@ -102,6 +108,11 @@ static struct utsname uts_buf;
 
 #define MAX_FILE_NAME 100
 #define ENTRIES_PER_BLOCK 50
+/*
+ * Change this entry if the number of addresses increases in future
+ */
+#define MAX_IP_ENTRIES 64
+#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
 
 struct kvp_record {
 	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
@@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
 	return 0;
 }
 
+int ip_version_check(const char *input_addr)
+{
+	struct in6_addr addr;
+
+	if (inet_pton(AF_INET, input_addr, &addr))
+		return IPV4;
+	else if (inet_pton(AF_INET6, input_addr, &addr))
+		return IPV6;
+
+	return -EINVAL;
+}
+
 /*
  * Only IPv4 subnet strings needs to be converted to plen
  * For IPv6 the subnet is already privided in plen format
@@ -1197,14 +1220,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
 	return plen;
 }
 
+static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
+				  int ip_sec)
+{
+	char addr[INET6_ADDRSTRLEN], *output_str;
+	int ip_offset = 0, error = 0, ip_ver;
+	char *param_name;
+
+	memset(addr, 0, sizeof(addr));
+
+	if (type == DNS)
+		param_name = "dns";
+	else if (type == GATEWAY)
+		param_name = "gateway";
+	else
+		return -EINVAL;
+
+	output_str = (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
+	if (!output_str)
+		return -ENOMEM;
+
+	while (1) {
+		memset(addr, 0, sizeof(addr));
+
+		if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
+					 (MAX_IP_ADDR_SIZE * 2)))
+			break;
+
+		ip_ver = ip_version_check(addr);
+		if (ip_ver < 0)
+			continue;
+
+		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
+		    (ip_ver == IPV6 && ip_sec == IPV6)) {
+			/*
+			 * do a bound check to avoid out-of bound writes
+			 */
+			if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
+			    (strlen(addr) + 1)) {
+				strncat(output_str, addr,
+					OUTSTR_BUF_SIZE - strlen(output_str));
+				strncat(output_str, ",",
+					OUTSTR_BUF_SIZE - strlen(output_str));
+			}
+		} else {
+			continue;
+		}
+	}
+
+	if (strlen(output_str)) {
+		output_str[strlen(output_str) - 1] = '\0';
+		error = fprintf(f, "%s=%s\n", param_name, output_str);
+	}
+
+	free(output_str);
+	return error;
+}
+
 static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
-				int is_ipv6)
+				int ip_sec)
 {
 	char addr[INET6_ADDRSTRLEN];
 	char subnet_addr[INET6_ADDRSTRLEN];
 	int error, i = 0;
 	int ip_offset = 0, subnet_offset = 0;
-	int plen;
+	int plen, ip_ver;
 
 	memset(addr, 0, sizeof(addr));
 	memset(subnet_addr, 0, sizeof(subnet_addr));
@@ -1216,10 +1296,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
 						       subnet_addr,
 						       (MAX_IP_ADDR_SIZE *
 							2))) {
-		if (!is_ipv6)
+		ip_ver = ip_version_check(addr);
+		if (ip_ver < 0)
+			continue;
+
+		if (ip_ver == IPV4 && ip_sec == IPV4)
 			plen = kvp_subnet_to_plen((char *)subnet_addr);
-		else
+		else if (ip_ver == IPV6 && ip_sec == IPV6)
 			plen = atoi(subnet_addr);
+		else
+			continue;
 
 		if (plen < 0)
 			return plen;
@@ -1238,12 +1324,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
 
 static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 {
-	int error = 0;
+	int error = 0, ip_ver;
 	char if_filename[PATH_MAX];
 	char nm_filename[PATH_MAX];
 	FILE *ifcfg_file, *nmfile;
 	char cmd[PATH_MAX];
-	int is_ipv6 = 0;
 	char *mac_addr;
 	int str_len;
 
@@ -1421,52 +1506,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	if (error)
 		goto setval_error;
 
-	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
-		error = fprintf(nmfile, "\n[ipv6]\n");
-		if (error < 0)
-			goto setval_error;
-		is_ipv6 = 1;
-	} else {
-		error = fprintf(nmfile, "\n[ipv4]\n");
-		if (error < 0)
-			goto setval_error;
-	}
-
 	/*
-	 * Now we populate the keyfile format
+	 * The keyfile format expects the IPv6 and IPv4 configuration in
+	 * different sections. Therefore we iterate through the list twice,
+	 * once to populate the IPv4 section and the next time for IPv6
 	 */
+	ip_ver = IPV4;
+	do {
+		if (ip_ver == IPV4) {
+			error = fprintf(nmfile, "\n[ipv4]\n");
+			if (error < 0)
+				goto setval_error;
+		} else {
+			error = fprintf(nmfile, "\n[ipv6]\n");
+			if (error < 0)
+				goto setval_error;
+		}
 
-	if (new_val->dhcp_enabled) {
-		error = kvp_write_file(nmfile, "method", "", "auto");
-		if (error < 0)
-			goto setval_error;
-	} else {
-		error = kvp_write_file(nmfile, "method", "", "manual");
+		/*
+		 * Now we populate the keyfile format
+		 */
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
+
+		/*
+		 * Write the configuration for ipaddress, netmask, gateway and
+		 * name services
+		 */
+		error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
+					     (char *)new_val->sub_net,
+					     ip_ver);
 		if (error < 0)
 			goto setval_error;
-	}
 
-	/*
-	 * Write the configuration for ipaddress, netmask, gateway and
-	 * name services
-	 */
-	error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
-				     (char *)new_val->sub_net, is_ipv6);
-	if (error < 0)
-		goto setval_error;
-
-	/* we do not want ipv4 addresses in ipv6 section and vice versa */
-	if (is_ipv6 != is_ipv4((char *)new_val->gate_way)) {
-		error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
+		error = process_dns_gateway_nm(nmfile,
+					       (char *)new_val->gate_way,
+					       GATEWAY, ip_ver);
 		if (error < 0)
 			goto setval_error;
-	}
 
-	if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
-		error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
+		error = process_dns_gateway_nm(nmfile,
+					       (char *)new_val->dns_addr, DNS,
+					       ip_ver);
 		if (error < 0)
 			goto setval_error;
-	}
+
+		ip_ver++;
+	} while (ip_ver < IP_TYPE_MAX);
+
 	fclose(nmfile);
 	fclose(ifcfg_file);
 
-- 
2.34.1


