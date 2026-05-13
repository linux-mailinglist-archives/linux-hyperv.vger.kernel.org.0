Return-Path: <linux-hyperv+bounces-10815-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPq9LCrsA2ruAgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10815-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:12:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B070B52CAA4
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3AEB300F2A3
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 03:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC92391833;
	Wed, 13 May 2026 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+jTlNDf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEF3314D9
	for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778641957; cv=none; b=SRc0sCS41gbW6n9BX9UZ/wWngZPEm7J/WEtqhdi2fsKglmZbG5FKWp12sna9mj+yEY7CMRKVrARuBHiPRNdPasLea2JEedW0kSygmCacvAnXOlCziZRD+DuIEF36F5BWgcPbf47t7KUJSE0usuLg60fdQYsH6Dp1nvPVsTrN2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778641957; c=relaxed/simple;
	bh=U/xsNA7hZRzARIiBox+NjSuM/YYCWZTsEtuGtaOQDNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AzeXmBzrGt4X6Il1FB1I7hT+eFsVG1qAa/5exkK/ApYJ/H6inqVKwBNJVm983d1r46j2uGdArQArZbT5p6WTjs0ms93mvI2Rmg3m2G5bXGxu9w453nKDuw4kKdb28XgYGHIgWAQR8+TqITWpL8muuMrL+wxmuzWEJmC6IPaE23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+jTlNDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4280DC2BCB0;
	Wed, 13 May 2026 03:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778641957;
	bh=U/xsNA7hZRzARIiBox+NjSuM/YYCWZTsEtuGtaOQDNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k+jTlNDfULI2CrGfnSNjwufRJrDEUhkfg+xVF3Rfxn+FGNCShrCw1Avo08hIv5083
	 X2eClDdd0hRRXD4RGtRLMSIjV2Rfeukjsp1iJGrOnB0E7qBOjuBx4NzXcRslqvv7JV
	 Lg7iO/5Yj0JKi2lAmrpLK4PB1dhzSgHcljb4vZuLeIccPCqfgUhhVEkTFvPaTlkvNl
	 SRPnobILJ7BWeoy6dU3HKkJNOjPjLUvGESNRJp+BS0BTM2TCxDQfrti1pYKmw19oeK
	 Q3bat8yaazIwJW1yXFHJr6XkWcuF1iG/63ugB/E004X+LFrLjAu/vlv9H0reQ1ru43
	 0Qx3fkOs5nGeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] IB/rdmavt: Don't abuse udata and
 ib_respond_udata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <2-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References: <2-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:12:36 +0000
Message-Id: <20260513031237.4280DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B070B52CAA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10815-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,ziepe.ca:email]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] TOCTOU heap buffer overflow due to unvalidated `num_sge` from =
user-shared memory.
- [High] Memory leak of the kernel queue structure (`srq->rq.kwq`) on user-=
backed SRQ modifications.
- [High] Locking imbalance and freeing memory while locked.
- [High] Inconsistent state and Use-After-Free on error path.
- [Low] Uninitialized variable compiler warning for `offset_addr`.
--

commit dac7699d9e58c179b3a8859ac64da79e5fd21f46
Author: Jason Gunthorpe <jgg@ziepe.ca>
Subject: IB/rdmavt: Don't abuse udata and ib_respond_udata()

This commit modifies rvt_modify_srq to use copy_to_user directly instead
of ib_copy_to_udata for returning the offset address.

> diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/r=
dmavt/srq.c
> index fe125bf85b272..d022aa56c5bfd 100644
> --- a/drivers/infiniband/sw/rdmavt/srq.c
> +++ b/drivers/infiniband/sw/rdmavt/srq.c
> @@ -128,6 +128,7 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_sr=
q_attr *attr,
>  	struct rvt_srq *srq =3D ibsrq_to_rvtsrq(ibsrq);
>  	struct rvt_dev_info *dev =3D ib_to_rvt(ibsrq->device);
>  	struct rvt_rq tmp_rq =3D {};
> +	__u64 offset_addr;
>  	int ret =3D 0;
> =20
>  	if (attr_mask & IB_SRQ_MAX_WR) {

Could hoisting offset_addr lead to a compiler warning for being potentially
uninitialized?

The compiler might assume udata->inlen could change concurrently across the
spin_lock_irq() and spin_unlock_irq() calls. If the first check fails
but the second one passes:

if (udata && udata->inlen >=3D sizeof(__u64))

Does this allow offset_addr to be used without initialization?

[ ... ]

> @@ -149,19 +150,17 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_=
srq_attr *attr,
>  			return -ENOMEM;
>  		/* Check that we can write the offset to mmap. */
>  		if (udata && udata->inlen >=3D sizeof(__u64)) {
> -			__u64 offset_addr;
>  			__u64 offset =3D 0;
> =20
>  			ret =3D ib_copy_from_udata(&offset_addr, udata,
>  						 sizeof(offset_addr));
>  			if (ret)
>  				goto bail_free;
> -			udata->outbuf =3D (void __user *)
> -					(unsigned long)offset_addr;
> -			ret =3D ib_copy_to_udata(udata, &offset,
> -					       sizeof(offset));
> -			if (ret)
> +			if (copy_to_user(u64_to_user_ptr(offset_addr), &offset,
> +					 sizeof(offset))) {
> +				ret =3D -EFAULT;
>  				goto bail_free;
> +			}
>  		}
> =20
>  		spin_lock_irq(&srq->rq.kwq->c_lock);

Can this code leak the kernel queue structure?

When resizing a user-backed SRQ, the code fetches elements from the old
user-mapped queue. In the udata path, okwq is left as NULL:

if (udata) {
        owq =3D srq->rq.wq;
        head =3D RDMA_READ_UAPI_ATOMIC(owq->head);
        tail =3D RDMA_READ_UAPI_ATOMIC(owq->tail);
} else {
        okwq =3D srq->rq.kwq;
        ...

When it later calls kvfree(okwq), it seems nothing is freed, which could
permanently leak the old kwq structure.

Is there a lock imbalance here when the queue is replaced?

The original queue is locked with:

spin_lock_irq(&srq->rq.kwq->c_lock);

But then the queue pointer is replaced:

srq->rq.kwq =3D tmp_rq.kwq;

When the lock is released:

spin_unlock_irq(&srq->rq.kwq->c_lock);

Does this unlock the new queue instead of the old one, and then free the old
queue via kvfree(okwq) while its lock is still held?

Can the loop migrating WQEs overflow the destination buffer?

The number of scatter-gather elements is read directly from user-shared
memory:

wqe =3D rvt_get_rwqe_ptr(&srq->rq, tail);
p->wr_id =3D wqe->wr_id;
p->num_sge =3D wqe->num_sge;
for (i =3D 0; i < wqe->num_sge; i++)
        p->sg_list[i] =3D wqe->sg_list[i];

If a userspace program concurrently modifies num_sge to a large value, could
this loop exceed the bounds of tmp_rq.kwq->curr_wq, since the destination
size was calculated based on srq->rq.max_sge?

[ ... ]

> @@ -236,10 +235,10 @@ int rvt_modify_srq(struct ib_srq *ibsrq, struct ib_=
srq_attr *attr,
>  			 * See rvt_mmap() for details.
>  			 */
>  			if (udata && udata->inlen >=3D sizeof(__u64)) {
> -				ret =3D ib_copy_to_udata(udata, &ip->offset,
> -						       sizeof(ip->offset));
> -				if (ret)
> -					return ret;
> +				if (copy_to_user(u64_to_user_ptr(offset_addr),
> +						 &ip->offset,
> +						 sizeof(ip->offset)))
> +					return -EFAULT;
>  			}
> =20

Does returning -EFAULT here leave the kernel and userspace in an inconsiste=
nt
state?

At this point, the kernel has already applied the SRQ size change, replaced
the queue, and permanently freed the old memory:

vfree(owq);
kvfree(okwq);

If copy_to_user fails and returns -EFAULT, userspace might interpret this as
a failed resize and continue using its existing memory mapping of the old
queue. Could this lead to a use-after-free since the pages have already
been freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v3-4effdebad75a+e=
1-rdma_udata_rep_jgg@nvidia.com?part=3D2

