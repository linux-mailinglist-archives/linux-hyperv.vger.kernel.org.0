Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97848642C73
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLEQDn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 11:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLEQDm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 11:03:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B013FA4;
        Mon,  5 Dec 2022 08:03:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13988611CA;
        Mon,  5 Dec 2022 16:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8930C433D6;
        Mon,  5 Dec 2022 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670256220;
        bh=mqFOwbVppYAcW5Cn5xUKN/wnrwuAAExaAVEWq0H9axM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANi23BgakNxd3FkjR7VfG4ohH47l8+R8mpEFenDtWCftg3MQQ6IopoRzje2nL+HiQ
         W/V3GUTObsYx+ERHGuN5QFLT8PU+TPVzYsCpUcCRWon3OTurNp0CBC//sQKoJd8wn0
         kpdJ4IXJQ8tNES9c4Tr4Ag8Zvf352rtyo6Fh3oJ0=
Date:   Mon, 5 Dec 2022 17:03:37 +0100
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
Subject: Re: [PATCH 5/6] ac97: make remove callback of ac97 driver void
 returned
Message-ID: <Y44WWZW5AK2q9s0q@kroah.com>
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB2323207367F2D39D0D725828CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323207367F2D39D0D725828CA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 05, 2022 at 11:36:43PM +0800, Dawei Li wrote:
> Since commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.
> 
> This change is for ac97 bus based drivers.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  drivers/mfd/wm97xx-core.c  | 4 +---
>  include/sound/ac97/codec.h | 6 +++---
>  sound/ac97/bus.c           | 5 ++---
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/wm97xx-core.c b/drivers/mfd/wm97xx-core.c
> index 9a2331eb1bfa..663acbb1854c 100644
> --- a/drivers/mfd/wm97xx-core.c
> +++ b/drivers/mfd/wm97xx-core.c
> @@ -319,13 +319,11 @@ static int wm97xx_ac97_probe(struct ac97_codec_device *adev)
>  	return ret;
>  }
>  
> -static int wm97xx_ac97_remove(struct ac97_codec_device *adev)
> +static void wm97xx_ac97_remove(struct ac97_codec_device *adev)
>  {
>  	struct wm97xx_priv *wm97xx = ac97_get_drvdata(adev);
>  
>  	snd_ac97_compat_release(wm97xx->ac97);
> -
> -	return 0;
>  }
>  
>  static const struct ac97_id wm97xx_ac97_ids[] = {
> diff --git a/include/sound/ac97/codec.h b/include/sound/ac97/codec.h
> index 9792d25fa369..a26e9e0082f6 100644
> --- a/include/sound/ac97/codec.h
> +++ b/include/sound/ac97/codec.h
> @@ -62,9 +62,9 @@ struct ac97_codec_device {
>   */
>  struct ac97_codec_driver {
>  	struct device_driver	driver;
> -	int			(*probe)(struct ac97_codec_device *);
> -	int			(*remove)(struct ac97_codec_device *);
> -	void			(*shutdown)(struct ac97_codec_device *);
> +	int			(*probe)(struct ac97_codec_device *dev);

Why did you change this line?

> +	void			(*remove)(struct ac97_codec_device *dev);
> +	void			(*shutdown)(struct ac97_codec_device *dev);

And this line?

Don't change things that you don't describe in your changelog and that
are not needed for your change.

thanks,

greg k-h
