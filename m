Return-Path: <linux-hyperv+bounces-10387-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADAZOaxm72kIBAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10387-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 15:37:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA04738EF
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 15:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38CD4300DE24
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 13:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5503CAE73;
	Mon, 27 Apr 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fpXs1g+j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3393C8716;
	Mon, 27 Apr 2026 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296927; cv=none; b=rbxwF27hhPUQHkLZtQsa07RxuNMUS76h2MRTb+cihDRjlyQJRMd3DAQGbLbab/rPIz96DrfSIu4Blx25LLi8wJviU+GCIfAjBWPu/aa138fkjbcjyztX4ubkwF2kF/jJ8gtfi8aGD8PnnYS0pmhk+ULDUG3aBm/ykvSXVluoyVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296927; c=relaxed/simple;
	bh=Hrd3Ufbn0yIBkbjycfXpMJ9mBOrSVze4ikAYNtzpkMc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kvAKViOxXwYuZ9LmB1rnuljYumtC/+2Z0mgEnijxkia9d/v8b8pqKfDOb5n4EfypBC472tfv6X6OcUo0b9MjEHX7b7PMVjXIatAD5+aITLTXXCtA/2zek9bUweW6laFWLvMZDRNUGWG6+c+1y6/7fPwFyt08rMydqNlPoy+i3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fpXs1g+j; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 2A95820B716A; Mon, 27 Apr 2026 06:35:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A95820B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777296926;
	bh=WsS2t80x+GGz7CqR25akz3086Hpb7Gp6QxW+DhOqL00=;
	h=From:To:Subject:Date:From;
	b=fpXs1g+jp/xD8PeBW9r9WrxfznWah99eMaY6m7AZKmmZq2t8QAzLxIW1Jojo0UZDS
	 JHUwY/rury8nDfx6NokHY8FQYlHIn1086VwqLMw1zvLSv8f6dABVi4j+dsaQGznQqS
	 Pg0wTkfw1/zDOW/EaQYxfTwU4AtJPcY1zts0RGfI=
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
	kotaranov@microsoft.com,
	horms@kernel.org,
	ssengar@linux.microsoft.com,
	jacob.e.keller@intel.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	sbhatta@marvell.com,
	leitao@debian.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH net-next v2 0/2] net: mana: Avoid queue struct allocation failure under memory fragmentation
Date: Mon, 27 Apr 2026 06:23:33 -0700
Message-ID: <20260427132807.1642290-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40BA04738EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10387-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The MANA driver can fail to load on systems with high memory
utilization because several allocations in the queue setup paths
require large physically contiguous blocks via kmalloc. Under memory
fragmentation these high-order allocations may fail, preventing the
driver from creating queues at probe time or when reconfiguring
channels, ring parameters or MTU at runtime.

Allocation sizes that are problematic:

  mana_create_txq -> tx_qp flat array (sizeof(mana_tx_qp) = 35528):
    16 queues (default): 35528 * 16 =  ~555 KB contiguous
    64 queues (max):     35528 * 64 = ~2220 KB contiguous

  mana_create_rxq -> rxq struct with flex array
  (sizeof(mana_rxq) = 35712, rx_oobs=296 per entry):
    depth 1024 (default): 35712 + 296 * 1024 =  ~331 KB per queue
    depth 8192 (max):     35712 + 296 * 8192 = ~2403 KB per queue

  mana_pre_alloc_rxbufs -> rxbufs_pre and das_pre arrays:
    16 queues, depth 1024 (default): 16 * 1024 * 8 =  128 KB each
    64 queues, depth 8192 (max):     64 * 8192 * 8 = 4096 KB each

This series addresses the issue by:
  1. Converting the tx_qp flat array into an array of pointers with
     per-queue kvzalloc (~35 KB each), replacing a single contiguous
     allocation that can reach ~2.2 MB at 64 queues.
  2. Switching rxbufs_pre, das_pre, and rxq allocations to
     kvmalloc/kvzalloc so the allocator can fall back to vmalloc
     when contiguous memory is unavailable.

Throughput testing confirms no regression. Since kvmalloc falls
back to vmalloc under memory fragmentation, all kvmalloc calls
were temporarily replaced with vmalloc to simulate the fallback
path (iperf3, GBits/sec):

                 Physically contiguous         vmalloc region
  Connections      TX          RX              TX          RX
  --------------------------------------------------------------
  1                47.2        46.9            46.8        46.6
  16               181         181             181         181
  32               181         181             181         181
  64               181         181             181         181

---
Changes in v2:
  - Rebased onto v7.1-rc1 (was v7.0-rc7)

Aditya Garg (2):
  net: mana: Use per-queue allocation for tx_qp to reduce allocation
    size
  net: mana: Use kvmalloc for large RX queue and buffer allocations

 .../net/ethernet/microsoft/mana/mana_bpf.c    |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 61 +++++++++++--------
 .../ethernet/microsoft/mana/mana_ethtool.c    |  2 +-
 include/net/mana/mana.h                       |  2 +-
 4 files changed, 39 insertions(+), 28 deletions(-)

-- 
2.43.0


