Return-Path: <linux-hyperv+bounces-8148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83202CF38C4
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1998F317957B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D58337BBC;
	Mon,  5 Jan 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="jIDzPCnP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9702BCF5;
	Mon,  5 Jan 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616149; cv=pass; b=i1+1xVlEpyDPOO+uaPE3pyZqUZJSmlNNRX+4MJtse84ii0onokqhH28H+n/fIRJFNAMcrwkDpaAaRE/eFY2eTZl/YYGKeAexbhBd6TBGR8tFY8wtgdcLUaICwb0VLjPZCjnB/nQ7dVrrMHrmN8spfNdsDjTUV2T576dVKTJeF8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616149; c=relaxed/simple;
	bh=jOfgYQdOfDQsB+dPsbMOo+d4xs3UOnvcKU7FWQTD8p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/rrVNUj1y1kHwjdxz0GHaKXvR15/OH8yNIpacTcU80/oJbOsJ6EfildjZICJs0/ku7kIrmgIMKDr/WBpRRUHQPgjTK4CZGBmn2uKroaxdzW8m2JOUicP8J8fAdmwsl1+ER8/Ops4IJfMzsUkuLsOrjfIJxIsMjJ37O90v5Dmgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=jIDzPCnP; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1767616136; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ROtB0eNd4fqW3nFu/mI3Owk54G4ugYSzAt47y2gnqHPHCFbKRcfHEQy8k4T/UGpTHpD3knpMNd5aEBUvdw48rmZIO2AhkRJIFuZI3r8gDd39Nlv5htlOqDha1S/MY32bddyegoM+sCpcUNbWGtb3yh36NBNHjsaefvpgMEog43g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767616136; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JLfHjh+7Y2apHERse94YUzusZTC4T/ZVTyh0f53oZb8=; 
	b=FgS0gDysHmQET4Ljp95ndS4OoPSCiJNgzov3ejcjuF7xbj7Bb2CKu03PeDVPteLvQotahS5A+DmksFM1Kj4fryJ0FblSEMOtkPgcFKE0EDiBDc6BkG8iKfnewZuZxTyfdM9r2dLsaINmN9ZNbBKrUWcRYJY4Ze9bnsqqRWeY6Cg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767616136;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=JLfHjh+7Y2apHERse94YUzusZTC4T/ZVTyh0f53oZb8=;
	b=jIDzPCnPDGFk/L1TOSh3nhD0SqEUiZGKgeeQrLjfw5qMM0aR3Br+FU94QRjAksqR
	2hGMke1iCNNykCaISev0ew26CZf0NG3kMg3m6g70rwW9kW0t6JrVG/vGCAA3ncVyzwn
	1TI9ywN+2vs4Dy0/vGSM7tIxsGW2tX2RLtj2Fts8=
Received: by mx.zohomail.com with SMTPS id 1767616134741875.3494296439226;
	Mon, 5 Jan 2026 04:28:54 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v2 1/2] hyperv: add definitions for arm64 gpa intercepts
Date: Mon,  5 Jan 2026 12:28:36 +0000
Message-Id: <20260105122837.1083896-2-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105122837.1083896-1-anirudh@anirudhrb.com>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
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
index 469186df7826..08965970c17d 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -800,6 +800,53 @@ struct hv_x64_memory_intercept_message {
 	u8 instruction_bytes[16];
 } __packed;
 
+#if IS_ENABLED(CONFIG_ARM64)
+union hv_arm64_vp_execution_state {
+	u16 as_uint16;
+	struct {
+		u16 cpl:2; /* Exception Level (EL) */
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


