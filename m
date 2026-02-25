Return-Path: <linux-hyperv+bounces-8986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGqKO9v+nmlAYgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8986-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 14:53:31 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 975A2198658
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 14:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2C2A30364E8
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CB392823;
	Wed, 25 Feb 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGdvAInU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4812326D5E;
	Wed, 25 Feb 2026 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027603; cv=none; b=pf80HsYpBDMeIomUZQ5jwgFEs9t9LCT10SSqgl95kRpqSt2rZoyU1BkUhMtnQvxg/xkMIMbpsQiuLUgAw0GFQIKJCFDIBWy3/wCGt4VKauTy4jZQBiRR7QjrEeZv6zvio/v1ntbPDB+gtu4JqZEZVfJj5/toFEYGsTEopS01CfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027603; c=relaxed/simple;
	bh=0/VLSDH+aLenvDTz2iQpW4+XTdWSmHCGUCVsbDzgtFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDYsBZKi8JnsCdjPHf7rFc4PFxEjbZy8+9p7+/Xw+6vrP6CuTCH48TXPHeEbLtVMkKtgtoISpOPwKm6E6KHJA4XzZykOMe5GszqXRZx4cDJ/36CfYGB38JB03oJRU9iBmeyN1wOKDZEQun+ZgBf5Na7Np+7k/wHR5G3vUNf7JHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGdvAInU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94971C116D0;
	Wed, 25 Feb 2026 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027603;
	bh=0/VLSDH+aLenvDTz2iQpW4+XTdWSmHCGUCVsbDzgtFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LGdvAInUWeTjKGBlQ43IRwm+nDhUkCTSbWLhM6tZ5yLBp0aN/ofIUv936Pap13IER
	 Y6i06yZYn117e9hkUMLvbh1CVk5Sl5hON36Y+gKMNMqubBz3Pjb8cCcex40jd+tskE
	 aHw+Mog5YKR5Kv+V9Be2nUmbjWhqkRdCZevhjeQDqEerDJ9hJzHXSZ78VzF+uHmJDL
	 6jl8QTdW/QAgLN57/RNRMs105OGUokK5il/Fa8Va/lJllZpQkAwEAGO2Wc4ObRvmOa
	 NjvvM4Gwd/AHuKU+ORgCbv8ZEj2gFQUwvxHSkPBgXBmfFZ4PnzbhvHT2XlRKTI8xJP
	 2mmc+PRcgMQEA==
Date: Wed, 25 Feb 2026 15:53:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
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
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH rdma-next 00/50] RDMA: Ensure CQ UMEMs are managed by
 ib_core
Message-ID: <20260225135320.GF9541@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8986-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 975A2198658
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:57:36PM +0200, Leon Romanovsky wrote:
> Unify CQ UMEM creation, resize and release in ib_core to avoid the need
> for complex driver-side handling. This lets us rely on the internal
> reference counters of the relevant ib_XXX objects to manage UMEM
> lifetime safely and consistently.
> 
> The resize cleanup made it clear that most drivers never handled this
> path correctly, and there's a good chance the functionality was never
> actually used. The most common issue was relying on the cq->resize_umem
> pointer to detect races with other CQ commands, without clearing it on
> errors and while ignoring proper locking for other CQ operations.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Leon Romanovsky (50):
>       RDMA: Move DMA block iterator logic into dedicated files
>       RDMA/umem: Allow including ib_umem header from any location
>       RDMA/umem: Remove unnecessary includes and defines from ib_umem header
>       RDMA/core: Promote UMEM to a core component
>       RDMA/core: Manage CQ umem in core code
>       RDMA/efa: Rely on CPU address in create‑QP
>       RDMA/core: Prepare create CQ path for API unification
>       RDMA/core: Reject zero CQE count
>       RDMA/efa: Remove check for zero CQE count
>       RDMA/mlx5: Save 4 bytes in CQ structure
>       RDMA/mlx5: Provide a modern CQ creation interface
>       RDMA/mlx4: Inline mlx4_ib_get_cq_umem into callers
>       RDMA/mlx4: Introduce a modern CQ creation interface
>       RDMA/mlx4: Remove unused create_flags field from CQ structure

