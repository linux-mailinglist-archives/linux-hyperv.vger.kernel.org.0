Return-Path: <linux-hyperv+bounces-10730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ic8KrJl/mmoqAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10730-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:37:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254794FC67A
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7F76301BA78
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B363988FB;
	Fri,  8 May 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJkT1dv3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA43312803;
	Fri,  8 May 2026 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279854; cv=none; b=KtUkSYcE/3rCBOUQ5G2te9V2eTcv2+PD/gEAS8OPU0MDj6Ua5ZNMfuWfq2JC2rDgbRJYT2B01tG/AEuU1GWjZ12W9nEYE2ohyD7CM+6aVXXbN+mOr6EJtQVWapWyxszPt2rYeMWo7G0Fi2kZzA21Y+nUpdkcLHnPqXlw9zPmr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279854; c=relaxed/simple;
	bh=ESszwYYzXDY8c9Jphu28lqXtSqTxsI9hvO0qvK9q/rA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nj7iAFyNMSNH4GzDKmWxZQSukjKbL71H3MBhoDeDtpY6I6Qa80T1a5diMnRTI9rVtbP/Z8nSD2pQVRKREH6BnH8sitss7AoxVsdmdwruE1gQO9cb1D/u9BDmpOWqfgKuD8ZM1I268Jf9p4yTdEXe4uK/BwJfq3Bef404+NrZ4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJkT1dv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F28C2BCB0;
	Fri,  8 May 2026 22:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778279854;
	bh=ESszwYYzXDY8c9Jphu28lqXtSqTxsI9hvO0qvK9q/rA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rJkT1dv398X3f6lhlOJhWpO2uWfpdczv9v7am+c1O+q6CQUMH+emzJfV3+56fNrT/
	 ena0fZDVTTPyj/URxd+3bZwtqerfcSpnIIHDxLw9nvDZpJd8/jT+zw0dkEiCQc6Oa9
	 a0NJHKWy1Y9F8T1atjqc8RFUV4VJC9aoRzNaiA7oL9t8dQdm0dgL1s2WTMQmZBcHnH
	 OxlOL/9eOHjpx0N/bE9T1gmjtAuEhbmtUHjMWnjjRIihsXhq16nY1ErVLXaUWJ7jcc
	 jIxQBcYJnsl7XOiJ+b4AoL/XUB/nYAt0kxmO9TROt1ZbXXTlweIKkUQwM7+xlBfToU
	 M768ZHcCd5t5A==
Date: Fri, 8 May 2026 17:37:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	paulros@microsoft.com
Subject: Re: [PATCH net-next] net: mana: Add handler for sriov configure
Message-ID: <20260508223732.GA25113@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508220412.15138-1-haiyangz@linux.microsoft.com>
X-Rspamd-Queue-Id: 254794FC67A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10730-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:04:06PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add callback function for the pci_driver, sriov_configure.
> 
> Also disable VF autoprobe when it runs as PF driver on bare metal,
> since the hardware side may not have the VF ready immediately.
> 
> Export pci_vf_drivers_autoprobe() so the driver can toggle the VF
> autoprobe flag.

Technically pci_vf_drivers_autoprobe() doesn't *toggle* the autoprobe
flag.  That would mean setting it to the opposite of its current
value.

Here I would say "so the driver can prevent autoprobing of the VFs",
which is the intent.

Out of curiosity, how do the VFs eventually get probed?  I guess
there's some other mechanism that tells you when they're ready, and
you manually use sysfs 'sriov_drivers_autoprobe' to enable probing,
then bind drivers to them via sysfs?

The prevention of autoprobing sounds like a critical part of this
change; might be worth saying something in the subject, because "add
sriov configure" doesn't include much information.

> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this would go via a net tree since that's where the bulk of
the changes are.

> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 20 +++++++++++++++++++
>  drivers/pci/iov.c                             |  1 +
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 3bc3fff55999..767f11d5b351 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -2094,6 +2094,11 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	gc->numa_node = dev_to_node(&pdev->dev);
>  	gc->is_pf = mana_is_pf(pdev->device);
> +
> +	/* Disable VF autoprobe on BM */
> +	if (gc->is_pf)
> +		pci_vf_drivers_autoprobe(pdev, false);
> +
>  	gc->bar0_va = bar0_va;
>  	gc->dev = &pdev->dev;
>  	xa_init(&gc->irq_contexts);
> @@ -2262,6 +2267,20 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> +static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int err = 0;
> +
> +	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
> +
> +	if (numvfs > 0)
> +		err = pci_enable_sriov(pdev, numvfs);
> +	else
> +		pci_disable_sriov(pdev);
> +
> +	return err ? err : numvfs;
> +}
> +
>  static const struct pci_device_id mana_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_VF_DEVICE_ID) },
> @@ -2276,6 +2295,7 @@ static struct pci_driver mana_driver = {
>  	.suspend	= mana_gd_suspend,
>  	.resume		= mana_gd_resume,
>  	.shutdown	= mana_gd_shutdown,
> +	.sriov_configure = mana_sriov_configure,
>  };
>  
>  static int __init mana_driver_init(void)
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 91ac4e37ecb9..5a701f44b8fd 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -1127,6 +1127,7 @@ void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
>  	if (dev->is_physfn)
>  		dev->sriov->drivers_autoprobe = auto_probe;
>  }
> +EXPORT_SYMBOL_GPL(pci_vf_drivers_autoprobe);
>  
>  /**
>   * pci_iov_bus_range - find bus range used by Virtual Function
> -- 
> 2.34.1
> 

