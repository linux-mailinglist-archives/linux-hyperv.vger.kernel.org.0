Return-Path: <linux-hyperv+bounces-4355-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B07A5A3C3
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 20:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A931891D77
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C270235C17;
	Mon, 10 Mar 2025 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uJavZm+h"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3A223535F
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Mar 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634797; cv=none; b=E4jJ3PrFwbEiy9iL90KidfwQO62ehKlGFse85NcrpPj+2Xo7s2piCUzLpHpkHxpvPews0q9BurWqtXmJrQoX6Wi8yyQRUdfQkKDmPG6mzyt9Q/ttdDFW1pDeu6gTt83UKv1NtWTuN8B7JQhk/FlTcwJNOpsjnCVkqj6e4HjmLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634797; c=relaxed/simple;
	bh=aMGKEDfrbum8nYqKksNtLhPPEJw4CitcdWmFichjJN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BAD2MPiBRgis6OT6fUpe4lao/94h0M4tSPNMmpxER7lcqCimNxbfChuKQ5XUV6sWPhphfpJud+2YAHycgbkT8asn6IR0lafMhMoS/HJY2JqKoL8rvnzatyoCuegMmG0cINjhXhPCw/bBjfgp5qJI4MIO0eufD8UlhPIpfRjCVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uJavZm+h; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741634792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zoz7U82cuSBuipZrq5cc1/YujrMio5TtbgMMrkTdaHQ=;
	b=uJavZm+hVT+Sn4mwU2rlaDFBjFkhD/ISd9k/37fv8gMHOZoBVwiFz81wleAyqi+cdMi657
	xRJN3fx6QhhvxuTI5wgSuVxercBU1S1GNy9VjIqVt69YIQnJ7cA+w8gmlnlrgsjVgc0JLH
	CDbDK2bx1XRk/iefHJxFAwwZs4ltgNU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hyperv: Remove unused union and structs
Date: Mon, 10 Mar 2025 20:26:28 +0100
Message-ID: <20250310192629.443162-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The union vmpacket_largest_possible_header and several structs have not
been used for a long time afaict - remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/hyperv.h | 47 ------------------------------------------
 1 file changed, 47 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 4179add2864b..bff91788c8a3 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -371,19 +371,6 @@ struct vmtransfer_page_packet_header {
 	struct vmtransfer_page_range ranges[];
 } __packed;
 
-struct vmgpadl_packet_header {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u32 reserved;
-} __packed;
-
-struct vmadd_remove_transfer_page_set {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u16 xfer_pageset_id;
-	u16 reserved;
-} __packed;
-
 /*
  * This structure defines a range in guest physical space that can be made to
  * look virtually contiguous.
@@ -394,30 +381,6 @@ struct gpa_range {
 	u64 pfn_array[];
 };
 
-/*
- * This is the format for an Establish Gpadl packet, which contains a handle by
- * which this GPADL will be known and a set of GPA ranges associated with it.
- * This can be converted to a MDL by the guest OS.  If there are multiple GPA
- * ranges, then the resulting MDL will be "chained," representing multiple VA
- * ranges.
- */
-struct vmestablish_gpadl {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u32 range_cnt;
-	struct gpa_range range[1];
-} __packed;
-
-/*
- * This is the format for a Teardown Gpadl packet, which indicates that the
- * GPADL handle in the Establish Gpadl packet will never be referenced again.
- */
-struct vmteardown_gpadl {
-	struct vmpacket_descriptor d;
-	u32 gpadl;
-	u32 reserved;	/* for alignment to a 8-byte boundary */
-} __packed;
-
 /*
  * This is the format for a GPA-Direct packet, which contains a set of GPA
  * ranges, in addition to commands and/or data.
@@ -438,16 +401,6 @@ struct vmadditional_data {
 	unsigned char data[1];
 } __packed;
 
-union vmpacket_largest_possible_header {
-	struct vmpacket_descriptor simple_hdr;
-	struct vmtransfer_page_packet_header xfer_page_hdr;
-	struct vmgpadl_packet_header gpadl_hdr;
-	struct vmadd_remove_transfer_page_set add_rm_xfer_page_hdr;
-	struct vmestablish_gpadl establish_gpadl_hdr;
-	struct vmteardown_gpadl teardown_gpadl_hdr;
-	struct vmdata_gpa_direct data_gpa_direct_hdr;
-};
-
 #define VMPACKET_DATA_START_ADDRESS(__packet)	\
 	(void *)(((unsigned char *)__packet) +	\
 	 ((struct vmpacket_descriptor)__packet)->offset8 * 8)
-- 
2.48.1


