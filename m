Return-Path: <linux-hyperv+bounces-3726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7278A171C9
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 18:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF2B3A2961
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EB11EE7DA;
	Mon, 20 Jan 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cwb1n6QV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A11E5705;
	Mon, 20 Jan 2025 17:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394053; cv=none; b=qnFeKClwmI562naeepDa/ksPg8vfoOr58/llJ4qRwN2hinJ7HP7lU4d+VihYGVfYLXoMqcgU1fIwh9DtuCQtK/S08UHGNEzlVCqDeCR7I6/Jg+yhhctyFwNVdW2rmzgnpPL1bbtjE1n7ivAOkN0ryBOz+08V8umx2zVuobQH6ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394053; c=relaxed/simple;
	bh=7JDU9O/pzmZ+qBDbHU6ezsdHQGUa0zhaY4tzHHbDops=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IvUbJ/UspYdtP4xc/1a0GlQD0MiuHPLqghftgO8vQlIBaQ1hzTc/gTZk1gvNbIPLKRz2iPCher7VLOoMPgUwzKwGvqS4RIf61FJQPTgwgM9xyFGf7Nbs1AJE0BzMBVs9iteSbK1Bx3DIxPE3OfPQhGiAzc49yQz0E0AzfvaTwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cwb1n6QV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1EB5205A9C7;
	Mon, 20 Jan 2025 09:27:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1EB5205A9C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737394045;
	bh=i4AagACb65a3Kh0fpdVsJdbH99BwOjqEk+khMkSZ2mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cwb1n6QVyPdVRk8GFHo65GKq4Eet5BRcLJFxlvc0lAviPXydIb1rFY8Co+DsoYO0W
	 8AJBCfmCstESnFkSfsbLFNsIXNzOkqP8ZS4YAieos7cKiuq5yXU2NndD4V/ccagH/3
	 8szE7ZKoOUNd/meCtFY1gdlpEniyuxvbc9o5db4Q=
From: Konstantin Taranov <kotaranov@linux.microsoft.com>
To: kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	pabeni@redhat.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	decui@microsoft.com,
	wei.liu@kernel.org,
	sharmaajay@microsoft.com,
	longli@microsoft.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 01/13] RDMA/mana_ib: Allow registration of DMA-mapped memory in PDs
Date: Mon, 20 Jan 2025 09:27:07 -0800
Message-Id: <1737394039-28772-2-git-send-email-kotaranov@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Konstantin Taranov <kotaranov@microsoft.com>

Allow the HW to register DMA-mapped memory for kernel-level PDs.

Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
Reviewed-by: Shiraz Saleem <shirazsaleem@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 3 +++
 include/net/mana/gdma.h           | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 67c2d43..45b251b 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -82,6 +82,9 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	mana_gd_init_req_hdr(&req.hdr, GDMA_CREATE_PD, sizeof(req),
 			     sizeof(resp));
 
+	if (!udata)
+		flags |= GDMA_PD_FLAG_ALLOW_GPA_MR;
+
 	req.flags = flags;
 	err = mana_gd_send_request(gc, sizeof(req), &req,
 				   sizeof(resp), &resp);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 90f5665..03e1b25 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -775,6 +775,7 @@ struct gdma_destroy_dma_region_req {
 
 enum gdma_pd_flags {
 	GDMA_PD_FLAG_INVALID = 0,
+	GDMA_PD_FLAG_ALLOW_GPA_MR = 1,
 };
 
 struct gdma_create_pd_req {
-- 
2.43.0


