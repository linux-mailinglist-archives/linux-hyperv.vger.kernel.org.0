Return-Path: <linux-hyperv+bounces-11955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6oQmKzOjVGpyogMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11955-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:34:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D080748C14
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 10:34:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WFQb8AGb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11955-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11955-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B3B3031800
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 08:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC963AD52B;
	Mon, 13 Jul 2026 08:28:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891CC3AD524
	for <linux-hyperv@vger.kernel.org>; Mon, 13 Jul 2026 08:28:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931289; cv=none; b=emKKncL13B7xOyvgMYHcqs0et4aAML0TyNU4Mls+0uGtB/MMRmhHvgguXOIrD9LaGdSw8c3lMRFoq/fI/XXEQfdP/EOweek4bAksb4nLSTspksWkzdltoP1E+rFJS3I1t0GkgEYdI+2yv13+waepuaya1A1AOLeP1Sa/wGt0l2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931289; c=relaxed/simple;
	bh=8ejGgmOWsmqXJeITu1HJ+eeluCBGi8lk56ED3Uemu4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2+kB3QRMIQWGvCmZ/6ZnSyzdNcQdgXtaICnjz3nbBt5TT0wMl04aKX+yXXJxJRZDtVp5K50+72f+gSlsWOy2jiFlHAmIAQ0rQ8S50Pg4KD7RIvYIvYLTvtrZ02Qnqxl6ZnW3Ye2c6VXnR+3NNFvqMrc3RmB5jwjup/ufva8pG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFQb8AGb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6D11F000E9;
	Mon, 13 Jul 2026 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783931288;
	bh=bGh6oU5iQiLxSNyUTmm3P/CHbg3XnDzufnxxnumTZks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WFQb8AGb/ybtkEvz6UPZjEkriUQPNCVwvrXpGm4rXL3gGRztOZFcQsXX7/ozxxVTB
	 W4d1tiUqpd93AWc2HOgOfeaCqSDdMu+na6J0c2sNy9WrhK5szTujWh0cMELZQjP+oH
	 jn67ppVJo8wYoew5VMRU0304jbQ+4raqeSAt5hhWOyOam8A401/wJciedogYosi+8/
	 Tf7WjufuttOTQ5fyWGn9rH7d4rsNDUWUlgJyNL+t4RK/qSVzYDyW7uGHKzNNCjoci/
	 e2QgJLhR/5f5eBYVYDyBv0zq4r1RzldI28OmUoBot3wXWxvzpPW3+6z6/OmOPpknV3
	 w7KdddEPgDXFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 1/2] RDMA/bnxt_re: Validate udata before
 destroying resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
 <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 08:28:07 +0000
Message-Id: <20260713082807.EB6D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11955-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D080748C14

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing hash_del on error paths in CQ and SRQ creation leads t=
o hash table corruption and use-after-free.
- [Critical] Lockless modifications and iterations over device-global hash =
tables (cq_hash and srq_hash) risk linked-list corruption.
- [High] Hardware Address Handle (AH) resource leak in bnxt_re_create_ah on=
 udata response failure.
- [High] Hardware and driver state modification applied before udata valida=
tion in modify/resize callbacks.
- [High] Memory leak of rdma_user_mmap_entry in bnxt_re_alloc_ucontext if u=
data validation or response fails.
--

--- Patch [1]: [PATCH rdma-next 1/2] RDMA/bnxt_re: Validate udata before de=
stroying resources ---
commit 1661d6c7bf0fdc123a46584fd78311e626482940
Author: Leon Romanovsky <leon@kernel.org>

RDMA/bnxt_re: Validate udata before destroying resources

This commit modifies the destroy callbacks to validate user data earlier
using ib_no_udata_io() before resources are torn down. This prevents
userspace access failures from leaving the driver and hardware in an
inconsistent state.

> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index 5657625290076..ef9943be18861 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c

[ ... ]

