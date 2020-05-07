Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1A51C9CD5
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 22:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGU6g (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 16:58:36 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:38182 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgEGU6g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 16:58:36 -0400
Received: by mail-oo1-f65.google.com with SMTP id i9so1671875ool.5;
        Thu, 07 May 2020 13:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lxk5gbj1SH/yPDCschhz+W4w8vALXa+wNd/bFZoLVl0=;
        b=nmzny55/ZJR1POywt0YxyR96mUHPFJ1LYiPeP18aCAtwtT9oe3pd9TJENsrTi3rE8n
         AfTTs1UZ44Eq3XM9pGdeVh0FFGPOAiiPBL2cvuujwAlF5zraEfz6yZgpmVgx0pRzP/wL
         TK0X5w8XETaGs8m1QCbPkoDV6jfNl+ZvrgOariJwpF7sCEjkWJt/+HtHoijXkKKHLaDG
         Efy08EfVLaseBZ0T42upyW8Q6lffROOmmuO6MZ1sYmjkRY448+qyicXF6+aWNWGQHr60
         pqHsjO86KZsYFflwtNRwxjYz2EHLBHzVNyqVX7HZ9OA2WLgSwIHbUFEx0NWEvMPDyWuk
         B76Q==
X-Gm-Message-State: AGi0PuaFXPOteTwncD7nqNmmuohooHNZi2tr40jxkmceqTXEKeAwdOLQ
        B7/DqHP8AHDtXqr6G66XYQ==
X-Google-Smtp-Source: APiQypLifuetw0ez5PKSz9qoxtY5MpD6KduLwlCg+SknYXTPTZ6gRRj5HTrEHT0ksAh3kG0Gap+XAg==
X-Received: by 2002:a4a:d136:: with SMTP id n22mr13431215oor.85.1588885113933;
        Thu, 07 May 2020 13:58:33 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v9sm1650909oib.56.2020.05.07.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:58:33 -0700 (PDT)
Received: (nullmailer pid 11452 invoked by uid 1000);
        Thu, 07 May 2020 20:58:31 -0000
Date:   Thu, 7 May 2020 15:58:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>
Subject: Re: [PATCH] PCI: export and use pci_msi_get_hwirq in pci-hyperv.c
Message-ID: <20200507205831.GA30988@bogus>
References: <20200422195818.35489-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422195818.35489-1-wei.liu@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 07:58:15PM +0000, Wei Liu wrote:
> There is a functionally identical function in pci-hyperv.c. Drop it and
> use pci_msi_get_hwirq instead.
> 
> This requires exporting pci_msi_get_hwirq and declaring it in msi.h.
> 
> No functional change intended.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/include/asm/msi.h          | 4 ++++
>  arch/x86/kernel/apic/msi.c          | 5 +++--
>  drivers/pci/controller/pci-hyperv.c | 8 +-------
>  3 files changed, 8 insertions(+), 9 deletions(-)

Would be better if done in a way to remove an x86 dependency. 

I guess this would do it:

#define pci_msi_get_hwirq NULL

when GENERIC_MSI_DOMAIN_OPS is enabled.

> 
> diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
> index 25ddd0916bb2..353b80122b2e 100644
> --- a/arch/x86/include/asm/msi.h
> +++ b/arch/x86/include/asm/msi.h
> @@ -11,4 +11,8 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>  
>  void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
>  
> +struct msi_domain_info;
> +irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
> +				  msi_alloc_info_t *arg);
> +
>  #endif /* _ASM_X86_MSI_H */
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 159bd0cb8548..56dcdd912564 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -204,11 +204,12 @@ void native_teardown_msi_irq(unsigned int irq)
>  	irq_domain_free_irqs(irq, 1);
>  }
>  
> -static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
> -					 msi_alloc_info_t *arg)
> +irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
> +				  msi_alloc_info_t *arg)
>  {
>  	return arg->msi_hwirq;
>  }
> +EXPORT_SYMBOL_GPL(pci_msi_get_hwirq);
>  
>  int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>  		    msi_alloc_info_t *arg)
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index e6020480a28b..2b4a6452095f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1520,14 +1520,8 @@ static struct irq_chip hv_msi_irq_chip = {
>  	.irq_unmask		= hv_irq_unmask,
>  };
>  
> -static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
> -						   msi_alloc_info_t *arg)
> -{
> -	return arg->msi_hwirq;
> -}
> -
>  static struct msi_domain_ops hv_msi_ops = {
> -	.get_hwirq	= hv_msi_domain_ops_get_hwirq,
> +	.get_hwirq	= pci_msi_get_hwirq,
>  	.msi_prepare	= pci_msi_prepare,
>  	.set_desc	= pci_msi_set_desc,
>  	.msi_free	= hv_msi_free,
> -- 
> 2.20.1
> 
