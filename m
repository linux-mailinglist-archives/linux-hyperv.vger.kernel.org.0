Return-Path: <linux-hyperv+bounces-10482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ol5K3VL8mnNpQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10482-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:18:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F50498E52
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 20:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8534030421C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35642189B;
	Wed, 29 Apr 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FjSpM9Y5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23F341C319;
	Wed, 29 Apr 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486671; cv=none; b=a4snUYoHPepS61gKnWkz8jw/LlrHOTXIbt02yVV34j1BK9uzjOeDCDBvBXd516r7rLeZalW6i0l2ZqRhlu6P6qoTrdVyIy+gjvP44YcgxZNAw53644Ne6zGeehwpTSqpxI2G7W0jfJ8wfeIFCNeudGHLxKzRs1R8CFc7rTOpQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486671; c=relaxed/simple;
	bh=pTT6Hswg7L3inYnv97QRqYWAPiZYEb3wMOjLKxxbICI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kby4nPnWYilgU3116xR+xY5pxJiRtO0qbwImnO5cCXuU0PQHhs6PLYyPqtzcynQsW1dnXLLh+WYVYNt4Kzes/2vrlYu/4kM7x85N0QXIezgzGc5awoqdZMuJB1P9rJzZgqpTdJjltPnjZpoRuONMOI+MQBwVT1TY4U20hZDC7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FjSpM9Y5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEA1720B716C;
	Wed, 29 Apr 2026 11:17:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEA1720B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777486668;
	bh=Uk8wk6XlWEHWPtWm07hcZvv/blXW1ZRa96uVpenLlnQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FjSpM9Y5DtzXULS+mS1ryxfjg77LiJvQ90H7HTHjv3gbPIIRVm3tTWVINXrD5w8MS
	 YI5CbAAH9+5f0hpefsgzVFAsef9n0iOjUrKErDgtNiPNytpxLlRITGY1eudyV1Ggr6
	 dW9+Kg8pxTDSFihitbCQmDR/lVrA9HsU31YFxHFc=
Subject: [PATCH 02/10] mshv: Fix potential integer overflow in
 mshv_region_create
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 18:17:48 +0000
Message-ID: 
 <177748666796.144491.13354229068891016734.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177748522635.144491.1565666089881726479.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57F50498E52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_FROM(0.00)[bounces-10482-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]

The allocation size is computed as:

  sizeof(*region) + sizeof(struct page *) * nr_pages

where nr_pages is a u64 originating from userspace. A sufficiently
large nr_pages can overflow the multiplication, resulting in a small
allocation followed by out-of-bounds writes when populating mreg_pages.

Use struct_size() which returns SIZE_MAX on overflow, causing vzalloc
to safely return NULL — caught by the existing error check.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index fdffd4f002f6f..1d04a97980b8b 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -177,7 +177,7 @@ struct mshv_mem_region *mshv_region_create(u64 guest_pfn, u64 nr_pages,
 {
 	struct mshv_mem_region *region;
 
-	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	region = vzalloc(struct_size(region, mreg_pages, nr_pages));
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 



