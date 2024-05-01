Return-Path: <linux-hyperv+bounces-2057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D08B8CD0
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 May 2024 17:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E52283AF7
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 May 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D725130AE1;
	Wed,  1 May 2024 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtXiDdFs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26059130AD6;
	Wed,  1 May 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576515; cv=none; b=ULiPbSSzTL/T9ABzXsh4SJULfLm7be0N26c06n2arrJdJSWa/QLJGpK7LgSvmolBAKo0sN+zn1JmqnH+6gWnZbduXHyOOOiggIlHxB4ZTDhp8O6Kg/2yihtztZZ+x60iapG032+Rxt4F5vp3WqPvcnioJn8bggUeMOg9c7Jx7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576515; c=relaxed/simple;
	bh=OKF5BJ9LX19SO+TK+66BXlQN4ZOtSpHwwd+vox4LDTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdSEpAYctac3DETOx/hQWGy7bgjM/UFmuZfjaMZ5kZE8rmHX0lq0MKvFI0xXdqVmKdvhsh0vrfzGtfEuj8nJD/z4FRy65zRYVpqNLK02afHTh/xzfhkAYuCHZPCMajlgXoy1DfBTua9rhVpwcpmGvjP+gFl8iY1CfaRh3SQYe9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtXiDdFs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eb24e3a2d9so45814205ad.1;
        Wed, 01 May 2024 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576513; x=1715181313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxPICHufJrRI7eTEH0R3o+PRxHFpRqv6o+L5HQrT7GQ=;
        b=NtXiDdFsKNBrqBLbdI5uBIJbx0vw4BHWX/nwy7cLyGjOLtVDX0m1dBM6eeFZkqJDBZ
         7Sz8pTlK1SrAvUTHA2trlrhiw8Kh2088ok0xh3GvrR22qx0QbenGq0YIGKHQ98lF9gdq
         L1xOViWr+oSrre4KbSCGE8erhsHoBP/KbYcGv1dFwciQvVPDS/9BMRJJZ1tN6BNQaOGG
         iryvrWm0gVXFzBRjMhBp8gLmW2dqh0wUHenzvJrmDrveBwb+3lREbE4u428tqUfjhKbQ
         TU6djJ0ZVdOxPi+rw/xD3IXwZmArcbGPxwyIYZAICs7QwRRcRcO3JEJgzzJEO98tNCci
         LE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576513; x=1715181313;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxPICHufJrRI7eTEH0R3o+PRxHFpRqv6o+L5HQrT7GQ=;
        b=vzXodrDWuv/o5rUAGFVxgSveXoYDyfGG9CCdhsYXw95YJ4Aqo+hTxJ5/iMWTGfmeKs
         UQAS1x4MT0sTzT8ePRxD6xo0fDofDnFKlMoEXfcF70p2Na3HQe67dg70aJBHIENTYBpU
         TYqNMX6N+qMFkXf94cIBsyF4zTUC9fYGxDdSPQrEoTuqxWNEWFwoXDjbWRo85KsSwdtE
         0HPrdz8LPkWWoMZDCmrjRBE2K93HO8ST/mZeYuraippGCZImcD8oz0MEQxDtXEfgH410
         W0hi1Vw9eWNp2gQC8xqkGWpzWBFHsxeLg/57YsD80/AaHuu+bGjxuWcWw4IMNrnP8UTg
         bwJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJSHwrTcVWEemNfRMvsrnDNyGBp9S1JDrUtrJnojdN4FRyeHzFUfxA1VC5KwZmsZJ2ttveHHkQUAj8e5lX4YH/ccDzvJX4YDPTTXjsGvluJ8af/pqFCbuWRamEHqaYyAJ9kit9uPrFtYvG
X-Gm-Message-State: AOJu0YwA4brD3e8HaWif+r1YALrwafLVXmOAbb9/iN2724AkoDDgFzfv
	IASDXs9xbwAR3d1ptWy3TlwIXQi0lPKvO+xTApY4zUtekvmw/DYq
