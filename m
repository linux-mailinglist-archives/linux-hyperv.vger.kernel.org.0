Return-Path: <linux-hyperv+bounces-9711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEHWOqrewWnxXQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9711-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 01:45:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E72FFF1E
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29E1F3017DF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 00:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5025A2C9;
	Tue, 24 Mar 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCd4Q3vB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA85211A05;
	Tue, 24 Mar 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313087; cv=none; b=XGDXKLpdDA2Wt31CCJQwLZUpoBSmM5kg+o2EfI33vucdVGkkmfffSiMKqXi9pNW4g8axJ9smUpWhBB8rvPUjnfmNsPfM02tDrjM1ET2N4uEAtevY1dij87EAchzFm1dF1OXtUE5E/TRceL4SD2nGe95tG//KGQef9mTC72eQ6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313087; c=relaxed/simple;
	bh=3NSu7dAMpTidKifNZ3xkJ8mY9uh7nIOtKm0YyLlr0gc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESPngaxZ6IpKWUGz344fE47nwC022tHOq+e8oaMqWQNoxp1vB5neoPKVEjjGv5FqwK5TD7vcXY3JHPlnm7mRbyb1R5GKanBX+uqQeSXVO3Bn/WooATx6KChpziCTXJleoTYerelc15poFdNMBuq57jNl8OyHKhwpRV47JoQMEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCd4Q3vB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5F9C4CEF7;
	Tue, 24 Mar 2026 00:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774313086;
	bh=3NSu7dAMpTidKifNZ3xkJ8mY9uh7nIOtKm0YyLlr0gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCd4Q3vBmKwC5MsElOJY+nQA1z6tzazp9xgKuaDXql8okKIclHvZzXa7En2D1bIDq
	 j+/nzNSawpniCaoaTp0P5W2/dLQ4Fymf/WgJklz6R8bCvJ9PpLHYtBGhKdwFy41+QG
	 NuF67KIti868RCndQrOdNQls9ouGwf3vnvpgibMz38997iqgqlO2x5BTO5vUs7rOYI
	 mV6UYtSkxgT1RbVZMebR23oTn3xifwy6ky+CljXK16ZEEZf2uvcg+hI5Lv+pMkTzxK
	 /CNIJVxRL99eMopvx79siDEqU4FL89YUa6osaI2jB5k8JbORrcZ7ohBWqlmyxKPLmf
	 GcCPWqBP03BGA==
Date: Mon, 23 Mar 2026 17:44:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
 dipayanroy@linux.microsoft.com, yury.norov@gmail.com, kees@kernel.org,
 ssengar@linux.microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <20260323174444.2717da3d@kernel.org>
In-Reply-To: <20260319070926.1459515-1-ernis@linux.microsoft.com>
References: <20260319070926.1459515-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9711-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA8E72FFF1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 00:09:13 -0700 Erni Sri Satya Vennela wrote:
> Add debugfs entries to expose hardware configuration and diagnostic
> information that aids in debugging driver initialization and runtime
> operations without adding noise to dmesg.
> 
> The debugfs directory creation and removal for each PCI device is
> integrated into mana_gd_setup() and mana_gd_cleanup_device()
> respectively, so that all callers (probe, remove, suspend, resume,
> shutdown) share a single code path.
> 
> Device-level entries (under /sys/kernel/debug/mana/<slot>/):
>   - num_msix_usable, max_num_queues: Max resources from hardware
>   - gdma_protocol_ver, pf_cap_flags1: VF version negotiation results
>   - num_vports, bm_hostmode: Device configuration
> 
> Per-vPort entries (under /sys/kernel/debug/mana/<slot>/vportN/):
>   - port_handle: Hardware vPort handle
>   - max_sq, max_rq: Max queues from vPort config
>   - indir_table_sz: Indirection table size
>   - steer_rx, steer_rss, steer_update_tab, steer_cqe_coalescing:
>     Last applied steering configuration parameters

AI says:

> @@ -1918,15 +1930,23 @@ static int mana_gd_setup(struct pci_dev *pdev)
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	int err;
>  
> +	if (gc->is_pf)
> +		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
> +	else
> +		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
> +							  mana_debugfs_root);

If pdev->slot is NULL (which can happen for VFs in environments like generic
VFIO passthrough or nested KVM), will pci_slot_name(pdev->slot) cause a
NULL pointer dereference?

Also, could this naming scheme cause name collisions? If multiple PFs are
present, they would all try to use "0". Similarly, VFs across different
PCI domains or buses might share the same physical slot identifier, leading
to -EEXIST errors. Would it be safer to use the unique PCI BDF via
pci_name(pdev) instead?

> @@ -3141,6 +3149,24 @@ static int mana_init_port(struct net_device *ndev)
>  	eth_hw_addr_set(ndev, apc->mac_addr);
>  	sprintf(vport, "vport%d", port_idx);
>  	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
> +
> +	debugfs_create_u64("port_handle", 0400, apc->mana_port_debugfs,
> +			   &apc->port_handle);

When operations like changing the MTU or setting an XDP program trigger a
detach/attach cycle, mana_detach() invokes mana_cleanup_port_context(),
which recursively removes the apc->mana_port_debugfs directory.
During re-attachment, mana_attach() calls mana_init_port(), which
recreates the directory and the new files added in this patch. However, the
pre-existing current_speed file (created in mana_probe_port()) is not
recreated here.

Does this cause the current_speed file to be permanently lost after a
detach/attach cycle? Should the creation of current_speed be moved to
mana_init_port() so it survives the cycle?
-- 
pw-bot: cr

