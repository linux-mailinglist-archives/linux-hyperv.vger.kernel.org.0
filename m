Return-Path: <linux-hyperv+bounces-2075-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315348BB02C
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 17:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07B81F217FA
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029B15358B;
	Fri,  3 May 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dff+ZjOr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A34314F9DA;
	Fri,  3 May 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751002; cv=none; b=Zg0+pv1rMLVhVTDI+r9nEKkhN9CfJzS40b7S9vWe2FCqZfyxcEP7q1aOnwkrOHPE37AtedV0dBSyqU9qaotO9hKDMfITvUvJIXAWQvQbdGCXU/VvpehrNJYVTmJTAQTblHQkVZYsMq8w1jvnYakoFHIG9ngPjc+ARzNa8FCxGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751002; c=relaxed/simple;
	bh=XDDDZ47yhQtUxvILRo0KvZEL28i4xZIyZurncqqyka8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvj5ht9HBow963rIR/TBUTG2UEoveVJ3jBxkFJYUs2Dmv29MsBwbRfjVKiG4zQdyiD6i929bOOfHTC4D5G5TQE1v1t4XfEOUJ8osfnoIPILa1WMKX2Nld3vKaaraKYSdvYR4vytDoIZ/2DnALgsvDnWXiPAJ4uIzaBBcEgySx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dff+ZjOr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4496af4cdso974565b3a.0;
        Fri, 03 May 2024 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714751000; x=1715355800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9gJHKcOFTrvpGkcMuXJ5PC60P56qGsVSgAqoLbMrj0=;
        b=dff+ZjOrKAB51qg/cN12qmO7oGXzCJDkq52Jkac0i9D2bCFx+xi1sjVra836MuZtIR
         IjNtHpi//9vHf+rXgrCTEH0YGNFyY42U/eSOtDSZ1bxup1i7e9ZMcE/wSONi/9qg1mCH
         wqekJFytrHANbHjDZzr7NhH3NR913uWFC9ot5aZYk4NVw/czcazOl46+XATI8UoKdsy/
         2qqUFx3zKrKuI3Jsak8JQxdUa7yZ8ZpqjjdehcmUkSWHyLCNBSCgSLOHK7ZDb8CgcQlZ
         elxScegOickpNrVwEYaN1IvsNOsmHnye6yO8QbJfr2v9EuvCZmyFXKf2br0KHLL+qF9d
         eK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751000; x=1715355800;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9gJHKcOFTrvpGkcMuXJ5PC60P56qGsVSgAqoLbMrj0=;
        b=Sd5FLqWVTAWNJTyoJMnsme6ryPpQx9uqmYFYZcSaqX/kBJgkdAUtzIQK6+elziM0aX
         5riIqYCc4ouaaRZzx0xXMj6+GMWNc/AP41PE2/doV0XSlxzQnoU4/r3hGkNyMcMm8xm2
         zlekBkwAol5iN6q4ut1jx8H/kehZfb3AEOb52+OeQalx1QGBEW18h4m+yt44kJFQDoqX
         EJ9E6dRKzSLdakqX1nuU5PmLm4HL+adEy2fFjznCKvemu6vSyVJkKD7N7XMQ6cOXom7+
         FGo7C7oqCq0ANAgyEEb5pfmteasIsnteI6ogcssv2R7Z2oifNCCPvq63MOTlAGV6AmEj
         7gog==
X-Forwarded-Encrypted: i=1; AJvYcCV4a797WKJnm4xBm7Ynyxm+dp0hIgFyihYUWx1GHkJqcEIuuMYeqgjCKxui2NLhSJ1Ef7U+rBCqUWiUuyVGG+dJQo/+QdTq3WYJXra8irRUMPHpyQWTxfXgp2RBxFyGzrZKNXnA1HpyJz6E
X-Gm-Message-State: AOJu0Ywuqk3tk0kqqGNsvRR/9Jv+gsIok9myVOINmHEKqTbz5+gXXlFe
	5tmMFzHktbS8llOKiX3l7e5TlKBpGVhEcsB1i2MldwdcMEhLSmLDnadkRA32
X-Google-Smtp-Source: AGHT+IEExpn+pFvyYzxmhPYMENO6fqLl3pfporH6QVHjwlPp4WGyn7vP43b2gPyk7WzXa31wBIK94g==
X-Received: by 2002:a05:6a20:5a96:b0:1ad:1612:7656 with SMTP id kh22-20020a056a205a9600b001ad16127656mr2817999pzb.59.1714751000481;
        Fri, 03 May 2024 08:43:20 -0700 (PDT)
Received: from localhost.localdomain ([67.161.114.176])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b001e604438791sm3446362plk.156.2024.05.03.08.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:43:20 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: david@redhat.com
Subject: [PATCH v3 1/2] hv_balloon: Use kernel macros to simplify open coded sequences
Date: Fri,  3 May 2024 08:43:11 -0700
Message-Id: <20240503154312.142466-1-mhklinux@outlook.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v3:
* No changes.

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


