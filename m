Return-Path: <linux-hyperv+bounces-9323-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKS7LYecsWnkDAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9323-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 17:47:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E426787B
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 17:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE3E63004DF1
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Mar 2026 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D93E2753;
	Wed, 11 Mar 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZehxxsSB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D33DFC9F;
	Wed, 11 Mar 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247620; cv=none; b=NUXhbzwq1YtX9ur7VbhbdP7Lg+TA/AU2PVTCYMCP5yeuKPNxlExLOEAvI+rivf3kEalNiPcga3DlgkR2OpTpLiD1IlApOSz/8VRUJBGd5EZ1AjgzXK1IBI4BlBjIT41QoDgv+dOXEx0dHKOCV+1B/etpZpSk1PqZheml9wvK4Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247620; c=relaxed/simple;
	bh=V+csIuFPiZnGbvUKN3wg+wCohRFfe/drD2mEXp8Rcck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvNllmwCTVAShIjmuezvmq/jD4WjFh4pbAtF+TB7F+rzJv4fOQx06Lahy2gpkPMfbK9BuTmUiMUJ4GQ+AyavVt5FHFPILM79MbpvCdCI9rcspDWEEfl9/T2bkbfia4fNaBhLqwgmjnwRiYfDUIHrQJ8IXi5crsQdDIzK9drLOFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZehxxsSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBE0C4CEF7;
	Wed, 11 Mar 2026 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773247620;
	bh=V+csIuFPiZnGbvUKN3wg+wCohRFfe/drD2mEXp8Rcck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZehxxsSBqg+PjVX4E0wThvLzSFr1QBAENhA6oI8QhEnsFcl9kzAq3IN0UGFdRPmb+
	 /t1kNA5/p8vSF149L1u70QxmSzYQrN9up6kBiTxLjd5sCT7ZjIkQGpDnggU1xjyTxG
	 WHUN4WuydbXM+AivHKWOM8Hpj+GyCQmflAdI/6fdgUZjhfrdyh0ye4Zs37xx5RmMRl
	 fyHCn/qIxFALdeS6bnTGAIlWF5OsWknK9OxScxG8R00dsiZ73lszUXEkb9zn/B5Y9b
	 R0Vg+FjSqXcWJ1ZN0jT01IgC+gp+RkbMVJvQJIH+djCuUSJGgnNkNLYNX0iBbL3OEn
	 ZWiDgMdfus7eQ==
Date: Wed, 11 Mar 2026 16:46:53 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kotaranov@microsoft.com,
	shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com, kees@kernel.org, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <20260311164653.GS461701@kernel.org>
References: <20260309143840.675606-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309143840.675606-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9323-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C8E426787B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 07:38:28AM -0700, Erni Sri Satya Vennela wrote:

...

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c

...

> @@ -2128,6 +2140,9 @@ int mana_gd_suspend(struct pci_dev *pdev, pm_message_t state)
>  
>  	mana_gd_cleanup(pdev);
>  
> +	debugfs_remove_recursive(gc->mana_pci_debugfs);
> +	gc->mana_pci_debugfs = NULL;

Hi Erni,

The same cleanup of mana_pci_debugfs already appears in a couple of other
places. It seems that all such cleanup is now paired with a call to
mana_gd_cleanup().

So could you consider performing the mana_pci_debugfs cleanup in
mana_gd_cleanup()? Possibly also renaming that function?

> +
>  	return 0;
>  }
>  
> @@ -2140,6 +2155,12 @@ int mana_gd_resume(struct pci_dev *pdev)
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	int err;
>  
> +	if (gc->is_pf)
> +		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> +	else
> +		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> +							  mana_debugfs_root);

Likewise the setup of mana_pci_debugfs seems to now always be paired
with a call to mana_gd_setup().

> +
>  	err = mana_gd_setup(pdev);
>  	if (err)
>  		return err;

...

