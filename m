Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32D1642C82
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Dec 2022 17:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiLEQIj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Dec 2022 11:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLEQIi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Dec 2022 11:08:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA6F1D0C0;
        Mon,  5 Dec 2022 08:08:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E23611D0;
        Mon,  5 Dec 2022 16:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ED3C433D6;
        Mon,  5 Dec 2022 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670256516;
        bh=2zTjxGImNhiKZkQVLYwU+D7sO9c/DELnBsQOLmxj5RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t1aBQ5PwG5R+hRKkkXrH8ZTKVgOxRxmB/P6l1a7WOnp6bg1x+OclpQCfQnhw/5RV9
         VWi7ElCSsHDX/U7BRQ1/TnpM9vFr8hQGRZDE9i4Y2GO9/XQcyWYoAD1bZDv9jDw4w5
         KgmnSDvMOM5qBG6N1xQJdeSmTODNmVm+4pNvzk5Y=
Date:   Mon, 5 Dec 2022 17:08:33 +0100
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
Subject: Re: [PATCH 2/6] macio: Make remove callback of macio driver void
 returned
Message-ID: <Y44XgS8nHgcJjQCL@kroah.com>
References: <20221205153644.60909-1-set_pte_at@outlook.com>
 <TYCP286MB2323FCDC7ECD87F8D97CB74BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323FCDC7ECD87F8D97CB74BCA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Dec 05, 2022 at 11:36:40PM +0800, Dawei Li wrote:
> Commit fc7a6209d571 ("bus: Make remove callback return
> void") forces bus_type::remove be void-returned, it doesn't
> make much sense for any bus based driver implementing remove
> callbalk to return non-void to its caller.
> 
> This change is for macio bus based drivers.
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  arch/powerpc/include/asm/macio.h                | 12 ++++++------
>  drivers/ata/pata_macio.c                        |  4 +---
>  drivers/macintosh/rack-meter.c                  |  4 +---
>  drivers/net/ethernet/apple/bmac.c               |  4 +---
>  drivers/net/ethernet/apple/mace.c               |  4 +---
>  drivers/net/wireless/intersil/orinoco/airport.c |  4 +---
>  drivers/scsi/mac53c94.c                         |  5 +----
>  drivers/scsi/mesh.c                             |  5 +----
>  drivers/tty/serial/pmac_zilog.c                 |  7 ++-----
>  sound/aoa/soundbus/i2sbus/core.c                |  4 +---
>  10 files changed, 16 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/macio.h b/arch/powerpc/include/asm/macio.h
> index ff5fd82d9ff0..f641c730c3b7 100644
> --- a/arch/powerpc/include/asm/macio.h
> +++ b/arch/powerpc/include/asm/macio.h
> @@ -124,15 +124,15 @@ static inline struct pci_dev *macio_get_pci_dev(struct macio_dev *mdev)
>   */
>  struct macio_driver
>  {
> -	int	(*probe)(struct macio_dev* dev, const struct of_device_id *match);
> -	int	(*remove)(struct macio_dev* dev);
> +	int	(*probe)(struct macio_dev *dev, const struct of_device_id *match);
> +	void	(*remove)(struct macio_dev *dev);

Again, you are changing lines you do not need to here.

thanks,

greg k-h
