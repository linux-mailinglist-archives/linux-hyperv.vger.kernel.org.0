Return-Path: <linux-hyperv+bounces-11979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mlk5Mb/+VmpOEAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11979-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:30:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1660A75A452
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 05:30:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11979-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11979-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B98B73043986
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Jul 2026 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511B3A9632;
	Wed, 15 Jul 2026 03:30:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1E83921DD;
	Wed, 15 Jul 2026 03:30:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086205; cv=none; b=GuasjNqZ8RZbT/sVbkMj8TEU62Y4z0MNCl13tIjHAJPWP/nDK3DcL/iIe/lJarBjNa9lZxvDs/3iZ83b/gmq9BnrHs4BJY6lC6GNBejReZqrHEMbezU6mwFnhOA/J84nTCI4+Mr8UItAvOjsVAcnrGnzj8lR2mKY9wMTYUA7oKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086205; c=relaxed/simple;
	bh=XQHjrjwOb6CCDALTtfR4DOdZJaA9AaPWzpgyD1WW8jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EK+Q9ngFCmzWWFd8BB7r4mviGZCwf9mQAjEBjTPKAJrU9T8RfEOqgYIVsanL3+4UfaUbmhEuWTf2q7jH3fsTbCLaW8AZe5xJIOCUrOxrOkiGQrwkTtnZA4NSjRkPJd2TQNY7JgDQE0SwsjvSQg4VdnMca8DCNYoBe1eptPaTrK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 603E420B7167; Tue, 14 Jul 2026 20:29:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 603E420B7167
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] net: mana: harden the HWC and add dynamic queue depth
Date: Tue, 14 Jul 2026 20:29:34 -0700
Message-ID: <20260715032942.3945317-1-longli@microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11979-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1660A75A452

This series hardens the MANA Hardware Channel (HWC) control-plane path
and then builds on that to support a dynamic HWC queue depth.

The HWC is the command channel the driver uses to talk to the device.
Today it is created at a fixed depth of one outstanding request, and
several of its lookup and teardown paths predate the RCU and DMA-lifetime
rules they now need to follow.  Raising the queue depth and allowing
concurrent commands makes those latent races reachable, so the fixes come
first and the feature builds on them.

Patches 1-5 are fixes for pre-existing HWC bugs, each with a Fixes: tag:

  1: cq_table was a plain pointer array freed with no grace period while
     the EQ interrupt handler dereferenced it; put it under RCU.
  2: the HWC RQ and SQ were sized with each other's message size, so a
     response could overflow the RQ buffer and the RX slot stride was
     computed with the wrong size.
  3: comp_buf was freed before the EQ was destroyed, so a late completion
     handler could touch freed memory.
  4: the RX path consumed device-supplied lengths and indices without
     validation; validate them before use (this matters for confidential
     VMs, where the DMA buffer is shared with the host).
  5: a failed mana_hwc_establish_channel() could leave live MST entries
     while the driver freed the queue buffers, and destroy_channel() freed
     the TXQ/RXQ before the EQ was quiesced; add a setup_active teardown
     gate and destroy the CQ first.

Patches 6-7 add the feature:

  6: replace the depth-1 semaphore with a slot bitmap and per-slot
     synchronization so several management commands can be in flight,
     with teardown that drains in-flight senders before freeing the HWC.
  7: bootstrap the HWC at depth 1, query the device maximum and, if it is
     larger, tear down and rebuild the queues at that depth.  The reported
     dimensions are validated before they size DMA allocations, and the
     capability is advertised so firmware enables it only when the driver
     supports it.

The fixes are grouped ahead of the feature they enable rather than sent
separately to net, since the HWC runs at depth 1 today and the races are
reached only once the later patches raise the depth.

Long Li (7):
  net: mana: RCU-protect gc->cq_table lookups against concurrent CQ
    destroy
  net: mana: fix HWC RQ/SQ buffer size swap
  net: mana: free HWC comp_buf after destroying the EQ
  net: mana: validate hardware-supplied values in the HWC RX path
  net: mana: fix HWC teardown safety with setup_active flag and destroy
    ordering
  net: mana: support concurrent HWC requests with proper synchronization
  net: mana: add dynamic HWC queue depth with reinit path

 drivers/infiniband/hw/mana/cq.c               |  46 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   |  78 +-
 .../net/ethernet/microsoft/mana/hw_channel.c  | 707 ++++++++++++++++--
 drivers/net/ethernet/microsoft/mana/mana_en.c |  22 +-
 include/net/mana/gdma.h                       |  48 +-
 include/net/mana/hw_channel.h                 |  40 +-
 6 files changed, 849 insertions(+), 92 deletions(-)


base-commit: f6f3b36c15ed44de1fbb44e645e4fae8c4a4453e
-- 
2.43.0


