Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB92B31316F
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Feb 2021 12:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhBHLyA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Feb 2021 06:54:00 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39668 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhBHLv7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Feb 2021 06:51:59 -0500
Received: by mail-wr1-f41.google.com with SMTP id h12so435126wrw.6
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Feb 2021 03:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sRMWs0FYMXPqa9zVntWGyH0kXhuXzQDzvcNFN0yn9fQ=;
        b=k09k0vPfJWeC8Hv1MDc2RBQ0xd9pruYo+X5HNNWtatnn4UZ75M0WHEKCjgm6MsKC3O
         qecKG2+Wawg0cSI4/+XdZDuZQAKt6kGlzNjPpghgHHYLcre7sIbNi86mhymvKgmEihSn
         ndJDea71DShkBvtmQqz8brpaaMHFv1KzMxHQmbmVL5BMcIqfwvElRP7Ix1evDLqGWgeZ
         2ifb472LMdD5CRr6+hnQvTn/sbdjnn03UQ3PE/bAu9C3Dh/Q+J+cuT/HioeHBtM23Kfi
         lVZzDPjEFVKmvtagUUMQtIQoUzK9TaompERWqr/mZguA8EyVW+5st8Z/PX+uTfpBSxap
         4cmw==
X-Gm-Message-State: AOAM530YB/wDoejWNn3PzQkaS28o2YSnWETns94Kd9J6e0DkBTdD3eHY
        XKaSPAAcy38PbeEnPisMXn8=
X-Google-Smtp-Source: ABdhPJz76IgEbznZbr88Ysct+wGRn0XmJo/vMBJxuilNcoVoswhNx4MMUGv1BsFSRdL0NtSIHZdBIg==
X-Received: by 2002:a5d:58fb:: with SMTP id f27mr7661301wrd.119.1612785078000;
        Mon, 08 Feb 2021 03:51:18 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q7sm28746533wrx.18.2021.02.08.03.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 03:51:17 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:51:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
Cc:     andres@anarazel.de, haiyangz@microsoft.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, sashal@kernel.org,
        mikelley@microsoft.com, sthemmin@microsoft.com,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 2/2] scsi: storvsc: Make max hw queues updatable
Message-ID: <20210208115116.wpuznzvf75duifsi@liuwe-devbox-debian-v2>
References: <20210203010904.hywx5xmwik52ccao@alap3.anarazel.de>
 <20210205212447.3327-1-melanieplageman@gmail.com>
 <20210205212447.3327-3-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205212447.3327-3-melanieplageman@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Melanie

On Fri, Feb 05, 2021 at 09:24:47PM +0000, Melanie Plageman (Microsoft) wrote:
> - Change name of parameter to storvsc_max_hw_queues
> - Make the parameter updatable on a running system
> - Change error to warning for an invalid value of the parameter at
>   driver init time
> 
> Signed-off-by: Melanie Plageman (Microsoft) <melanieplageman@gmail.com>

This patch contains a section which seems to be a copy&paste error from
another email.

Also, please use get_maintainers.pl to CC the correct maintainers. You
can configure git-sendemail such that the correct people are CC'ed
automatically. The storvsc code normally goes via the storage
maintainers' tree.

If you have any question about how to use the get_maintainers.pl script
or the upstreaming process in general, let me know.

Wei.

> ---
> 
> Andres wrote:
> >> On 2021-02-02 15:19:08 -0500, Melanie Plageman wrote:
> >> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> >> index 2e4fa77445fd..d72ab6daf9ae 100644
> >> --- a/drivers/scsi/storvsc_drv.c
> >> +++ b/drivers/scsi/storvsc_drv.c
> >> @@ -378,10 +378,14 @@ static u32 max_outstanding_req_per_channel;
> >>  static int storvsc_change_queue_depth(struct scsi_device *sdev, int
[...]
