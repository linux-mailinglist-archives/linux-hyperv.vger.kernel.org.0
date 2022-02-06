Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2134AB011
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Feb 2022 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbiBFO4J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Feb 2022 09:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFO4I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Feb 2022 09:56:08 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25A59C06173B;
        Sun,  6 Feb 2022 06:56:03 -0800 (PST)
Received: from surface (unknown [174.127.243.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5297520B83F8;
        Sun,  6 Feb 2022 06:56:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5297520B83F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644159362;
        bh=GhHIJgEMdB6on1gb1C9wQQfaiEoGRKLqQkCffp33rY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5hJhlPbCjV0wLGmJO/rb2sXxKEU/PR8viFAyDPQCPGFXM9gnByrQr+q/74OpR4q/
         zaLDn5wuK3jyYcSeLyV/YRv+IzAdclJaU9RKX4X83E4zZcXwfiNBRRANiUznRRFMWQ
         F7g2ELoU5Oze8Vlqy/C7GgQXNFFmCx4xkDqJMmkY=
Date:   Sun, 6 Feb 2022 06:55:56 -0800
From:   Juan Vazquez <juvazq@linux.microsoft.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     decui@microsoft.com, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        sthemmin@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Fix memory leak in
 vmbus_add_channel_kobj
Message-ID: <20220206145556.72obb2qxbsktw3sc@surface>
References: <20220128215604.xuqdpnnn4yjqfaoy@surface>
 <20220203173008.43480-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220203173008.43480-1-linmq006@gmail.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Feb 04, 2022 at 01:30:08AM +0800, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()：
> 
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
> 
> Fix memory leak by calling kobject_put().
> 
> Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> Changes in v2:
> - Add cleanup when sysfs_create_group() fails
> 
> kobject_uevent() is used for notifying userspace by sending an uevent,
> I don't think we need to do error handling for it.

Thanks for the patch. It looks good to me.

Reviewed-by: Juan Vazquez <juvazq@linux.microsoft.com>

> ---
>  drivers/hv/vmbus_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 17bf55fe3169..34a4fd21bdf5 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2028,8 +2028,10 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
>  	kobj->kset = dev->channels_kset;
>  	ret = kobject_init_and_add(kobj, &vmbus_chan_ktype, NULL,
>  				   "%u", relid);
> -	if (ret)
> +	if (ret) {
> +		kobject_put(kobj);
>  		return ret;
> +	}
>  
>  	ret = sysfs_create_group(kobj, &vmbus_chan_group);
>  
> @@ -2038,6 +2040,7 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
>  		 * The calling functions' error handling paths will cleanup the
>  		 * empty channel directory.
>  		 */
> +		kobject_put(kobj);
>  		dev_err(device, "Unable to set up channel sysfs files\n");
>  		return ret;
>  	}
> -- 
> 2.25.1