X-Google-Smtp-Source: AGHT+IHkQBGQObUTbD7dIWZi83Gg6HMVwyNu54SfpdiChcNl2AiJWxhaUqx2/AW1fWxBUTIpVDQ4ow==
X-Received: by 2002:a17:902:dac5:b0:1eb:60ec:32d0 with SMTP id q5-20020a170902dac500b001eb60ec32d0mr3725577plx.5.1714576513369;
        Wed, 01 May 2024 08:15:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001dd88a5dc47sm5586861plx.290.2024.05.01.08.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:15:13 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: david@redhat.com
Subject: [PATCH v2 1/2] hv_balloon: Use kernel macros to simplify open coded sequences
Date: Wed,  1 May 2024 08:14:57 -0700
Message-Id: <20240501151458.2807-1-mhklinux@outlook.com>
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

Code sequences equivalent to ALIGN(), ALIGN_DOWN(), and umin() are
currently open coded. Change these to use the kernel macro to
improve code clarity. ALIGN() and ALIGN_DOWN() require the
alignment value to be a power of 2, which is the case here.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* No changes. This is a new patch that goes with v2 of patch 2 of this series.

 drivers/hv/hv_balloon.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index e000fa3b9f97..9f45b8a6762c 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -729,15 +729,8 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 
 		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
 			has->ha_end_pfn +=  HA_CHUNK;
-
-			if (total_pfn > HA_CHUNK) {
-				processed_pfn = HA_CHUNK;
-				total_pfn -= HA_CHUNK;
-			} else {
-				processed_pfn = total_pfn;
-				total_pfn = 0;
-			}
-
+			processed_pfn = umin(total_pfn, HA_CHUNK);
+			total_pfn -= processed_pfn;
 			has->covered_end_pfn +=  processed_pfn;
 		}
 
@@ -800,7 +793,7 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 {
 	struct hv_hotadd_state *has;
 	struct hv_hotadd_gap *gap;
-	unsigned long residual, new_inc;
+	unsigned long residual;
 	int ret = 0;
 
 	guard(spinlock_irqsave)(&dm_device.ha_lock);
@@ -836,15 +829,9 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 		 * our current limit; extend it.
 		 */
 		if ((start_pfn + pfn_cnt) > has->end_pfn) {
+			/* Extend the region by multiples of HA_CHUNK */
 			residual = (start_pfn + pfn_cnt - has->end_pfn);
-			/*
-			 * Extend the region by multiples of HA_CHUNK.
-			 */
-			new_inc = (residual / HA_CHUNK) * HA_CHUNK;
-			if (residual % HA_CHUNK)
-				new_inc += HA_CHUNK;
-
-			has->end_pfn += new_inc;
+			has->end_pfn += ALIGN(residual, HA_CHUNK);
 		}
 
 		ret = 1;
@@ -915,9 +902,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			 */
 			size = (has->end_pfn - has->ha_end_pfn);
 			if (pfn_cnt <= size) {
-				size = ((pfn_cnt / HA_CHUNK) * HA_CHUNK);
-				if (pfn_cnt % HA_CHUNK)
-					size += HA_CHUNK;
+				size = ALIGN(pfn_cnt, HA_CHUNK);
 			} else {
 				pfn_cnt = size;
 			}
@@ -1011,9 +996,6 @@ static void hot_add_req(struct work_struct *dummy)
 	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
 
 	if ((rg_start == 0) && (!dm->host_specified_ha_region)) {
-		unsigned long region_size;
-		unsigned long region_start;
-
 		/*
 		 * The host has not specified the hot-add region.
 		 * Based on the hot-add page range being specified,
@@ -1021,14 +1003,8 @@ static void hot_add_req(struct work_struct *dummy)
 		 * that need to be hot-added while ensuring the alignment
 		 * and size requirements of Linux as it relates to hot-add.
 		 */
-		region_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
-		if (pfn_cnt % HA_CHUNK)
-			region_size += HA_CHUNK;
-
-		region_start = (pg_start / HA_CHUNK) * HA_CHUNK;
-
-		rg_start = region_start;
-		rg_sz = region_size;
+		rg_start = ALIGN_DOWN(pg_start, HA_CHUNK);
+		rg_sz = ALIGN(pfn_cnt, HA_CHUNK);
 	}
 
 	if (do_hot_add)
-- 
2.25.1


