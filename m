Return-Path: <linux-hyperv+bounces-1712-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B2878714
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAD281447
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 18:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3C652F82;
	Mon, 11 Mar 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZFlKfI9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435763BB29;
	Mon, 11 Mar 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710180774; cv=none; b=up4pGgmSdXQIcoqd40cFbEPUMVoqJD9M1nDp1zlD93Bp8VFFCwnUEON1NjjSzBMfYsy6uYoPvo0bL6PD0W69vKBFyRC0yqcQoIZdCJh0WIHrmGYBj3EC4ndhzRukUgTUG8tIukZFNYFoldCHBaAvDVwHHXbybGXRNv6sgyLvmXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710180774; c=relaxed/simple;
	bh=NNSHfvBkcnofDuPTmyiip/uUKA9VYNoT31uHzplNxCI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=B6FDRPitySU+keomOVKYPo5LwKa7BpMVbOzGDqFqxemgZQ3/eqEvit5J2b3pJnFP82g8DuRre+GuMTqyBPeGhvG/vqy1bxAk61O7vLExF7FyEZc6Q+TiZ6GV4Uj0oOjFqxAw1ubF0cb7PhXygOkbzceI2lahWrsjRSfkUJs8K98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZFlKfI9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e64997a934so3657601b3a.0;
        Mon, 11 Mar 2024 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710180772; x=1710785572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pHdxOU6FI0zPgGr7ph1GUra/E3baRZW/HfFXDD76XIM=;
        b=SZFlKfI9pNDnbqkTmzr3Ty5Zwy/fQzIKZ0xUIWV+q1hBx3Egsw5k+6b9xp+6oALj4Q
         ifGgMyUxQ/jBFjs3sViUtKURuEM6oOAK2cQ/61cXLpPmjKWAKDvSb+fKYOtOHcP6tuI3
         jzQPvpuZio8fECTFR+lNvR2b9GarXwNebqGC5Ls9qcU6k+gYejd6+ZeYo6KiA4LXchk5
         ZwP8LLbne9i38p0QGPoCNXSvTvVEmAUjzoFC7EeHiszdA6AIWuQkMG13DyPHSAfcnMlo
         JnpW8x16S91GEB0fHIEocYnQJQMzx1qczVW+nQVStzhZ8voloiGkmP31RoPMIxK/cMNH
         PfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710180772; x=1710785572;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHdxOU6FI0zPgGr7ph1GUra/E3baRZW/HfFXDD76XIM=;
        b=dFyG55F0rJVy2xfVg95l/l4hNWGQiJJxcSffPIXtaydxemkzLKNqfnCO5x27xFjHPu
         ARR9YE0/rH65hKXMr1eglAB9pizjkJyjk5Snul+fTpFyQd8u+/4QXy9gINp9plvmB0NN
         U2RxNZviLbOr44lx0YQpiiju1rni8DV0cXI6YFMGkMtUArpCPWQPsgc+hnp2J+LIujVW
         lZv3gwWy3BrnmMyy22U6HqFUxOjESL/RCTgV/7Yi6NFYPX9AuyNVFXNuN2P6L/teAps9
         0gzXbGKiv93pAV2qHpKTxhPsSPVuC11wLijxPuxLI5Q1ssZGMQtAHzaXnN0DpBnv0hTc
         wNtg==
X-Forwarded-Encrypted: i=1; AJvYcCXLksfaFDi5r0ValV/mViu9CcaZ+d3xv3EAgHSyl+HoXkeuZn3u8vdJ1fQHQn00ndv9Lzh9Jp5xk0F7rAzPs66dJT6oT6KO14tgI2AlB7g/OxloeOuSW7PUQbnvmoWJvXk3BL56t2g5AvDA
X-Gm-Message-State: AOJu0YyWtsXvqD12VIM/D8xnoK6HNzogG3dbjXvTgXJ3zWcUOZqM1Mib
	w2+3KaI4EaG7X3ZpQ3VpQ8POumhGpN1W7l4zDb0ULz5BWaaPQDUZ
