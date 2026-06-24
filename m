Return-Path: <linux-hyperv+bounces-11660-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4wfkI7FZPGpHnAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11660-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 00:26:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2850A6C1BE5
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 00:26:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11660-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11660-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F87630267B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2026 22:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9AE3264F2;
	Wed, 24 Jun 2026 22:26:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E5E2C08CF;
	Wed, 24 Jun 2026 22:26:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340013; cv=none; b=GnpXV2UyppwiX2Cbuk5z8ZVdADUUJL72XfkEIcEmdo2EHouonCobHd8OQCvwkiDfAbHaviRgby3ZFGDvsdr2b0lz9PBk3+Mxd3sRm5BmZwOzci+kBRpP13d7YvxoN4gKmrSLpJVLOkhcdZw5TYa8MuumHlryknqHJqHQS0mMxxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340013; c=relaxed/simple;
	bh=Dcemh5adW4aUAyKSjdTU9WEGDohpJ/2reiBtr58yTn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=O5JdFLdIzG7BgspkCeOSGIft6h19dSiR5/1P15whmkBndTv3zBItYajZH1qfl4MGCo/C7svhsMSw5D/RwaspXV49Cxf3Bd7Cjw/Yj70sxt2vtnVfMPbruANWdDhg+oas7/JVzLiRMUrL7Bb5kkrosCygNrUMpi4SS4KQLL2/G/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1009)
	id DA54520B7166; Wed, 24 Jun 2026 15:26:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA54520B7166
From: Dexuan Cui <decui@microsoft.com>
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
	kotaranov@microsoft.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	kees@kernel.org,
	jacob.e.keller@intel.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net v2 0/2] Fix MANA RX with bounce buffering
Date: Wed, 24 Jun 2026 15:26:03 -0700
Message-ID: <20260624222605.1794719-1-decui@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:kees@kernel.org,m:jacob.e.keller@intel.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11660-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[decui@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2850A6C1BE5

With swiotlb=force, the MANA NIC fails to work properly due to commit
730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead
of full pages to improve memory efficiency.")

Dipayaan tried to fix this by avoiding page pool frags when bounce
buffering is in use [1][2]. However, that is not a clean solution: no
other NIC drivers need to explicitly check whether bounce buffering is
in use. It is also not good for throughput, since
dma_map_single()/dma_unmap_single() are then called for each incoming
packet.

In fact, page pool frags can still be used with the standard MTU of
1500: all we need is to add page_pool_dma_sync_for_cpu() before the CPU
reads the incoming packet, so I implemented that in v1 [3].

As Simon suggested [4], this version splits v1 into two patches:
Patch 1 adds page_pool_dma_sync_for_cpu().
Patch 2 validates the packet length reported by the NIC.

There is no functional difference between v1 and v2, so I am keeping
Haiyang's Reviewed-by tag in v2.

Please review. Thanks!

Note that, with jumbo MTU and XDP, page pool frags are not used, and
dma_map_single()/dma_unmap_single() are still called for each incoming
packet, causing poor throughput with swiotlb=force; see
mana_get_rxbuf_cfg() and mana_refill_rx_oob() -> mana_get_rxfrag().
The jumbo MTU/XDP issue will be addressed later since that needs more
consideration if we want to use page pool with PP_FLAG_DMA_MAP there:
e.g., for XDP, the received packet can be transmitted in place, i.e. the
same RX buffer can be used as a TX buffer:
mana_rx_skb() -> mana_xdp_tx() -> mana_start_xmit() -> mana_map_skb().

In mana_create_page_pool(), we may have to set pprm.dma_dir to
DMA_BIDIRECTIONAL if XDP is in use:
pprm.dma_dir = mana_xdp_get(mpc) ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;

In the case of XDP, the next issue is that mana_rx_skb() -> ... ->
mana_map_skb() appears to call dma_map_single() on an RX buffer allocated
from a page pool created with PP_FLAG_DMA_MAP, which seems incorrect.
Any thoughts?

[1] https://lore.kernel.org/all/ae91hyrLf4n23XE6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/#r
[2] https://lore.kernel.org/all/ae9pxvJfkAZYfKMf@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/
[3] https://lore.kernel.org/all/20260618035029.249361-1-decui@microsoft.com/
[4] https://lore.kernel.org/all/20260619090514.GT827683@horms.kernel.org/

Dexuan Cui (2):
  net: mana: Sync page pool RX frags for CPU
  net: mana: Validate the packet length reported by the NIC

 drivers/net/ethernet/microsoft/mana/mana_en.c | 61 +++++++++++++++----
 include/net/mana/mana.h                       |  8 +++
 2 files changed, 58 insertions(+), 11 deletions(-)

-- 
2.34.1


