Return-Path: <linux-hyperv+bounces-8798-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD2mMPIDj2lJHQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8798-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:58:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0381354A4
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 11:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9CC0304EAB5
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Feb 2026 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98A4352921;
	Fri, 13 Feb 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcBX74YW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C2634D3A4;
	Fri, 13 Feb 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770980335; cv=none; b=nCm3hxMCed+HTkjyiyPThSiGoi32MBj0R4nNw9pYzR7ug816EmHK2aYZnfXF+C+WNp002aj0T5+2Abgep/O+cuKjwSsUksC4Ex8EDRQn0TAzuJ2Bw9NWMCoGj2NjfOGzqBlXHbXN3czBibWY5bHVTHVxnIz6rlTK0XVTFq58KJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770980335; c=relaxed/simple;
	bh=TCCJqn0RdlnOIJSaHBSG4qrlkiuN3WnIfd5kcfNuAl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VVBudllQX6xrqOWP6gxkS3CxhKMdXATobQaJfNrTOv/dqY1Ll8kKE8xD66oMzFxOq1yPIjPr4mdeg86dZNC8Kd8KE26iSCgngrCvvbL/0t8yqg5J19QcW5zRjsv78V1Kf4dV6g47CAqeAhSeOoU4aRdsZPHE1yHpomQGDwnQBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcBX74YW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24E3C116C6;
	Fri, 13 Feb 2026 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770980335;
	bh=TCCJqn0RdlnOIJSaHBSG4qrlkiuN3WnIfd5kcfNuAl8=;
	h=From:To:Cc:Subject:Date:From;
	b=NcBX74YW2naBk5C3e+jQ4QV4K/RoEJ8msMQvp3k3fy34EPQgLt2/F65jDsgWLBZOg
	 Mrfix3MO1EaI08R8f1doEz9h9TjI21TbxU1kFNEGfGGSynvjyszKcLaL+Iheyaqjb0
	 Wysjq3F1cQcHpNGdX8FBXh8B/i+BjU8cmIKVxMVSlc6SYWLEjxrgnvDCsBI9moBQEN
	 mP4kdzaNmDWfjRhrw+QkmnRjfffvxn5aXHpx8H5FM5j2pM1AxrdSPhXD9OGANPn+KO
	 aEwkxZI4YXfoUf8l7Pk6rgV6KX0agEu6kB33OTCR5R5TdRPylKn+lJdwXGnN1Ru4aW
	 GeaOStCAqJcgA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH rdma-next 00/50] RDMA: Ensure CQ UMEMs are managed by ib_core
Date: Fri, 13 Feb 2026 12:57:36 +0200
Message-ID: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260203-refactor-umem-e5b4277e41b4
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8798-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C0381354A4
X-Rspamd-Action: no action

Unify CQ UMEM creation, resize and release in ib_core to avoid the need=0D
for complex driver-side handling. This lets us rely on the internal=0D
reference counters of the relevant ib_XXX objects to manage UMEM=0D
lifetime safely and consistently.=0D
=0D
The resize cleanup made it clear that most drivers never handled this=0D
path correctly, and there's a good chance the functionality was never=0D
actually used. The most common issue was relying on the cq->resize_umem=0D
pointer to detect races with other CQ commands, without clearing it on=0D
errors and while ignoring proper locking for other CQ operations.=0D
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
Leon Romanovsky (50):=0D
      RDMA: Move DMA block iterator logic into dedicated files=0D
      RDMA/umem: Allow including ib_umem header from any location=0D
      RDMA/umem: Remove unnecessary includes and defines from ib_umem heade=
