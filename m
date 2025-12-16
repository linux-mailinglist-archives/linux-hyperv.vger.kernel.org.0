Return-Path: <linux-hyperv+bounces-8032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B52CC39A0
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 15:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0347303105F
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CE33A9EC;
	Tue, 16 Dec 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="rj0gW1z3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB2933A9EB;
	Tue, 16 Dec 2025 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765895376; cv=pass; b=Pk2P0q5z6/vYW1TYRzqDnjeXsS1iXi8YjHstsm/1PCD4l8mUTu5ZZAXMOL2A8QvtgF7maFEFGlCXUd6spbnXDz0imxIPNXeL3SC0AhB2EF1/VvkzHRHz8wpNozaYC9LkTbwifL4psFUrkPGb1LruqY/G0OQHfTxL4zstQKm0cVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765895376; c=relaxed/simple;
	bh=WLRuh4s4NIdpCxg4XlikUDvd08oZOqfWwUpJ19c/Vt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOY44NeXxoe033jTxbea7+lcNQCIWdcSUqZjLGwET5N3c3wg4jqC+eSwjCbbpN+1cTab/AU7WtRQF4xjqQFDCrDIUkMz+5/OuGBapyO+vXq/QQnfse8pwdnzdcGHyO+GqfQJebo5mOWgG2KewwfTFbgCAaHgmsWdnHN9nKP0oFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=rj0gW1z3; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765895356; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BJfslcbjUyP/ANp3+OIXWYXm5ENu+tjHUFKw74krTiQstEHOFLExqNDFCQkqDl8+pXAoOfJh4kj97eMuzOx0bxsvbdbUu/9zjt2fIOdYybuceyKHz1TbfTaiYm+yuH720hVwfIYUnuc0Ets7YkVZC47mLMn+WshQ0KOkc/As5XI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765895356; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=p72hboX00ZYXjPvMhyIKAfVKmeA/7k8vW4MCIKUpY+w=; 
	b=QwVoq3eO3g6PI7WF/UFXnwhwSjLVwKpqbjAdvfHx2umUj/4eo2By04SaIGEpUKmF0NHWg7A+p7lpMD9gp8rgyxpLWrSaGms/EYsglIK+crTJqakK9pzwq4l1jrheM6GpelVxCflW5pxybZ9kqah50ZadROpP/8opbO8ogG9dR2M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765895356;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=p72hboX00ZYXjPvMhyIKAfVKmeA/7k8vW4MCIKUpY+w=;
	b=rj0gW1z39BtlkzHFLtg/ItCuppChH9C5hCBxfYkp+Y5Capdgacqf8ohJoy3TXEm+
	mQEsZ9ji7ETI/iKNN5dp4JYPpKlrBuYVp0iSacUFTjBCPZGqGLs57DwvOGVyOTE7xkL
	No7cUHGAMArMc6yYtuj7tPsSQXKusuI6563vB0l4=
Received: by mx.zohomail.com with SMTPS id 176589535443157.63328039870237;
	Tue, 16 Dec 2025 06:29:14 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH 2/3] mshv: handle gpa intercepts for arm64
Date: Tue, 16 Dec 2025 14:20:29 +0000
Message-Id: <20251216142030.4095527-3-anirudh@anirudhrb.com>
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

The mshv driver now uses movable pages for guests. For arm64 guests
to be functional, handle gpa intercepts for arm64 too (the current
code implements handling only for x86). Without this, arm64 guests are
broken.

Move some arch-agnostic functions out of #ifdefs so that they can be
re-used.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root_main.c | 38 ++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 9cf28a3f12fe..882605349664 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -608,7 +608,6 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 	return NULL;
 }
 
-#ifdef CONFIG_X86_64
 static struct mshv_mem_region *
 mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 {
@@ -625,6 +624,34 @@ mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 	return region;
 }
 
+#ifdef CONFIG_X86_64
+static u64 mshv_get_gpa_intercept_gfn(struct mshv_vp *vp)
+{
+	struct hv_x64_memory_intercept_message *msg;
+	u64 gfn;
+
+	msg = (struct hv_x64_memory_intercept_message *)
+		vp->vp_intercept_msg_page->u.payload;
+
+	gfn = HVPFN_DOWN(msg->guest_physical_address);
+
+	return gfn;
+}
+#else  /* CONFIG_X86_64 */
+static u64 mshv_get_gpa_intercept_gfn(struct mshv_vp *vp)
+{
+	struct hv_arm64_memory_intercept_message *msg;
+	u64 gfn;
+
+	msg = (struct hv_arm64_memory_intercept_message *)
+		vp->vp_intercept_msg_page->u.payload;
+
+	gfn = HVPFN_DOWN(msg->guest_physical_address);
+
+	return gfn;
+}
+#endif /* CONFIG_X86_64 */
+
 /**
  * mshv_handle_gpa_intercept - Handle GPA (Guest Physical Address) intercepts.
  * @vp: Pointer to the virtual processor structure.
@@ -640,14 +667,10 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 {
 	struct mshv_partition *p = vp->vp_partition;
 	struct mshv_mem_region *region;
-	struct hv_x64_memory_intercept_message *msg;
 	bool ret;
 	u64 gfn;
 
-	msg = (struct hv_x64_memory_intercept_message *)
-		vp->vp_intercept_msg_page->u.payload;
-
-	gfn = HVPFN_DOWN(msg->guest_physical_address);
+	gfn = mshv_get_gpa_intercept_gfn(vp);
 
 	region = mshv_partition_region_by_gfn_get(p, gfn);
 	if (!region)
@@ -663,9 +686,6 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 
 	return ret;
 }
-#else  /* CONFIG_X86_64 */
-static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
-#endif /* CONFIG_X86_64 */
 
 static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
 {
-- 
2.34.1


