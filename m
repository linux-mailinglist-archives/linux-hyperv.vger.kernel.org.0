Return-Path: <linux-hyperv+bounces-8713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKOzD8Q9g2kPkQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8713-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 13:38:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB06DE5E53
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B813004634
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665523E8C7D;
	Wed,  4 Feb 2026 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEaiROt5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440F82C21EC;
	Wed,  4 Feb 2026 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208706; cv=none; b=Xc6W9iSSKAv++JVvOEneWR7WD6KCJgbbcIpSh/nMAShQcs5JC5LbX+CbZPAyNM4RzDKRYNSbjz05dBP//St8TtPgG0SBZ9oqQSUkZxNRDfoYrIjtmaPvJ7BQ3wjh94/QuZKY54EjNp7OJeOHVlWcIeu7jfaMzaCpb09UaEa0Isk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208706; c=relaxed/simple;
	bh=QjTkEFh9Z7+vYHXhZJPmcgYBg55SoIB8GLp3IxRx09Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdCxP+QuoD+Um8APvd1fmOD/uYnWTh/zo9Eurp/f/pPnBe6vHMrGEV8HFwQCVGFT5oUthz/aM/Cg2TIiWl4wyHxwI5DiMcIMxwoAkjFEakPNCIzTngsqGsWmuxSMIfqtxTB9W7u3uImJiqEWjeoag4v7Ru5yytjHmPvgTBBI77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEaiROt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9F4C19422;
	Wed,  4 Feb 2026 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208705;
	bh=QjTkEFh9Z7+vYHXhZJPmcgYBg55SoIB8GLp3IxRx09Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEaiROt5pv1sUvQKhOW+pviEld9OB4K0vJzVEP4RSWuZsGxT6tftAwsnlCufXle27
	 YEx7zj2IK595Tkt1WnV2CZKHm0TgN8eE7Yw9H6+dgib6mTL1oVkYSMw/MdXQoLnWtx
	 wvIBDrCnTzEsmFcGEidocaKfSC1p4vjJXrJIE+M/ln0WvEnGTBl690Z1NayJjRvMqQ
	 CmsUFuKASDa7jJtgkimOQ8g2Rvewz+3TlRJXxbQquamkRXIuI5pzDt+Qs9aZJK6iqR
	 tM9RCM/BzuiG9CriXJ37ozY2GWm2rO6K/TDCom1WTawJjnO+RWZsUoLgPt8JHbfgns
	 Nx4eJM6qhgoXg==
Date: Wed, 4 Feb 2026 18:08:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: pci-hyperv-intf: remove unnecessary
 module_init/exit functions
Message-ID: <uzgdfs2oxied6634png3ncsxgoy7pcoy6lozmppglu7uihli5s@aea7ity26eds>
References: <20260131020017.45712-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131020017.45712-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8713-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB06DE5E53
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 06:00:17PM -0800, Ethan Nelson-Moore wrote:
> The pci-hyperv-intf driver has unnecessary empty module_init and
> module_exit functions. Remove them. Note that if a module_init function
> exists, a module_exit function must also exist; otherwise, the module
> cannot be unloaded.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/controller/pci-hyperv-intf.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv-intf.c b/drivers/pci/controller/pci-hyperv-intf.c
> index 28b3e93d31c0..18acbda867f0 100644
> --- a/drivers/pci/controller/pci-hyperv-intf.c
> +++ b/drivers/pci/controller/pci-hyperv-intf.c
> @@ -52,17 +52,5 @@ int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
>  }
>  EXPORT_SYMBOL_GPL(hyperv_reg_block_invalidate);
>  
> -static void __exit exit_hv_pci_intf(void)
> -{
> -}
> -
> -static int __init init_hv_pci_intf(void)
> -{
> -	return 0;
> -}
> -
> -module_init(init_hv_pci_intf);
> -module_exit(exit_hv_pci_intf);
> -
>  MODULE_DESCRIPTION("Hyper-V PCI Interface");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

