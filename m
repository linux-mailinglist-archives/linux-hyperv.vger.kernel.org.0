Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122F11E1DF9
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 May 2020 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgEZJJG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 May 2020 05:09:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39299 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbgEZJJG (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 May 2020 05:09:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id t18so5566095wru.6;
        Tue, 26 May 2020 02:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKd3JTZJplU94QhSKbd/esureWVCaIfQr3MBhsFOydU=;
        b=JP1t2cqm2SVT1Q4DCatQdYHGn8I3e/sa2hyC5U5BhY1jtaJg44fgqGfVOUr553z7IN
         /Mg/oIJp9bwevUY8KcfzVmIIiL1B/hV8j2AJ95GOCseSawd4qJUixZHbMsz6PYbMgJu5
         inkgEsndHe7zSvbxd1SdqCabKqvV4MMuHGxOmOMt04DH1q48+/st1E2JpZ1LNB/O6tXS
         McjVEqY10IkuOj8MdBa1Pw9mItt8J+bFMbtCxTQh7HDPIBCYzsksMOrVgnzv7/jHa3q5
         9g4jWtOdSNwYgA9E71XHivBuhYQkHRgX+f/hBmqcnQGITfyl1qGzVz1bHZIlLEtw2VLd
         KP2w==
X-Gm-Message-State: AOAM532ux4NkS87NSDmNbQ7wxrsvBowzwO8mKy/+7AoSwUvelyExZY1v
        BrF5H4tuU+wFZpH0ma3jKB5DhauC
X-Google-Smtp-Source: ABdhPJzPzLK8j+Jjs7Zi3RaE1b1BwpiXzaWJ/jf4rjIE+RvGFP9AEm4LkOXcV313giaSc3ZJ2hBKvw==
X-Received: by 2002:adf:f702:: with SMTP id r2mr19812123wrp.191.1590484144074;
        Tue, 26 May 2020 02:09:04 -0700 (PDT)
Received: from debian (82.149.115.87.dyn.plus.net. [87.115.149.82])
        by smtp.gmail.com with ESMTPSA id n17sm20446723wrr.42.2020.05.26.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:09:03 -0700 (PDT)
Date:   Tue, 26 May 2020 10:09:01 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/hyper-v: Constify hyperv_ir_domain_ops
Message-ID: <20200526090901.xuzobaw2v4lapfdc@debian>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
 <20200525214958.30015-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525214958.30015-2-rikard.falkeborn@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 25, 2020 at 11:49:57PM +0200, Rikard Falkeborn wrote:
> The struct hyperv_ir_domain_ops is not modified and can be made const to
> allow the compiler to put it in read-only memory.
> 
> Before:
>    text    data     bss     dec     hex filename
>    2916    1180    1120    5216    1460 drivers/iommu/hyperv-iommu.o
> 
> After:
>    text    data     bss     dec     hex filename
>    3044    1052    1120    5216    1460 drivers/iommu/hyperv-iommu.o
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/iommu/hyperv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index a386b83e0e34..3c0c67a99c7b 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -131,7 +131,7 @@ static int hyperv_irq_remapping_activate(struct irq_domain *domain,
>  	return 0;
>  }
>  
> -static struct irq_domain_ops hyperv_ir_domain_ops = {
> +static const struct irq_domain_ops hyperv_ir_domain_ops = {
>  	.alloc = hyperv_irq_remapping_alloc,
>  	.free = hyperv_irq_remapping_free,
>  	.activate = hyperv_irq_remapping_activate,
> -- 
> 2.26.2
> 
