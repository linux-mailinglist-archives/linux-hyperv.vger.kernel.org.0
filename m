Return-Path: <linux-hyperv+bounces-9182-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLvaNLeDq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9182-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:47:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596B229712
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE4C301FD41
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA8E318EF0;
	Sat,  7 Mar 2026 01:47:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78258175A95;
	Sat,  7 Mar 2026 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848052; cv=none; b=Dj9eOj7XDP0PzejiDBsOO77rFe+f3VMbSaYIQAczQZgE8q5BDE+YkIoAlPWoNUVBN3ruS420iC+8Jr7a9//9f2VxMuWPLjuMAhvH7+I+g6adJl8JuucaeonCj9SiCowECO5RqmeG6pbz6SwhWkIKR1tXsQpR3+CF0A8PeeAo0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848052; c=relaxed/simple;
	bh=QF81WmpxRrWYRBaun7KIn1uyg/V2x5q4tPvGnG722MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJ027xag+6RtZ3ge0t86P7Rm+DByer/9TRiU6VQ5YtJFGSkSX2s0ExhuuCoIFvy8TIDqMxpfif/ko9a44hk/exeHGOGMF48VdYNY/JD62zejp7G5KbfELRY4/+NTI40L8rlFGJZpwx70s/HYG5I+qnoaU/5WXXLBP7VS9fs44ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 4415E20B6F02; Fri,  6 Mar 2026 17:47:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4415E20B6F02
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
	Dexuan Cui <decui@microsoft.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 0/8] RDMA/mana_ib: Handle service reset for RDMA resources
Date: Fri,  6 Mar 2026 17:47:14 -0800
Message-ID: <20260307014723.556523-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3596B229712
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9182-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.368];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When the MANA hardware undergoes a service reset, the ETH auxiliary device
(mana.eth) used by DPDK persists across the reset cycle — it is not removed
and re-added like RC/UD/GSI QPs. This means userspace RDMA consumers such
as DPDK have no way of knowing that firmware handles for their PD, CQ, WQ,
QP and MR resources have become stale.

This series adds per-ucontext resource tracking and a reset notification
mechanism so that:

1. The RDMA driver is informed of service reset events via direct callbacks
   from the ETH driver (reset_notify / resume_notify).

2. On reset, all tracked firmware handles are invalidated (set to
   INVALID_MANA_HANDLE), user doorbell mappings are revoked via
   rdma_user_mmap_disassociate(), and IB_EVENT_PORT_ERR is dispatched to
   each affected ucontext so userspace can detect the reset.

3. Destroy callbacks check for INVALID_MANA_HANDLE and skip firmware
   commands for resources already invalidated by the reset path,
   preventing stale handles from being sent to firmware.

4. A reset_rwsem serializes handle invalidation against resource creation
   to avoid races between the reset path and new resource allocation.

Patches 1-6 introduce per-ucontext tracking lists for each resource type.
Patch 7 implements the reset/resume notification mechanism with rwsem
serialization, mmap revocation, and IB event dispatch.
Patch 8 adds INVALID_MANA_HANDLE checks in destroy callbacks.

Tested with DPDK testpmd on Azure VM (linux-next-20260306) — confirmed
IB_EVENT_PORT_ERR (type=10) and IB_EVENT_PORT_ACTIVE (type=9) are delivered
to userspace during service reset, and testpmd tears down cleanly afterwards.

Long Li (8):
  RDMA/mana_ib: Track ucontext per device
  RDMA/mana_ib: Track PD per ucontext
  RDMA/mana_ib: Track CQ per ucontext
  RDMA/mana_ib: Track WQ per ucontext
  RDMA/mana_ib: Track QP per ucontext
  RDMA/mana_ib: Track MR per ucontext
  RDMA/mana_ib: Notify service reset events to RDMA devices
  RDMA/mana_ib: Skip firmware commands for invalidated handles

 drivers/infiniband/hw/mana/cq.c               |  44 +++++--
 drivers/infiniband/hw/mana/device.c           | 105 ++++++++++++++++++
 drivers/infiniband/hw/mana/main.c             |  56 +++++++++-
 drivers/infiniband/hw/mana/mana_ib.h          |  19 ++++
 drivers/infiniband/hw/mana/mr.c               |  33 +++++-
 drivers/infiniband/hw/mana/qp.c               |  61 +++++++---
 drivers/infiniband/hw/mana/wq.c               |  24 ++++
 drivers/net/ethernet/microsoft/mana/mana_en.c |  14 ++-
 include/net/mana/gdma.h                       |   6 +
 9 files changed, 331 insertions(+), 31 deletions(-)

-- 
2.43.0

