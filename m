Return-Path: <linux-hyperv+bounces-7447-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D8C3D8E6
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 23:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB377188EC06
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E7F32143E;
	Thu,  6 Nov 2025 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qngDrBqK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30F30BBB0;
	Thu,  6 Nov 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467216; cv=none; b=kvIVYgYQCnknXuCTU4OTcouGwSmQQFbz1Mys82zz7u/eRqw5TsOZF2ER0PXkNdKvI7a1dSPi22QlXjewoMauZ3MSETKmBE89xwdPrgABhDx7/uSGT1CWHPUpTmqTF1vM5pcvTeBIOeN/5YcpCfRA3ckShyy4IVsgHs4uMXfCR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467216; c=relaxed/simple;
	bh=1GsE3ZQQUNdKJ93/v6q7dsqth8ASVKYkWHm9x63xlwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W9sTLQKsK02TBp8rqwVh6779UXQDM3TIjxLmzL1ewQ2eV2xuJd1hVpP+6o6V21GpAae+BFm4oI5/L/saRN4O50VgoQYW6W3Es+vXtpPh0WIuv3vpv2foPHnm5WBtpUenuz6HplVlvy1uevlJTGckukgCga1ZDB046pvRJoCi8xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qngDrBqK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 45B99211CFAF; Thu,  6 Nov 2025 14:13:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45B99211CFAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762467215;
	bh=RmRanQLOp0XTHdqwcRIWaYAnmlFXYk+Veiu4Gf5Xd8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qngDrBqKN8nTsvpAvV+Ptw/TQfqM7S4wP2eJIfkcLw/3q4astbld1BrDmY8Ifmq4n
	 dBR/bMP3OgXl+t0wb0qu2Jd2Yltu3r2E9Znai1/GvZ3j8mVyExuML3YrLwdGREq1bX
	 P7dcHJDYxxmZKlppHfar8ozDuNsb16byeCVCxtU4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	magnuskulke@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	muislam@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 2/2] mshv: Allow mappings that overlap in uaddr
Date: Thu,  6 Nov 2025 14:13:31 -0800
Message-Id: <1762467211-8213-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Currently the MSHV driver rejects mappings that would overlap in
userspace.

Some VMMs require the same memory to be mapped to different parts of
the guest's address space, and so working around this restriction is
difficult.

The hypervisor itself doesn't prohibit mappings that overlap in uaddr,
(really in SPA; system physical addresses), so supporting this in the
driver doesn't require any extra work: only the checks need to be
removed.

Since no userspace code until now has been able to overlap regions in
userspace, relaxing this constraint can't break any existing code.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 8 ++------
 include/uapi/linux/mshv.h   | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 25a68912a78d..b1821b18fa09 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1220,12 +1220,8 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 
 	/* Reject overlapping regions */
 	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		u64 rg_size = rg->nr_pages << HV_HYP_PAGE_SHIFT;
-
-		if ((mem->guest_pfn + nr_pages <= rg->start_gfn ||
-		     rg->start_gfn + rg->nr_pages <= mem->guest_pfn) &&
-		    (mem->userspace_addr + mem->size <= rg->start_uaddr ||
-		     rg->start_uaddr + rg_size <= mem->userspace_addr))
+		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
+		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
 			continue;
 
 		return -EEXIST;
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 9091946cba23..b10c8d1cb2ad 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -123,7 +123,7 @@ enum {
  * @rsvd: MBZ
  *
  * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
- * Mappings can't overlap in GPA space or userspace.
+ * Mappings can't overlap in GPA space.
  * To unmap, these fields must match an existing mapping.
  */
 struct mshv_user_mem_region {
-- 
2.34.1


