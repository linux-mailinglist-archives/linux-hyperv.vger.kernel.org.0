Return-Path: <linux-hyperv+bounces-10893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CATzLVxIBmo3hwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10893-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 00:10:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9C5475A0
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 00:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27516300737C
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18BA38D6A4;
	Thu, 14 May 2026 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svo89J1s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF10834B183
	for <linux-hyperv@vger.kernel.org>; Thu, 14 May 2026 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778796634; cv=none; b=cUTDz+Oosur/FM71LMEqqsUV3dRE/KM5nG9/z0rhP7NtC4UlQcQP5selsvLIQ7msKLw/wdUCcMIWrMx/d1QZog6ofCj3+o+hBJfHB9P5m0IESf85d5uhQ8lBbtj0WM1Kw+2zPgBo++k27BxWu6la0Ez8xLxJafZVlp4TcGp4+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778796634; c=relaxed/simple;
	bh=gL0k1l3QCbsEl1nY3qDHIps+akXy3cLwkooDsMmXPqE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bP0oVoXabXjLs7rH1ZnWEJfgVKRQLvs5zU259yzOkKrbhHMhQTj/3AfsMYgch6/oH7aLGkswkK58GuYVTlSz/nb7o7gCKShH7bWNhPe+uFwvnyTqEKUzJhMgIhDp8T7QC89Mv4Wfg1+qd4AtgYzyPfPANPyVQRRC+SbNh9P4i7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svo89J1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EB1C2BCB3;
	Thu, 14 May 2026 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778796634;
	bh=gL0k1l3QCbsEl1nY3qDHIps+akXy3cLwkooDsMmXPqE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=svo89J1spX8VdAbxqzOQ6Vajy4uLTReuis6QWPh6Zbg3cotEUI0SCoSRU+O0VIBZA
	 AKyaY8GgIVY5nPCDTk5EhTQKuVHoL/6m0DwRfS3lWIwf2y/zqSPkY53pQLng/9AxMR
	 qRQQt7nsFo7KCMzmaORGCtkg4vjl1XqRRxoXo57RpX2UtOKRjo/GZoc78RalOXhF2j
	 vPdSnezP7VNZhoWEr/xiHeOEMIDbZtlW1o1nSG9kDIIWIz0ueNf2isNIuRsH7d9xlr
	 DefT+uuKCX7hhl/u+6UILsp4+1Of1WcXiPi7E5CSiY5U2X8wYT3upUqdy+f06UFyVb
	 pSPmuWtUlEHZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 2/6] net: mana: Query device capabilities
 and configure MSI-X sharing for EQs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260513220956.402058-3-longli@microsoft.com>
References: <20260513220956.402058-3-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:10:34 +0000
Message-Id: <20260514221034.69EB1C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 62F9C5475A0
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
	TAGGED_FROM(0.00)[bounces-10893-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The explicit `msi_sharing =3D true` requirement for platforms with=
out dynamic MSI-X support is unconditionally overwritten, leading to incorr=
ect MSI-X configuration.
--

commit 113e4b9419d10774e0a86653bf123b1add7cbc2e
Author: Long Li <longli@microsoft.com>

net: mana: Query device capabilities and configure MSI-X sharing for EQs

This commit adjusts the max number of queues to allow dedicated MSI-X vecto=
rs
for each vPort and enables MSI-X sharing among vPorts when there are not
enough vectors or the platform does not support dynamic MSI-X allocation.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index 3bc3fff559991..bbd055849e363 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -179,8 +179,18 @@ static int mana_gd_query_max_resources(struct pci_de=
v *pdev)
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
>  	struct gdma_query_max_resources_resp resp =3D {};
>  	struct gdma_general_req req =3D {};
> +	unsigned int max_num_queues;
> +	u8 bm_hostmode;
> +	u16 num_ports;
>  	int err;
> =20
> +	/* Reset msi_sharing so it is recomputed from current hardware
> +	 * state. On resume, num_online_cpus() or num_msix_usable may
> +	 * have changed, making dedicated MSI-X feasible where it was
> +	 * not before.
> +	 */
> +	gc->msi_sharing =3D false;
> +

Does this unconditional reset unintentionally overwrite the platform constr=
aint
for systems without dynamic MSI-X support?

[ ... ]

> @@ -1889,6 +1936,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *p=
dev)
>  		/* Need 1 interrupt for HWC */
>  		max_irqs =3D min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1;
>  		min_irqs =3D 2;
> +		gc->msi_sharing =3D true;
>  	}
> =20
>  	nvec =3D pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);

The commit message states that sharing is always used when the platform does
not support dynamic MSI-X allocation. This is successfully set here in
mana_gd_setup_hwc_irqs().

However, looking at mana_gd_setup(), mana_gd_query_max_resources() is called
after mana_gd_setup_hwc_irqs().

Will this execution order cause the driver to ignore the limitation and
attempt to use dedicated MSI-X vectors if there happen to be enough
pre-allocated vectors to satisfy the per-vPort math later in the function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513220956.4020=
58-1-longli@microsoft.com?part=3D2

