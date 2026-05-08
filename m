Return-Path: <linux-hyperv+bounces-10721-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CgeEDhd/mkWpgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10721-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:01:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F64FC1D9
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEADC3028EAC
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 22:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CCA33AD85;
	Fri,  8 May 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz/hujLN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352028B4E2;
	Fri,  8 May 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277676; cv=none; b=cvMaK4O5K2M1niL+42J+7gVVGckmTRByCfYrZRS0uvE2xyyCz0C+W9Ugbgacy/z3q+2luAX2tuKINqLT4mj+vzDdSdtpUqq8VbdGJvh/gPk6k0a/DgNUj2E8wNuGmsKcy77FW+9Ot92Sh1FXIl88iO2HZ8Btcdq/O4J9lBZhD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277676; c=relaxed/simple;
	bh=dlC8DEal6+mRXnMYoeF8CMQ2mQkWznW4KNJd1nWPFQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XniJ19IwQl67aoSb7LyitpyjVDlWEWcZyPwD/wAX2htivyskbyed/uig8akaYKHSfRjIP++wL/6O79sDItq4JBcqxU/uTPPVk5PeSAzCutpX9CFVOrZ6B4alDpXuGqXaBuemy+Wuq6v1+5YBBkdMnGM1cGvbMbAR9Wv/kXFW9fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz/hujLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546D4C2BCB0;
	Fri,  8 May 2026 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277676;
	bh=dlC8DEal6+mRXnMYoeF8CMQ2mQkWznW4KNJd1nWPFQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pz/hujLNL49drlwd018RK77gQJq2N1oJrh0BSaqLivLfeYA9ZtV4KhDTYYxA7nqsf
	 91Vd6wzlrjr8sod6vjPQhJe1BdHlRuzFPIWQW6vva2b/kqEGZ05jw31lxx+8mHYKvZ
	 xl+yfrv1aswFl5HjgLwn2hQbg7gbpRPRkClF6/3okLeu4ae46kCWKb8vmH4veLpzEb
	 WEHPx4M+OKF2RpEJlzNHkkAsct9Hs5banunHfe0iEJ6AHjg+MhVT9gIZ4HgySnqfip
	 DqwU6A4K9OdlN+on5/qjIdLYPYXeXuoqiJijywJCR5SoHMHA1Y4uaX+A9oWRrd5vei
	 gmrH8Vsw6LT4g==
From: Jakub Kicinski <kuba@kernel.org>
To: ernis@linux.microsoft.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v8] net: mana: Expose hardware diagnostic info via debugfs
Date: Fri,  8 May 2026 15:01:14 -0700
Message-ID: <20260508220114.3342627-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506055128.291494-1-ernis@linux.microsoft.com>
References: <20260506055128.291494-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC3F64FC1D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10721-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: mana: Expose hardware diagnostic info via debugfs

Add debugfs entries to expose hardware configuration and diagnostic
information that aids in debugging driver initialization and runtime
operations without adding noise to dmesg.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -2231,13 +2239,18 @@ int mana_gd_resume(struct pci_dev *pdev)
>  
>  	err = mana_probe(&gc->mana, true);
>  	if (err)
> -		return err;
> +		goto cleanup_gd;
>  
>  	err = mana_rdma_probe(&gc->mana_ib);
>  	if (err)
> -		return err;
> +		goto cleanup_mana;
>  
>  	return 0;
> +cleanup_mana:
> +	mana_remove(&gc->mana, true);
> +cleanup_gd:
> +	mana_gd_cleanup_device(pdev);
> +	return err;
>  }

Since mana_remove() called with true for suspending skips
unregister_netdevice(), the network devices remain registered in the system.

If mana_gd_cleanup_device() is then called, which destroys the hardware
channel and clears gc->hwc.driver_data, could this lead to a NULL pointer
dereference if userspace later interacts with the still-registered devices?

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> @@ -3161,6 +3169,23 @@ static int mana_init_port(struct net_device *ndev)
>  	eth_hw_addr_set(ndev, apc->mac_addr);
>  	sprintf(vport, "vport%d", port_idx);
>  	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
> +
> +	debugfs_create_u64("port_handle", 0400, apc->mana_port_debugfs,
> +			   &apc->port_handle);

When the device suspends, mana_gd_suspend() calls mana_gd_cleanup_device(),
which recursively removes the entire debugfs directory tree.

During resume, the parent debugfs directory is recreated, but mana_probe()
skips calling mana_init_port() for existing ports.

Does this mean the per-vPort debugfs entries are permanently lost after a
suspend and resume cycle?

[ ... ]
> @@ -3800,6 +3830,9 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  
>  	mana_gd_deregister_device(gd);
>  
> +	debugfs_lookup_and_remove("bm_hostmode", gc->mana_pci_debugfs);
> +	debugfs_lookup_and_remove("num_vports", gc->mana_pci_debugfs);
> +
>  	if (suspending)
>  		return;

Earlier in mana_remove(), free_netdev() is called, which frees the port
context structure (apc) allocated via netdev_priv(ndev).

Since the per-vPort debugfs files created in mana_init_port() directly
reference memory within apc, and apc->mana_port_debugfs is not explicitly
removed here, does this leave the debugfs files accessible but pointing to
freed memory until the parent directory is finally removed in
mana_gd_cleanup_device()?

