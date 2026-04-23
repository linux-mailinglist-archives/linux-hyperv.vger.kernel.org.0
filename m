Return-Path: <linux-hyperv+bounces-10351-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNpmELRf6mmrygIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10351-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:06:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF46455E69
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50B8E3002B69
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7E3A9629;
	Thu, 23 Apr 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b="hXHsGbgn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAAE314D34
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Apr 2026 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967597; cv=none; b=fy66lbmsJKymFTNTkx1vdpLKTuurNHjiWxeYoJAbvI3PsoGqbPqHkXvDeAHLcOEb7vs/KFSstNK+dRzs3dUdyptQKf21ZiE5Otk/3J/9JLVXJsaACxQ5ZCd+ohsrd4pLsjTBlQpGu7ABrql+5GgFSXxrDK0qYMpOb6dAZ/pMy2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967597; c=relaxed/simple;
	bh=HXgw0xCF/A+VSScfuz+pjLZwlRW774RPWXvvA2uAphE=;
	h=Message-Id:Subject:From:To:Date:Cc:Mime-Version; b=g67i+qbDe1vFmjQ+THjONgDQAv56OQngyKOJ//GS4H0PV4vx4yOv9n6mJYCkiKm6TGtGLQsrztjP9vPmxX0IkKfyQI8UdjsVn7prf+7zKIK1RHzKiU1YMc1CILLTpl9P3NeUv/60KvajBRgcaU0XF5Kg9DnV8WwB3UfJZOpKWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=unknownbbqr.xyz header.i=@unknownbbqr.xyz header.b=hXHsGbgn; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unknownbbqr.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unknownbbqr.xyz;
 q=dns/txt; s=brevo1; bh=TKXC6dWzW+FWDLZF204bMaYSJzDpONYm3mWkhEbFx2U=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=hXHsGbgnEHtKU1zsj4qG4rfwqJ66k787z1raXccUEcJ/RoFEvhtDDmN96vQ0LZDKs5ekJpxg+vFg
        YpZUs4n5dGvoIMkiAT+wmrnAGh9a6GI9fH+d0pH8yo7MvdNiC25CT7X0pxUrj6lfdfgYQ2o8vqAJ
        Ph/Yoow2r/367ZxJfasbTIhv8ZBeDS78//a2TBEokCVKYfeEdlbq+1ST/BtWDxsCVCZNXmbwADuu
        D6xVX9us5oHy5xMGseqjOenkAGgEQ6GMe9zJ40a4LXGo0vP3v8ezsFA1vQUYX9V4bci+Kd5PDKjJ
        Om+PPd7RmdPAHRHqsqfbYfFrsDyOWuSgwbVrJQ==
