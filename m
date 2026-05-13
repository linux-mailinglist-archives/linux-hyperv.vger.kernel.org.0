Return-Path: <linux-hyperv+bounces-10871-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEeZNjrmBGpCQQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10871-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:59:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F453AC1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895FB302F277
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30539379C5F;
	Wed, 13 May 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTiFJnMC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEBF2FF147
	for <linux-hyperv@vger.kernel.org>; Wed, 13 May 2026 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778705957; cv=none; b=CldXfYK6DZ1i4tGmVwjz7rT7fhJvzxbmq6Bx46jAEq3bXOuORsJsUrWvtD0C21XWSV2X9Y+570aqfkA/OXdEmCMEjtnTtJk43PJ6zo/RRT33eVVP3dIM60i2w+vTYGGgXgRIxRfzFqFEIs2JVNmjereecpgkcs2jKuNZzcCNWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778705957; c=relaxed/simple;
	bh=yhXFienkxK03mGgGcpd1gdthCLovcVxpzmqYIdkc4oA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nsKyPVif7xHidmUjly1VW3v+0OEELdvYH1w6vGSI2D/XrxSLtPMPrVXUpCXUfxmFGU2aqws8lqjmn/SzsicXcNqjpVSjGXRGddgUZ/Ir/2vdxmSb2pKrexOweGiFqn8L777XIfpe2ZbStEm0uTPJk7EnqL0U0d/e5ku+VJXDpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTiFJnMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F0C19425;
	Wed, 13 May 2026 20:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778705956;
	bh=yhXFienkxK03mGgGcpd1gdthCLovcVxpzmqYIdkc4oA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jTiFJnMC8bQTnMTKVqwbotzCATXIbp9AA5GJOJfVx1i7yl4LBzTT4wc1ey2eCGYqu
	 jFAcuX51ekEByEXiqs06J51G8ZlZexvefTMtD5l8keiAU14LXSpSfrrgTkpTMcBUc9
	 epu7k8Th6HlkbQ5dVexdLVtouEQuDRpXR4Y7hoTIA+/xjs7Q6Dw6rGyUOhI5pySqX/
	 5oPNMaogqX80E7j6KNSPNuKiVlrTisoscWaNubjshesIGVo8mMvkbFGwdlaLE7rzN7
	 HCUokt3N2EtkzrHVJGJ5fyXIOV3zh612NGUTAgcHj5fW8Cz7RW003jWKKBbONQmwew
	 nwHP2vw4ITTpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] RDMA: Replace memset with = {} pattern for
 ib_respond_udata()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <10-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References: <10-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:59:15 +0000
Message-Id: <20260513205916.926F0C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 369F453AC1E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10871-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.linux.dev:replyto,smtp.kernel.org:mid,ziepe.ca:email,sashiko.dev:url]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of `memset` in `qedr_copy_qp_uresp` introduces a kernel st=
ack information leak to user-space due to uninitialized struct padding byte=
s.
--

commit 5d1e218c098790b95c443563dc2cc0974927c81a
Author: Jason Gunthorpe <jgg@ziepe.ca>

RDMA: Replace memset with =3D {} pattern for ib_respond_udata()

This patch replaces multiple instances of memset() used for zeroing
response structures with the aggregate initialization pattern =3D {}. It
also removes a redundant memset() in qedr_copy_qp_uresp().

> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/q=
edr/verbs.c
> index 79190c5b8b50b..1af908275ca72 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
[ ... ]
> @@ -1283,8 +1281,6 @@ static int qedr_copy_qp_uresp(struct qedr_dev *dev,
>  			      struct qedr_qp *qp, struct ib_udata *udata,
>  			      struct qedr_create_qp_uresp *uresp)
>  {
> -	memset(uresp, 0, sizeof(*uresp));
> -
>  	if (qedr_qp_has_sq(qp))
>  		qedr_copy_sq_uresp(dev, uresp, qp);

Does this change expose kernel stack memory to userspace?

The commit message notes that qedr_copy_qp_uresp() is already called with
zeroed memory. If the caller is using aggregate initialization (=3D {}) on
the stack, this may not completely zero the memory.

Unlike memset(), the C standard does not guarantee that =3D {} will zero out
implicit padding bytes. The compiler might optimize the initialization by
only zeroing the named fields.

Looking at struct qedr_create_qp_uresp, there appear to be 4 bytes of
implicit padding due to field alignment:

include/uapi/rdma/qedr-abi.h:struct qedr_create_qp_uresp {
	__u32 qp_id;
	__u32 atomic_supported;

	/* SQ */
	__u32 sq_db_offset;
	__u16 sq_icid;
        <--- 2 bytes of padding here to align rq_db_offset

	/* RQ */
	__u32 rq_db_offset;
	__u16 rq_icid;
        <--- 2 bytes of padding here to align rq_db2_offset

	__u32 rq_db2_offset;
	__u32 reserved;
...

Since ib_respond_udata() copies sizeof(*uresp) to userspace, could the
removal of memset() cause residual stack data in these padding holes to be
leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v3-4effdebad75a+e=
1-rdma_udata_rep_jgg@nvidia.com?part=3D10

