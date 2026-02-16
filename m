Return-Path: <linux-hyperv+bounces-8858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4foPFDeWkmnuuwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8858-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 04:59:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F47140CD1
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 04:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A8E5300B046
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Feb 2026 03:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A757C275AF0;
	Mon, 16 Feb 2026 03:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MBQ7sVnA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1913922576E
	for <linux-hyperv@vger.kernel.org>; Mon, 16 Feb 2026 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.228
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771214388; cv=pass; b=c4c9X8t8xJGCFfuWhm7qyaVpemMhONf2t8oqzkRIpWl5jO9JZW73Rv9vyzFQZwf+WwBtLpHrecriyd9iYLUvquy0F6yYTyA1qnYgM61C6I5aSxLFgPFTVQ8wZ4s8ApS3fTubXVdh7EPWB8s7m475gnBbuItfc5YoKqFCBah7Qfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771214388; c=relaxed/simple;
	bh=PoS7G8pw3jpzw0lKyFC6/sUP1J+W1CTMAFrVoDrum4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLS7g1yQvbsfyQmBTrYuzEnLf4B3HD8Bu8c0d6O9FpTWsXC5IWkAvhDA5Vb/SD5fcA715cRh5oTICL6Z2MFLeq45XN2vEM7ZiAinNvppxMHm4558+0hXXRymW9cYnnXp1Xmg5lLOUPKU30YhTfQe2lhA3fbw9YVv6QZ/YdDO4Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MBQ7sVnA; arc=pass smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8cb3dfb3461so304436385a.3
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Feb 2026 19:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771214386; x=1771819186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kvOJ9zk+kC9WWpV/tcKepoylAQPPlZ2SiG5DQHV6Kg=;
        b=SkXy8LP1InfopeCQ+GeAZRE1ty75XmjQOFgYIV+sevVlLh7pS7mjx8bbw3sbFHCE6X
         0mrIg4gLTyhPuDplQopQYKC2VK7wrBAoNPAZuKlyaSRse4wlsovkI74QVzwCoyn4o83/
         U0sjA+LZ0cEYZ8KorPkTZxZrCAugWCBXn8bXETcnlQrQphUAD8N9sDWjn6JN8eRlLt0B
         zBqpgG4ChsVdtEJCCJ5nQCzke+3duUdferHppMLucx3iDxGCmX032bU3QJ4ghOAaRiF5
         fuxkIEWNowIJLqwSz64yPlu79F3+0+yFoYgKRDzNnFDxLf9uNDu+7BWpSfKFWa9YuIMN
         p4VA==
X-Forwarded-Encrypted: i=2; AJvYcCX5HPLupk2qo1Dy9s2vPAfht8CA9/MuoRjHbEqMUN3RRGextyAW8AIcLlHG5HFBp1Xk1LdctOw6RV0WYvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlQqyYsHcY4mYM+mvV6pmqojAKplw7VV5cBz4Muz6uNT1NJ+MJ
	nTp9WvEudPCwVToy9U8sgw3O2J3v/g12Afhm8MeeEPwvS52Si0JrNu1wfaTMYKqVjRIfYlP3V27
	MJKV462FF7mag0V+JZpa6aatQibxC+wUeDg80D+1DqlI3q4LufoCV4b4hfrxS5HYvhRRRfPUr1S
	3STyxSbS8fGSsexDaWJTXzSYgEkpGP7YU37gC3OJHiR3ZyQvZuE25zsHsmQF53dfd0wv0E4cFlb
	JLnCKB+JLQkIEW1uAUZ
X-Gm-Gg: AZuq6aLqUzdNK1Uayz3JOR6VgSl0uwHgin+ug66/RVQWcVl/Dcy+m1e3a2sZMCNWNRg
	bCADV1yO1N+aU9Ne5K3Smx4HG9jmYzKmvdVqJHGdbbwmrV92p3thPmfgrLw5lU32UVnh9AEnw2m
	9orqqEUaX8KamG1d43XtgPrC4nqFu7s5h1uVYTWeZm82W/61S9gqi9j8PLiEvcLDgDmT41MxakO
	xbBaJb3y/E57747jmvCa2F7wZ5Zsex+aq5Fk/Sf0clfhxhwfQMVFA5NRP/517N5tM6+hdnsxn1d
	4GVcl93Z+XH9OFniXaae+wbvNPIRpx0B2J4bgzEjE9tha4NyqI/J+0Hxv8ziCANh3Qx9RzQaNah
	pPo91om5NA7BBIvE5EJvymk+yb4dhyUliULSyGZPdSIPY2akAxaZ56Y6rpkGsDJ71bsfagpcJXw
	vREFmPEU/BeK1sek7yNM7xzbMcEJA8LUHZXSJ/a9HkyFRAJafsyD3b641UIw==
