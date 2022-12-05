Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEE2642C7F
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 17:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLEQIA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 11:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLEQH7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 11:07:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C381B1C5;
        Mon,  5 Dec 2022 08:07:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBF59B8111D;
        Mon,  5 Dec 2022 16:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA843C433D6;
        Mon,  5 Dec 2022 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670256475;
        bh=Eu6yRxptwIjp+jobzTRehJVPk3s3l2rtPAWW3JDKriU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGQk9MFX4LB7qvP2B2anJGqE6Z6d0L46ICiQtdTZRCj2bbx+sL1Qj6lDYAd796T73
         krThdNV5BAuOVBcjlWHfKp1kVWotWO8++wS4g8SLIq/MBzEqMQLv0PWpHmDlNEYi2z
         li2DvIFUErFDJ0iS5DzLus0ZVrozvfh9M06QC2jc=
Date:   Mon, 5 Dec 2022 17:07:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     johannes@sipsolutions.net, robert.jarzmik@free.fr, jgross@suse.com,
        sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
        roger.pau@citrix.com, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        xen-devel@lists.xenproject.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] soundbus: make remove callback of soundbus driver
 void returned
Message-ID: <Y44XWIqnKwE7ntPL@kroah.com>
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB2323BBFCE929111043E60D3BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323BBFCE929111043E60D3BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 05, 2022 at 11:36:44PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.
> 
> This change is for soundbus based drivers.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  sound/aoa/fabrics/layout.c    | 3 +--
>  sound/aoa/soundbus/soundbus.h | 6 +++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
> index ec4ef18555bc..850dc8c53e9b 100644
> --- a/sound/aoa/fabrics/layout.c
> +++ b/sound/aoa/fabrics/layout.c
> @@ -1094,7 +1094,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
>  	return -ENODEV;
>  }
>  
> -static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
> +static void aoa_fabric_layout_remove(struct soundbus_dev *sdev)
>  {
>  	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
>  	int i;
> @@ -1123,7 +1123,6 @@ static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
>  	kfree(ldev);
>  	sdev->pcmid = -1;
>  	sdev->pcmname = NULL;
> -	return 0;
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/sound/aoa/soundbus/soundbus.h b/sound/aoa/soundbus/soundbus.h
> index 3a99c1f1a3ca..230dfa1ba270 100644
> --- a/sound/aoa/soundbus/soundbus.h
> +++ b/sound/aoa/soundbus/soundbus.h
> @@ -184,10 +184,10 @@ struct soundbus_driver {
>  
>  	/* we don't implement any matching at all */
>  
> -	int	(*probe)(struct soundbus_dev* dev);
> -	int	(*remove)(struct soundbus_dev* dev);
> +	int	(*probe)(struct soundbus_dev *dev);

Why change this line too?

thanks,

greg k-h
