Return-Path: <linux-hyperv+bounces-2058-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D01F08B8CD2
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 May 2024 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F7D1F258AE
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 May 2024 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC4130AEC;
	Wed,  1 May 2024 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGLj9FVW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108C5130AD8;
	Wed,  1 May 2024 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576516; cv=none; b=eYaEphOkS8Ee7fff9g8xLY2UUZ10CHr0GHsRHEHZiCvGCKTuEXyRE+lkP1Kf3CYe0Ia6QOvvRf1DMBmwQrbJDayA5L+P8UBU7XhBpZvxLoGG0z6AB69nTa90ETuNQDj7+D0HkDqqaXZv5GeWp7joVOsOqf+DXsgGaS4O8gbN3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576516; c=relaxed/simple;
	bh=U8Px4b/teO73nyl2rSpindj7Au8xlqUmX7JokTjhvpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qk9bR8fWd8hMtcGx91k3hQRCUzW5F+FodDsCpOkNTTIihH+bEw7G6e4W+8aeG1Ran493FhlWZ9LjSd1dwUR6z4Rg+DThEk+t013Xt3rnJ8zE5Gd4GOvHq5vtjLeVBbV1NZcRtPUKv54cDoPGfH1mPdj92PbaU5fbauTWmCl2pGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGLj9FVW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3c3aa8938so45525595ad.1;
        Wed, 01 May 2024 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576514; x=1715181314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=As1IPJwr8YYHOOYyMBNwGJbpJ2c4tXwq7t24zgDtyBM=;
        b=SGLj9FVWcjst+Z4k1zPxaJgzHxRoh8KCa/F5RbZH+Kl2s24z7ukhsDtLHHBxIXR+kh
         ZmFR/oou6Mt6pDD2kyngpxenRuQmuRG19dBg/5+bFuOBAOxBqP33ELwngZ7yqYOe4tnW
         HncmMpmP0QQeQFLuJ4WIhHlBCxdQzI5fhuecUYd+kBz72oH3FKEiDTX3Vqej4WEiL/gf
         Rrnlsok9Z9fTut+XPzjLYWAHZ3Y4aA/cdmzUDREkYRUGQRI9b3xZOBPFEa4ntD+PIsvF
         NtEtTFsHoteBsMOo7T1UaIHCBm9T+q786zL7UNBtfnUGmQQKbubU1Oikog3Wu44adRLV
         lxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576514; x=1715181314;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=As1IPJwr8YYHOOYyMBNwGJbpJ2c4tXwq7t24zgDtyBM=;
        b=uwQ2v8I9NowXTpFbdMHQwOVmm9MdUxphX0AdRYf1BQgJKCn1zUJbIJBW3L+FeHFAIJ
         sNccE217eqEn2UW3db94BBQwEV9wO8mm+9VYsSXrQX8ugn8KHjf5iTDNK609G5pYTzo4
         Ep4dXsqcNCnX3lMWuj7c2rob4j9wORGyTA88wM2obc3d3tB5g16FeXrp+QcXGZWPgeLB
         +RKCpKrgbILqJKi6BMUhXT99+3fIqgFtFcccldFcjOshnL5U0uVcqYU738Mee1Jww7wq
         VElUvuluI09F6pscwdPk4mGYQFvrLJTWpcaj47Lx4PUnICrEc4u8lKW0MbhMJanIvflV
         klpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBk2Ji4o3lB+3U0LddnQ7aFguplrguNG8CmpyRVEYVXMadfQZtdslnFikNACvrVHNwK44oarCKy00gZRnnrFBOaXGPSp59gtQ/G4duUndxKGLsopPKOoXcVyRoGQ071kxhGZ0UsHrJ61Xz
X-Gm-Message-State: AOJu0Yx2nIHIClZN7j4j5UOxRpEmeA5On/3mgkSMghCJxxrkzdtx73m3
	T2wRRQ3qnZ2WpMiCLneAEQ5v7BmzGSASyr9kyDsfpMXGRfs/kJ+DeoKSxA==
