Return-Path: <linux-hyperv+bounces-11482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eg/hJTwyIWrwAQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11482-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 10:07:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0351263DD88
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 10:07:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=V6rVA8hh;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11482-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11482-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5DAD308B7DD
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 08:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772AF3AA1BC;
	Thu,  4 Jun 2026 08:02:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19632F691D;
	Thu,  4 Jun 2026 08:01:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560120; cv=none; b=Fp4pLgJIGLut5TL7duQNVyrrYCGLymgu7dkuu7RcO9dPC3T5Uc8q0SsBtgkO68WWV6DL9veItqmI8wA7NvN8b/0jgED2TYD4IAGN5AJ5C41OMjTdb1hSBS5gYyE7rnfXLQfuj9yCdzdb7qcvGqNNcQmWxGD0tpL4nxU/SpvxDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560120; c=relaxed/simple;
	bh=n8VVP+9Ut/pPJaDMpjrG9YrjXTEQjfc1uE8wALIaiGQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Glv4OjxIh2NEgj9mjNcnNXatFVpCH6SjvpTD9wHK5e7mEnY9zyvii+E401dr+daOTNdKdvP13iIM3zPm4xixoBAM+bDvgpc+MMjkXv0woyfLa1htlPRUQyEfV3weL3dYgAmLrbXaiWmXTsxOwFNkUyiHT9m81kmG1Do2o8Gt3l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V6rVA8hh; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 32A8620B716A; Thu,  4 Jun 2026 01:01:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32A8620B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780560103;
	bh=uIJJBlUJY3hU5mdhZK3p66/7yKcCChdf152P0tJa958=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=V6rVA8hhoqNT2pfHcsOcAMTLWQDR1iEwKLrnnvt8JVw6/k8BNNFEHpl7HE1QBQffv
	 Oe7LWzEo9FKGpZDpa9ZQFXBPxHLHWd5lzZ5X2bo8NF8Kmx3drsWrfUEnqyB9aciS2e
	 NBoNIngUG35roiDUYGnTXvkwodjJlg0U3aA26+LA=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: mana: initialize gdma queue id to INVALID_QUEUE_ID
Date: Thu,  4 Jun 2026 01:01:25 -0700
Message-ID: <20260604080137.1995269-2-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11482-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:gargaditya@linux.microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0351263DD88

mana_gd_create_mana_wq_cq() leaves queue->id as 0 (from kzalloc_obj())
until mana_create_wq_obj() assigns the firmware-returned id. If creation
fails before that, cleanup calls mana_gd_destroy_cq() with id 0, NULLing
gc->cq_table[0] and silently breaking whichever real CQ owns that slot.

Initialize queue->id to INVALID_QUEUE_ID right after allocation, matching
mana_gd_create_eq(). The existing (id >= max_num_cqs) guard then
short-circuits cleanly.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 712a0881d720..9d145517c6dc 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1200,6 +1200,8 @@ int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 	if (!queue)
 		return -ENOMEM;
 
+	queue->id = INVALID_QUEUE_ID;
+
 	gmi = &queue->mem_info;
 	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
 	if (err) {
-- 
2.43.0


