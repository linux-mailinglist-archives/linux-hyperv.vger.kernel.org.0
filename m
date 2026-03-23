Return-Path: <linux-hyperv+bounces-9689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAewLQD4wGkwPAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9689-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 09:21:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACDE2EE37C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 09:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98F5F300646E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF524371893;
	Mon, 23 Mar 2026 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CKdi5VuT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116E37104E;
	Mon, 23 Mar 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254078; cv=none; b=ktKJEMgSz70bHSGc5o1Z3tBlB/7WRUqffysE80lBzEcY1JeEV/tgl6c1WjTbqkfeKnr9lMYM0KTFmPp7HGN5lwq3OmF1zBJH9D3NZZcP6++hPvex6rOM10Qv02Zel7uBXgP+SWM9dTilqB0mB3hRjc5g5F5vRiHU+S5FQ+4uwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254078; c=relaxed/simple;
	bh=qNhWPu5HjvRRDOABzZBW+TX71Rg3S7gQG7xVx4hvlHc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gDHRNsijHZltDLP3Up1bwbx6YIVRdgaz/lOCGA7P6UiZOZ3OrTAWt0rYCnO1vLQzGLdjTFwgN3Gi219RguHCyL7cAM/CpaCPlJ7mBCfaQOd8lohtgjd1kC7vbX7TRd1BfWdAbpNMx8RmiBd5nq8EjkFzouOC1HE/qcOSIUnemFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CKdi5VuT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 6499420B710C; Mon, 23 Mar 2026 01:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6499420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774254077;
	bh=v/zgGi4KnjBvHxMREYCKdbfOdu/jxb/Ui7FVSLqycy4=;
	h=Date:From:To:Subject:From;
	b=CKdi5VuTiQB9IpVdyfyTwIqnm2v5nCt8M4S98WbE+nU4Bs7FnNXyNQv+m68595nGQ
	 Cna+S0Tdh54funfgEyq0yYe31AuP6dK5HkNIXnCJ/4iUIBcMA4fa1iwQaD0ClLYX9i
	 cffIZcdJNXtclSuWBRw4Sj4wT82C6dshpXRokKHU=
Date: Mon, 23 Mar 2026 01:21:17 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	dipayanroy@microsoft.com
Subject: [PATCH net] net: mana: Fix RX skb truesize accounting
Message-ID: <acD3/f4Se3miC/6z@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9689-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 5ACDE2EE37C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MANA passes rxq->alloc_size to napi_build_skb() for all RX buffers.
It is correct for fragment-backed RX buffers, where alloc_size matches
the actual backing allocation used for each packet buffer. However, in
the non-fragment RX path mana allocates a full page, or a higher-order
page, per RX buffer. In that case alloc_size only reflects the usable
packet area and not the actual backing memory.

This causes napi_build_skb() to underestimate the skb backing allocation
in the single-buffer RX path, so skb->truesize is derived from a value
smaller than the real RX buffer allocation.

Fix this by updating alloc_size in the non-fragment RX path to the
actual backing allocation size before it is passed to napi_build_skb().

Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index ea71de39f996..884f8e548174 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -766,6 +766,13 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 		}
 
 		*frag_count = 1;
+
+		/* In the single-buffer path, napi_build_skb() must see the
+		 * actual backing allocation size so skb->truesize reflects
+		 * the full page (or higher-order page), not just the usable
+		 * packet area.
+		 */
+		*alloc_size = PAGE_SIZE << get_order(*alloc_size);
 		return;
 	}
 
-- 
2.43.0


