Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9903D270D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhGVPNW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhGVPNW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 11:13:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F435C061575;
        Thu, 22 Jul 2021 08:53:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s5so5808303ild.5;
        Thu, 22 Jul 2021 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tqbIeVytySLrVUqucnFueIZLeD4JyyzSEXHu7r6LWKY=;
        b=T7OLQ4uB95BTSn7XrflN3dutNOasGlclR2ro3UFO1eTdyO5zRzDrZz00HSqd7Wefqe
         RO0IKObjQ97rX5br9NR8WynJkInMzlmTnBw87xpH1xuiJAVjWAxSidQtvVLDOSlDSmlb
         5Grw1l4y92/bZIO9FUSqgiaTs6RrrAZq72YLppYjzMyx5x53ZEBs3nl5rFJZk+zACvN1
         GogNijrs/AiRIN7XDjBaViqSQWvzZ2MSMbHes1eCUab8AKTlRXThELswrJxoq/so6EG9
         NMytZTJAT+xBCN8PWMzkhgP7bKOSIWs5IZufPC+Jk5Y3PwMuttTsGPU3SgLUuUD05PUV
         BuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tqbIeVytySLrVUqucnFueIZLeD4JyyzSEXHu7r6LWKY=;
        b=HSl/HCSCx7ruoCDhPiu4qRkK13tMPdwQsQ/BSUOmd+ieVmJkp7dX2UXTONYDH2id0m
         avydF4bUn2aWd5A9jdjriss/8hivzjnRoyeZAYY3BUV9nTQDgSbyEH9ev2+P3zCj7z0M
         nSMhvahZGHwrnyLnDg1LDuduR0AxjA/0Em0wid3FHb0rWpXw39/pni0oFHE3myCbWRST
         JLzRtODKce2f2hUOrOoe3tnT6qneLFvIO5NRFJrwSMJyNHbs98ZGgXPOxiWoKhfZn7yy
         lI7PPFqgboKVDDRdptsF62JZ99JiRGd6nEhMXGp4jSAkrQ8wtDtyziiXfZUxhYd7iIdl
         0QuA==
X-Gm-Message-State: AOAM5307Sllv6M1zH5NALQMmGUA+xxEOqtTlx/uyKeBarFhopdyB9CWA
        Gb5Qd3rhTpyZfICxWMBRXGo=
X-Google-Smtp-Source: ABdhPJxj8N8OHDl/bP3f9RRslCV/V0WWELPx1Q49AuOX2FlR1HIOt1C6pi93dSzCJsoWMVLx1HUaAg==
X-Received: by 2002:a05:6e02:a:: with SMTP id h10mr321144ilr.285.1626969236780;
        Thu, 22 Jul 2021 08:53:56 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id u13sm15652794iot.29.2021.07.22.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:53:56 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1D41627C0054;
        Thu, 22 Jul 2021 11:53:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 22 Jul 2021 11:53:55 -0400
X-ME-Sender: <xms:kpT5YPi72sXKo5FoY9y39_ul142YBMXO94-jjzab0Rg4R1r15N6N3w>
    <xme:kpT5YMD0mGOHaqShxwo_ptb_tAehlozTeBSa_d9NeOzn90ZTeS1P3X5i96-B3YokM
    DNNqE1ECMotz_Ulfw>
X-ME-Received: <xmr:kpT5YPENZezIZD_vWwKyOMB7eqPeWWwvkHFeG3Rho2IF2BZeRRpmQKzsQYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeigdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:kpT5YMThnI6CNQqOl_WVs5IQ-ey5d9nZbAIoFA3bk4VSnXv0O8OyGA>
    <xmx:kpT5YMz8lQDOsSUTF8fWqw-gtrpa20NobUMvOzn28ddbMfs4fva4Jw>
    <xmx:kpT5YC6H8nVaCmmluTy3lgma1XQy4pi1Gkq4Y5eVE99hLTpnlkzH1g>
    <xmx:k5T5YJESizdWq2BHo_QevkUU4HD6lHTa43mHgP5lZYkeW8VqQ1Dmt33BHUQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jul 2021 11:53:53 -0400 (EDT)
Date:   Thu, 22 Jul 2021 23:53:50 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC v5.1 1/8] PCI: Introduce domain_nr in pci_host_bridge
Message-ID: <YPmUjgz2KoPBhHaY@boqun-archlinux>
References: <0210720134429.511541-2-boqun.feng@gmail.com>
 <20210721005336.517760-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721005336.517760-1-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 21, 2021 at 08:53:36AM +0800, Boqun Feng wrote:
> Currently we retrieve the PCI domain number of the host bridge from the
> bus sysdata (or pci_config_window if PCI_DOMAINS_GENERIC=y). Actually
> we have the information at PCI host bridge probing time, and it makes
> sense that we store it into pci_host_bridge. One benefit of doing so is
> the requirement for supporting PCI on Hyper-V for ARM64, because the
> host bridge of Hyper-V doesn't have pci_config_window, whereas ARM64 is
> a PCI_DOMAINS_GENERIC=y arch, so we cannot retrieve the PCI domain
> number from pci_config_window on ARM64 Hyper-V guest.
> 
> As the preparation for ARM64 Hyper-V PCI support, we introduce the
> domain_nr in pci_host_bridge and a sentinel value to allow drivers to
> set domain numbers properly at probing time. Currently
> CONFIG_PCI_DOMAINS_GENERIC=y archs are only users of this
> newly-introduced field.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/probe.c |  6 +++++-
>  include/linux/pci.h | 10 ++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 79177ac37880..60c50d4f156f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -594,6 +594,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
> +	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>  
>  	device_initialize(&bridge->dev);
>  }
> @@ -898,7 +899,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> -	bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> +	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
> +		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> +	else
> +		bus->domain_nr = bridge->domain_nr;
>  #endif
>  
>  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 540b377ca8f6..ba61f4e144aa 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -526,6 +526,15 @@ static inline int pci_channel_offline(struct pci_dev *pdev)
>  	return (pdev->error_state != pci_channel_io_normal);
>  }
>  
> +/*
> +* Currently in ACPI spec, for each PCI host bridge, PCI Segment Group number is
> +* limited to a 16-bit value, therefore (int)-1 is not a valid PCI domain number,
> +* and can be used as a sentinel value indicating ->domain_nr is not set by the
> +* driver (and CONFIG_PCI_DOMAINS_GENERIC=y archs will set it with
> +* pci_bus_find_domain_nr()).
> +*/

Hmm.. I forgot to fix this part. Just fixed it locally. Apologies...

Lorenzo, how does the rest look to you? If you think they are good to
take then I can send a updated version of this patch #1 (version 5.2
maybe), otherwise (if you think more reviews are needed), I will wait
and resolve other feedbacks (if any) and put the updated patch #1 into
next iteration (maybe after next -rc is out). Thanks!

Just in case, this is the link for the whole series:
https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/

Regards,
Boqun

> +#define PCI_DOMAIN_NR_NOT_SET (-1)
> +
>  struct pci_host_bridge {
>  	struct device	dev;
>  	struct pci_bus	*bus;		/* Root bus */
> @@ -533,6 +542,7 @@ struct pci_host_bridge {
>  	struct pci_ops	*child_ops;
>  	void		*sysdata;
>  	int		busnr;
> +	int		domain_nr;
>  	struct list_head windows;	/* resource_entry */
>  	struct list_head dma_ranges;	/* dma ranges resource list */
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
> -- 
> 2.30.2
> 
