Return-Path: <linux-hyperv+bounces-10820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEHZCZgHBGoHCQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10820-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 07:09:44 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9718B52D771
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 07:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B1A3027300
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E99384CF8;
	Wed, 13 May 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnA+kn23"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311E33CEA7;
	Wed, 13 May 2026 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648972; cv=none; b=Wf/f1H1oso7OxOak8b+tJ1ONiSltdxsT6ykeg2lfgGsTB9UYQVN0iqpQQX4Z47yw9JpF5cQaIKrCNWCbDHs/1eVTh3aRAVgFkOGkoaRRIV/ZCSVg9P8C1v8Cb/gYM9WzM/BxPjp+sxMnYDve7WdAlEZoaMwIiocHdr9cL+7oGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648972; c=relaxed/simple;
	bh=vSpNICj8FRQIEEplzSitQ31XDKoymAyfswGV6NdN8H4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OVaLTQzIOCugWzHRYwju0MzgbtJa8tEBJfFlaRvgvyAHlSee+sojh+thAKhJPfmR85Gq9/CMi7JB/2kB8J58vdPCwjDxl7087WKDhhGPmpUZ6uI4vDtUCamQXTYRdwHvkTS3VDGnjxJ5VC6zySKl/8D0rTCoVp/XzA0jgqTPYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnA+kn23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE056C2BCB7;
	Wed, 13 May 2026 05:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778648971;
	bh=vSpNICj8FRQIEEplzSitQ31XDKoymAyfswGV6NdN8H4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TnA+kn23Tskn9jdTf6JaNOmtSa4ZcyDVXVu39JvahSuh8a+7EfknI0Eh118ou/9aV
	 bXWprt+JgzLYqxv7kRmlvPfOkrzLhRAoLzd0aZPT/sFR1UyR8gzJxZ5xklxiJBMXTF
	 FanGiPEi837LDXZBJObxaDKgE34Q6CnVP2ttNa9icNamOLNjgiNl/tCAmZOZ8NNp6e
	 VvI0gVmfSBkG6urFvbhmidgJ2I8IjWpcbmFmuz+FqsWLs9ri8C2nbSYqsFr5oIP0R/
	 1zrYgja/oM2igPV8MDSJrhXyKtHQlz/SZ76C7ZEmCF4KnmO4bBmAyMVlwC0TZjk6WZ
	 TzZqisJ58yzCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 05/11] mshv: Implement mshv bridge device for VFIO
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260512020259.1678627-6-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:09:31 +0000
Message-Id: <20260513050931.BE056C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 9718B52D771
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10820-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unprotected access to `pt_devices` list and missing lockdep assert=
ion.
- [Low] The `mshv_vfio_device_ops` structure is missing the `const` qualifi=
er.
--

commit 96ab470ecc51b095ed8b1538e4abdf37d030b039
Author: Mukesh R <mrathor@linux.microsoft.com>
Subject: mshv: Implement mshv bridge device for VFIO

This commit introduces a new VFIO-MSHV bridge pseudo device file, adapted
from KVM's VFIO bridge. It provides the necessary device operations to link
VFIO files with an MSHV partition.

> diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
> new file mode 100644
> index 0000000000000..00a97920e25ba
> --- /dev/null
> +++ b/drivers/hv/mshv_vfio.c
[ ... ]
> +static long mshv_vfio_create_device(struct mshv_device *mshvdev)
> +{
> +	struct mshv_device *tmp;
> +	struct mshv_vfio *mshv_vfio;
> +
> +	/* Only one VFIO "device" per VM */
> +	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
> +			     device_ptnode)
> +		if (tmp->device_ops =3D=3D &mshv_vfio_device_ops)
> +			return -EBUSY;

Are we missing a lockdep assertion here to ensure the partition lock is hel=
d?

Since this iterates over the pt_devices list to enforce a singleton device,
could concurrent ioctl calls bypass this check and corrupt the hlist if the
caller doesn't acquire the lock?

[ ... ]

> +struct mshv_device_ops mshv_vfio_device_ops =3D {
> +	.device_name =3D "mshv-vfio",
> +	.device_create =3D mshv_vfio_create_device,
> +	.device_release =3D mshv_vfio_release_device,
> +	.device_set_attr =3D mshv_vfio_set_attr,
> +	.device_has_attr =3D mshv_vfio_has_attr,
> +};

Should mshv_vfio_device_ops be declared as const?

The structure consists entirely of function pointers and is never modified
after initialization. Making it const would place it in read-only memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D5