Message-Id: <9b368f72-18d1-4cba-bbd7-5c044b84081d@smtp-relay.sendinblue.com>
Origin-messageId: <20260423180630.6521-1-dev@unknownbbqr.xyz>
Feedback-ID: 77.32.148.26:10473219_-1:10473219:Sendinblue
X-CSA-Complaints: csa-complaints@eco.de
Subject: [PATCH] tools/hv: fix parse_ip_val_buffer out-of-bounds write
X-sib-id: P0coI5KHO2JcpaDDeGQqDDN2b-YIna1GqekI2MncE3bc8AFlDnyPfB-4HQ3Tf8sV-UZ-7nu6IjXxgd2IJqHIsy9Tt2VLP1rvKoydyyPRB3oR1jeBrjefEl8RP_79ZxypJDWCT8xH6eHHjA3OxOnJihOdGI3J_2ha7eNHkHBkVV3Z98J2DvskFGPTfQ
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: "unknownbbqrx" <dev@unknownbbqr.xyz>
X-Mailin-EID: NDQzNzMzMzgyfmxpbnV4LWh5cGVydkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjYwNDIzMTgwNjMwLjY1MjEtMS1kZXZAdW5rbm93bmJicXIueHl6Pn5nei5kLnNlbmRlci1zaWIuY29t
To: <kys@microsoft.com>,<haiyangz@microsoft.com>,<wei.liu@kernel.org>,<decui@microsoft.com>,<longli@microsoft.com>
Date: Thu, 23 Apr 2026 21:06:30 +0300
Cc: <linux-hyperv@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "unknownbbqrx" <dev@unknownbbqr.xyz>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[unknownbbqr.xyz:s=brevo1];
	MV_CASE(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[unknownbbqr.xyz : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10351-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[unknownbbqr.xyz:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[dev@unknownbbqr.xyz,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unknownbbqr.xyz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp-relay.sendinblue.com:mid]
X-Rspamd-Queue-Id: 2AF46455E69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


parse_ip_val_buffer() validates the parsed token length against out_len,
but several callers passed MAX_IP_ADDR_SIZE * 2 while the destination
buffers are much smaller stack arrays (e.g. INET6_ADDRSTRLEN).

This can lead to out-of-bounds writes via strcpy() when a long token is
parsed from host-provided IP/subnet strings.

Use size_t for out_len, switch to bounded copy with memcpy() + explicit
NUL termination, and pass the actual destination buffer sizes at all
call sites.

Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>
---
 tools/hv/hv_kvp_daemon.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index c02f8a341..ecf123bce 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1188,10 +1188,11 @@ static int is_ipv4(char *addr)
 }
=20
 static int parse_ip_val_buffer(char *in_buf, int *offset,
-				char *out_buf, int out_len)
+				char *out_buf, size_t out_len)
 {
 	char *x;
 	char *start;
+	size_t copy_len;
=20
 	/*
 	 * in_buf has sequence of characters that are separated by
@@ -1214,8 +1215,10 @@ static int parse_ip_val_buffer(char *in_buf, int *of=
fset,
 		while (start[i] =3D=3D ' ')
 			i++;
=20
-		if ((x - start) <=3D out_len) {
-			strcpy(out_buf, (start + i));
+		copy_len =3D x - (start + i);
+		if (copy_len < out_len) {
+			memcpy(out_buf, start + i, copy_len);
+			out_buf[copy_len] =3D '\0';
 			*offset +=3D (x - start) + 1;
 			return 1;
 		}
@@ -1249,7 +1252,7 @@ static int process_ip_string(FILE *f, char *ip_string=
, int type)
 	memset(addr, 0, sizeof(addr));
=20
 	while (parse_ip_val_buffer(ip_string, &offset, addr,
-					(MAX_IP_ADDR_SIZE * 2))) {
+					sizeof(addr))) {
=20
 		sub_str[0] =3D 0;
 		if (is_ipv4(addr)) {
@@ -1374,7 +1377,7 @@ static int process_dns_gateway_nm(FILE *f, char *ip_s=
tring, int type,
 		memset(addr, 0, sizeof(addr));
=20
 		if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
-					 (MAX_IP_ADDR_SIZE * 2)))
+					 sizeof(addr)))
 			break;
=20
 		ip_ver =3D ip_version_check(addr);
@@ -1426,12 +1429,11 @@ static int process_ip_string_nm(FILE *f, char *ip_s=
tring, char *subnet,
 	memset(subnet_addr, 0, sizeof(subnet_addr));
=20
 	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
-				   (MAX_IP_ADDR_SIZE * 2)) &&
+				   sizeof(addr)) &&
 				   parse_ip_val_buffer(subnet,
-						       &subnet_offset,
-						       subnet_addr,
-						       (MAX_IP_ADDR_SIZE *
-							2))) {
+					       &subnet_offset,
+					       subnet_addr,
+					       sizeof(subnet_addr))) {
 		ip_ver =3D ip_version_check(addr);
 		if (ip_ver < 0)
 			continue;

base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
prerequisite-patch-id: b61dd51dee390277603975bf729a687113185c3a
prerequisite-patch-id: df28525061dd528875c7c75880b4684d80f4aa7d
prerequisite-patch-id: 64c48c6f2222781631304d9d4d7d1c712c002610
prerequisite-patch-id: 9be258692732026bf560ed9887adbd02a8887263
--=20
2.53.0