X-Google-Smtp-Source: AGHT+IHISD/BiV8r1yvh8oMROb0wM8wV2Wmpb7jI9ihnw0Ad/Zl9TAKDbZc/EBiKrLMs6dRpIewdFQ==
X-Received: by 2002:a17:903:11ce:b0:1e4:9c2f:d343 with SMTP id q14-20020a17090311ce00b001e49c2fd343mr3419684plh.7.1714576514106;
        Wed, 01 May 2024 08:15:14 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902db0900b001dd88a5dc47sm5586861plx.290.2024.05.01.08.15.13
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
Subject: [PATCH v2 2/2] hv_balloon: Enable hot-add for memblock sizes > 128 MiB
Date: Wed,  1 May 2024 08:14:58 -0700
Message-Id: <20240501151458.2807-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240501151458.2807-1-mhklinux@outlook.com>
References: <20240501151458.2807-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

The Hyper-V balloon driver supports hot-add of memory in addition
to ballooning. Current code hot-adds in fixed size chunks of
128 MiB (fixed constant HA_CHUNK in the code). While this works
in Hyper-V VMs with 64 GiB or less or memory where the Linux
memblock size is 128 MiB, the hot-add fails for larger memblock
sizes because add_memory() expects memory to be added in chunks
that match the memblock size. Messages like the following are
reported when Linux has a 256 MiB memblock size:

[  312.668859] Block size [0x10000000] unaligned hotplug range:
               start 0x310000000, size 0x8000000
[  312.668880] hv_balloon: hot_add memory failed error is -22
[  312.668984] hv_balloon: Memory hot add failed

Larger memblock sizes are usually used in VMs with more than
64 GiB of memory, depending on the alignment of the VM's
physical address space.

Fix this problem by having the Hyper-V balloon driver determine
the Linux memblock size, and process hot-add requests in that
chunk size instead of a fixed 128 MiB. Also update the hot-add
alignment requested of the Hyper-V host to match the memblock
size.

The code changes look significant, but in fact are just a
simple text substitution of a new global variable for the
previous HA_CHUNK constant. No algorithms are changed except
to initialize the new global variable and to calculate the
alignment value to pass to Hyper-V. Testing with memblock
sizes of 256 MiB and 2 GiB shows correct operation.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Change new global variable name from ha_chunk_pgs to
  ha_pages_in_chunk [David Hildenbrand]