X-Google-Smtp-Source: AGHT+IFBbIjR32PbIYfTWs+uRY9c0pwYjvTgr8H3ULTdBrVByC9khjQqCTAmswxtIdGE67iLv1IsTw==
X-Received: by 2002:a05:6a00:983:b0:6e6:9a11:9d57 with SMTP id u3-20020a056a00098300b006e69a119d57mr1339143pfg.7.1710180772446;
        Mon, 11 Mar 2024 11:12:52 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id p1-20020a62b801000000b006e66a76d877sm4882751pfe.153.2024.03.11.11.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 11:12:52 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] hv_balloon: Enable hot-add for memblock sizes > 128 Mbytes
Date: Mon, 11 Mar 2024 11:12:38 -0700
Message-Id: <20240311181238.1241-1-mhklinux@outlook.com>
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

The Hyper-V balloon driver supports hot-add of memory in addition
to ballooning. Current code hot-adds in fixed size chunks of
128 Mbytes (fixed constant HA_CHUNK in the code).  While this works
in Hyper-V VMs with 64 Gbytes or less or memory where the Linux
memblock size is 128 Mbytes, the hot-add fails for larger memblock
sizes because add_memory() expects memory to be added in chunks
that match the memblock size. Messages like the following are
reported when Linux has a 256 Mbyte memblock size:

[  312.668859] Block size [0x10000000] unaligned hotplug range:
               start 0x310000000, size 0x8000000
[  312.668880] hv_balloon: hot_add memory failed error is -22
[  312.668984] hv_balloon: Memory hot add failed

Larger memblock sizes are usually used in VMs with more than
64 Gbytes of memory, depending on the alignment of the VM's
physical address space.

Fix this problem by having the Hyper-V balloon driver determine
the Linux memblock size, and process hot-add requests in that
chunk size instead of a fixed 128 Mbytes. Also update the hot-add
alignment requested of the Hyper-V host to match the memblock
size instead of being a fixed 128 Mbytes.

The code changes look significant, but in fact are just a
simple text substitution of a new global variable for the
previous HA_CHUNK constant. No algorithms are changed except
to initialize the new global variable and to calculate the
alignment value to pass to Hyper-V. Testing with memblock
sizes of 256 Mbytes and 2 Gbytes shows correct operation.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_balloon.c | 64 ++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index e000fa3b9f97..d3bfbf3d274a 100644
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
+static unsigned long ha_chunk_pgs;
+
 #define PAGES_IN_2M (2 * 1024 * 1024 / PAGE_SIZE)
