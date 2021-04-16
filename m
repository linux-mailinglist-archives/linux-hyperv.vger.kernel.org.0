Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7E3625D2
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Apr 2021 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhDPQkm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 16 Apr 2021 12:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbhDPQkm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 16 Apr 2021 12:40:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E389C06175F
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Apr 2021 09:40:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i190so18688878pfc.12
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Apr 2021 09:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBMbrSOywNmfduS/OTT3MgG5hkK1w/tlntAgfLJqoII=;
        b=t7nKMlwt2xNTb0VB5O3hJidsskXOoEd+BB1LiY/DkvohgS/mG4I49FoWx/KDPdrsGs
         NEnjD0k2IrRndhYGwjPO0ocv4l/PR1WwYdaMupvBLARIkFqL0UCJe2To5TjDODgJr/fd
         Yfkygig4e4EfeFD8E6T0mDauYZ0nFZEjOFvTwY0Ok8NYTeuH1eL7gyZ3K6W+xv8xqgdi
         n8UaXKXQ7O0VXJJ3876gSSPZ5wa6mxYE4oUjkiTQUpof5BPnGPUgwf/TRoksXbSGUOJ5
         i9KSSj50mxWvXyHPBoEWdq5yqASbmihRN4lluaTWLLYRzvaNVGECmMuBdss7TCJG+O3R
         P9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBMbrSOywNmfduS/OTT3MgG5hkK1w/tlntAgfLJqoII=;
        b=Jqosre1T0Ye3jnvKOHuBtQUI9N6lUot595UmLOIfbxQJHfLBrCBnCNooWTfp7a+QFX
         bHf0AB+z8jOfnWSnLbQZNcXZNpn+L+8Z3YQTL/oUYsrzE2tdZH1LkcwFDwjf19V0paFt
         VCaViUg6yHw0uDmV+oTrLYvJTPxQXP555+rj8T250/l24WrhDxV4IqiSDkjyZXXIoagY
         8efUyp+RKkFAh9UGS/9EBKq6LSfdhoPK6uVAgVhLGfwEkk/hI+U4xRGyo0FwT7Duda4Y
         r0Xk3dTh+5g4vGtdzeS5kYeSvMOk3ed4kSrdr9W3hW99jyxFBTNXDYNy485BKBEYX/m7
         I7sw==
X-Gm-Message-State: AOAM530ZkeBYie1wICvWJEk18/og63McUvprG2tycIXwNhSDV+U7TOq2
        Yjc17tqiw6CCvONgow6h7kn+iw==
X-Google-Smtp-Source: ABdhPJwOxcBV/K+3tCZDrbPAFySF7Z1daXqBFUfpr1wER35W5490o1xjQaiUOIp0pkRXCU7DADaBLw==
X-Received: by 2002:a62:b412:0:b029:21f:6b06:7bdd with SMTP id h18-20020a62b4120000b029021f6b067bddmr8656780pfn.51.1618591215753;
        Fri, 16 Apr 2021 09:40:15 -0700 (PDT)
Received: from hermes.local (76-14-218-44.or.wavecable.com. [76.14.218.44])
        by smtp.gmail.com with ESMTPSA id k21sm5164664pfi.28.2021.04.16.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 09:40:15 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:40:06 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, kuba@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        liuwe@microsoft.com, netdev@vger.kernel.org, leon@kernel.org,
        andrew@lunn.ch, bernd@petrovitsch.priv.at, rdunlap@infradead.org,
        shacharr@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v7 net-next] net: mana: Add a driver for Microsoft Azure
 Network Adapter (MANA)
Message-ID: <20210416094006.70661f47@hermes.local>
In-Reply-To: <20210416060705.21998-1-decui@microsoft.com>
References: <20210416060705.21998-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, 15 Apr 2021 23:07:05 -0700
Dexuan Cui <decui@microsoft.com> wrote:

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 7349a70af083..f682a5572d84 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2297,6 +2297,7 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
>  {
>  	struct device *parent = vf_netdev->dev.parent;
>  	struct net_device_context *ndev_ctx;
> +	struct net_device *ndev;
>  	struct pci_dev *pdev;
>  	u32 serial;
>  
> @@ -2319,8 +2320,17 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
>  		if (!ndev_ctx->vf_alloc)
>  			continue;
>  
> -		if (ndev_ctx->vf_serial == serial)
> -			return hv_get_drvdata(ndev_ctx->device_ctx);
> +		if (ndev_ctx->vf_serial != serial)
> +			continue;
> +
> +		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
> +		if (ndev->addr_len != vf_netdev->addr_len ||
> +		    memcmp(ndev->perm_addr, vf_netdev->perm_addr,
> +			   ndev->addr_len) != 0)
> +			continue;
> +
> +		return ndev;
> +
>  	}
>  
>  	netdev_notice(vf_netdev,


This probably should be a separate patch.
I think it is trying to address the case of VF discovery in Hyper-V/Azure where the reported
VF from Hypervisor is bogus or confused.

