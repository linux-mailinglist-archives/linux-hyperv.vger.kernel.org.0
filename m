Return-Path: <linux-hyperv+bounces-11319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJHoIkfzGGoMpQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11319-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 04:00:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CDC5FC3E2
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 04:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E2983007649
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212ED1A0712;
	Fri, 29 May 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLFvlhUi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC13624A8
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 01:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019956; cv=none; b=nV+jW/26jNdqpQ2xqyQ7qt37awkfmaV2usBLxxCABS4XiTmHeo7SH+fieReADuaKtJLHqCKbDaRrIGYAHBA5TuDOBva2+ZY5rfK4sT0LahwEWmwiT35XVJvT8WX3+E9epu5AF+pTvfyACNQMR+6SnDh5983+IsUMNdOhoKwL3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019956; c=relaxed/simple;
	bh=r+OzR4f284Us8aBThAWLdioEFCKg4dWkXOgsEsPPer0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H62iESv5e/mUywWlSdVcERXOTqh6Fo5dnYe1XqfmPNgukFX6I6xkccF/K1Of8XRQASbsOqClBKKTgzdkcsOAa75CzB4HWnIKLVhdFEMR7kDvm7/byYKM5QtsVPlsvwvenzOh6v9c3D+DiBOuaDEc9pjgtW5x3/TatRz1v7bmvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLFvlhUi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2222D1F000E9;
	Fri, 29 May 2026 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780019954;
	bh=RWlFK7Pvdiye+73L3KHYf1JISQi9PXGFE25SrOab8ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLFvlhUirCrctHIMQGOMRLwIvVHniLJbPu3rP40R7Z9K+yR5SRAhcdSpLxzda9mxz
	 1wZaUKCX3cIdto6GaIzY9we5Mo4lspArJNZ4iG5be4ji7IofPeLDRPcLixBiavUuBQ
	 S3ZurxOsdLFLfz2+NocrylrYSGj58fYpxUxReJazaM7PMpx167oMRl9mPvI87Oxfih
	 1R1WDNCI6iYuZSUvu1YNNhzVkkbskbLSUTgKkkO/YzpJpUeqk6lnVpD7Qm8mhGq1uC
	 mfogxJx8KtdEfgFhKx71Kc5sYGAtJ/QQ6zdUiDG483Lu6eGkm2mqdgGT33GHGqQXJb
	 YiJebHgKVV/Lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] drm/hyperv: Use "hv_drm_" as symbol name prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhklkml@zohomail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260529014826.41256-1-mhklkml@zohomail.com>
References: <20260529014826.41256-1-mhklkml@zohomail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 01:59:13 +0000
Message-Id: <20260529015914.2222D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11319-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,outlook.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 07CDC5FC3E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of PCI driver on VMBus registration failure in mod=
ule init.
- [High] Flawed synchronous VMBus message handling: missing reinit_completi=
on() and ignored send errors.
--

commit a50bc353055fe2753b3f284aeec394019513c888
Author: Michael Kelley <mhklinux@outlook.com>
Subject: drm/hyperv: Use "hv_drm_" as symbol name prefix

This commit mechanically substitutes the "hyperv_" prefix with "hv_drm_"
for all functions and structures in the Hyper-V DRM driver. This avoids
namespace conflicts with generic Hyper-V initialization code.

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hy=
perv/hyperv_drm_drv.c
> index b6bf6412ae34a..20f35c48c0b82 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
[ ... ]
> -static int __init hyperv_init(void)
> +static int __init hv_drm_init(void)
>  {
>  	int ret;
> =20
>  	if (drm_firmware_drivers_only())
>  		return -ENODEV;
> =20
> -	ret =3D pci_register_driver(&hyperv_pci_driver);
> +	ret =3D pci_register_driver(&hv_drm_pci_driver);
>  	if (ret !=3D 0)
>  		return ret;
> =20
> -	return vmbus_driver_register(&hyperv_hv_driver);
> +	return vmbus_driver_register(&hv_drm_hv_driver);
>  }

[Severity: High]
This is a pre-existing issue, but if vmbus_driver_register() fails, does th=
is
leave the PCI driver registered while the module initialization fails?

If the module initialization returns an error and the kernel frees the
module's memory, the PCI subsystem might retain a dangling pointer to the
freed hv_drm_pci_driver structure. Could this lead to a kernel panic or
use-after-free if the PCI driver list is traversed later?

> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/=
hyperv/hyperv_drm_proto.c
> index 6e09b0218df4e..f0ef627b4898a 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
[ ... ]
> -static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
> +static int hv_drm_negotiate_version(struct hv_device *hdev, u32 ver)
>  {
> -	struct hyperv_drm_device *hv =3D hv_get_drvdata(hdev);
> +	struct hv_drm_device *hv =3D hv_get_drvdata(hdev);
>  	struct synthvid_msg *msg =3D (struct synthvid_msg *)hv->init_buf;
>  	struct drm_device *dev =3D &hv->dev;
>  	unsigned long t;
> @@ -223,7 +223,7 @@ static int hyperv_negotiate_version(struct hv_device =
*hdev, u32 ver)
>  	msg->vid_hdr.size =3D sizeof(struct synthvid_msg_hdr) +
>  		sizeof(struct synthvid_version_req);
>  	msg->ver_req.version =3D ver;
> -	hyperv_sendpacket(hdev, msg);
> +	hv_drm_sendpacket(hdev, msg);
> =20
>  	t =3D wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);

[Severity: High]
This isn't a bug introduced by this patch, but since the driver only
initializes the completion once during probe, is it possible for it to beco=
me
stale here?

If a previous request timed out and the host responds later, the completion
could remain signaled. This would cause a subsequent request to immediately
return from wait_for_completion_timeout() and process incorrect or stale da=
ta.

Should there be a call to reinit_completion() before sending the packet?

Additionally, since hv_drm_sendpacket() errors are ignored, does the driver
unnecessarily hang in wait_for_completion_timeout() for the full timeout
duration if the packet completely failed to send?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529014826.4125=
6-1-mhklkml@zohomail.com?part=3D1

