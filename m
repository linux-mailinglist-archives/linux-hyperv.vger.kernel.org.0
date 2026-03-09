Return-Path: <linux-hyperv+bounces-9197-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFrXMfUPr2ldNQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9197-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 19:22:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C09623E8EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 09 Mar 2026 19:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34043004C6C
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Mar 2026 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388634678C;
	Mon,  9 Mar 2026 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hsoJCVNk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497712DB78E;
	Mon,  9 Mar 2026 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080499; cv=none; b=Kqn4soql9be2DFfEmoVIBArTKQZmSQFko6pAX9N4n4uupGEwTLehR57dbTrgR2WKg2pxKLHhYreYin3OpTlO593NlkTHvXvtTDAXIoPtDHA3zgvIRbOxpUy4gwkeOnavglwuJZcwgafLnib/Oy3qswgHY88mjko2y9jBMoK5xSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080499; c=relaxed/simple;
	bh=CGwODdLjcrGCYkRvulT3LzYy3rQk0FcW7yLuBEZT5Xw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uWbkNUTJrq8rUvbP0/dHWuA4QpWuXc+h8wOn42cx1j3FNcMVkl6phebwpRix1P3MqMFuzONIIjLnIkok+QsyZv4QInbx8aiAg9rZkLWO0dzVAZ+6JyfTLnE1U9rbcvtP/wN2BOuv5lXEDHbTEmcsf7GfBW0UMuRFn59pl23pgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hsoJCVNk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 2ACAA20B710C; Mon,  9 Mar 2026 11:21:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2ACAA20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773080498;
	bh=uhqGyVVMocgtmkrBPFhspgz4i3mEwX4e/mn8SitwRpU=;
	h=Date:From:To:Subject:From;
	b=hsoJCVNkm9uV0pkmTTfp3ibx52wF9DHZdO5kBbf3mbTJ6wAUAWIZBwAJWaN2dFyG7
	 zAM+waebSLyUTuDpz1mU6x+04pc4mkqSZxV07zdMymPDRE6DfddpUseJLfliHqHrGX
	 P5I1kALuEizExsJh3kvd2YLKex2DF0drB4rBhQzk=
Date: Mon, 9 Mar 2026 11:21:38 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
Subject: [PATCH net] net: mana: Fix use-after-free in
 mana_hwc_destroy_channel() by re-ordering teardown
Message-ID: <aa8PshvNRfuRYO/p@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2C09623E8EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9197-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

A potential race condition exists in mana_hwc_destroy_channel() where
hwc->caller_ctx is freed before the HWC's Completion Queue (CQ) and
Event Queue (EQ) are destroyed. This allows an in-flight CQ interrupt
handler to dereference freed memory, leading to a use-after-free or
NULL pointer dereference in mana_hwc_handle_resp().

mana_smc_teardown_hwc() signals the hardware to stop but does not
synchronize against IRQ handlers already executing on other CPUs. The
IRQ synchronization only happens in mana_hwc_destroy_cq() via
mana_gd_destroy_eq() -> mana_gd_deregister_irq(). Since this runs
after kfree(hwc->caller_ctx), a concurrent mana_hwc_rx_event_handler()
can dereference freed caller_ctx (and rxq->msg_buf) in
mana_hwc_handle_resp().

Fix this by reordering teardown to reverse-of-creation order: destroy
the TX/RX work queues and CQ/EQ before freeing hwc->caller_ctx. This
ensures all in-flight interrupt handlers complete before the memory they
access is freed.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 91975bdb5686..dbbde0fa57e7 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -814,9 +814,6 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 		gc->max_num_cqs = 0;
 	}
 
-	kfree(hwc->caller_ctx);
-	hwc->caller_ctx = NULL;
-
 	if (hwc->txq)
 		mana_hwc_destroy_wq(hwc, hwc->txq);
 
@@ -826,6 +823,9 @@ void mana_hwc_destroy_channel(struct gdma_context *gc)
 	if (hwc->cq)
 		mana_hwc_destroy_cq(hwc->gdma_dev->gdma_context, hwc->cq);
 
+	kfree(hwc->caller_ctx);
+	hwc->caller_ctx = NULL;
+
 	mana_gd_free_res_map(&hwc->inflight_msg_res);
 
 	hwc->num_inflight_msg = 0;
-- 
2.43.0


