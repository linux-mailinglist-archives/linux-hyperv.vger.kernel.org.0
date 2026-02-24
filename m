Return-Path: <linux-hyperv+bounces-8968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sApwNJWFnWmVQQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8968-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 12:03:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F46185D50
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 12:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7CDA31D8D0F
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171C37AA82;
	Tue, 24 Feb 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb3JOvJG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB4E555;
	Tue, 24 Feb 2026 10:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771930762; cv=none; b=KpRbBLFyBinwAyorMtQfw4FFFx/kOhVRaiJoMkJ+g+wOj2dH4Ir3s/2Vv4QUeDikGebBWDHUHWiRjDnkUkg030WKTizLZxlYz04Fdm7SrmKfQd9Xci+Twg1ANxSFa7CIAJ3bxQwNTqKKLdhymVQvBuwYNQYOwF1S39Hy7oYoDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771930762; c=relaxed/simple;
	bh=Y3zzVBzpV+EIOPg+RxrfVhGUf1Vmtj7Fn46cUTuZ20s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvwIaDoue3ZJErOkqiVsfqYIzjOYPVaP3Layb/iFSA3B6XzS+TgOF+H3+drfoUiQIxuX7mjaIRPxa0kUtG8gPbvg4c72+Pbht0h1TuzKCLq/2qoL/a4lJBaXI8TRHU9RTQPeatpLcFXIELWb0RZrxijZidLvf97HW+6B07vQpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb3JOvJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604D0C4AF09;
	Tue, 24 Feb 2026 10:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771930762;
	bh=Y3zzVBzpV+EIOPg+RxrfVhGUf1Vmtj7Fn46cUTuZ20s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb3JOvJGxpRciuJmvU/UOFRYjtrxXL6LJS27dawLUCL5Oz3cwU7BNf21QIuUL/8H6
	 CIUj7rhuQk79v/0mpwNgxKU1KkU5IvaaLzUtlqS77SnpEtsl8z/UGgCdxiNHO1jdtZ
	 OGQDclP0rZjfsuyb5g9YF30KrC9gV9sEhkNLXgTVK5gYCv/rqD8tfVDTkgAotnCddy
	 Otg1+0tHny+NyQlcDMvDEM+ZB33jYBB+mCp22bUa5iZSaTG29YWA+gX24cPm+tCmrn
	 NCeG6Lvjcq/+oTCeIOngTPFAz2UwmAZ3k33rRSsbeyMJsNQvv5pJInVfBxUZcbxHVH
	 KwP2cLb5aCalw==
Date: Tue, 24 Feb 2026 12:59:18 +0200
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
Message-ID: <20260224105918.GL10607@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
 <CA+sbYW2QKSbKpoHWMCL_6QnXYVuhx9Los9EMFasWeKCfcqUXsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW2QKSbKpoHWMCL_6QnXYVuhx9Los9EMFasWeKCfcqUXsg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8968-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 41F46185D50
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:45:42PM +0530, Selvin Xavier wrote:
> On Fri, Feb 13, 2026 at 4:31 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > There is no need to defer the CQ resize operation, as it is intended to
> > be completed in one pass. The current bnxt_re_resize_cq() implementation
> > does not handle concurrent CQ resize requests, and this will be addressed
> > in the following patches.
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
> Since this code is removed,  we need to remove  ibv_cmd_poll_cq call
> from the user library.
> For older libraries which still calls ibv_cmd_poll_cq, i think we
> should we keep a check.  Else it will throw a print "POLL CQ : no CQL
> to use". Either we should add the following code or remove this print.
>        if (cq->ib_cq.umem)
>                   return 0;

I'll add the check with extra comment.

> Otherwise, it looks good to me.

Thanks

> 
> Thanks,
> Selvin
> 
> 
> 
> 
> >         spin_lock_irqsave(&cq->cq_lock, flags);
> >         budget = min_t(u32, num_entries, cq->max_cql);
> >         num_entries = budget;
> >
> > --
> > 2.52.0
> >



