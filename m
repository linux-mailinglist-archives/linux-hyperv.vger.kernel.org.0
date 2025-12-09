Return-Path: <linux-hyperv+bounces-8003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6FCB099E
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Dec 2025 17:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78B4D301F038
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Dec 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4BE2FF653;
	Tue,  9 Dec 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oRrZ6kmT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE612FF672;
	Tue,  9 Dec 2025 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298248; cv=none; b=G7BIjxUFWaZPzw1CB5h0JBh4WRDBUmrpuLXCGL4BEURYM6X23tY/hbodrJqAd46y3A18h5NlChOeH7i3IgZ7VQDUspMqmt2e2cYpLwX9CsgLBaVc/4RIrsvmqVcU08oFzFMP1fxDrsN3RePMyaqSvUTuQaq34OlEo9I9Hfu/72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298248; c=relaxed/simple;
	bh=Diw35JF+7zQTIAfbT55xJkTorTSvu16zooOic5VssNU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Ia6OgyJI1FgIaHk8XQltX8I2LdgjcyvCZ0Qmxm8Tj6cT4RTwpVGF3edcbyQP8S3NssG3d1V/Qfgjc3XSVpwPTebuIQXjt252dUFPJioWJx3LJL7D1CizM2/KAILnUHQaHovO4G4BABYH5eJYfonpOup6xyQsKVZYte9gndntJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oRrZ6kmT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11ECB20156A9;
	Tue,  9 Dec 2025 08:37:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11ECB20156A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765298241;
	bh=JgN6I1MKMFjwpH7qPn++VLVFdZwiPMMx2reD2VTRr08=;
	h=Subject:From:To:Cc:Date:From;
	b=oRrZ6kmTHEjrjg1Bxy0weT3RZzo9MiqyUHBhI4V+lpHtiqqQBSvFYzg2Ecsv+WwXU
	 FS4CpQsG2H6zsk0dv1Wh65v4atAG1kwN6kLpHwG930LAuEzSN1x1QALoM+Mh+USTNv
	 /5+W7JOmVRBl7iIq43fKouC6G533v/rqfnfOK0z8=
Subject: [PATCH] mshv: Use PMD_ORDER instead of HPAGE_PMD_ORDER when
 processing regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 09 Dec 2025 16:37:20 +0000
Message-ID: 
 <176529822862.17729.14849117117197568731.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Fix page order determination logic when CONFIG_PGTABLE_HAS_HUGE_LEAVES
is undefined, as HPAGE_PMD_SHIFT is defined as BUILD_BUG in that case.

Fixes: abceb4297bf8 ("mshv: Fix huge page handling in memory region
traversal")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 202b9d551e39..dc2d7044fb91 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -58,7 +58,7 @@ static long mshv_region_process_chunk(struct mshv_mem_region *region,
 
 	page_order = folio_order(page_folio(page));
 	/* The hypervisor only supports 4K and 2M page sizes */
-	if (page_order && page_order != HPAGE_PMD_ORDER)
+	if (page_order && page_order != PMD_ORDER)
 		return -EINVAL;
 
 	stride = 1 << page_order;



