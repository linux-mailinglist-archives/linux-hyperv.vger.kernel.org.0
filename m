Return-Path: <linux-hyperv+bounces-1731-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9B3879445
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51461C2341C
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276E236AFB;
	Tue, 12 Mar 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RNnWbBup"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B47A15E;
	Tue, 12 Mar 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247121; cv=none; b=J0ci8FuBq/sZhI7Jrw328JyoNNVLZOtKblUNPQEbpMv0yKbQTjZQZW+r1oDGJxqtgdgF+ChmUdHRlC+QYqNXJkZx/f11r4gsAcF+lIlNsalJrFFkB45j+5AVQIDgtJP71B1PZmBeVGlUV+g0u2SRaFwh7szSyhDdZdfZVP6EVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247121; c=relaxed/simple;
	bh=GkAYNH3txNSYtyzxuiX102WxRl42aZ7qyZWzRykfmMA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TmVPrFjFfaRmkp9XuyqT8UrnKoEUyZhn1utKZofQ20mbj9Jqf+bBfFfqP4BA5u93K0f75Dvky1ydTfHN/s57ByDnGHWzUV4+r8UuEnV9lY2PeEXKhigrKTjxTFw+r2IHu8ccjMeDPftHycPcTzl+PsU4wJEoqnqhyHES73xQP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RNnWbBup; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 7982120B74C0; Tue, 12 Mar 2024 05:38:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7982120B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710247113;
	bh=sDwJ3xsCeoh5Z54rGko8eW0A7PXt+rXt9R3ZVFeOvpw=;
	h=From:To:Cc:Subject:Date:From;
	b=RNnWbBupf2BCZ+CJUxFMW57gwfOevD24X/oS1pfxuVT+2ekyDVb2L/wkBwdKLabSQ
	 RUiyuGDykqTp0721U0UItp8w59yvH75J8wTEBmlbHODwYBygwH1WRR2uAUIlvsa6py
	 nHrnVoWqO9bghKvLnqe8w3u8DSTwrITOC2chpcPg=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>,
	Ani Sinha <anisinha@redhat.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for keyfile format
Date: Tue, 12 Mar 2024 05:38:32 -0700
Message-Id: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
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

Built-on: Rhel9
Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v2
 * Use calloc to avoid initialization later
 * Return standard error codes
 * Free the output_str pointer on completion
 * Add out-of bound checks while writing to buffers
---
 tools/hv/hv_kvp_daemon.c | 173 +++++++++++++++++++++++++++++----------
 1 file changed, 132 insertions(+), 41 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 318e2dad27e0..ae65be004eb1 100644
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
@@ -102,6 +108,7 @@ static struct utsname uts_buf;
 
 #define MAX_FILE_NAME 100
 #define ENTRIES_PER_BLOCK 50
+#define MAX_IP_ENTRIES 64
 
 struct kvp_record {
 	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
@@ -1171,6 +1178,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
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
+	else
+		return -EINVAL;
+}
+
 /*
  * Only IPv4 subnet strings needs to be converted to plen
  * For IPv6 the subnet is already privided in plen format
@@ -1197,14 +1216,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
 	return plen;
 }
 
+static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
+				  int ip_sec)
+{
+	char addr[INET6_ADDRSTRLEN], *output_str;
+	int ip_offset = 0, error = 0, ip_ver;
+	char *param_name;
+
+	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
+				    sizeof(char));
+
+	if (!output_str)
+		return -ENOMEM;
+
+	memset(addr, 0, sizeof(addr));
+
+	if (type == DNS) {
+		param_name = "dns";
+	} else if (type == GATEWAY) {
+		param_name = "gateway";
+	} else {
+		error = -EINVAL;
+		goto cleanup;
+	}
+
+	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
+				   (MAX_IP_ADDR_SIZE * 2))) {
+		ip_ver = ip_version_check(addr);
+		if (ip_ver < 0)
+			continue;
+
+		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
+		    (ip_ver == IPV6 && ip_sec == IPV6)) {
+			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
+			    (strlen(addr))) {
+				strcat(output_str, addr);
+				strcat(output_str, ",");
+			}
+			memset(addr, 0, sizeof(addr));
+
+		} else {
+			memset(addr, 0, sizeof(addr));
+			continue;
+		}
+	}
+
+	if (strlen(output_str)) {
+		output_str[strlen(output_str) - 1] = '\0';
+		error = fprintf(f, "%s=%s\n", param_name, output_str);
+		if (error <  0)
+			goto cleanup;
+	}
+
+cleanup:
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
@@ -1216,10 +1292,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
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
@@ -1238,12 +1320,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
 
 static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 {
-	int error = 0;
+	int error = 0, ip_type;
 	char if_filename[PATH_MAX];
 	char nm_filename[PATH_MAX];
 	FILE *ifcfg_file, *nmfile;
 	char cmd[PATH_MAX];
-	int is_ipv6 = 0;
 	char *mac_addr;
 	int str_len;
 
@@ -1421,52 +1502,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
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
+	ip_type = IPV4;
+	do {
+		if (ip_type == IPV4) {
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
+					     ip_type);
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
+					       GATEWAY, ip_type);
 		if (error < 0)
 			goto setval_error;
-	}
 
-	if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
-		error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
+		error = process_dns_gateway_nm(nmfile,
+					       (char *)new_val->dns_addr, DNS,
+					       ip_type);
 		if (error < 0)
 			goto setval_error;
-	}
+
+		ip_type++;
+	} while (ip_type < IP_TYPE_MAX);
+
 	fclose(nmfile);
 	fclose(ifcfg_file);
 
-- 
2.34.1


