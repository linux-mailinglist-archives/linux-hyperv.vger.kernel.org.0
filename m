Return-Path: <linux-hyperv+bounces-11827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BPUHKxmwRmqXbgsAu9opvQ
	(envelope-from <linux-hyperv+bounces-11827-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:38:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BC96FC2A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Jul 2026 20:38:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L5ZevbvT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11827-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11827-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD14A33368AF
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jul 2026 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8AF3655D5;
	Thu,  2 Jul 2026 18:02:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E968353A8D
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Jul 2026 18:02:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015329; cv=none; b=bTjkv3Kl7GZ6IN6WXKBwSX5ZzFaJX0QnAIpABFbaeOiikB6agbd9V3VFmvlIBe15o1rnV4pZnJc5/eCbeNkly1DchwQHtwP4/mEwnp0Jjkev5YIWO8fWZ9VRzGC36ZsdTFztY9YQacRWTj7bCn8G57yE7ORdjMZU+4MeFsZyoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015329; c=relaxed/simple;
	bh=Xe77sodh1hCAo7GbZ9URyFEy8NkYRBog8DOs2cBqDXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XiEoA2XHy6GZt1rAfUzyygweb2G7PZeYyifTCrYGZaEj/qrpQ4j9QyokBABdFEVSRKu+rG1H4s/N+lupmbkyVyYp/P5jjCj1Jvi7/SFqzvZixq3fuP5GpjQmAIwtPBL+W+AdP3U3gd/YWv7EDgerx0Bn0TE94dIUJ5zPB8pZ+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5ZevbvT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8221F000E9;
	Thu,  2 Jul 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783015328;
	bh=lddvbKAwlwsuhHKBf2U4RUJVcjB3vrJ0L4DOGSAgG1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L5ZevbvTpywqv3vyKTw5YxV21bXuuMQ+6Qf3G4Z6JWFQLfTagY/htEuwfiiNs/JPl
	 xacojax6FaYJDtbJUnLORQ4JBNlxTLKsGWaIn5eOJKqnUcd16kc57fDk2BHiExkRfY
	 uEcEXWKomsFcHSUXWSvSApMyOA5kyr50ZMZ23GHRzw751Vs9OBkOdV2Keh1OkjcRds
	 7kNye8WcjF9SiV4LknWfbDZbr7ccFH44vxfVs/6tK5DClK10XYyqgM3WagP9I1hbna
	 vfLgGD31TP9DizmelIvxg3zWVC7EV7zPWcDRqQgIAufYO/+QSHx9GoM/1Pj59pIEsh
	 4uGFcqvaNaZKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Add handler for sriov configure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260701180116.507690-1-haiyangz@linux.microsoft.com>
References: <20260701180116.507690-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 18:02:07 +0000
Message-Id: <20260702180208.1C8221F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-11827-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2BC96FC2A7

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Disabling SR-IOV without checking if Virtual Functions (VFs) are a=
ssigned to a guest VM.
- [High] Missing SR-IOV cleanup during PF driver removal and shutdown.
--

commit 3df823cc57367f69930deb6dc48172ce7d77e785
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Add handler for sriov configure

Add callback function for the pci_driver / sriov_configure.

It asks the NIC to provide certain number of VFs, or disable
VFs if the request is zero.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index e8b7ffb47eb98..f7a79874fd0eb 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -2496,6 +2496,20 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }

[Severity: High]
With the addition of SR-IOV support in this patch, do mana_gd_shutdown() and
mana_gd_remove() need to call pci_disable_sriov()?

If a user enables VFs via sysfs and then unbinds the driver or shuts down t=
he
system, could this omission introduce a regression where orphaned, dead VF =
PCI
devices are left in the kernel?

Accessing these orphaned VFs might trigger use-after-free crashes or hardwa=
re
faults, as the underlying PF hardware and driver context have been destroye=
d.

> +static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int err =3D 0;
> +
> +	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
> +
> +	if (numvfs > 0)
> +		err =3D pci_enable_sriov(pdev, numvfs);
> +	else
> +		pci_disable_sriov(pdev);

[Severity: High]
Should this path check if the VFs are currently assigned to a guest VM befo=
re
disabling SR-IOV?

If a privileged user writes 0 to sriov_numvfs while VFs are actively assign=
ed
to a VM (e.g., via vfio-pci), could forcefully removing the PCI devices cau=
se
a regression resulting in host IOMMU faults and guest kernel panics?

Would it be better to check pci_vfs_assigned(pdev) here, or use the
pci_sriov_configure_simple() helper to safely enforce this?

> +
> +	return err ? err : numvfs;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701180116.5076=
90-1-haiyangz@linux.microsoft.com?part=3D1

