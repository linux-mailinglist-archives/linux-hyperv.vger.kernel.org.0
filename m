Return-Path: <linux-hyperv+bounces-8362-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A95D39D0E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 04:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46911300661B
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jan 2026 03:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AEE214A97;
	Mon, 19 Jan 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmPh6VX6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2418D636
	for <linux-hyperv@vger.kernel.org>; Mon, 19 Jan 2026 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768793681; cv=none; b=Gpw56BhPnKZ650HGYxemEO61c8L/Vimvqc6BjCeGMlOHHVaHoZnqO3ZcbsUOTgTlgL9gsO90w1ptwl6AM2Ky5F7q5/KXYPeUrHs3kbNJxCfoaicaNBzBtx4/alqkNl9ax7wd3m/mffoYdO0paU6WnT0hZX61me1YpKrHokEV8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768793681; c=relaxed/simple;
	bh=pbp8tYPiNrZcgIQvDZI5eEb2NR8vJyZgrAbLP4qkBzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2rN9me1WPO5rXii/kUotrpKamNgbl69BGHWz9g0sZMkxFj26czsptohjQ7MAQ+/y1WxX5LOUfU4WrGIdBigGvkJhXanfPaIPsRdSYvCnKkjFMkHI3F3ZPtd1elBam7gGx+wvRa7OkhIOde48T/0vicYOp4gGLfb9hUVQYV8rG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmPh6VX6; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1348469a12.3
        for <linux-hyperv@vger.kernel.org>; Sun, 18 Jan 2026 19:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768793679; x=1769398479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jX98CY3Kn2Bn/rMGmuBNaSs0hgC1A09OghGTp78PTWw=;
        b=AmPh6VX6p7jUc7jTzliLk5QNKYbJ7KnFAhOdtZ9IOU2MMKO6Jq5oDlJZ0s/D8aWeLu
         AsaYeoJGlGZmmWc54GRjyjZKTcxNFINe+CkwXn1KtiH8BSKGhmxPNlTzxdsB7gK1EIJz
         MzhsLHnQJUQ+zNUAIULlNWNhbQiWbcjgoDEYih8C6mfVLFlaET/RuNRyHjN3ZptNik+P
         J6Im+cAEiotNkJqP2HQ8uZaVcIYeuvz4lQ7y8jnQIFHQEWZYwI22koZNRiRv6Ktsnl5P
         ktLhig7KgAIIWpuF5PT7EsfiSlpzLjdDbP2iRy/sEdalis3k52jGvGITIqEtXrzRltSt
         Ji+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768793679; x=1769398479;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jX98CY3Kn2Bn/rMGmuBNaSs0hgC1A09OghGTp78PTWw=;
        b=q86msileDyyQ8utR/ZTLuFAwxR5WUbKYFblxPqGlGrJlnJ1EnatXqz+xW/zUwhb1KT
         SfhcWPxRLxlGZ4TJ/rR7ERYASwC/tPzKy0Gt4OwgbXKvQmATFFcz3+mYbKfFkm7G5D2O
         XfvKbUn0/fxCQ0/VVTVJmHUkCgC+7z5kB5spIpmrZTNaKN6LvrXPSbbSUmkWHQRgFyfd
         isWhf1G7dFctjm6RRXk50eEdA2rzQbEr+CozMvU3HUccr3/Zp03peKbOBuIT0gDPYpiK
         aNHoJ5/gPXcUZ44bEDZB205+Hav0VshSUZgfE9we1E4v0KJ5TlVjvU+iom2VBpx/pZTY
         fdjg==
X-Forwarded-Encrypted: i=1; AJvYcCVBRe1YtyiZybpE9jMD05pcljpawIv615pKRvGhcm8TPaukAhBe2SC2gk1dzivSnPqgXxUpzzvmFmLSOC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwildnOLp0NGEpyXZSXtU94h6yTDSaqHq8RRIKL1FHD3Vc9/SFZ
	GmrSkeme5t1l07EvKwmRhVTUHHEVuGnqZHLzddZ6YYMyjNrb6z77ciQi
