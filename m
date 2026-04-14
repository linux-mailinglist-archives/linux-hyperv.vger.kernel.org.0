Return-Path: <linux-hyperv+bounces-10147-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i+HYNNvF3WlYjAkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10147-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 06:43:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46D3F5827
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 06:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9754303FAA2
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 04:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CD2727E2;
	Tue, 14 Apr 2026 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYnYqVKg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C1923EA94;
	Tue, 14 Apr 2026 04:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776141784; cv=none; b=JyMzAl2qbj5k4BPS3VOrKph5JyIMSLpMIaYUwtnpmI5f81bxPGyrMrPnlDb83wVH85A20oCu1X3NMeIzvHta/QpD4Umg+mkJCjZUUvjPuegqu+uIuAqAK/qzL1T6md6Q1uQg6JGOK+YWaEA7nrcGVev4jZRsLnyjp3MaMwEsZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776141784; c=relaxed/simple;
	bh=e/BPH2h+nZPRVrxfRKT1ziyVJ4Lnh+hL6hFNVjHyb8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN4pHy7RtQTcSA5Hyg0a1zrZXsqakADVirvsjpFPCya/k+oQDT5nsQHznrFJv6mieCFumhBBlFzedCxLloHf0jyBO/q/7MJTzpd3XEClMCJ2wvItoYfURM2oql71dnGq/LyvsSHJOS8g0qzut4dSaA2BLuo5yIvNxS0tfqlXLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYnYqVKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A54AC19425;
	Tue, 14 Apr 2026 04:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776141783;
	bh=e/BPH2h+nZPRVrxfRKT1ziyVJ4Lnh+hL6hFNVjHyb8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYnYqVKgzRlGTEeRmTM9EH6dnJi2YNsxoAjpS2mqPMROVogr9MdRvDZhBMCgGjzxv
	 5gLFu8fnsUz1AQFWXhrWjySnXxnai2d/ypecJZHQQtcBb4Iyic9SlXozHTv4aEEqJG
	 x51loIXt7VQNxEciw1h9fWP0RypyyzcSJ+QNb7ViIf2+x5glhkKp0hDfUh0SxTwfNc
	 2ZfEhaUXSOFhtg/wW/x6I/CHF29f6dV/tFKcz9z+0i70Y5KpOebnym/wJFPAqJGA20
	 VO1nGA0PA0Daih/Zv35DD/YgTicmmFklLE9KU7FZDwtJ204sQTSmLYELqLhXF0euT3
	 xjiTxjGlBuvUA==
Date: Tue, 14 Apr 2026 04:43:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mukesh Rathor <mrathor@linux.microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Export hv_vmbus_exists() and use it
 in pci-hyperv
Message-ID: <20260414044302.GA2787213@liuwe-devbox-debian-v2.local>
References: <20260409215232.399350-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409215232.399350-1-decui@microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10147-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 2F46D3F5827
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 02:52:32PM -0700, Dexuan Cui wrote:
> With commit f84b21da3624 ("PCI: hv: Don't load the driver for baremetal root partition"),
> the bare metal Linux root partition won't use the pci-hyperv driver, but
> when a Linux VM runs on the Linux root partition, pci-hyperv's module_init
> function init_hv_pci_drv() can still run, e.g. in the case of
> CONFIG_PCI_HYPERV=y, even if the VMBus driver is not used in such a VM
> (i.e. the hv_vmbus driver's init function returns -ENODEV due to
> vmbus_root_device being NULL).
> 
> In such a Linux VM, init_hv_pci_drv() runs with a side effect: the 3
> hvpci_block_ops callbacks are set to functions that depend on hv_vmbus.
> 
> Later, when the MLX driver in such a VM invokes the callbacks, e.g. in
> drivers/net/ethernet/mellanox/mlx5/core/lib/hv.c:
> mlx5_hv_register_invalidate(), hvpci_block_ops.reg_blk_invalidate() is
> hv_register_block_invalidate() rather than a NULL function pointer, and
> hv_register_block_invalidate() assumes that it can find a struct
> hv_pcibus_device from pdev->bus->sysdata, which is false in such a VM.
> 
> Consequently, hv_register_block_invalidate() -> get_pcichild_wslot() ->
> spin_lock_irqsave() may hang since it can be accessing an invalid
> spinlock pointer.
> 
> Fix the issue by exporting hv_vmbus_exists() and using it in pci-hyperv:
> 
>     hv_root_partition() is true and hv_nested is false ==>
> 	hv_vmbus_exists() is false.
> 
>     hv_root_partition() is true and hv_nested is true ==>
> 	hv_vmbus_exists() is true.
> 
>     hv_root_partition() is false ==> hv_vmbus_exists() is true.
> 
> While at it, rename vmbus_exists() to hv_vmbus_exists() to follow the
> convention that all public functions have the hv_ prefix; also change
> the return value's type from int to bool to make the code more readable;
> also move the two pr_info() calls.
> 
> Reported-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied. Thanks.

