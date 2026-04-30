Return-Path: <linux-hyperv+bounces-10516-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xx8eJGbU8mnIugEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10516-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:02:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E488549D22F
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 597A1303F7EF
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 04:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A1367F22;
	Thu, 30 Apr 2026 04:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="flP7c3Qz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83B1E32D6;
	Thu, 30 Apr 2026 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521686; cv=none; b=uYsORrpFMn6EPrh0guxgo2xo8COHWtvheTkX6+AoBAl46SGVpiHwGgSJfvz0V/LtrQpXUvLF8RZWDGv8dxSPKv86Q1jPJ9kIwu2oq1lgIZxbnTODThX/8WWTqoh1+y0oiPuDVKqrBIdX2K0CxdZ57LanMLqoRIZ8mjV21egiOhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521686; c=relaxed/simple;
	bh=ihbHFS8fqcjykLtVPxLwkEHGOCgwdO8Sw8gLFVNIZA0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5Lb4o0eYWluTJpRCktw6YujPqjzj6Mh2ECYJ8qYC0wPgHRJzOJU3jmg6QQJgaaLtYdG1P3E8KEPSvJBqpgfYwZMMxki0bLKzaY8tIvRc3Dhe4Ykb6p8VPOjTCYbZWhlnbae0wCqXddkfMTlqcy8AIV11YD9x5Kx7h/5fcNDmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=flP7c3Qz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16F7320B7172;
	Wed, 29 Apr 2026 21:01:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16F7320B7172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777521685;
	bh=EnERMomum/goudk6/J3udw33PHVB548hHsdYQiEYmdg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=flP7c3QzjUzHXjoyiDril6Z9M3lxe/6jKjRalsA3lDQLWvxFolIhWNL16ly8CizcN
	 6/C/ygveYA1rkXbriwFIkejXDtBdD95CUf5Vre/tQ3rW2vUsLYW0M8dDtpXqSv3/RX
	 9os2aNF34VtKUl43d0IXSMv1kGqaMWE9nvbhROH4=
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	leon@kernel.org,
	longli@microsoft.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	stephen@networkplumber.org,
	jacob.e.keller@intel.com,
	dipayanroy@microsoft.com,
	leitao@debian.org,
	kees@kernel.org,
	john.fastabend@gmail.com,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	sdf@fomichev.me,
	yury.norov@gmail.com
Subject: [PATCH 3/3] net: mana: remove double CQ cleanup in mana_create_rxq error path
Date: Wed, 29 Apr 2026 20:57:54 -0700
Message-ID: <20260430035935.1859220-4-dipayanroy@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
References: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E488549D22F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10516-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In mana_create_rxq(), the error cleanup path calls mana_destroy_rxq()
followed by mana_deinit_cq(). This is incorrect for two reasons:

1. mana_destroy_rxq() already calls mana_deinit_cq() internally,
   so the CQ's GDMA queue is destroyed twice.

2. mana_destroy_rxq() frees the rxq via kfree(rxq) before returning.
   The subsequent mana_deinit_cq(apc, cq) then operates on freed memory
   since cq points to &rxq->rx_cq, which is embedded in the
   already-freed rxq structure — a use-after-free.

Remove the redundant mana_deinit_cq() call from the error path since
mana_destroy_rxq() already handles CQ cleanup. mana_deinit_cq() is
itself safe for an uninitialized CQ as it checks for a NULL gdma_cq
before proceeding.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f2a6ea162dc3..9afc786b297a 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2799,9 +2799,6 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	mana_destroy_rxq(apc, rxq, false);
 
-	if (cq)
-		mana_deinit_cq(apc, cq);
-
 	return NULL;
 }
 
-- 
2.43.0


