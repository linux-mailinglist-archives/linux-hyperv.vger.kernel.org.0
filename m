Return-Path: <linux-hyperv+bounces-8692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NDeBw7hgmnhdwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8692-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:02:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FCE22B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28D0E3018BF8
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D143361661;
	Wed,  4 Feb 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwV3onC0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D27361DDF;
	Wed,  4 Feb 2026 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184937; cv=none; b=ujlAAiVyLg/ushCeiuXDPAXq93KObgPZQFdj/7JLQ7In0/ynFiK19MBjduFyhBtGm2XxrhQeRVMOTn0lufFoPi4PaI7iutNwz4iYJQsyzDKdi9J4NaThaTw1GVYdmnzCzX9MMwyVzcI17RvAqtiPcwpTPCRtLKfv6yifuOyyH3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184937; c=relaxed/simple;
	bh=xRXMA/dDbdrJX3BOcLGYpGpKjEdBlU3OgbLJdZwIERQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V97OJupcqSNrkc9wmCFK7hT9BY77Tgl4fG1ynQnn5/FtQ3x6tQY5bj1z7B3xXSrE93y0qsodpM0ZUyjz/RG4l22+FoYr9NNVEKEG/I+i+lgj1+KBkumF7YVINNoKAFx/7w3VhsAOQGCb65RnGnZYqDjfZwvszNlNsgjuWXKpkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwV3onC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96398C4CEF7;
	Wed,  4 Feb 2026 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770184936;
	bh=xRXMA/dDbdrJX3BOcLGYpGpKjEdBlU3OgbLJdZwIERQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwV3onC0nhBoKL2RjKnCnjflornaH3TLeEbrbLHWboIQFoS3E+kw99G60f8+3vbLH
	 helaHdfOFdYhY/r+oXmjEpBwihpAJReqITdcU9k0Wfdsz4s+4aQOTuWBcWG1SYrPg7
	 QuQG/6y+1hMRatXqzwYOi1pLDpVurfTBeiXBddvfCeiA8sXqIS0Hb+rKEwQ7LPLL4v
	 PpYOFILtDdRE2YdcjJoh003fBx3BzEHah6EMAH56+Vff4z0JiKe1QaA5Ik2PPaBiQa
	 nbWZj9mbSLjLteiHbKLFW37ZGc3yCCjV6dgZ6yOvHKSxeUa1joUKoI7LOZd8memrlJ
	 EEiK07ms3saCQ==
Date: Wed, 4 Feb 2026 06:02:15 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
Message-ID: <20260204060215.GA79272@liuwe-devbox-debian-v2.local>
References: <20260111170034.67558-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111170034.67558-1-mhklinux@outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8692-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 734FCE22B5
X-Rspamd-Action: no action

On Sun, Jan 11, 2026 at 09:00:34AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Field pci_bus in struct hv_pcibus_device is unused since
> commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

It looks like this trivial patch is not yet picked up. I've queued it
up.

Thanks,
Wei

> ---
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 1e237d3538f9..7fcba05cec30 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -501,7 +501,6 @@ struct hv_pcibus_device {
>  	struct resource *low_mmio_res;
>  	struct resource *high_mmio_res;
>  	struct completion *survey_event;
> -	struct pci_bus *pci_bus;
>  	spinlock_t config_lock;	/* Avoid two threads writing index page */
>  	spinlock_t device_list_lock;	/* Protect lists below */
>  	void __iomem *cfg_addr;
> -- 
> 2.25.1
> 

