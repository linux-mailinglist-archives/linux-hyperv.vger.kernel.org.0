Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D606A58D3F
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Jun 2019 23:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0ViU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Jun 2019 17:38:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59897 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0ViU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Jun 2019 17:38:20 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgc5v-0000s3-Ge; Thu, 27 Jun 2019 23:38:15 +0200
Date:   Thu, 27 Jun 2019 23:38:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
cc:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] x86: hv: hv_init.c: Add functions to allocate/deallocate
 page for Hyper-V
In-Reply-To: <d19c28cda88bf1706baff883380dfd321da30a68.1560837096.git.m.maya.nakamura@gmail.com>
Message-ID: <alpine.DEB.2.21.1906272334560.32342@nanos.tec.linutronix.de>
References: <cover.1560837096.git.m.maya.nakamura@gmail.com> <d19c28cda88bf1706baff883380dfd321da30a68.1560837096.git.m.maya.nakamura@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya,

On Tue, 18 Jun 2019, Maya Nakamura wrote:

> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 0e033ef11a9f..e8960a83add7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> +void *hv_alloc_hyperv_page(void)
> +{
> +	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
> +
> +	return (void *)__get_free_page(GFP_KERNEL);
> +}
> +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> +
> +void hv_free_hyperv_page(unsigned long addr)
> +{
> +	free_page(addr);
> +}
> +EXPORT_SYMBOL_GPL(hv_free_hyperv_page);

These functions need to be declared in a header file.

Thanks,

	tglx


