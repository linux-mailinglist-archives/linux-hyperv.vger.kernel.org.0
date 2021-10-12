Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8031C42AC55
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Oct 2021 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhJLSty (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 12 Oct 2021 14:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhJLStx (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 12 Oct 2021 14:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50DF660F38;
        Tue, 12 Oct 2021 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634064471;
        bh=g0UlFNB7A1rfYG89xyudfyZaI1PGZI9nFZxmcnLOcw0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=syx3c2/rFgh3PpODLTFKuzyIhCUSWKCeTzWAW55vCDKSRbcAcBTnIxmu9cwL6reDJ
         4nxMwj8lq/1zy32JtRzwp0HWrk1rKcVtWol2VI+UjZNM/rp/A39D2yv+fQyhYq0dzb
         yu8b1IR/vCUj/hfkjX+5ZdmxB78tazKuWykR2+e4pOduuoauxZjwKcN6kreTLpc1Z5
         f+0ZT7M0YkzoZ+ye5KXJ7wOQyzLellDlvwHKyjOpWIYGCPof1DpRRX5GqNVLX68hVd
         2hUx548Ii1BlScX4YlSzuTqX5R4cLIBMxCl0rDbhCCmQeZihlRlfVog8/JwpushVGo
         zTXt1gdwLTDGA==
Date:   Tue, 12 Oct 2021 13:47:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: hv: Remove unnecessary integer promotion from
 dev_err()
Message-ID: <20211012184749.GA1775474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008222732.2868493-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 08, 2021 at 10:27:30PM +0000, Krzysztof Wilczyński wrote:
> Internally, printk() et al already correctly handles the standard
> integer promotions, so there is no need to explicitly "%h" modifier as
> part of a format string such as "%hx".
> 
> Thus, drop the "%h" modifier as it's completely unnecessary (N.B. this
> wouldn't be true for the sscanf() function family), and match preferred
> coding style.
> 
> Related:
>   commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary
>   commit 70eb2275ff8e ("checkpatch: add warning for unnecessary use of %h[xudi] and %hh[xudi]")
>   https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
> 
> No change to functionality intended.

Applied 1/3 and 3/3 to pci/misc for v5.16, thanks!

For 2/3, I think we might want to convert the VF ID to be unsigned
consistently.

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 67c46e52c0dc..6733cb14e775 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3126,14 +3126,14 @@ static int hv_pci_probe(struct hv_device *hdev,
>  
>  	if (dom == HVPCI_DOM_INVALID) {
>  		dev_err(&hdev->device,
> -			"Unable to use dom# 0x%hx or other numbers", dom_req);
> +			"Unable to use dom# 0x%x or other numbers", dom_req);
>  		ret = -EINVAL;
>  		goto free_bus;
>  	}
>  
>  	if (dom != dom_req)
>  		dev_info(&hdev->device,
> -			 "PCI dom# 0x%hx has collision, using 0x%hx",
> +			 "PCI dom# 0x%x has collision, using 0x%x",
>  			 dom_req, dom);
>  
>  	hbus->bridge->domain_nr = dom;
> -- 
> 2.33.0
> 