X-Gm-Gg: AY/fxX4EXRv9UZMMTSlFML4O23j4lCrBNQp0DFPGca+J2NX+/1SqOHFK9yQLxWr2wws
	hLuXx430CmFotoX/3TyPApbiuLnX0jxUM/Gy5cxFtbsj/s6M4YlgPD1jtTRv0oAyV4nVTIUyp8O
	EnOSKNDLkXifcNY5luU3BHyeO5qOTw0/2eRQwfBDb8U2iAB8kRqp2FbGw8WOMkQX+H6DR9r7hse
	JlpzmF5k8ZLEaxhwyZINpvBjHvAfB+VO8ncz1qK2AcCdk1zm/E+zXvuMSHo9HZLCblWKjqJ//w1
	BXXFY3pU65EeZnLG8anNZIFTLEo8vBVjpvvtweUBgoaDedeg1/aS/90oEJvxMMHi2YVdcgt2lNo
	I+1qVy/kZZFzR5BTwwOsTc1/kOspPY1TkgK2fj8mkvleUDzs1WgXJ6pzAx2dw9ccbegz6JJkJpF
	L/np+EsqO9IK13pSUvXFro7IuerPNiq8VZ+NpiJ8joz+s1rsJ0UYkK5kkHDRw01oDSVA==
X-Received: by 2002:a05:6a21:e97:b0:34f:b660:770d with SMTP id adf61e73a8af0-38dfe770a12mr8927103637.55.1768793679085;
        Sun, 18 Jan 2026 19:34:39 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fbf8fsm78346925ad.78.2026.01.18.19.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 19:34:38 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: Use memremap()/memunmap() instead of ioremap_cache()/iounmap()
Date: Sun, 18 Jan 2026 19:34:35 -0800
Message-Id: <20260119033435.3358-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

When running with a paravisor or in the root partition, the SynIC event and
message pages are provided by the paravisor or hypervisor respectively,
instead of being allocated by Linux. The provided pages are normal memory,
but are outside of the physical address space seen by Linux. As such they
cannot be accessed via the kernel's direct map, and must be explicitly
mapped to a kernel virtual address.

Current code uses ioremap_cache() and iounmap() to map and unmap the pages.
These functions are for use on I/O address space that may not behave as
normal memory, so they generate or expect addresses with the __iomem
attribute. For normal memory, the preferred functions are memremap() and
memunmap(), which operate similarly but without __iomem.

At the time of the original work on CoCo VMs on Hyper-V, memremap() did not
support creating a decrypted mapping, so ioremap_cache() was used instead,
since I/O address space is always mapped decrypted. memremap() has since
been enhanced to allow decrypted mappings, so replace ioremap_cache() with
memremap() when mapping the event and message pages. Similarly, replace
iounmap() with memunmap(). As a side benefit, the replacement cleans up
'sparse' warnings about __iomem mismatches.

The replacement is done to use the correct functions as long-term goodness
and to clean up the sparse warnings. No runtime bugs are fixed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601170445.JtZQwndW-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202512150359.fMdmbddk-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
I've tested these changes in SEV-SNP and TDX VMs in Azure, and in a
D16lds v6 VM in Azure, which has a paravisor but no encryption. Normal
VMs without a paravisor don't go down this code path.

But I don't have a way to test in the root partition. If someone could do
a quick verification in the root partition, that would be helpful.

 drivers/hv/hv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index c100f04b3581..ea6835638505 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -287,11 +287,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	simp.simp_enabled = 1;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		/* Mask out vTOM bit and map as decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
 		hv_cpu->hyp_synic_message_page =
-			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+			memremap(base, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 		if (!hv_cpu->hyp_synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
@@ -306,11 +306,11 @@ void hv_hyp_synic_enable_regs(unsigned int cpu)
 	siefp.siefp_enabled = 1;
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
-		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
+		/* Mask out vTOM bit and map as decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
 		hv_cpu->hyp_synic_event_page =
-			(void *)ioremap_cache(base, HV_HYP_PAGE_SIZE);
+			memremap(base, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
 		if (!hv_cpu->hyp_synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
@@ -429,7 +429,7 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 	simp.simp_enabled = 0;
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
 		if (hv_cpu->hyp_synic_message_page) {
-			iounmap(hv_cpu->hyp_synic_message_page);
+			memunmap(hv_cpu->hyp_synic_message_page);
 			hv_cpu->hyp_synic_message_page = NULL;
 		}
 	} else {
@@ -443,7 +443,7 @@ void hv_hyp_synic_disable_regs(unsigned int cpu)
 
 	if (ms_hyperv.paravisor_present || hv_root_partition()) {
 		if (hv_cpu->hyp_synic_event_page) {
-			iounmap(hv_cpu->hyp_synic_event_page);
+			memunmap(hv_cpu->hyp_synic_event_page);
 			hv_cpu->hyp_synic_event_page = NULL;
 		}
 	} else {
-- 
2.25.1


