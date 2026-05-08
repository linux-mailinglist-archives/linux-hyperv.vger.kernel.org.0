Return-Path: <linux-hyperv+bounces-10723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNuTMxRg/mnhpwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10723-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:13:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECE34FC38A
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AD5F30151D8
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 22:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98533451AB;
	Fri,  8 May 2026 22:12:19 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918733121F;
	Fri,  8 May 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278339; cv=none; b=Hq5X53ifAtr1ky9Zp9JeX3/+SmK19Nl0LXZJF3M4nORaS+kiwC7Pel+FT/ueieI2GtLKV6dQbvGCGYb6a4OCkXvn81MWNUv1UYdj0QFhsPGtyQ+iQkYXRzC/ZUJKibEAdfFHX+qrjzogOJXXHbvJzjdy8Xaa7XLjCNP+2Us4Qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278339; c=relaxed/simple;
	bh=rWXn8kZoCAfuI+9t6avOlyzcNEoHjXZd4IWN+0mlLlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h15iYq/6sXn9/0nJpMvfGQcijBvlqamLLj3KZahhlI9cX0B/lExiRpNQGc6q6XBCrR/d8uHtgN9GAJlL6GoUovf5cntE8sedveIuqvYeDpwTAXg6TWbk+hiI4ivVx6i4OuEQ92WzuV+8ksk0SLS9o0nhnZi42W6Q6JNefKkjOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 14BED20B7168; Fri,  8 May 2026 15:12:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14BED20B7168
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
	shradhagupta@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 0/6] net: mana: Per-vPort EQ and MSI-X interrupt management
Date: Fri,  8 May 2026 15:11:56 -0700
Message-ID: <20260508221202.15725-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ECE34FC38A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-10723-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.509];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This series moves EQ ownership from the shared mana_context to per-vPort
mana_port_context, enabling each vPort to have dedicated MSI-X vectors
when the hardware provides enough vectors. When vectors are limited, the
driver falls back to sharing MSI-X among vPorts.

The series introduces a GDMA IRQ Context (GIC) abstraction with reference
counting to manage interrupt context lifecycle. This allows both Ethernet
and RDMA EQs to dynamically acquire dedicated or shared MSI-X vectors at
vPort creation time rather than pre-allocating all vectors at probe time.

Key changes:
- Per-vPort EQ allocation with exported lifecycle functions for RDMA use
- Device capability query to determine dedicated vs shared MSI-X mode
- GIC context with refcounting for flexible interrupt management
- On-demand interrupt context allocation when creating vPort EQs
- RDMA EQ integration with the GIC framework

Changes in v8:
- Fix comment to reference per-vPort queue count instead of
  gc->max_num_queues (patch 2)
- Remove duplicate irq_update_affinity_hint() calls from error paths
  and mana_gd_remove_irqs(); the clearing is now centralized in
  mana_gd_put_gic() (patch 4)
- Note the IRQ name change (mana_q -> mana_msi) in the commit
  message (patch 4)
- Remove dead conditional write to spec.eq.msix_index (patch 5)
- Document GIC ownership contract and msix_index invariant change
  in commit message (patch 5)
- Populate eq.irq on RDMA EQs for consistency with the Ethernet
  path (patch 6)
- Document BIT(6) relocation and capability flag semantics in
  commit message (patch 6)
- Fix checkpatch --strict alignment and line length warnings

Changes in v7:
- Use rounddown_pow_of_two() instead of roundup_pow_of_two() when
  computing per-vPort queue count to avoid unnecessarily forcing shared
  MSI-X mode (patch 2)
- Call mana_gd_setup_remaining_irqs() unconditionally to ensure
  irq_contexts are populated in both dedicated and shared MSI-X modes,
  fixing bisectability between patches 2 and 5 (patch 2)
- Guard ibdev_dbg() in mana_ib_cfg_vport() with error check so the
  vport handle is not logged on the failure path (patch 1)
- Use cached gic->irq instead of pci_irq_vector() lookup in
  mana_gd_put_gic() for consistency with the allocation path (patch 3)
- Fix unsigned int* to int* pointer type mismatch when calling
  mana_gd_get_gic() by using a local int variable for the MSI index
  (patches 5, 6)

Changes in v6:
- Rebased on net-next/main (v7.1-rc1)

Changes in v5:
- Rebased on net-next/main

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

 drivers/infiniband/hw/mana/main.c             |  62 +++-
 drivers/infiniband/hw/mana/qp.c               |  16 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 316 +++++++++++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 169 ++++++----
 include/net/mana/gdma.h                       |  33 +-
 include/net/mana/mana.h                       |   7 +-
 6 files changed, 434 insertions(+), 169 deletions(-)

-- 
2.43.0

