Return-Path: <linux-hyperv+bounces-8149-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1727CF3864
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 13:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A2E830060E5
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 12:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F35033BBD3;
	Mon,  5 Jan 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="nSiKLJrb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF533BBD6;
	Mon,  5 Jan 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616158; cv=pass; b=hvSJQoBf8qET07aU6DQvjmV4wXQ7jOBh8lopQTZrYrtBA3D/NFPXKDdyF+6mmK5InTd9rYpiYEKthpHML6MmKZvtcqPSgLlvnUcUOoZLZj38ym49zDceTCXsIDrkYpksMMIpnmY0bqAQFFtrY4YcVLCmrf+4gENcnrWBO1X4Sh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616158; c=relaxed/simple;
	bh=GGPXvC2qVvhjV6soKdPKL88SGkOq4Fh/Abkd32uQe4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGLTrPZbO4ihltrCodKjoYPP3IkkUW7gu9zFyNVSkyLtS12cHBdhSjtC7G0gaoj4UU+udEhM7x+lWteAXCtGkOmHzYoFpzzUTRexAO7DY2Qeev2Qo2z/XfyHJlVJS5aotZ0ieoscbHivbf1D4KjXSAOk78QNKkx5CtURlwKdDmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=nSiKLJrb; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1767616144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b2M/fSbn767uJraNwO5n1yyogJGcuRWiXfDxmdPJeHsTr+lN6PmhB89f28CEkrSTd574gMXNJ/sLzN7Rik0qfd8LSDq/zPVJQOH7+wPD3wqDsnxUteS0vNhrqbBpWyiqtKTw+Wo1D/vesM3LTIvK1BzicOzVx+xt1Cxy/wxkS9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767616144; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C2c1vhOKm50oXDZHbkO2WlrpgJh1RklsPFHVTLTxfqY=; 
	b=cSqsaeL7ZJ6geEspVd0YRxPhlIeZgqKvEQ2y1EGj9r04WUM4HdBqgL0EUwGq4c5f9dsgSYapB8TlH1MP4oBm5pKjtxCZoJuQaH3wwEA7zIXJhzRe/s6/KNc7tjyX3yYZJCT7c87x6kF23hk2Cu3LyAmsxSxssqe61/Tsj9FV2X8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767616144;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=C2c1vhOKm50oXDZHbkO2WlrpgJh1RklsPFHVTLTxfqY=;
	b=nSiKLJrbDiyFeU67YD429CIHO0oxBupNwC67uCiG+XCnkk4W2XSF0wypX0W4VHhi
	lVQSvxoERfevwBerbCn5j1Pw4CLY+q4bTf0O85HUEwfR+iZ97TjxBwBbOjdNVRaN2ss
	EGLHIONzezRGN2oZmpM9z0ZO609qeCNFt0mHsOaI=
Received: by mx.zohomail.com with SMTPS id 1767616141147155.20323072971576;
	Mon, 5 Jan 2026 04:29:01 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v2 2/2] mshv: handle gpa intercepts for arm64
Date: Mon,  5 Jan 2026 12:28:37 +0000
Message-Id: <20260105122837.1083896-3-anirudh@anirudhrb.com>
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

The mshv driver now uses movable pages for guests. For arm64 guests
to be functional, handle gpa intercepts for arm64 too (the current
code implements handling only for x86).

Move some arch-agnostic functions out of #ifdefs so that they can be
re-used.

Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 9cf28a3f12fe..f8c4c2ae2cc9 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 	return NULL;
 }
 
-#ifdef CONFIG_X86_64
 static struct mshv_mem_region *
 mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 {
@@ -640,12 +639,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 {
 	struct mshv_partition *p = vp->vp_partition;
 	struct mshv_mem_region *region;
-	struct hv_x64_memory_intercept_message *msg;
 	bool ret;
 	u64 gfn;
-
-	msg = (struct hv_x64_memory_intercept_message *)
+#if defined(CONFIG_X86_64)
+	struct hv_x64_memory_intercept_message *msg =
+		(struct hv_x64_memory_intercept_message *)
+		vp->vp_intercept_msg_page->u.payload;
+#elif defined(CONFIG_ARM64)
+	struct hv_arm64_memory_intercept_message *msg =
+		(struct hv_arm64_memory_intercept_message *)
 		vp->vp_intercept_msg_page->u.payload;
+#endif
 
 	gfn = HVPFN_DOWN(msg->guest_physical_address);
 
@@ -663,9 +667,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 
 	return ret;
 }
-#else  /* CONFIG_X86_64 */
-static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
-#endif /* CONFIG_X86_64 */
 
 static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
 {
-- 
2.34.1