r=0D
      RDMA/core: Promote UMEM to a core component=0D
      RDMA/core: Manage CQ umem in core code=0D
      RDMA/efa: Rely on CPU address in create=E2=80=91QP=0D
      RDMA/core: Prepare create CQ path for API unification=0D
      RDMA/core: Reject zero CQE count=0D
      RDMA/efa: Remove check for zero CQE count=0D
      RDMA/mlx5: Save 4 bytes in CQ structure=0D
      RDMA/mlx5: Provide a modern CQ creation interface=0D
      RDMA/mlx4: Inline mlx4_ib_get_cq_umem into callers=0D
      RDMA/mlx4: Introduce a modern CQ creation interface=0D
      RDMA/mlx4: Remove unused create_flags field from CQ structure=0D
      RDMA/bnxt_re: Convert to modern CQ interface=0D
      RDMA/cxgb4: Separate kernel and user CQ creation paths=0D
      RDMA/mthca: Split user and kernel CQ creation paths=0D
      RDMA/erdma: Separate user and kernel CQ creation paths=0D
      RDMA/ionic: Split user and kernel CQ creation paths=0D
      RDMA/qedr: Convert to modern CQ interface=0D
      RDMA/vmw_pvrdma: Provide a modern CQ creation interface=0D
      RDMA/ocrdma: Split user and kernel CQ creation paths=0D
      RDMA/irdma: Split user and kernel CQ creation paths=0D
      RDMA/usnic: Provide a modern CQ creation interface=0D
      RDMA/mana: Provide a modern CQ creation interface=0D
      RDMA/erdma: Separate user and kernel CQ creation paths=0D
      RDMA/rdmavt: Split user and kernel CQ creation paths=0D
      RDMA/siw: Split user and kernel CQ creation paths=0D
      RDMA/rxe: Split user and kernel CQ creation paths=0D
      RDMA/core: Remove legacy CQ creation fallback path=0D
      RDMA/core: Remove unused ib_resize_cq() implementation=0D
      RDMA: Clarify that CQ resize is a user=E2=80=91space verb=0D
      RDMA/bnxt_re: Drop support for resizing kernel CQs=0D
      RDMA/irdma: Remove resize support for kernel CQs=0D
      RDMA/mlx4: Remove support for kernel CQ resize=0D
      RDMA/mlx5: Remove support for resizing kernel CQs=0D
      RDMA/mthca: Remove resize support for kernel CQs=0D
      RDMA/rdmavt: Remove resize support for kernel CQs=0D
      RDMA/rxe: Remove unused kernel=E2=80=91side CQ resize support=0D
      RDMA: Properly propagate the number of CQEs as unsigned int=0D
      RDMA/core: Generalize CQ resize locking=0D
      RDMA/bnxt_re: Complete CQ resize in a single step=0D
      RDMA/bnxt_re: Rely on common resize=E2=80=91CQ locking=0D
      RDMA/bnxt_re: Reduce CQ memory footprint=0D
      RDMA/mlx4: Use generic resize-CQ lock=0D
      RDMA/mlx4: Use on=E2=80=91stack variables instead of storing them in =
the CQ object=0D
      RDMA/mlx5: Use generic resize-CQ lock=0D
      RDMA/mlx5: Select resize=E2=80=91CQ callback based on device capabili=
ties=0D
      RDMA/mlx5: Reduce CQ memory footprint=0D
      RDMA/mthca: Use generic resize-CQ lock=0D
=0D
 drivers/infiniband/core/Makefile                |   6 +-=0D
 drivers/infiniband/core/cq.c                    |   3 +=0D
 drivers/infiniband/core/device.c                |   4 +-=0D
 drivers/infiniband/core/iter.c                  |  43 +++=0D
 drivers/infiniband/core/umem.c                  |   2 +-=0D
 drivers/infiniband/core/uverbs_cmd.c            |  18 +-=0D
 drivers/infiniband/core/uverbs_std_types_cq.c   |  35 ++-=0D
 drivers/infiniband/core/verbs.c                 |  61 +---=0D
 drivers/infiniband/hw/bnxt_re/ib_verbs.c        | 246 ++++++++-------=0D
 drivers/infiniband/hw/bnxt_re/ib_verbs.h        |   9 +-=0D
 drivers/infiniband/hw/bnxt_re/main.c            |   3 +-=0D
 drivers/infiniband/hw/bnxt_re/qplib_res.c       |   2 +-=0D
 drivers/infiniband/hw/cxgb4/cq.c                | 218 +++++++++----=0D
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h          |   2 +=0D
 drivers/infiniband/hw/cxgb4/mem.c               |   2 +-=0D
 drivers/infiniband/hw/cxgb4/provider.c          |   1 +=0D
 drivers/infiniband/hw/efa/efa.h                 |   6 +-=0D
 drivers/infiniband/hw/efa/efa_main.c            |   3 +-=0D
 drivers/infiniband/hw/efa/efa_verbs.c           |  44 ++-=0D
 drivers/infiniband/hw/erdma/erdma_main.c        |   1 +=0D
 drivers/infiniband/hw/erdma/erdma_verbs.c       |  99 ++++--=0D
 drivers/infiniband/hw/erdma/erdma_verbs.h       |   2 +=0D
 drivers/infiniband/hw/hns/hns_roce_alloc.c      |   2 +-=0D
 drivers/infiniband/hw/hns/hns_roce_cq.c         | 103 ++++--=0D
 drivers/infiniband/hw/hns/hns_roce_debugfs.c    |   1 -=0D
 drivers/infiniband/hw/hns/hns_roce_device.h     |   3 +-=0D
 drivers/infiniband/hw/hns/hns_roce_main.c       |   1 +=0D
 drivers/infiniband/hw/ionic/ionic_controlpath.c |  88 ++++--=0D
 drivers/infiniband/hw/ionic/ionic_ibdev.c       |   1 +=0D
 drivers/infiniband/hw/ionic/ionic_ibdev.h       |   4 +-=0D
 drivers/infiniband/hw/irdma/main.h              |   2 +-=0D
 drivers/infiniband/hw/irdma/verbs.c             | 402 +++++++++++++-------=