> @@ -3471,7 +3471,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct =
ib_udata *udata)
>  	nq =3D cq->qplib_cq.nq;
>  	cctx =3D rdev->chip_ctx;
> =20
> -	ret =3D ib_is_udata_in_empty(udata);
> +	ret =3D ib_no_udata_io(udata);
>  	if (ret)
>  		return ret;

[Severity: Critical]
This is a pre-existing issue, but does removing the CQ from the global hash
table here require locking?

In bnxt_re_destroy_cq(), just after this udata validation, the CQ is deleted
from rdev->cq_hash via hash_del() without any locks:

    if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT)
        hash_del(&cq->hash_entry);

However, concurrent additions occur in bnxt_re_create_user_cq() via
hash_add() and lockless iterations happen in bnxt_re_search_for_cq(). Can
this cause list corruption or use-after-free if multiple threads create,
destroy, or query CQs concurrently?

[Severity: Critical]
This isn't a bug introduced by this patch, but can this leak a dangling
pointer into the hash table on error?

In bnxt_re_create_user_cq(), if memory allocation for the page fails or
ib_respond_udata() fails, we jump to the error path and free the CQ without
removing it from the hash table:

bnxt_re_create_user_cq() {
    ...
    if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
        hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
        /* Allocate a page */
        cq->uctx_cq_page =3D (void *)get_zeroed_page(GFP_KERNEL);
        if (!cq->uctx_cq_page) {
            rc =3D -ENOMEM;
            goto destroy_cq;
        }
    ...
    rc =3D ib_respond_udata(udata, resp);
    if (rc)
        goto free_mem;
    ...
free_mem:
    free_page((unsigned long)cq->uctx_cq_page);
destroy_cq:
    bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
free_umem:
    ib_umem_release(cq->umem);
    return rc;
}

Since hash_del() isn't called here, could subsequent lookups hit a
use-after-free? This same pattern also appears in bnxt_re_create_srq()
where srq_hash is modified.

[Severity: High]
This isn't a bug introduced by this patch, but since this patch fixes udata
validation in destroy callbacks, should similar fixes be applied to the
modify and resize callbacks?

In functions like bnxt_re_modify_srq(), bnxt_re_modify_qp(), and
bnxt_re_resize_cq(), the hardware and driver state is modified before the
final copy-to-user response:

drivers/infiniband/hw/bnxt_re/ib_verbs.c:bnxt_re_modify_qp() {
    ...
    /* hardware QP state is modified here */
    ...
    return ib_respond_empty_udata(udata);
}

If the udata response buffer is invalid, the function fails, but the hardwa=
re
and driver states are already updated. Can this desynchronize kernel state
from userspace state?

[Severity: High]
This is a pre-existing issue, but does this error path permanently leak the
hardware Address Handle?

If ib_respond_empty_udata() fails in bnxt_re_create_ah(), the function
returns the error directly without cleaning up the hardware AH or
decrementing ah_count:

drivers/infiniband/hw/bnxt_re/ib_verbs.c:bnxt_re_create_ah() {
    ...
    return ib_respond_empty_udata(udata);
}

Can an unprivileged application repeatedly trigger this by passing an inval=
id
udata response buffer to exhaust hardware resources and kernel memory?

[Severity: High]
This is a pre-existing issue, but does the cfail error path leak the mmap
entry?

In bnxt_re_alloc_ucontext(), if validation or the udata response fails, we
jump to cfail:

drivers/infiniband/hw/bnxt_re/ib_verbs.c:bnxt_re_alloc_ucontext() {
    ...
    rc =3D ib_respond_udata(udata, resp);
    if (rc) {
        rc =3D -EFAULT;
        goto cfail;
    }
    ...
cfail:
    free_page((unsigned long)uctx->shpg);
    uctx->shpg =3D NULL;
fail:
    return rc;
}

This path skips calling rdma_user_mmap_entry_remove(uctx->shpage_mmap).
Does this permanently leak the kzalloc'd mmap entry, allowing memory
exhaustion if triggered repeatedly by userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fix-destro=
y-no-udata-v1-0-fcca2e34fd57@nvidia.com?part=3D1