-#define HA_CHUNK (128 * 1024 * 1024 / PAGE_SIZE)
 
 struct hv_dynmem_device {
 	struct hv_device *dev;
@@ -724,15 +725,15 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 	unsigned long processed_pfn;
 	unsigned long total_pfn = pfn_count;
 
-	for (i = 0; i < (size/HA_CHUNK); i++) {
-		start_pfn = start + (i * HA_CHUNK);
+	for (i = 0; i < (size/ha_chunk_pgs); i++) {
+		start_pfn = start + (i * ha_chunk_pgs);
 
 		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
-			has->ha_end_pfn +=  HA_CHUNK;
+			has->ha_end_pfn +=  ha_chunk_pgs;
 
-			if (total_pfn > HA_CHUNK) {
-				processed_pfn = HA_CHUNK;
-				total_pfn -= HA_CHUNK;
+			if (total_pfn > ha_chunk_pgs) {
+				processed_pfn = ha_chunk_pgs;
+				total_pfn -= ha_chunk_pgs;
 			} else {
 				processed_pfn = total_pfn;
 				total_pfn = 0;
@@ -745,7 +746,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 
 		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
 		ret = add_memory(nid, PFN_PHYS((start_pfn)),
-				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
+				(ha_chunk_pgs << PAGE_SHIFT), MHP_MERGE_RESOURCE);
 
 		if (ret) {
 			pr_err("hot_add memory failed error is %d\n", ret);
@@ -760,7 +761,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
 				do_hot_add = false;
 			}
 			scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
-				has->ha_end_pfn -= HA_CHUNK;
+				has->ha_end_pfn -= ha_chunk_pgs;
 				has->covered_end_pfn -=  processed_pfn;
 			}
 			break;
@@ -838,11 +839,11 @@ static int pfn_covered(unsigned long start_pfn, unsigned long pfn_cnt)
 		if ((start_pfn + pfn_cnt) > has->end_pfn) {
 			residual = (start_pfn + pfn_cnt - has->end_pfn);
 			/*
-			 * Extend the region by multiples of HA_CHUNK.
+			 * Extend the region by multiples of ha_chunk_pgs.
 			 */
-			new_inc = (residual / HA_CHUNK) * HA_CHUNK;
-			if (residual % HA_CHUNK)
-				new_inc += HA_CHUNK;
+			new_inc = (residual / ha_chunk_pgs) * ha_chunk_pgs;
+			if (residual % ha_chunk_pgs)
+				new_inc += ha_chunk_pgs;
 
 			has->end_pfn += new_inc;
 		}
@@ -910,14 +911,14 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			 * We have some residual hot add range
 			 * that needs to be hot added; hot add
 			 * it now. Hot add a multiple of
-			 * HA_CHUNK that fully covers the pages
+			 * ha_chunk_pgs that fully covers the pages
 			 * we have.
 			 */
 			size = (has->end_pfn - has->ha_end_pfn);
 			if (pfn_cnt <= size) {
-				size = ((pfn_cnt / HA_CHUNK) * HA_CHUNK);
-				if (pfn_cnt % HA_CHUNK)
-					size += HA_CHUNK;
+				size = ((pfn_cnt / ha_chunk_pgs) * ha_chunk_pgs);
+				if (pfn_cnt % ha_chunk_pgs)
+					size += ha_chunk_pgs;
 			} else {
 				pfn_cnt = size;
 			}
@@ -1021,11 +1022,11 @@ static void hot_add_req(struct work_struct *dummy)
 		 * that need to be hot-added while ensuring the alignment
 		 * and size requirements of Linux as it relates to hot-add.
 		 */
-		region_size = (pfn_cnt / HA_CHUNK) * HA_CHUNK;
-		if (pfn_cnt % HA_CHUNK)
-			region_size += HA_CHUNK;
+		region_size = (pfn_cnt / ha_chunk_pgs) * ha_chunk_pgs;
+		if (pfn_cnt % ha_chunk_pgs)
+			region_size += ha_chunk_pgs;
 
-		region_start = (pg_start / HA_CHUNK) * HA_CHUNK;
+		region_start = (pg_start / ha_chunk_pgs) * ha_chunk_pgs;
 
 		rg_start = region_start;
 		rg_sz = region_size;
@@ -1832,9 +1833,12 @@ static int balloon_connect_vsp(struct hv_device *dev)
 
 	/*
 	 * Specify our alignment requirements as it relates
-	 * memory hot-add. Specify 128MB alignment.
+	 * memory hot-add.  The value is the log base 2 of
+	 * the number of megabytes in a chunk. For example,
+	 * with 256 Mbyte chunks, the value is 8.
 	 */
-	cap_msg.caps.cap_bits.hot_add_alignment = 7;
+	cap_msg.caps.cap_bits.hot_add_alignment =
+			ilog2(ha_chunk_pgs >> (20 - PAGE_SHIFT));
 
 	/*
 	 * Currently the host does not use these
@@ -2156,6 +2160,12 @@ static  struct hv_driver balloon_drv = {
 
 static int __init init_balloon_drv(void)
 {
+	/*
+	 * Hot-add must operate in chunks that are of size
+	 * equal to the memory block size because that's
+	 * what the core add_memory() interface requires.
+	 */
+	ha_chunk_pgs = memory_block_size_bytes() / PAGE_SIZE;
 
 	return vmbus_driver_register(&balloon_drv);
 }
-- 
2.25.1