----=0D
 drivers/infiniband/hw/mana/cq.c                 | 128 +++++---=0D
 drivers/infiniband/hw/mana/device.c             |   1 +=0D
 drivers/infiniband/hw/mana/main.c               |  25 +-=0D
 drivers/infiniband/hw/mana/mana_ib.h            |   6 +-=0D
 drivers/infiniband/hw/mana/qp.c                 |  42 ++-=0D
 drivers/infiniband/hw/mana/wq.c                 |  14 +-=0D
 drivers/infiniband/hw/mlx4/cq.c                 | 401 ++++++++------------=
---=0D
 drivers/infiniband/hw/mlx4/main.c               |   3 +-=0D
 drivers/infiniband/hw/mlx4/mlx4_ib.h            |  10 +-=0D
 drivers/infiniband/hw/mlx4/mr.c                 |   1 +=0D
 drivers/infiniband/hw/mlx5/cq.c                 | 383 ++++++++------------=
--=0D
 drivers/infiniband/hw/mlx5/main.c               |   9 +-=0D
 drivers/infiniband/hw/mlx5/mem.c                |   1 +=0D
 drivers/infiniband/hw/mlx5/mlx5_ib.h            |  12 +-=0D
 drivers/infiniband/hw/mlx5/qp.c                 |   2 +-=0D
 drivers/infiniband/hw/mlx5/umr.c                |   1 +=0D
 drivers/infiniband/hw/mthca/mthca_cq.c          |   1 -=0D
 drivers/infiniband/hw/mthca/mthca_provider.c    | 193 ++++--------=0D
 drivers/infiniband/hw/mthca/mthca_provider.h    |   1 -=0D
 drivers/infiniband/hw/ocrdma/ocrdma_main.c      |   3 +-=0D
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  70 +++--=0D
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     |   6 +-=0D
 drivers/infiniband/hw/qedr/main.c               |   1 +=0D
 drivers/infiniband/hw/qedr/verbs.c              | 325 +++++++++++--------=
=0D
 drivers/infiniband/hw/qedr/verbs.h              |   2 +=0D
 drivers/infiniband/hw/usnic/usnic_ib_main.c     |   2 +-=0D
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |   6 +-=0D
 drivers/infiniband/hw/usnic/usnic_ib_verbs.h    |   4 +-=0D
 drivers/infiniband/hw/vmw_pvrdma/pvrdma.h       |   2 +-=0D
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    | 171 ++++++----=0D
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c  |   1 +=0D
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |   3 +=0D
 drivers/infiniband/sw/rdmavt/cq.c               | 224 +++++++------=0D
 drivers/infiniband/sw/rdmavt/cq.h               |   4 +-=0D
 drivers/infiniband/sw/rdmavt/vt.c               |   3 +-=0D
 drivers/infiniband/sw/rxe/rxe_cq.c              |  31 --=0D
 drivers/infiniband/sw/rxe/rxe_loc.h             |   3 -=0D
 drivers/infiniband/sw/rxe/rxe_verbs.c           | 115 +++----=0D
 drivers/infiniband/sw/siw/siw_main.c            |   1 +=0D
 drivers/infiniband/sw/siw/siw_verbs.c           | 111 +++++--=0D
 drivers/infiniband/sw/siw/siw_verbs.h           |   2 +=0D
 include/rdma/ib_umem.h                          |  36 +--=0D
 include/rdma/ib_verbs.h                         |  67 +---=0D
 include/rdma/iter.h                             |  88 ++++++=0D
 76 files changed, 2085 insertions(+), 1847 deletions(-)=0D
---=0D
base-commit: 42e3aac65c1c9eb36cdee0d8312a326196e0822f=0D
change-id: 20260203-refactor-umem-e5b4277e41b4=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

