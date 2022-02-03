Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52F4A83D7
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Feb 2022 13:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241799AbiBCMbJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 3 Feb 2022 07:31:09 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37575 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBCMbJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 3 Feb 2022 07:31:09 -0500
Received: by mail-wm1-f46.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso7029517wmj.2;
        Thu, 03 Feb 2022 04:31:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQlsqU6nwN5H06FUJhcRC/Lf5jSW1qr5K68X4aIq/8k=;
        b=ujMi9CK47xCwdJS2kjDRHtLXvAe5B90CLQu7oEMWYTnaqGPbcCKU7gueGOYC8XM/A9
         SCaAbU6KPcl+nOWm2CWAuoClgWD1MPPQE5b+g6FUlqK95b6PQLetE0UrU0It1NebOMvk
         CbJwpt4GPkf9o2ggMDqfUgHWCLzmqOfxfHX7LTrivfg708rKb5gVI9uqjQpLz2OmWE0m
         IHLiizXwDj5Elh9AvHQVCGsLEAfA+O1zpiZYXLtwLl5siu1CNsdNuj8TQD6yJ+S8SG4J
         /SS3KOQXTRQTkcL/6ScA2o4y7syFyRSXNYSZgZVLXxslmlPHH4XH3Z/adGlSAieLX2jJ
         C0DA==
X-Gm-Message-State: AOAM530ulGWK1QlZiZ7j6kXHZcddAX2RuETcUav5mQp5/iiPeUFdvj+w
        bupYUIC2xCMkBrJ4LuO+xKaXWD4RTPY=
X-Google-Smtp-Source: ABdhPJzF7z+fL/OuNnuydRrL+Q6wVTrUnC+3D7A5TzMkKtzM9syv09XWpMUnJFfoED+iCLtHIakqvQ==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr10078665wmi.151.1643891467556;
        Thu, 03 Feb 2022 04:31:07 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i13sm20256737wrf.3.2022.02.03.04.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 04:31:07 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:31:05 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, paekkaladevi@microsoft.com,
        Long Li <longli@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com
Subject: Re: [Patch v4] PCI: hv: Fix NUMA node assignment when kernel boots
 with custom NUMA topology
Message-ID: <20220203123105.kc67tb7a2ntx5tfl@liuwe-devbox-debian-v2>
References: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643247814-15184-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 26, 2022 at 05:43:34PM -0800, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> When kernel boots with a NUMA topology with some NUMA nodes offline, the PCI
> driver should only set an online NUMA node on the device. This can happen
> during KDUMP where some NUMA nodes are not made online by the KDUMP kernel.
> 
> This patch also fixes the case where kernel is booting with "numa=off".
> 
> Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

CC PCI maintainers.

Hi Bjorn and Lorenzo

Are you going to pick this up? This is a fix we would like to see
upstream sooner rather than later.

I can pick this up via hyperv-fixes if that suits you, since this only
affect pci-hyperv.c.

Thanks,
Wei.

> ---
> Change log:
> v2: use numa_map_to_online_node() to assign a node to device (suggested by
> Michael Kelly <mikelley@microsoft.com>)
> v3: add "Fixes" and check for num_possible_nodes()
> v4: fix commit message format
> 
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 20ea2ee330b8..ae0bc2fee4ca 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2155,8 +2155,17 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
>  		if (!hv_dev)
>  			continue;
>  
> -		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
> -			set_dev_node(&dev->dev, hv_dev->desc.virtual_numa_node);
> +		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> +		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> +			/*
> +			 * The kernel may boot with some NUMA nodes offline
> +			 * (e.g. in a KDUMP kernel) or with NUMA disabled via
> +			 * "numa=off". In those cases, adjust the host provided
> +			 * NUMA node to a valid NUMA node used by the kernel.
> +			 */
> +			set_dev_node(&dev->dev,
> +				     numa_map_to_online_node(
> +					     hv_dev->desc.virtual_numa_node));
>  
>  		put_pcichild(hv_dev);
>  	}
> -- 
> 2.25.1
> 
