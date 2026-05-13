Return-Path: <linux-hyperv+bounces-10870-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INatEE3YBGovPwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10870-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:00:13 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A524E53A43A
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9905B3015D1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975463B95E4;
	Wed, 13 May 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eei8K786"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DBC3B1034;
	Wed, 13 May 2026 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702410; cv=none; b=SRDtmjEyXvBl07rBhz0fhO4pfljKJTdQEJugvQTR5AVfwgLh9aqSzrjvTucjvtfl99EyGrYIrIcO+euOuF/VHON1yeImo904Anfd/NVVtPbaV2NgiOJhZrLkBdk9z8qPnDczC+nxBJY2iGDUnPl+wauR0DrmJnmmJLqRHLeA82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702410; c=relaxed/simple;
	bh=MyeugStu5BAvNjTeTDQo2ztI5l0SON+1OLxginf/62s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DVJIeWO+eqBNlEY45hobSY8/eBKg3n+H0YyoRWk+lYwxgCHe+o/V5lJ2SOQTv87ehX7xKkMpthHLNnNg6lIuwNYwGUd80o1wC2Zg+JynmbyzO6AGtjkgWKSJCLUcTxj8IuReHPyd5K3cp6ZZq1DdMR7rN0o78wPR4HOrKOTYEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eei8K786; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC469C19425;
	Wed, 13 May 2026 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778702410;
	bh=MyeugStu5BAvNjTeTDQo2ztI5l0SON+1OLxginf/62s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Eei8K786p8FJjhwVp2C4HdbRYn+Hcro6Ryduv6K3hu/OqMZzWFqxRUvnqJwvhUTLu
	 3tvuDBdfBdSr8erw0qS3uhl/nrpbHQHhiRhFY2x8g1PfMQR1tUQJch9dxGX37s+8mi
	 x3iyQuIjVjsBwxNuULpau+W/vyft9ZIVdcsvIrAGuUXh9j66IrCLOpN5QYW7Xe+Pci
	 TN/waxduGk/XCzXJvqp1Tv612PaBZcphK3s+/Ub4zP9zTdWlBXG0szFfWEk9XsYC3E
	 n4jLVyGmHAVfNzafoTm6b+2az0s96tiy5tmsu2rN02LTALB6G1kgVoFW3K/S/A/2WH
	 eKV+9qRoCFP+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 11/11] mshv: Mark mem regions as non-movable upfront
 if device passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260512020259.1678627-12-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-12-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:00:09 +0000
Message-Id: <20260513200009.DC469C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: A524E53A43A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10870-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Failing `copy_to_user` during device creation bypasses the `pt=
_regions_pinned` enforcement while leaving the device fully accessible.
- [High] Device creation does not validate or pin pre-existing memory regio=
ns, allowing an unsafe mix of movable regions and device passthrough.
- [High] Missing synchronization between device creation and region creatio=
n allows concurrent bypass of the pinning constraint.
--

commit add8cd40c15400cf2b19c8993ce14d4b4a7adef6
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Mark mem regions as non-movable upfront if device passthru

This commit ensures that if a VM is started with a device attached, its
memory regions are marked as non-movable upfront to allow the use of SLAT
for IOMMU. It also adds a boot parameter to disable movable pages globally.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index a7864463961bc..ac71534733bd8 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c

[ ... ]

> @@ -1303,6 +1307,12 @@ static void mshv_async_hvcall_handler(void *data, =
u64 *status)
>  	*status =3D partition->async_hypercall_status;
>  }
> =20
> +static bool mshv_do_pt_regions_pinned(struct mshv_partition *pt)
> +{
> +	return pt->pt_regions_pinned || mshv_partition_encrypted(pt) ||
> +	       hv_no_movbl_pgs;
> +}

Is there a potential race condition here between device creation and region
creation?

pt->pt_regions_pinned is written in mshv_partition_ioctl_create_device()
without holding any locks. Concurrently, mshv_partition_create_region()
reads this flag via mshv_do_pt_regions_pinned() without synchronization.

If a region is created while a concurrent device creation thread is about to
set pt_regions_pinned to true, could the region incorrectly be instantiated
as movable while a passthrough device is active?

[ ... ]

> @@ -1808,6 +1818,9 @@ static long mshv_partition_ioctl_create_device(stru=
ct mshv_partition *partition,
>  	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
>  		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
> =20
> +	/* For now, all regions must be pinned if there is device passthru. */
> +	partition->pt_regions_pinned =3D true;

If the copy_to_user() fails, the function returns early and skips setting
pt_regions_pinned to true. However, anon_inode_getfd() has already installed
the file descriptor in the process's file descriptor table, meaning the
device remains fully accessible. Can this allow userspace to bypass the
pt_regions_pinned enforcement?

Additionally, when a device is attached, this sets pt_regions_pinned to true
for future memory region creations. Does this handle the case where a
partition already has existing memory regions?

If userspace creates movable regions first and then attaches a device, is
there a risk that page migration could cause the device to DMA into incorre=
ct
physical memory?

>  	return 0;
> =20
>  undo_out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D11