* Use kernel macros ALIGN(), ALIGN_DOWN(), and umin()
  to simplify code and reduce references to HA_CHUNK. For
  ease of review, this is done in a new patch preceeding
  this one. [David Hildenbrand]

 drivers/hv/hv_balloon.c | 55 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 9f45b8a6762c..e0a1a18041ca 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -425,11 +425,11 @@ struct dm_info_msg {
  * The range start_pfn : end_pfn specifies the range
  * that the host has asked us to hot add. The range
  * start_pfn : ha_end_pfn specifies the range that we have
- * currently hot added. We hot add in multiples of 128M
- * chunks; it is possible that we may not be able to bring
- * online all the pages in the region. The range
+ * currently hot added. We hot add in chunks equal to the
+ * memory block size; it is possible that we may not be able
+ * to bring online all the pages in the region. The range
  * covered_start_pfn:covered_end_pfn defines the pages that can
- * be brough online.
+ * be brought online.
  */
 
 struct hv_hotadd_state {
@@ -505,8 +505,9 @@ enum hv_dm_state {
 
 static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
 static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
+static unsigned long ha_pages_in_chunk;
+
 #define PAGES_IN_2M (2 * 1024 * 1024 / PAGE_SIZE)
-#define HA_CHUNK (128 * 1024 * 1024 / PAGE_SIZE)
 
 struct hv_dynmem_device {
 	struct hv_device *dev;
@@ -724,21 +725,21 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	unsigned long processed_pfn;
 	unsigned long total_pfn = pfn_count;
 
-	for (i = 0; i < (size/HA_CHUNK); i++) {
-		start_pfn = start + (i * HA_CHUNK);
+	for (i = 0; i < (size/ha_pages_in_chunk); i++) {
+		start_pfn = start + (i * ha_pages_in_chunk);
 
 		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
-			has->ha_end_pfn +=  HA_CHUNK;
-			processed_pfn = umin(total_pfn, HA_CHUNK);
+			has->ha_end_pfn += ha_pages_in_chunk;
+			processed_pfn = umin(total_pfn, ha_pages_in_chunk);
 			total_pfn -= processed_pfn;
-			has->covered_end_pfn +=  processed_pfn;
+			has->covered_end_pfn += processed_pfn;
 		}
 
 		reinit_completion(&dm_device.ol_waitevent);
 
 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
-				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
+				(ha_pages_in_chunk << PAGE_SHIFT), MHP_MERGE_RESOURCE);
 
 		if (ret) {
 			pr_err("hot_add memory failed error is %d\n", ret);
@@ -753,7 +754,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				do_hot_add = false;
 			}
 			scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
-				has->ha_end_pfn -= HA_CHUNK;
+				has->ha_end_pfn -= ha_pages_in_chunk;
 				has->covered_end_pfn -=  processed_pfn;
 			}
 			break;
@@ -829,9 +830,9 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 		 * our current limit; extend it.
 		 */
 		if ((start_pfn + pfn_cnt) > has->end_pfn) {
-			/* Extend the region by multiples of HA_CHUNK */
+			/* Extend the region by multiples of ha_pages_in_chunk */
 			residual = (start_pfn + pfn_cnt - has->end_pfn);
-			has->end_pfn += ALIGN(residual, HA_CHUNK);
+			has->end_pfn += ALIGN(residual, ha_pages_in_chunk);
 		}
 
 		ret = 1;
@@ -897,12 +898,12 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			 * We have some residual hot add range
 			 * that needs to be hot added; hot add
 			 * it now. Hot add a multiple of
-			 * HA_CHUNK that fully covers the pages
+			 * ha_pages_in_chunk that fully covers the pages
 			 * we have.
 			 */
 			size = (has->end_pfn - has->ha_end_pfn);
 			if (pfn_cnt <= size) {
-				size = ALIGN(pfn_cnt, HA_CHUNK);
+				size = ALIGN(pfn_cnt, ha_pages_in_chunk);
 			} else {
 				pfn_cnt = size;
 			}
@@ -1003,8 +1004,8 @@ static void hot_add_req(struct work_struct *dummy)
 		 * that need to be hot-added while ensuring the alignment
 		 * and size requirements of Linux as it relates to hot-add.
 		 */
-		rg_start = ALIGN_DOWN(pg_start, HA_CHUNK);
-		rg_sz = ALIGN(pfn_cnt, HA_CHUNK);
+		rg_start = ALIGN_DOWN(pg_start, ha_pages_in_chunk);
+		rg_sz = ALIGN(pfn_cnt, ha_pages_in_chunk);
 	}
 
 	if (do_hot_add)
@@ -1807,10 +1808,13 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	cap_msg.caps.cap_bits.hot_add = hot_add_enabled();
 
 	/*
-	 * Specify our alignment requirements as it relates
-	 * memory hot-add. Specify 128MB alignment.
+	 * Specify our alignment requirements for memory hot-add. The value is
+	 * the log base 2 of the number of megabytes in a chunk. For example,
+	 * with 256 MiB chunks, the value is 8. The number of MiB in a chunk
+	 * must be a power of 2.
 	 */
-	cap_msg.caps.cap_bits.hot_add_alignment = 7;
+	cap_msg.caps.cap_bits.hot_add_alignment =
+			ilog2(ha_pages_in_chunk >> (20 - PAGE_SHIFT));
 
 	/*
 	 * Currently the host does not use these
@@ -2132,6 +2136,15 @@ static  struct hv_driver balloon_drv = {
 
 static int __init init_balloon_drv(void)
 {
+	/*
+	 * Hot-add must operate in chunks that are of size
+	 * equal to the memory block size because that's
+	 * what the core add_memory() interface requires.
+	 * The Hyper-V interface requires that the memory block
+	 * size be a power of 2, which is guaranteed by the
+	 * check in memory_dev_init().
+	 */
+	ha_pages_in_chunk = memory_block_size_bytes() / PAGE_SIZE;
 
 	return vmbus_driver_register(&balloon_drv);
 }
-- 
2.25.1


