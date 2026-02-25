Return-Path: <linux-hyperv+bounces-8984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6CJtb2nmm+YAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8984-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 14:19:18 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74BA197E8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 224EE30200DC
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FDC3B5317;
	Wed, 25 Feb 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYgI/wBB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0D3ACF0B;
	Wed, 25 Feb 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025553; cv=none; b=W9lDWk+e7zPkIo1XtDmiKAyYkxkuQPVOiGuytCWIdo9oZDlpEUhU5zjvgAPUPeUkI3Oq50Lg61NN1/p8UU4he2zDAh2ygl3hu7USCoHtlCWuZBleQJZNN/+cv9J/O4wqVJStr456kVIKsMK3nBILC37/Ga6dgeJnzCegIxPRkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025553; c=relaxed/simple;
	bh=JsHNTuDpDaTenv/doXJeT6JTO4Gzv/IyY7siVzebZek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwJEC0NJGq7DDRtTDuKtKAc27iuTW3OXln2jILAN9O47/j/RTyHn87Jt2wcazjSAGG52e4sm8WQUn3z7ukE7oIK5WNzrk3O1Kvu1oxLCDC9U13cpfmy58xPwJJMLZWx/OOMaL/+ArpjSef9dhCetXBuy7SNgm+9GviutkK3/FdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYgI/wBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF600C116D0;
	Wed, 25 Feb 2026 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025552;
	bh=JsHNTuDpDaTenv/doXJeT6JTO4Gzv/IyY7siVzebZek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jYgI/wBBIjm7WRhcOiIVl3RoGnGfZMdVlbgwEUIWrVx8v7cLefQKJTlI86LkLu6eC
	 k0XT2Yp05DVZC9Bjl5I2tH+opZM7btcHssfQrsUnY1ZrqoNoXz6/+mBt91buZcevYZ
	 75DLbWXpWPQYFXvTv+TVfi/ywxUD0k4BPN0VAM+h3CSSS5T2Egg9wnVYzBy5MfeYYY
	 4LD00VeqE7ZOt34uIGB+8ZoPDVhC7B1+fm+w5uN6qkWsOqxDfapHLgXSun+66EC/Sb
	 YCWBrxfRn7o/HYA+s6HkXHTwnrgmPqkVqpU8HiKN+im03/fmToQkvlo/y5u9iqMLOK
	 os0KW0LWcRTUw==
Date: Wed, 25 Feb 2026 13:19:06 +0000
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	dipayanroy@microsoft.com, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net] net: mana: Fix double destroy_workqueue on service
 rescan PCI path
Message-ID: <aZ72yhY98hVbHSrr@horms.kernel.org>
References: <aZ2bzL64NagfyHpg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ2bzL64NagfyHpg@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8984-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B74BA197E8C
X-Rspamd-Action: no action

+ Leon

On Tue, Feb 24, 2026 at 04:38:36AM -0800, Dipayaan Roy wrote:
> While testing corner cases in the driver, a use-after-free crash
> was found on the service rescan PCI path.
> 
> When mana_serv_reset() calls mana_gd_suspend(), mana_gd_cleanup()
> destroys gc->service_wq. If the subsequent mana_gd_resume() fails
> with -ETIMEDOUT or -EPROTO, the code falls through to
> mana_serv_rescan() which triggers pci_stop_and_remove_bus_device().
> This invokes the PCI .remove callback (mana_gd_remove), which calls
> mana_gd_cleanup() a second time, attempting to destroy the already-
> freed workqueue. Fix this by NULL-checking gc->service_wq in
> mana_gd_cleanup() and setting it to NULL after destruction.
> 
> Call stack of issue for reference:
> [Sat Feb 21 18:53:48 2026] Call Trace:
> [Sat Feb 21 18:53:48 2026]  <TASK>
> [Sat Feb 21 18:53:48 2026]  mana_gd_cleanup+0x33/0x70 [mana]
> [Sat Feb 21 18:53:48 2026]  mana_gd_remove+0x3a/0xc0 [mana]
> [Sat Feb 21 18:53:48 2026]  pci_device_remove+0x41/0xb0
> [Sat Feb 21 18:53:48 2026]  device_remove+0x46/0x70
> [Sat Feb 21 18:53:48 2026]  device_release_driver_internal+0x1e3/0x250
> [Sat Feb 21 18:53:48 2026]  device_release_driver+0x12/0x20
> [Sat Feb 21 18:53:48 2026]  pci_stop_bus_device+0x6a/0x90
> [Sat Feb 21 18:53:48 2026]  pci_stop_and_remove_bus_device+0x13/0x30
> [Sat Feb 21 18:53:48 2026]  mana_do_service+0x180/0x290 [mana]
> [Sat Feb 21 18:53:48 2026]  mana_serv_func+0x24/0x50 [mana]
> [Sat Feb 21 18:53:48 2026]  process_one_work+0x190/0x3d0
> [Sat Feb 21 18:53:48 2026]  worker_thread+0x16e/0x2e0
> [Sat Feb 21 18:53:48 2026]  kthread+0xf7/0x130
> [Sat Feb 21 18:53:48 2026]  ? __pfx_worker_thread+0x10/0x10
> [Sat Feb 21 18:53:48 2026]  ? __pfx_kthread+0x10/0x10
> [Sat Feb 21 18:53:48 2026]  ret_from_fork+0x269/0x350
> [Sat Feb 21 18:53:48 2026]  ? __pfx_kthread+0x10/0x10
> [Sat Feb 21 18:53:48 2026]  ret_from_fork_asm+0x1a/0x30
> [Sat Feb 21 18:53:48 2026]  </TASK>
> 
> Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servicing events")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 5 ++++-
>  drivers/net/ethernet/microsoft/mana/mana_en.c   | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 0055c231acf6..3926d18f1840 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1946,7 +1946,10 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
>  
>  	mana_gd_remove_irqs(pdev);
>  
> -	destroy_workqueue(gc->service_wq);
> +	if (gc->service_wq) {
> +		destroy_workqueue(gc->service_wq);
> +		gc->service_wq = NULL;
> +	}
>  	dev_dbg(&pdev->dev, "mana gdma cleanup successful\n");
>  }
>  
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9b5a72ada5c4..f69e42651359 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3762,7 +3762,9 @@ void mana_rdma_remove(struct gdma_dev *gd)
>  	}
>  
>  	WRITE_ONCE(gd->rdma_teardown, true);
> -	flush_workqueue(gc->service_wq);
> +
> +	if (gc->service_wq)
> +		flush_workqueue(gc->service_wq);
>  
>  	if (gd->adev)
>  		remove_adev(gd);
> -- 
> 2.43.0
> 

