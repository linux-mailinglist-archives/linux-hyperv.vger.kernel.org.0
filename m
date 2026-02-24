Return-Path: <linux-hyperv+bounces-8964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHtVBBdfnWmxOgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8964-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 09:19:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71581183856
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 09:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5ACE300D47A
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Feb 2026 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135A2D59E8;
	Tue, 24 Feb 2026 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dmAJCyzy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FE36681E
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Feb 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920961; cv=pass; b=CqOOrjv8jguFwWmPV44iXzP1b8NEJ/RGvV64Dmvcekv0TqzTQz+GRTS3iXO3SWmZb91ocv4lRHj2/z3s+3EEdn1gF93e+VFz1RbNeaIKKucftW1LRMJrNKfu8NawKdD6PPxSi+9k2LA3E3iGEGax0fEi31A+c0coHSo71Qh2lQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920961; c=relaxed/simple;
	bh=3xOPfK0HK2dcUdbi5mOv1FsPCDeSzKquKqUpS2gcK2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZ5C0n4DlfmrTWXXDG45Dv9zqnXmaitD8RaXZfO02lTOFhM/Ou5ZlxrY+rIEnYZjTd9wwVLrDemksvgf7eqF6zROFSkfyvWRhZEwgSVHNHbu3Zz3DxYujWaAb7cpgepHGyTv5HwJSFMMVRCv7P/hWftfdnatKfT8mf7WBRJHz3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dmAJCyzy; arc=pass smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso2821342b3a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Feb 2026 00:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920958; x=1772525758;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTeqYJLzkjyEKYxryQMaRuzga5YXzYwpD/8fkJneAUA=;
        b=laUpHsJ5CoQUOijpI1l/WfTZahtLudl6eyx9sh0VLTv9Ym0A+iDcDagAwP/8T73mRw
         OOxg5CdLAoDRxn6kwTuqed8hkgHESzcN7ShSLp2IOWTcJ8WDnZBHwSY4hV7E5mqLmhmG
         OcInDwZlPu0lNejTYLawBU6oG886ITHl8o/TRTMbHyoJpMT5mAG/MafKAKZzvHjhBYKE
         OF+Sme0UKG5YfUm4Hw818jqoKu1UZsxEPk63Ykybd1SW/SpYpskW37aPUk5qcOqbtKfv
         UYlmbyHN1kwzTlH/dHz3jNmHcipUzCMd3acWW/w7KiDP6sfkZHfnjy78arOYx1UkT1Hd
         jtcw==
X-Forwarded-Encrypted: i=2; AJvYcCUk6SnEmEjALWiC2nMMV/pAmppLjo3e01JdL/XicJTiGpYt2tQHprfi+rFumVAmIiYECvrFCuPjsnEBIxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaGHIqYSc2TH7G0C/A9/LuwAXtOZolcnj6RXZCQX5k54AgRzE
	x4OjrYdqIq+bMuHo41JOjQMtiyc+/hqVxqcSOgGlZOfimOJ+SdXpK/8SFr0PnU2qMWgGiXFMc7A
	9xP/OsWH7bdAfFXM78pbRIMPKLJ913RjZY2qkMneNaUA5mwwuf7x7JDV7PpANZVxdaRviuQtceZ
	N/5J88xCBpXMDw/zPVj+zgtMS9pivvQltrLMZZhC68cNWHZl4FDAqIU3zZ6Q7ZI1PD1W2nQlmcy
	iHQrY3RMK+29xCbV7Ny
X-Gm-Gg: ATEYQzyQCr/+wNryGo3ItErugc+6s8y1CPuDzr3h8aKi+gP97+Og7wUDUgxX/Jtmuto
	rsVt/Iwz9ZzwPNsZ0rC06Cn7/2rOL0GpQbM4CoRdLejjZJXZ/o9LWTn848G0DodHLx78HLaNYSp
	82tt0+tNGSbaICQS8kyN4XRgKv+CNoMVnN/dItmatA81cNNDAvYXy0I3FyVRoLvz6qWMa0U9zEJ
	ub2yvlZIOrnYe3q983vEYN65yXhOmH8A0j0zHhB36TfP2H5yo49853V/0gXM9qItIY2WyGhBJrT
	M9mAtkwmD4ZWHiI2oRZJ3QPMagA7FZKvtOQCfqVauXtSwI8KjQdtUg0E/H54BMwLZN21SF+J/Ks
	0nX1pLa2W0KUqsoCk08ROQiKV3nszkho49meBIl3PiTGDe1phhzJ97dkYhSRZlvKLfiCxW/DXE9
	f6SHkQxm94FUE0IJdOZasjfAN0W7MjxWAQEO8C+aEMwivzGRl6XhQDKu9a+6IP
