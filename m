Return-Path: <linux-hyperv+bounces-8859-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMmaDcjQkmm1yQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8859-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 09:09:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B101416FD
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 09:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67C743005767
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E42F4A05;
	Mon, 16 Feb 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJgMczy6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E8291C10;
	Mon, 16 Feb 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771229270; cv=none; b=vGFWU3HfG4m4p3hnc/uOldzaxA2Kw21xElXvjIeMp20Ef+Y4F0u58PVXrrmYP33baa/C/ZvzsG6oZN1a0wtysJwIvtMq/i5enP79JcKArkc/z7hI0bMVPpnMdykXwUhQHLcnlo8Sfy1HAoCPxdDv1kJeBkR5LKwx5ZCB/pUjdfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771229270; c=relaxed/simple;
	bh=kUeipZUCiBC1s95R7DnHcqASgWZS4kGTKoxYiL4yUl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfO+fPSzlXaFXGSG05PcP0i2+54yZU+bnlnCsibeRR9QjiCxuyNYgi9PpH+uweXxNNC6y8mvvW88rmYBVTvGjXT7kDalb4u4M0HoBTofqH8lfhJ31xXY3xKJwqTzrGiOoBVvRv6R6liZB4IQWmcYFiBjW6/3osmRTHKJXn+/iLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJgMczy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7353C116C6;
	Mon, 16 Feb 2026 08:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771229270;
	bh=kUeipZUCiBC1s95R7DnHcqASgWZS4kGTKoxYiL4yUl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJgMczy6sdC/hJJi3kWhYSA0H6vAFECD85YFsag+UoEhpdWVyAkkAveoKpuoRAtHg
	 oIfXJXn6Rf0D34dgqXQg+/s6iFuMxBEkvJF81ju++sePlXtb0ChjSM+/8jw0wCIRbd
	 URgEGYJ94KT+31WhcrZ7G5/qUWirBTebKSyFh5936Ks1WEhdUUmtLIUkLcXmLt23ZY
	 cBz2E7gcxM2vk7uc7OgKz+pc6yJODCPH3WyJ+La30+EYvcr6XAdSl1rxTpXsUVYIlX
	 Vejl7DurnZZ+BXwK5BTVtXTZLV2Qt2f8yh1RNNjKKaIXOWcYMGkDRN09vCNN0z1d8t
	 hUOrDXyDYImGA==
Date: Mon, 16 Feb 2026 10:07:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
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
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a
 single step
Message-ID: <20260216080746.GD12989@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
 <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8859-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7B101416FD
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 09:29:29AM +0530, Selvin Xavier wrote:
> On Fri, Feb 13, 2026 at 4:31 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > There is no need to defer the CQ resize operation, as it is intended to
> > be completed in one pass. The current bnxt_re_resize_cq() implementation
> > does not handle concurrent CQ resize requests, and this will be addressed
> > in the following patches.
> bnxt HW requires that the previous CQ memory be available with the HW until
> HW generates a cut off cqe on the CQ that is being destroyed. This is
> the reason for
> polling the completions in the user library after returning the
> resize_cq call. Once the polling
> thread sees the expected CQE, it will invoke the driver to free CQ
> memory.

This flow is problematic. It requires the kernel to trust a user‑space
application, which is not acceptable. There is no guarantee that the
rdma-core implementation is correct or will invoke the interface properly.
Users can bypass rdma-core entirely and issue ioctls directly (syzkaller,
custom rdma-core variants, etc.), leading to umem leaks, races that overwrite
kernel memory, and access to fields that are now being modified. All of this
can occur silently and without any protections.

> So ib_umem_release should wait. This patch doesn't guarantee that.

The issue is that it was never guaranteed in the first place. It only appeared
to work under very controlled conditions.

> Do you think if there is a better way to handle this requirement?

You should wait for BNXT_RE_WC_TYPE_COFF in the kernel before returning
from resize_cq.

Thanks

> 
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++-----------------------
> >  1 file changed, 9 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > index d652018c19b3..2aecfbbb7eaf 100644
> > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > @@ -3309,20 +3309,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> >         return rc;
> >  }
> >
> > -static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> > -{
> > -       struct bnxt_re_dev *rdev = cq->rdev;
> > -
> > -       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> > -
> > -       cq->qplib_cq.max_wqe = cq->resize_cqe;
> > -       if (cq->resize_umem) {
> > -               ib_umem_release(cq->ib_cq.umem);
> > -               cq->ib_cq.umem = cq->resize_umem;
> > -               cq->resize_umem = NULL;
> > -               cq->resize_cqe = 0;
> > -       }
> > -}
> >
> >  int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
> >                       struct ib_udata *udata)
> > @@ -3387,7 +3373,15 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
> >                 goto fail;
> >         }
> >
> > -       cq->ib_cq.cqe = cq->resize_cqe;
> > +       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> > +
> > +       cq->qplib_cq.max_wqe = cq->resize_cqe;
> > +       ib_umem_release(cq->ib_cq.umem);
> > +       cq->ib_cq.umem = cq->resize_umem;
> > +       cq->resize_umem = NULL;
> > +       cq->resize_cqe = 0;
> > +
> > +       cq->ib_cq.cqe = entries;
> >         atomic_inc(&rdev->stats.res.resize_count);
> >
> >         return 0;
> > @@ -3907,15 +3901,6 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
> >         struct bnxt_re_sqp_entries *sqp_entry = NULL;
> >         unsigned long flags;
> >
> > -       /* User CQ; the only processing we do is to
> > -        * complete any pending CQ resize operation.
> > -        */
> > -       if (cq->ib_cq.umem) {
> > -               if (cq->resize_umem)
> > -                       bnxt_re_resize_cq_complete(cq);
> > -               return 0;
> > -       }
> > -
> >         spin_lock_irqsave(&cq->cq_lock, flags);
> >         budget = min_t(u32, num_entries, cq->max_cql);
> >         num_entries = budget;
> >
> > --
> > 2.52.0
> >



