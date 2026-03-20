Return-Path: <linux-hyperv+bounces-9670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEVAGzvevWk1DAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9670-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:54:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E92E258B
	for <lists+linux-hyperv@lfdr.de>; Sat, 21 Mar 2026 00:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B083018AF1
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD73A8738;
	Fri, 20 Mar 2026 23:54:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D953A7F57;
	Fri, 20 Mar 2026 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774050872; cv=none; b=Bi2FJNAdPU4DnrXSCmJwJIa6trBKh8NXu+J1VPpTe3VNigVz6afFaVFM5/jqkHWWz18XW7fy9GQkSbPpLyKM0ieiHxfnxVcl1ylw16PDju/+sUIDyyCMssqwAVRHbWXnTLqodIeFCx6XLVyatFoI205R0rBvmLAdatIuL5JOOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774050872; c=relaxed/simple;
	bh=2vTo0YRF/YNAnCuxFaXllF21g50Np+nFXnkqq61p8MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmDo9y7aFhAuuNKWgSvncir27yJNqx8qW/vd2bz6v2SPz6LiAj4TBeuk7JN2cbQ0F7WhYjhcerBAx/JvkXBW8e6NX8nYBV+orD1uCgH6TzZn9dDm7HQudGQ3CV66c2G3k3mEBoFWiOK/bNwj2eqTNLZTlpKFNXBMN4qYHdS/K+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 4810920B6F01; Fri, 20 Mar 2026 16:54:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4810920B6F01
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
Subject: [PATCH net-next v4 0/6] net: mana: Per-vPort EQ and MSI-X interrupt management
Date: Fri, 20 Mar 2026 16:54:13 -0700
Message-ID: <cover.1774049761.git.longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9670-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C40E92E258B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds per-vPort Event Queue (EQ) allocation and MSI-X interrupt
management for the MANA driver. Previously, all vPorts shared a single set
of EQs. This change enables dedicated EQs per vPort with support for both
dedicated and shared MSI-X vector allocation modes.

Patch 1 moves EQ ownership from mana_context to per-vPort mana_port_context
and exports create/destroy functions for the RDMA driver.

Patch 2 adds device capability queries to determine whether MSI-X vectors
should be dedicated per-vPort or shared. When the number of available MSI-X
vectors is insufficient for dedicated allocation, the driver enables sharing
mode with bitmap-based vector assignment.

Patch 3 introduces the GIC (GDMA IRQ Context) abstraction with reference
counting, allowing multiple EQs to safely share a single MSI-X vector.

Patch 4 converts the global EQ allocation in probe/resume to use the new
GIC functions.

Patch 5 adds per-vPort GIC lifecycle management, calling get/put on each
EQ creation and destruction during vPort open/close.

Patch 6 extends the same GIC lifecycle management to the RDMA driver's EQ
allocation path.

Changes in v4:
- Rebased on net-next/main 7.0-rc4
- Patch 2: Use MANA_DEF_NUM_QUEUES instead of hardcoded 16 for
  max_num_queues clamping
- Patch 3: Track dyn_msix in GIC context instead of re-checking
  pci_msix_can_alloc_dyn() on each call; improved remove_irqs iteration
  to skip unallocated entries

Changes in v3:
- Rebased on net-next/main
- Patch 1: Added NULL check for mpc->eqs in mana_ib_create_qp_rss() to
  prevent NULL pointer dereference when RSS QP is created before a raw QP
  has configured the vport and allocated EQs

Changes in v2:
- Rebased on net-next/main (adapted to kzalloc_objs/kzalloc_obj macros,
  new GDMA_DRV_CAP_FLAG definitions)
- Patch 2: Fixed misleading comment for max_num_queues vs
  max_num_queues_vport in gdma.h
- Patch 3: Fixed spelling typo in gdma_main.c ("difference" -> "different")

Long Li (6):
  net: mana: Create separate EQs for each vPort
  net: mana: Query device capabilities and configure MSI-X sharing for
    EQs
  net: mana: Introduce GIC context with refcounting for interrupt
    management
  net: mana: Use GIC functions to allocate global EQs
  net: mana: Allocate interrupt context for each EQ when creating vPort
  RDMA/mana_ib: Allocate interrupt contexts on EQs

 drivers/infiniband/hw/mana/main.c             |  47 ++-
 drivers/infiniband/hw/mana/qp.c               |  16 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 307 +++++++++++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 162 +++++----
 include/net/mana/gdma.h                       |  32 +-
 include/net/mana/mana.h                       |   7 +-
 6 files changed, 416 insertions(+), 155 deletions(-)

-- 
2.43.0