X-Received: by 2002:a17:903:1248:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2ad7441ab46mr111831615ad.11.1771920958106;
        Tue, 24 Feb 2026 00:15:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad74fd7249sm10776355ad.30.2026.02.24.00.15.57
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 00:15:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8fbaa0787cso537644866b.1
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Feb 2026 00:15:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771920956; cv=none;
        d=google.com; s=arc-20240605;
        b=eo4jci9w/zShir1uhIijSdKW/7dklf4btQbwbQznzDDBJmEymOm9il9106KhLFRSL0
         vnUjgmpy6mUoD7h3/tqgUXZaDfEGKO3aLTWICk31zQ1cPtRWqZm8MdTBpv9L2Bs8LpUk
         EKbfVmWPJF+36s7YW3E+roXMNdGKmOIs5VZrjFVd9TIO7l9GaifO92/FfETc4K/cnieO
         Hp519BXNYdl9oYZbju9uSd1U2K7XuddGPFDLXExwQ/WNc2UHuLNrlaJEY2nUUkZNbVxt
         nh7mMw4depb1yxkAoJq+u0cNTkvI/Uk75QUeU7YCHcROAkaLe8x3WzSe1pqkLLvBxmZY
         eOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OTeqYJLzkjyEKYxryQMaRuzga5YXzYwpD/8fkJneAUA=;
        fh=zUP6PYvRYdcUYe7QK4sw6u1Kz9SpIjSaH2fD74Ogs94=;
        b=j4eB0Xit4GRTQYInLMqOVgsAz1mGt0LTkld7cgLEYcAqlIYwWFsdmDdV0Pno5AgcsP
         5cHpNobFjHJeTFrXn/f4H7jAGP1cK5mbckKyLAtRn7ZpEjadWGNzEzF2hqlxJxOrKT2Z
         ojTSjAflY07Y1Q3o5FNiAUH7sMrcsmDZPTQ/HDzb741ZhdeBlLGx8e6XqWTEhZ8CZu5W
         rRpsBJGunNxk46ri3gMcRtI/3mgkRQMl9oAHeF69kG6sWBD/T06tgXYa+8bDl9EXNM89
         D5IOkiCjXUn0zXGl7ZfOJ2EspZk/ptj67Fykh3DjzhueKWK0ntxDFe5Oj4qitlfndUsI
         9aGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771920956; x=1772525756; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OTeqYJLzkjyEKYxryQMaRuzga5YXzYwpD/8fkJneAUA=;
        b=dmAJCyzyNyBBvjrw4Jg2Zux4MxhaZTN3QsUmtXtKBFugK25X2aVW69FoedFyKBZ8wS
         SF1iGVo+O0Iz08xDmecRW8u13gqIKPf5y8mppmc0Zr4F2Ytnh5qoI0b2QkaWxKFy1SHs
         GEVVkpIn3McxYVgO2ZfVXzrxudwVwU6m1QT0s=
X-Forwarded-Encrypted: i=1; AJvYcCV6zV4w5vMDX3Rg1s0XJBKAuHsBJlpnBFG7/zyvbqH3/7Edf8cG+c2okNr26JDhfXqSEOJ3WYAZ5aQ9DRA=@vger.kernel.org
X-Received: by 2002:a17:906:4fc7:b0:b90:e278:a09a with SMTP id a640c23a62f3a-b90e278a155mr185951966b.55.1771920955721;
        Tue, 24 Feb 2026 00:15:55 -0800 (PST)
X-Received: by 2002:a17:906:4fc7:b0:b90:e278:a09a with SMTP id
 a640c23a62f3a-b90e278a155mr185948866b.55.1771920955134; Tue, 24 Feb 2026
 00:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com> <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
