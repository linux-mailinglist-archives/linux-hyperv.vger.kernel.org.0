Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF49F4A033B
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 22:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351440AbiA1V4J (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 16:56:09 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39418 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiA1V4I (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 16:56:08 -0500
Received: from surface (unknown [174.127.243.168])
        by linux.microsoft.com (Postfix) with ESMTPSA id 582CB20B6C61;
        Fri, 28 Jan 2022 13:56:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 582CB20B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643406968;
        bh=9JajQ2cBB5tapkpmhdqs1zZw1ZE4vcEc/n6fplQCYFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hiu0PF/MX8BJZLEC/B7FeSL0l8z7DjmO9m/BWsOiWAyrczXlJKEvpZYFY6dK3VvfT
         0bV1rgImlH83GTHD4xjMSu0USVhT07qltqji91Obuy44IR1DNg73SpJpM5eZ6gfua9
         2MdVYAB07s8L0LpiQdTCq4DF6+qRhax9Laz/pIrk=
Date:   Fri, 28 Jan 2022 13:56:04 -0800
From:   Juan Vazquez <juvazq@linux.microsoft.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix memory leak in
 vmbus_add_channel_kobj
Message-ID: <20220128215604.xuqdpnnn4yjqfaoy@surface>
References: <20220126055247.8125-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126055247.8125-1-linmq006@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jan 26, 2022 at 05:52:46AM +0000, Miaoqian Lin wrote:
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
>  drivers/hv/vmbus_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 17bf55fe3169..9e055697783b 100644
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
If sysfs_create_group() fails same cleanup I think is required.

Later kobject_uevent() may fail according to doc, but there is no error
handling, maybe a good moment to consider adding it and do same cleanup.
>  
> -- 
> 2.17.1
