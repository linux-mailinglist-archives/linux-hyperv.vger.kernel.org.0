Return-Path: <linux-hyperv+bounces-529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E9D7CA974
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B18281466
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Oct 2023 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C5D27724;
	Mon, 16 Oct 2023 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFU9qjy1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3826E16
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 13:31:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9D8FE
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697463111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Jtm1tEmFiRiINyK6FbX/DTU+6o2WQy/gZL8mUSOJZE=;
	b=XFU9qjy1xNlc3cCCmrk6hInW1r1NjL3sWQRA4Jj1SK9HCbqqFJprnn9oVKgW7AwEgN+WyC
	fZUXXiyUgcXM81HC89wR4rPTahwWi9j0gaT/Y6rKvGjWIcGyPcXwx0deXx9nWY++JTB+Zq
	g5OQ6llQuyW9JTplVyUK/iymBLR083g=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Mel8wcnnPUObMhel6ocv0Q-1; Mon, 16 Oct 2023 09:31:50 -0400
X-MC-Unique: Mel8wcnnPUObMhel6ocv0Q-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-69eac5ffc69so3170877b3a.3
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Oct 2023 06:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697463109; x=1698067909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Jtm1tEmFiRiINyK6FbX/DTU+6o2WQy/gZL8mUSOJZE=;
        b=SdKHvr75mIEy7+ou3YLtT3wYmqbE49IIW/O/AfZSIaOsMNwymru315ICebb0txTTz2
         AYDpJ7heNtCf+eO/CWBvaVQAoyqDx6rZjswx7mu2QWfn/sOceovmSm67z4P3pQuGLkBW
         j/Q3jsscIStRReKNk/splLxYhQx/+4/23XollpntJ2X9bYA1rxgQSpBHLpYrrX/H6CHc
         SNabfQKG/p2Gih6MLcfAwMBefEgj1fO23gKYIaN86XTwet1NcVJ6rk+XYqN5GP1vScdP
         vcRrOhM2mB+yhpJ5aFyKYfDeZ3mYNpyUP31vVnIHvp/Ckl5FzdKQy08SY1jxB7ZL7qqw
         k/4g==
X-Gm-Message-State: AOJu0Yzslnwp8N7ImVvTOZRf5cRliaELbHXN629KqdYJ25FHhAGp2FUG
	smBpfVmcA3DkizE8CklsBBcUcANobXmfg36f+Om4ufCvMwPRZf82L2pdTuZeUL1Uy5xxdtYmB14
	2oVe33Hm7mu1UnhCR7vijEuX1
X-Received: by 2002:a05:6a00:939e:b0:6b9:a3d3:772a with SMTP id ka30-20020a056a00939e00b006b9a3d3772amr4687230pfb.14.1697463109431;
        Mon, 16 Oct 2023 06:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcJzESwZaLhYz7DMTVB+52tKlwHzYIpua/wPaiM4lgrz+IgCyqnAYd3MTKlM35D7/G5fzXrA==
X-Received: by 2002:a05:6a00:939e:b0:6b9:a3d3:772a with SMTP id ka30-20020a056a00939e00b006b9a3d3772amr4687210pfb.14.1697463109151;
        Mon, 16 Oct 2023 06:31:49 -0700 (PDT)
Received: from fc37-ani.redhat.com ([115.96.142.157])
        by smtp.googlemail.com with ESMTPSA id u12-20020aa7848c000000b006887be16675sm17988235pfn.205.2023.10.16.06.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:31:48 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Ani Sinha <anisinha@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM keyfiles
Date: Mon, 16 Oct 2023 19:01:22 +0530
Message-Id: <20231016133122.2419537-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Some small fixes:
 - lets make sure we are not adding ipv4 addresses in ipv6 section in
   keyfile and vice versa.
 - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead of
   checking the whole value of addr_family.
 - Some trivial fixes in hv_set_ifconfig.sh.

These fixes are proposed after doing some internal testing at Red Hat.

CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>
Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based connection profile")
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
 tools/hv/hv_set_ifconfig.sh |  4 ++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 264eeb9c46a9..318e2dad27e0 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	if (error)
 		goto setval_error;
 
-	if (new_val->addr_family == ADDR_FAMILY_IPV6) {
+	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
 		error = fprintf(nmfile, "\n[ipv6]\n");
 		if (error < 0)
 			goto setval_error;
@@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 	if (error < 0)
 		goto setval_error;
 
-	error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
-	if (error < 0)
-		goto setval_error;
-
-	error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
-	if (error < 0)
-		goto setval_error;
+	/* we do not want ipv4 addresses in ipv6 section and vice versa */
+	if (is_ipv6 != is_ipv4((char *)new_val->gate_way)) {
+		error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
+		if (error < 0)
+			goto setval_error;
+	}
 
+	if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
+		error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
+		if (error < 0)
+			goto setval_error;
+	}
 	fclose(nmfile);
 	fclose(ifcfg_file);
 
diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
index ae5a7a8249a2..440a91b35823 100755
--- a/tools/hv/hv_set_ifconfig.sh
+++ b/tools/hv/hv_set_ifconfig.sh
@@ -53,7 +53,7 @@
 #                       or "manual" if no boot-time protocol should be used)
 #
 # address1=ipaddr1/plen
-# address=ipaddr2/plen
+# address2=ipaddr2/plen
 #
 # gateway=gateway1;gateway2
 #
@@ -61,7 +61,7 @@
 #
 # [ipv6]
 # address1=ipaddr1/plen
-# address2=ipaddr1/plen
+# address2=ipaddr2/plen
 #
 # gateway=gateway1;gateway2
 #
-- 
2.39.2


