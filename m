Return-Path: <linux-hyperv+bounces-11495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zj7AFgUfImrFSgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11495-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 02:57:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5296442B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 02:57:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11495-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11495-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1A53011F17
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 00:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F423D7FF;
	Fri,  5 Jun 2026 00:57:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4010A1C695;
	Fri,  5 Jun 2026 00:57:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621058; cv=none; b=UAI1FRcr1ZmZq736FojMgGpvW3CaedOC3ZYzhsuvuAWJ/FKgYvCSwQ11Z4GR5IP6wWN1VUFXsTjkVvP/szuRpOq860EQ7KiWiXO6PZCKPP0K+11ebPq49h+u+L6Zj/+k3mfynt4JC4ZwSeTGl3clRDvw77Epg1qtRSm9QgFB0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621058; c=relaxed/simple;
	bh=jszyRrYiL96XU6G1BbKnPnxd9Zpxbplb2qCmzqkVUOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgRxvtzaubqfI+CDycgYCgwiBCCJGlQ41dBDAwCup4J/5LEZx8Wu8epFFI8cMDYbtTzZ5n54nAWro8LvJml2/7WNwMuA2cEoWlxixVcTvueCHcsBST7oEIzBY9SVITJhniwA4KcEe0ItB5gQsu13tYDpz2ZmbMLP5PTY/zgpWyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 1677A20B7169; Thu,  4 Jun 2026 17:57:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1677A20B7169
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
Subject: [PATCH net-next v12 0/6] net: mana: Per-vPort EQ and MSI-X management
Date: Thu,  4 Jun 2026 17:57:09 -0700
Message-ID: <20260605005717.2059954-1-longli@microsoft.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11495-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: AD5296442B9

This series moves EQ ownership from the shared mana_context to per-vPort
mana_port_context, enabling each vPort to have dedicated MSI-X vectors
when the hardware provides enough vectors. When vectors are limited, the
driver falls back to sharing MSI-X among vPorts.

The series introduces a GDMA IRQ Context (GIC) abstraction with reference
counting to manage interrupt context lifecycle. This allows both Ethernet
and RDMA EQs to dynamically acquire dedicated or shared MSI-X vectors at
vPort creation time rather than pre-allocating all vectors at probe time.

This series is intended to go through the net-next tree.

The following changes since commit 93790c374b9d77f3db15786d7d432872d92751cf:

  net/mlx5: convert miss_list allocation to kvmalloc_array() (2026-06-04 09:33:24 -0700)

are available in the Git repository at:

  https://github.com/longlimsft/linux.git tags/mana-eq-msi-v12

for you to fetch changes up to 18505b11dcf052442cdeba5e208a85219776206a:

  RDMA/mana_ib: Allocate interrupt contexts on EQs (2026-06-05 00:26:56 +0000)

Changes in v12:
- Restrict each vport to a single RSS QP. The hardware only supports
  one steering config per vport, and destroy disables RX globally.
  Previously a second RSS QP would silently overwrite the first.
  Track via pd->has_rss_qp under vport_mutex (patch 1)
- Validate comp_vector against per-vPort EQ count with modulo mapping.
  Document the rationale: when RDMA-advertised num_comp_vectors exceeds
  the port's num_queues, the vector is remapped to an available EQ
  rather than failing QP creation (patch 1)
- Extend channel_changing serialization to the async per-port queue
  reset handler, preventing RDMA from claiming the vport during
  the reset detach/attach window (patch 1)
- Fix HW vport registration leak: roll back
  mana_pf_register_hw_vport() when mana_cfg_vport() fails in
  mana_create_vport() (patch 1)
- Cap num_ports to MAX_PORTS_IN_MANA_DEV before the per-vPort MSI-X
  budget calculation so it matches the port count that is later
  instantiated by mana_probe() (patch 2)
- Use a local msi variable in mana_gd_setup_irqs() and
  mana_gd_setup_dyn_irqs() to decouple the loop counter from
  the callee-updated mana_gd_get_gic() parameter (patch 4)
- Add WARN_ON(!xa_empty()) assertion in mana_gd_remove_irqs()
  before pci_free_irq_vectors() to catch leaked GIC references
  (patch 4)
- Log gc->max_num_queues_vport (per-vPort value) instead of
  gc->max_num_queues (global) in the MSI sharing mode message,
  use %u format specifiers (patch 2)
- Clarify comment about MANA_DEF_NUM_QUEUES clamping vs hardware
  max precedence (patch 2)
- Rebase onto net-next/main (2026-06-04)

Changes in v11:
- Address AI reviewer feedback from Paolo on patch 1: add cross-port
  PD-sharing check in mana_ib_create_qp_rss() to match the guard
  already present in mana_ib_cfg_vport(), preventing NULL deref on
  mpc->eqs when an RSS QP is created on a different port than the
  PD's bound port (patch 1)
- Document that pd->vport_port is only valid when vport_use_count > 0
  in the struct mana_ib_pd comment, as suggested by the AI reviewer
  (patch 1)
- Propagate actual error code from mana_ib_cfg_vport() instead of
  hardcoding -ENODEV in the raw QP creation path (patch 1)
- Switch mana_gd_get_gic() from returning NULL to IS_ERR/PTR_ERR on
  failure so callers can propagate the actual error code (-ENOSPC,
  -ENOMEM, etc.) instead of always returning -ENOMEM (patch 3)
- Update all mana_gd_get_gic() callers (patches 2, 4, 5, 6) to use
  IS_ERR()/PTR_ERR() error checking
- Set *msi_requested after pci_msix_alloc_irq_at() returns the actual
  assigned index, so the caller gets the correct MSI vector when
  dynamic allocation remaps it (patch 3)
- Add comments documenting the GIC refcount ownership contract in
  mana_gd_register_irq() and mana_gd_deregister_irq() (patch 5)
- Move the zero-port detection error message from mana_probe() to
  mana_gd_query_max_resources() where the actual check occurs (patch 2)
- Clamp apc->max_queues to gc->max_num_queues_vport in
  mana_init_port() so that on resume, if max_num_queues_vport has
  decreased, num_queues is reduced before EQ allocation (patch 2)

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

 drivers/infiniband/hw/mana/main.c             |  83 +++-
 drivers/infiniband/hw/mana/mana_ib.h          |  14 +
 drivers/infiniband/hw/mana/qp.c               |  68 +++-
 .../net/ethernet/microsoft/mana/gdma_main.c   | 359 +++++++++++++-----
 drivers/net/ethernet/microsoft/mana/mana_en.c | 198 ++++++----
 .../ethernet/microsoft/mana/mana_ethtool.c    |  23 +-
 include/net/mana/gdma.h                       |  33 +-
 include/net/mana/mana.h                       |  15 +-
 8 files changed, 604 insertions(+), 189 deletions(-)


base-commit: 93790c374b9d77f3db15786d7d432872d92751cf
-- 
2.43.0


