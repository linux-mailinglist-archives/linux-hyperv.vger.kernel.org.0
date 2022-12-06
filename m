Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCED64423D
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Dec 2022 12:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLFLhn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 6 Dec 2022 06:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiLFLhc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 6 Dec 2022 06:37:32 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F3BF73;
        Tue,  6 Dec 2022 03:37:30 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id bs21so23059203wrb.4;
        Tue, 06 Dec 2022 03:37:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dEEPgYHWLWGN87zsbE4biUqCxTkyL0Hp4s+LmxL1OA=;
        b=BX7ppSth1PbgamtzbcN0AJc3/Ug4pt3Jfdn6v+/AzPJi05fItfOGDcKO8MlStm73A4
         dHfjwu39fJM2rLI2x2iADEVz4ACrnoX9Ms9420we9MIcuqFQ+sgK0ETW0ngJ9DvGiUwr
         KKGuh0POI+u8n+iSlZHkB4tLIvr+c3uckYRHG+wA3buHKdM2dj8H5ZN/iqLRsZE268jg
         /zZZiOgEI/xhtmZfSXd40FZlouhXbek+u55DRIdq3E+aJ0DC4JLESLAqPuNmkUyHiI6v
         kZoR2fBsrhA//h9738zsw6XEIfcvR9OngY2N+wnbNo89buAoaw54Bnz3kM+6y+yQhiOA
         Wxhg==
X-Gm-Message-State: ANoB5pl5JSXlMXuuclHSwg7295J72FEPJxQPZxpF15C4F30o9cZ3CEV8
        5biF6XcAXmnirHfz6j24NB8=
X-Google-Smtp-Source: AA0mqf5IQao7pI3S55ozIZ3UILwG0zwLXEWSh3JhE8Rsg0wuM8pdCGyXY1E8JKqEYaIaMJ9EdjlENQ==
X-Received: by 2002:a5d:5385:0:b0:242:f8d:fcee with SMTP id d5-20020a5d5385000000b002420f8dfceemr27418643wrv.86.1670326648777;
        Tue, 06 Dec 2022 03:37:28 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600000d100b0024207ed4ce0sm16635553wrx.58.2022.12.06.03.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 03:37:27 -0800 (PST)
Date:   Tue, 6 Dec 2022 11:37:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        robert.jarzmik@free.fr, jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com, roger.pau@citrix.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] hyperv: Make remove callback of hyperv driver void
 returned
Message-ID: <Y48pdr9DEmXShhFR@liuwe-devbox-debian-v2>
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB232373567792ED1AC5E0849FCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB232373567792ED1AC5E0849FCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 05, 2022 at 11:36:39PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.
> 
> This change is for hyperv bus based drivers.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
[...]
> -static int netvsc_remove(struct hv_device *dev)
> +static void netvsc_remove(struct hv_device *dev)
>  {
>  	struct net_device_context *ndev_ctx;
>  	struct net_device *vf_netdev, *net;
> @@ -2603,7 +2603,6 @@ static int netvsc_remove(struct hv_device *dev)
>  	net = hv_get_drvdata(dev);
>  	if (net == NULL) {
>  		dev_err(&dev->device, "No net device to remove\n");
> -		return 0;

This is wrong. You are introducing a NULL pointer dereference.

>  	}
>  
>  	ndev_ctx = netdev_priv(net);
> @@ -2637,7 +2636,6 @@ static int netvsc_remove(struct hv_device *dev)
>  
>  	free_percpu(ndev_ctx->vf_stats);
>  	free_netdev(net);
> -	return 0;
>  }
>  
>  static int netvsc_suspend(struct hv_device *dev)
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ba64284eaf9f..3a09de70d6ea 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3756,7 +3756,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>   *
>   * Return: 0 on success, -errno on failure
>   */

This comment is no longer needed in the new world.

But, are you sure you're modifying the correct piece of code?

hv_pci_remove is not a hook in the base bus type. It is used in struct
hv_driver.

The same comment applies to all other modifications.

Thanks,
Wei.