X-Received: by 2002:ac8:5a04:0:b0:4e8:b9fd:59f0 with SMTP id d75a77b69052e-506a6b34cadmr118603771cf.61.1771214385693;
        Sun, 15 Feb 2026 19:59:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8971c8e32b4sm19620406d6.0.2026.02.15.19.59.45
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Feb 2026 19:59:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8861544696so292135266b.3
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Feb 2026 19:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771214384; cv=none;
        d=google.com; s=arc-20240605;
        b=CsH5625ofC56ztcfmwcwGDuFJe4V8J7x4b6NGstOfiURRxENMb2eXKbcCZGek3z6Nx
         yHZ4fFrJTZb2dEgLHUW4mK6rXPCBoSjp5RtwQstA3hx/w+QSz3a3CifVXbWPXnIFATRf
         wGxyWN5NBur+20+O4eqwBb2CZF79+l4bQmntcHWlhF0SR4MKEx4/xOQPBz4NksRbD17L
         TIau0oeHNNDpHLbU1edHfkmEy8x4VmzHMmgtCZG9RvpSrvcoTKZ0noxL6WjjplWpuQRS
         xOg9TdmEPR8ZKE7JGkWQsMBqWrnHpPu/2qRXAQWnYCZjLt5G2WxVehEH6jRRQ+CYzKEl
         LBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4kvOJ9zk+kC9WWpV/tcKepoylAQPPlZ2SiG5DQHV6Kg=;
        fh=99506ihi5En2c9rwZTs3nOnMYUkrbFIY9DHeeC4NKUc=;
        b=VdG56TjTUL67b1SeFohQQmF3GFlYYejLuQAakxWGrvT7aQk1lP4tbWiwOG7g4rRD6M
         giI3EtsrBBfGMjVB6OE5H0zaba21Af8AvqG+3wZWjWsGV/uWA1+vP2bMfgcWuYWIXxRs
         pccYJa8w0h8u6NVHOXNih0MuTTMEy8fxpdIhrefF6G/ctcQzAfpjxwwCYUMeooDZSugD
         TqjBLyAlBFmygDiOcw1jktkykDQ72RzF5zSuBP4Ph3pYc8gBaJIp8zk7eRenRWmWybBs
         DwPb3VQBv5VofnTLmnzdxtSjQb8j5RupKGjO2ydXdKON0RjYxK5ha0zyy8/YiFUS+/qI
         FEVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771214384; x=1771819184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4kvOJ9zk+kC9WWpV/tcKepoylAQPPlZ2SiG5DQHV6Kg=;
        b=MBQ7sVnAOm9/h70iT+1u6JMRpW1qPuOYuVZ/W+G15LIBSQ4AWBxEGLqP+KPumSzDS1
         YeabQPDdWVQOnBFaZC+Y1URygPPBU42m9ZDtHawSLuEtt7pmOWOtVd3+1LsPYyoW9N89
         FLHw7GgzByq6eXZxUUhPqB/xdq7Hniq7L+r58=
X-Forwarded-Encrypted: i=1; AJvYcCW+ivJ3xiNPSLaFBU9EBY4ecKvmqruSmXBCLhf8QWsYhqI8tTAaXxTOwAvH506xT2ZfQLARoWvGvfKaeZM=@vger.kernel.org
X-Received: by 2002:a17:907:9282:b0:b87:6953:9d5e with SMTP id a640c23a62f3a-b8fb44870a8mr448292166b.33.1771214383901;
        Sun, 15 Feb 2026 19:59:43 -0800 (PST)
X-Received: by 2002:a17:907:9282:b0:b87:6953:9d5e with SMTP id
 a640c23a62f3a-b8fb44870a8mr448290166b.33.1771214383394; Sun, 15 Feb 2026
 19:59:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com> <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
In-Reply-To: <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Mon, 16 Feb 2026 09:29:29 +0530
X-Gm-Features: AaiRm53YuvEdahP9BFdxxykEgks-2-so2BYe0D9GQQvG1LfKUwG4ZM7F5DjtN-0
Message-ID: <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
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
	boundary="000000000000347e19064ae8fcf8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8858-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-hyperv@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 92F47140CD1
X-Rspamd-Action: no action

--000000000000347e19064ae8fcf8
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
bnxt HW requires that the previous CQ memory be available with the HW until
HW generates a cut off cqe on the CQ that is being destroyed. This is
the reason for
polling the completions in the user library after returning the
resize_cq call. Once the polling
thread sees the expected CQE, it will invoke the driver to free CQ
memory.  So ib_umem_release
should wait. This patch doesn't guarantee that.  Do you think if there
is a better way to handle this requirement?

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
>         spin_lock_irqsave(&cq->cq_lock, flags);
>         budget =3D min_t(u32, num_entries, cq->max_cql);
>         num_entries =3D budget;
>
> --
> 2.52.0
>

--000000000000347e19064ae8fcf8
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
EHewyNNlkY4qI/Y/4FDemH598qhce+Q8ReKG/2VVATAwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMjE2MDM1OTQ0WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAL80bUWzOlO7ylY9A/f9ng2JrEOROa8iAgyi5
bjpaaSGGjai0d/LCunA/I1GdQWxanYhsPhhzpmlMhdiL+BfwtcJGjFqrKqNJllcHEIO2acGgGZeN
uXhIqXTwjSjfy4RKDGnbS3XdGJyFH06LaVURp1dR0ED0akkIjmTeDGLrNhc4Q+MOym58cGeL6HVk
rAmYNaiUVNgVwkQIr6OGhTaT3HgflS8ug/Zf84jqTFYS4GusKWnYUw5bgVGMgydAnjo8qt9xu13j
IxKc1UryuP70KCAaY6fbe2q9rNtobkA1OFJWzF+1ECKMsibWluA+aoS10nuCWhYEkXt4RPrVYapm
LQ==
--000000000000347e19064ae8fcf8--