In-Reply-To: <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 24 Feb 2026 13:45:42 +0530
X-Gm-Features: AaiRm51gjKLFr_itNmmCkoksrEUliBBNuDXhLVUIvbEBJWjHQvi7hvOD0_H4ouM
Message-ID: <CA+sbYW2QKSbKpoHWMCL_6QnXYVuhx9Los9EMFasWeKCfcqUXsg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a
 single step
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Michael Margolin <mrgolin@amazon.com>, 
	Gal Pressman <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang <huangjunxian6@hisilicon.com>, 
	Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, 
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Bernard Metzler <bernard.metzler@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000029f3eb064b8d7f6f"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8964-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 71581183856
X-Rspamd-Action: no action

--00000000000029f3eb064b8d7f6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 4:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> From: Leon Romanovsky <leonro@nvidia.com>
>
> There is no need to defer the CQ resize operation, as it is intended to
> be completed in one pass. The current bnxt_re_resize_cq() implementation
> does not handle concurrent CQ resize requests, and this will be addressed
> in the following patches.
>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 33 +++++++++-----------------=
------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniban=
d/hw/bnxt_re/ib_verbs.c
> index d652018c19b3..2aecfbbb7eaf 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3309,20 +3309,6 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const st=
ruct ib_cq_init_attr *attr,
>         return rc;
>  }
>
> -static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> -{
> -       struct bnxt_re_dev *rdev =3D cq->rdev;
> -
> -       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> -
> -       cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> -       if (cq->resize_umem) {
> -               ib_umem_release(cq->ib_cq.umem);
> -               cq->ib_cq.umem =3D cq->resize_umem;
> -               cq->resize_umem =3D NULL;
> -               cq->resize_cqe =3D 0;
> -       }
> -}
>
>  int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
>                       struct ib_udata *udata)
> @@ -3387,7 +3373,15 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned=
 int cqe,
>                 goto fail;
>         }
>
> -       cq->ib_cq.cqe =3D cq->resize_cqe;
> +       bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> +
> +       cq->qplib_cq.max_wqe =3D cq->resize_cqe;
> +       ib_umem_release(cq->ib_cq.umem);
> +       cq->ib_cq.umem =3D cq->resize_umem;
> +       cq->resize_umem =3D NULL;
> +       cq->resize_cqe =3D 0;
> +
> +       cq->ib_cq.cqe =3D entries;
>         atomic_inc(&rdev->stats.res.resize_count);
>
>         return 0;
> @@ -3907,15 +3901,6 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_e=
ntries, struct ib_wc *wc)
>         struct bnxt_re_sqp_entries *sqp_entry =3D NULL;
>         unsigned long flags;
>
> -       /* User CQ; the only processing we do is to
> -        * complete any pending CQ resize operation.
> -        */
> -       if (cq->ib_cq.umem) {
> -               if (cq->resize_umem)
> -                       bnxt_re_resize_cq_complete(cq);
> -               return 0;
> -       }
> -
Since this code is removed,  we need to remove  ibv_cmd_poll_cq call
from the user library.
For older libraries which still calls ibv_cmd_poll_cq, i think we
should we keep a check.  Else it will throw a print "POLL CQ : no CQL
to use". Either we should add the following code or remove this print.
       if (cq->ib_cq.umem)
                  return 0;
Otherwise, it looks good to me.

Thanks,
Selvin




>         spin_lock_irqsave(&cq->cq_lock, flags);
>         budget =3D min_t(u32, num_entries, cq->max_cql);
>         num_entries =3D budget;
>
> --
> 2.52.0
>

--00000000000029f3eb064b8d7f6f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
43Ox+DYLcGC8S4Gzq0rnofQlm07NmVi6333yG+LovQ0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMjI0MDgxNTU2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAegUd/1wC3Cm3d0EHtYSVMrAx6j6wCBaPg1g5
UTWEmhvGhpRyjzsaj+6zT5GCQkAv4b6K7A+B47Do8wHD6KGtBzDGqTgRZghfxeDcDNrmOwoiZm+k
yQe1dGL10mwoArI7NzjzKQZhDiKgL+w8cRi9ogLps85c3DfKogvYPLiBmEOSg6ThlPxAsDbFwA+l
SNEHGRlykDdyr5jrutshSf82Nos/rfhaK8gisK80J/RkyM7BvsQJ3jod08e+NwuHq6VDyI8N4Z48
Wkx+Ia8mV+WB96iwGNMpiLBAu65m21XDSS4XATeIBgxBLkARuXi2YrHIMcpRDAKiA43JKHeva0m7
gw==
--00000000000029f3eb064b8d7f6f--