I took 14 patches above, rest will need to be resubmitted.

Thanks

>       RDMA/bnxt_re: Convert to modern CQ interface
>       RDMA/cxgb4: Separate kernel and user CQ creation paths
>       RDMA/mthca: Split user and kernel CQ creation paths
>       RDMA/erdma: Separate user and kernel CQ creation paths
>       RDMA/ionic: Split user and kernel CQ creation paths
>       RDMA/qedr: Convert to modern CQ interface
>       RDMA/vmw_pvrdma: Provide a modern CQ creation interface
>       RDMA/ocrdma: Split user and kernel CQ creation paths
>       RDMA/irdma: Split user and kernel CQ creation paths
>       RDMA/usnic: Provide a modern CQ creation interface
>       RDMA/mana: Provide a modern CQ creation interface
>       RDMA/erdma: Separate user and kernel CQ creation paths
>       RDMA/rdmavt: Split user and kernel CQ creation paths
>       RDMA/siw: Split user and kernel CQ creation paths
>       RDMA/rxe: Split user and kernel CQ creation paths
>       RDMA/core: Remove legacy CQ creation fallback path
>       RDMA/core: Remove unused ib_resize_cq() implementation
>       RDMA: Clarify that CQ resize is a user‑space verb
>       RDMA/bnxt_re: Drop support for resizing kernel CQs
>       RDMA/irdma: Remove resize support for kernel CQs
>       RDMA/mlx4: Remove support for kernel CQ resize
>       RDMA/mlx5: Remove support for resizing kernel CQs
>       RDMA/mthca: Remove resize support for kernel CQs
>       RDMA/rdmavt: Remove resize support for kernel CQs
>       RDMA/rxe: Remove unused kernel‑side CQ resize support
>       RDMA: Properly propagate the number of CQEs as unsigned int
>       RDMA/core: Generalize CQ resize locking
>       RDMA/bnxt_re: Complete CQ resize in a single step
>       RDMA/bnxt_re: Rely on common resize‑CQ locking
>       RDMA/bnxt_re: Reduce CQ memory footprint
>       RDMA/mlx4: Use generic resize-CQ lock
>       RDMA/mlx4: Use on‑stack variables instead of storing them in the CQ object
>       RDMA/mlx5: Use generic resize-CQ lock
>       RDMA/mlx5: Select resize‑CQ callback based on device capabilities
>       RDMA/mlx5: Reduce CQ memory footprint
>       RDMA/mthca: Use generic resize-CQ lock
> 
>  drivers/infiniband/core/Makefile                |   6 +-
>  drivers/infiniband/core/cq.c                    |   3 +
>  drivers/infiniband/core/device.c                |   4 +-
>  drivers/infiniband/core/iter.c                  |  43 +++
>  drivers/infiniband/core/umem.c                  |   2 +-
>  drivers/infiniband/core/uverbs_cmd.c            |  18 +-
>  drivers/infiniband/core/uverbs_std_types_cq.c   |  35 ++-
>  drivers/infiniband/core/verbs.c                 |  61 +---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c        | 246 ++++++++-------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h        |   9 +-
>  drivers/infiniband/hw/bnxt_re/main.c            |   3 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.c       |   2 +-
>  drivers/infiniband/hw/cxgb4/cq.c                | 218 +++++++++----
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h          |   2 +
>  drivers/infiniband/hw/cxgb4/mem.c               |   2 +-
>  drivers/infiniband/hw/cxgb4/provider.c          |   1 +
>  drivers/infiniband/hw/efa/efa.h                 |   6 +-
>  drivers/infiniband/hw/efa/efa_main.c            |   3 +-
>  drivers/infiniband/hw/efa/efa_verbs.c           |  44 ++-
>  drivers/infiniband/hw/erdma/erdma_main.c        |   1 +
>  drivers/infiniband/hw/erdma/erdma_verbs.c       |  99 ++++--
>  drivers/infiniband/hw/erdma/erdma_verbs.h       |   2 +
>  drivers/infiniband/hw/hns/hns_roce_alloc.c      |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_cq.c         | 103 ++++--
>  drivers/infiniband/hw/hns/hns_roce_debugfs.c    |   1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h     |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c       |   1 +
>  drivers/infiniband/hw/ionic/ionic_controlpath.c |  88 ++++--
>  drivers/infiniband/hw/ionic/ionic_ibdev.c       |   1 +
>  drivers/infiniband/hw/ionic/ionic_ibdev.h       |   4 +-
>  drivers/infiniband/hw/irdma/main.h              |   2 +-
>  drivers/infiniband/hw/irdma/verbs.c             | 402 +++++++++++++-----------
>  drivers/infiniband/hw/mana/cq.c                 | 128 +++++---
>  drivers/infiniband/hw/mana/device.c             |   1 +
>  drivers/infiniband/hw/mana/main.c               |  25 +-
>  drivers/infiniband/hw/mana/mana_ib.h            |   6 +-
>  drivers/infiniband/hw/mana/qp.c                 |  42 ++-
>  drivers/infiniband/hw/mana/wq.c                 |  14 +-
>  drivers/infiniband/hw/mlx4/cq.c                 | 401 ++++++++---------------
>  drivers/infiniband/hw/mlx4/main.c               |   3 +-
>  drivers/infiniband/hw/mlx4/mlx4_ib.h            |  10 +-
>  drivers/infiniband/hw/mlx4/mr.c                 |   1 +
>  drivers/infiniband/hw/mlx5/cq.c                 | 383 ++++++++--------------
>  drivers/infiniband/hw/mlx5/main.c               |   9 +-
>  drivers/infiniband/hw/mlx5/mem.c                |   1 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h            |  12 +-
>  drivers/infiniband/hw/mlx5/qp.c                 |   2 +-
>  drivers/infiniband/hw/mlx5/umr.c                |   1 +
>  drivers/infiniband/hw/mthca/mthca_cq.c          |   1 -
>  drivers/infiniband/hw/mthca/mthca_provider.c    | 193 ++++--------
>  drivers/infiniband/hw/mthca/mthca_provider.h    |   1 -
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c      |   3 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  70 +++--
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.h     |   6 +-
>  drivers/infiniband/hw/qedr/main.c               |   1 +
>  drivers/infiniband/hw/qedr/verbs.c              | 325 +++++++++++--------
>  drivers/infiniband/hw/qedr/verbs.h              |   2 +
>  drivers/infiniband/hw/usnic/usnic_ib_main.c     |   2 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |   6 +-
>  drivers/infiniband/hw/usnic/usnic_ib_verbs.h    |   4 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma.h       |   2 +-
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c    | 171 ++++++----
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c  |   1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h |   3 +
>  drivers/infiniband/sw/rdmavt/cq.c               | 224 +++++++------
>  drivers/infiniband/sw/rdmavt/cq.h               |   4 +-
>  drivers/infiniband/sw/rdmavt/vt.c               |   3 +-
>  drivers/infiniband/sw/rxe/rxe_cq.c              |  31 --
>  drivers/infiniband/sw/rxe/rxe_loc.h             |   3 -
>  drivers/infiniband/sw/rxe/rxe_verbs.c           | 115 +++----
>  drivers/infiniband/sw/siw/siw_main.c            |   1 +
>  drivers/infiniband/sw/siw/siw_verbs.c           | 111 +++++--
>  drivers/infiniband/sw/siw/siw_verbs.h           |   2 +
>  include/rdma/ib_umem.h                          |  36 +--
>  include/rdma/ib_verbs.h                         |  67 +---
>  include/rdma/iter.h                             |  88 ++++++
>  76 files changed, 2085 insertions(+), 1847 deletions(-)
> ---
> base-commit: 42e3aac65c1c9eb36cdee0d8312a326196e0822f
> change-id: 20260203-refactor-umem-e5b4277e41b4
> 
> Best regards,
> --  
> Leon Romanovsky <leonro@nvidia.com>
> 

