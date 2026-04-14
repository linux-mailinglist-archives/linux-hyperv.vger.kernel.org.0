Return-Path: <linux-hyperv+bounces-10154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ar+BQtd3mlfCQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10154-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:28:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5293FBCFF
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 544833094F01
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21293E9F89;
	Tue, 14 Apr 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jJdRn+Pj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787463E95A9;
	Tue, 14 Apr 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179720; cv=none; b=Jyn1Ge/pYsheqhM7Cz89oJq5LmRdnUUgJFcEgz9bi0/zvHnocplSHWIDJlI41V9/mlMR9O3YuPGut4dz8uWhfPEltkWGjE1qBs+kUI6QwWvbgHWyNJoIJjggzO9ReUd619BVGCCBaMzXKqRpmEfHIHmtbLP/vicC7D+KoB7imrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179720; c=relaxed/simple;
	bh=j9M29PHUu4QzpxXOdZ8HdXPKWG1HRS2IhD1l2gJjzz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OUrwpFYuYJoYGLfXFqwdWwq7hwZIY9gVXLlo9UleTLjiScoFqICyUPJa32PSdUZZXapiauAKQgywGNcTh+smNpwzeS/Nu+rL1IiCAaEBFldoFpJn6mDed18c3OUhjua5rvYMx6Lr3cdQ83qIL90yGopO56/83k7rDXj9+lQu3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jJdRn+Pj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 5717720B6F01; Tue, 14 Apr 2026 08:15:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5717720B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776179711;
	bh=76UaCt7m9qkU00fT5oqnIBRKGwTRxVqIsQNXt0w0ZGQ=;
	h=From:To:Subject:Date:From;
	b=jJdRn+Pj80pI4jVUiXvqv7FzQ1idXvrx/bcuGRBLQTKeJ1vCNNfB1JCfLl6GWh5PI
	 D59f6qAl54DYHzp1mKXOJoIoex3EnVH5tG4lWlqqGoqtmBfMNnbxrNlt11QkImSoyJ
	 PHrOsRq4X/6NQItha9nrV38lfGx63ktxEoN/WFf8=
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
Subject: [PATCH net-next 0/2] net: mana: Avoid queue struct allocation failure under memory fragmentation
Date: Tue, 14 Apr 2026 08:13:28 -0700
Message-ID: <20260414151456.687506-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10154-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_TWELVE(0.00)[27];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD5293FBCFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


