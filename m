Return-Path: <linux-hyperv+bounces-10895-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBbCBoSbBmoHlQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10895-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:05:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8845490F9
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 06:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CFA33010513
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 04:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB10328616;
	Fri, 15 May 2026 04:05:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5B42EB10;
	Fri, 15 May 2026 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778817918; cv=none; b=lM948Sj9OxotAXKdqhOfl49n4oVIHkU7tblztZdbxo0s5/2Z8dieeps49uh+NfGJVIYFOKLSw8q8XoXo+zBi2vIzSGD1eS2Ly5Rl6TB4qLpudMsXLCAiB+uojI9OzX7OVTNLXs4oCxQzDHjkLDwZeIEv+BRUUosm/h523Ft3bC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778817918; c=relaxed/simple;
	bh=71RlvkTNOnH3EHLmE8fInH6bP9fIvzC5NoO/qbnu9hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2SLwLE5A+6Qt90b4G6tsCPu9GZe4/V59o3tkC1aTzEsR0WpVL0ra6bxbg5Btk5NtrDUy/7UAsYeNhNXbqTx8Qle24/7nz/tGtKRGcRP3ea4JFTqPDtd2Ybsj7ENcn0vJkQJKZdGddmh+h2TLIr3sb/+wLA0YOkzlrND0aDrM0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 4DA5F20B7166; Thu, 14 May 2026 21:05:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DA5F20B7166
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
Subject: [PATCH net-next v10 0/6] net: mana: Per-vPort EQ and MSI-X interrupt management
Date: Thu, 14 May 2026 21:05:02 -0700
Message-ID: <20260515040508.491748-1-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D8845490F9
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
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	TAGGED_FROM(0.00)[bounces-10895-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.906];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

This series moves EQ ownership from the shared mana_context to per-vPort
mana_port_context, enabling each vPort to have dedicated MSI-X vectors
when the hardware provides enough vectors. When vectors are limited, the
driver falls back to sharing MSI-X among vPorts.

The series introduces a GDMA IRQ Context (GIC) abstraction with reference
counting to manage interrupt context lifecycle. This allows both Ethernet
and RDMA EQs to dynamically acquire dedicated or shared MSI-X vectors at
vPort creation time rather than pre-allocating all vectors at probe time.

This series touches both the net and RDMA MANA drivers and is intended
to go through the net-next tree. The patches are available on a shared
branch for both netdev and RDMA maintainers to review.

The following changes since commit 73d587ae684d176fac9db94173f77d78a794ea4f:

  net: ethtool: fix missing closing paren in rings_reply_size() (2026-05-11 18:42:25 -0700)

are available in the Git repository at:

  https://github.com/longlimsft/linux.git tags/mana-eq-msi-v10

for you to fetch changes up to fb1f61f57f46f9511c64a09aa20a3a94374aebf4:

  RDMA/mana_ib: Allocate interrupt contexts on EQs
to go through the net-next tree. The patches are available on a shared
branch for both netdev and RDMA maintainers to review.

Changes in v10:
- Add channel_changing flag to block RDMA from grabbing the vport
  during mana_set_channels() detach/attach window. The flag is checked
  in mana_cfg_vport() only when called from the RDMA path via a new
  check_channel_changing parameter (patch 1)
- Bind each PD to a single physical port via pd->vport_port to prevent
  cross-port PD sharing which would cause EQ scope mismatch. Returns
  -EINVAL if a second port tries to use an already-bound PD (patch 1)
- Guard gc->msi_sharing reset with pci_msix_can_alloc_dyn() to avoid
  overwriting the non-dyn platform constraint set by
  mana_gd_setup_hwc_irqs() (patch 2)

Changes in v9:
- RSS QPs now take a vport reference via pd->vport_use_count to ensure
  EQs outlive all QP consumers. EQs are only destroyed when the last
  QP (raw or RSS) on the PD releases its reference (patch 1)
- Serialize mana_set_channels() against RDMA vport configuration via
  apc->vport_mutex when the port is down. When the port is up, Ethernet
  owns the vport exclusively so no locking is needed (patch 1)
- Change WARN_ON(apc->eqs) to bail out with -EEXIST to prevent
  leaking prior EQ array if invariant is violated (patch 1)
- Only commit pd->tx_shortform_allowed and pd->tx_vp_offset after
  mana_create_eq() succeeds (patch 1)
- Reset gc->msi_sharing at the top of mana_gd_query_max_resources()
  so it is recomputed from current hardware state on resume (patch 2)
- Fix reverse Christmas tree variable declaration ordering (patches
  1, 3, 5)

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

 drivers/infiniband/hw/mana/main.c             |  83 ++++-
 drivers/infiniband/hw/mana/mana_ib.h          |   8 +
 drivers/infiniband/hw/mana/qp.c               |  37 +-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 326 +++++++++++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 175 ++++++----
 .../ethernet/microsoft/mana/mana_ethtool.c    |  23 +-
 include/net/mana/gdma.h                       |  33 +-
 include/net/mana/mana.h                       |  15 +-
 8 files changed, 520 insertions(+), 180 deletions(-)

-- 
2.43.0

