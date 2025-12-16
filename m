Return-Path: <linux-hyperv+bounces-8031-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98FCC3A55
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 15:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6537030DFFB6
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5BF339846;
	Tue, 16 Dec 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="nmP9WKB8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7B3101AD;
	Tue, 16 Dec 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895369; cv=pass; b=GJGeEQajMhSa0KBL8S5JnRkymZ0e3XKTG03UErtbvw8hBYVhGdEKEfLKx7MQ9h8TfM3G2y7qtyO/fj0JvPIndjEPfnCBWCXf1jCvKOJz9XiK/VKwojIfADbDDhDCifRO3sYfoY34b1ekOSKClzE8Jq1Cr6LZLTwi+PjufKGMNF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895369; c=relaxed/simple;
	bh=zcnEiUbrTrjAWPvSfGmCBVqU+Lolp4XTvj1tacfRak0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYszewAj0smpA7oZ+Y8ALN3aPbc5nCzbJq7glwe39zcfYLe84iyxHjFQ+4lsJn4VUfsCHfhENSQ/SZfdxdIWeE/3xgeNbZJMTIhDvsSyXf9VGRzw3bBO651DlsdxQYLS9jQr4Ur+N6VFm2l1qyKTKqSInKOnpgkgJyRuVTo6SCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=nmP9WKB8; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765895349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ChsumNi9TKevOJ1GsBhyGosukmt00gP2oDK7jdyh9qHzUjyi2Xp/pRdG/+TMylb74sSwNb4aMDSQlOH6Rdw3HaQxgszYtzNsLJ15ZAEEjpOKA+vx+oiKRE7b6bYFKRBR75uSKT6lPFO/Aev0gmPjC1/QC8fuusiLB4EycZSj+9c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765895349; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yZ4QmkDSQEPgsBVMbQvcxL4TzoqYmIuNbuF9xkeY7K8=; 
	b=chtSwZv6MXqUpqzMh7d2I/tgDuRRHJhKFh/e8N0cDQq7E7CbADOdnK32VbNAgXPi7UcbXAGAY9qJRc42SupAZaM3C+97Lg8znTdXuWiumpZscTtmVrb++a0Jggz5VmtOve0IOcUSv5W690KB7MptGtzZFCRXwPVttAmK6O0nsFo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765895349;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=yZ4QmkDSQEPgsBVMbQvcxL4TzoqYmIuNbuF9xkeY7K8=;
	b=nmP9WKB8Bqx9gW7QHBBCPqQguYEDdo1lRlrrRc0Er9pbQTnHJBNFXgR0fgfb/CYy
	dhUG3oAkHX6Um3qRNe3mcBYJQRd609RtoT/rxh5yEPAqGkgKF8FfhcdTA7i52ImxkdM
	sz7QaMW46rhlRHWM0USBN2PShJmpK0oxBChJd1Qs=
Received: by mx.zohomail.com with SMTPS id 1765895348311554.6134755506345;
	Tue, 16 Dec 2025 06:29:08 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH 1/3] hyperv: add definitions for arm64 gpa intercepts
Date: Tue, 16 Dec 2025 14:20:28 +0000
Message-Id: <20251216142030.4095527-2-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216142030.4095527-1-anirudh@anirudhrb.com>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Add definitions required for handling GPA intercepts on arm64.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 include/hyperv/hvhdk.h | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 469186df7826..a286f75f0afa 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -800,6 +800,53 @@ struct hv_x64_memory_intercept_message {
 	u8 instruction_bytes[16];
 } __packed;
 
+#if IS_ENABLED(CONFIG_ARM64)
+union hv_arm64_vp_execution_state {
+	u16 as_uint16;
+	struct {
+		u16 cpl:2;
+		u16 debug_active:1;
+		u16 interruption_pending:1;
+		u16 vtl:4;
+		u16 virtualization_fault_active:1;
+		u16 reserved:7;
+	} __packed;
+};
+
+struct hv_arm64_intercept_message_header {
+	u32 vp_index;
+	u8 instruction_length;
+	u8 intercept_access_type;
+	union hv_arm64_vp_execution_state execution_state;
+	u64 pc;
+	u64 cpsr;
+} __packed;
+
+union hv_arm64_memory_access_info {
+	u8 as_uint8;
+	struct {
+		u8 gva_valid:1;
+		u8 gva_gpa_valid:1;
+		u8 hypercall_output_pending:1;
+		u8 reserved:5;
+	} __packed;
+};
+
+struct hv_arm64_memory_intercept_message {
+	struct hv_arm64_intercept_message_header header;
+	u32 cache_type; /* enum hv_cache_type */
+	u8 instruction_byte_count;
+	union hv_arm64_memory_access_info memory_access_info;
+	u16 reserved1;
+	u8 instruction_bytes[4];
+	u32 reserved2;
+	u64 guest_virtual_address;
+	u64 guest_physical_address;
+	u64 syndrome;
+} __packed;
+
+#endif /* CONFIG_ARM64 */
+
 /*
  * Dispatch state for the VP communicated by the hypervisor to the
  * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
-- 
2.34.1


