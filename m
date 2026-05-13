Return-Path: <linux-hyperv+bounces-10868-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDMrKd3QBGr0PQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10868-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:28:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0146539F0B
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 21:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC5D300EABB
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 19:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E913ADB94;
	Wed, 13 May 2026 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBrBqqm7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C313AC0D7
	for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699256; cv=none; b=uhEetuQMXFIpsoOQDXyT/gc0uOiiS62qsBPD/856bhU+ulbIgQRMrxRKg+Vgn5Y9EW1AD8XZacbovVtOKc0bcLhkT9UGWaw12qbJ89nzG0yR/PHeuPCmgS/6tvlKsHbW/U0wN+7c40NpdWXq3lge6jTmPRXDRbt2im0sWHBEfl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699256; c=relaxed/simple;
	bh=F9Th7aFzwZTXtCAo77Fucif2QV7bLOEDV3n4ocWRSxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qpKpIzpsAZmcVhWvFpUPlfIp/t4VRS2posbXviPqJ2Lsb1SwH01JObUIIwSKEWvO9wK76LyrQA+GEmKbOQtwUiqOjf85cumFRmRfTApdq859jztQNvRSrP7UC3Ore5O4hCZoALe9JN2eWlTBgGFlwfvitmL8TpZ7MZUgq+msy2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBrBqqm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7095FC19425;
	Wed, 13 May 2026 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699255;
	bh=F9Th7aFzwZTXtCAo77Fucif2QV7bLOEDV3n4ocWRSxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cBrBqqm7drO6LPibzzRBK6fBDoVrUXVFR1X6HF+pP29zE2Chmwj6mr+SWRkwbGT3p
	 Y0jLnjCpigOX/Bs9Wf9Q+nw5xgSylzDXpxscVPcfIMEzib+Vm/9uwCKzHmoy+/Q179
	 FYe0/J3S9VYbV2q/IfTvEwxowtL1bFJROecJUTEhGgVSkHd3qnuiJaNYUMEqvs8PGc
	 y+/iIFhQM66Z6xwpVZ5k9La8ZtJlyigLZ4vGQ51liRcP9/bWv8Bt2vXEsmo4cscAc1
	 CE+j/UumQZV2qY8q4MdmEZZ/ppmWY4Npotg7fkJkHhQYi1tzCRp3IRQcPLXMaZkVBa
	 VBc5gSPymRfvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] RDMA/qedr: Replace qedr_ib_copy_to_udata()
 with ib_respond_udata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <6-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References: <6-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 19:07:35 +0000
Message-Id: <20260513190735.7095FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: F0146539F0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10868-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,ziepe.ca:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `qedr_create_user_qp`, the error code from `qedr_copy_qp_uresp`=
 is overwritten by the return value of `rdma_destroy_qp` in the error clean=
up path, causing a false success return.
--

commit 5dc8fd66d59366118ca19c878df5216ffd4a4a52
Author: Jason Gunthorpe <jgg@ziepe.ca>

RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()

This replaces qedr_ib_copy_to_udata() with ib_respond_udata() to handle
copying data to user-space, removing the local inline wrapper.

> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/q=
edr/verbs.c
> index 3b86ea1cf8888..79190c5b8b50b 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
[ ... ]
> @@ -1311,13 +1294,7 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
>  	uresp->atomic_supported =3D dev->atomic_cap !=3D IB_ATOMIC_NONE;
>  	uresp->qp_id =3D qp->qp_id;
> =20
> -	rc =3D qedr_ib_copy_to_udata(udata, uresp, sizeof(*uresp));
> -	if (rc)
> -		DP_ERR(dev,
> -		       "create qp: failed a copy to user space with qp icid=3D0x%x.\n",
> -		       qp->icid);
> -
> -	return rc;
> +	return ib_respond_udata(udata, *uresp);

This isn't a bug introduced by your patch, but does the error handling
in qedr_create_user_qp() overwrite the return value of this function?

If qedr_copy_qp_uresp() or subsequent qedr_db_recovery_add() calls fail,
the function branches to the err label:

drivers/infiniband/hw/qedr/verbs.c:qedr_create_user_qp() {
    ...
	if (udata) {
		rc =3D qedr_copy_qp_uresp(dev, qp, udata, &uresp);
		if (rc)
			goto err;
	}
    ...
err:
	rc =3D dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
	if (rc)
		DP_ERR(dev, "create qp: fatal fault. rc=3D%d", rc);

err1:
	qedr_cleanup_user(dev, ctx, qp);
	return rc;
}

Since destroying the newly allocated QP typically succeeds and returns 0,
would this unconditionally overwrite the original error code in rc, returni=
ng
a false success to user-space?

If user-space subsequently attempts to post work requests to this destroyed
QP, could it lead to hardware undefined behavior, PCIe errors, or system
crashes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v3-4effdebad75a+e=
1-rdma_udata_rep_jgg@nvidia.com?part=3D6

