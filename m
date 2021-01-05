Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BC32EAB2F
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jan 2021 13:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbhAEMu1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 07:50:27 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:34342 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbhAEMu1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 07:50:27 -0500
Received: by mail-wm1-f53.google.com with SMTP id g25so1428893wmh.1;
        Tue, 05 Jan 2021 04:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EZyGTkbcPKYFMYzBs6nzV7gzqDTgrLCohcmlMq4hEI=;
        b=tUVXjXzxjbzWdV3DGqTjnF9bWlFPX2dLKA4jQFzh3pvWvtnFVkAALEGs3JLW/tPsjR
         QObWbj92j5jmeCI+5tQu4Essy3rGyaR36/BgRsSE+svwRrtiOfw0r6iKnfjf6mwufqet
         lJaeHVLKeBelJkCRshaV5W1z5bXCvzRWqv83RsC5kQuVs5ZqJm1wCBmn6bx1jYlzBQ5I
         9ZNn7QWXKKWbmiZ0bem/1Vpotd1/YeaXMhq1y60m85mDAiXxYWC9F7dxq/u8cdoaXwRR
         LaQRoNXg2QDpeWiJImk5mdyVSB9oOG1ZL8KvBriEEPqH7Mqp527PkkguUZPwp2erzY8x
         QmDw==
X-Gm-Message-State: AOAM530ddpijKfCnb0S+0pPxz/yU2CNMP93Ri2xbPHYJtCwJtHgcqWVI
        BkPBbmjBFJBaQI0XmxTJbMI=
X-Google-Smtp-Source: ABdhPJwVF9QsjoP9c6QsEyg8wGmoe0XVEaVCxQwg16LI6/ysVkwjGrIshpO1H1hZSY09vUDjY/ORhQ==
X-Received: by 2002:a1c:bc88:: with SMTP id m130mr3440767wmf.82.1609850984936;
        Tue, 05 Jan 2021 04:49:44 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k1sm95366837wrn.46.2021.01.05.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:49:44 -0800 (PST)
Date:   Tue, 5 Jan 2021 12:49:43 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: Re: [PATCH v3 0/6] Drivers: hv: vmbus: More VMBus-hardening changes
Message-ID: <20210105124943.qaoqj76kb2qasaoq@liuwe-devbox-debian-v2>
References: <20201209070827.29335-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209070827.29335-1-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 09, 2020 at 08:08:21AM +0100, Andrea Parri (Microsoft) wrote:
> Integrating feedback from Juan, Michael and Wei. [1]  Changelogs are
> inline/in the patches.
> 
> Thanks,
>   Andrea
> 
> [1] https://lkml.kernel.org/r/20201202092214.13520-1-parri.andrea@gmail.com
> 
> Andrea Parri (Microsoft) (6):
>   Drivers: hv: vmbus: Initialize memory to be sent to the host
>   Drivers: hv: vmbus: Reduce number of references to message in
>     vmbus_on_msg_dpc()
>   Drivers: hv: vmbus: Copy the hv_message in vmbus_on_msg_dpc()
>   Drivers: hv: vmbus: Avoid use-after-free in vmbus_onoffer_rescind()
>   Drivers: hv: vmbus: Resolve race condition in vmbus_onoffer_rescind()

I've applied the first five to hyperv-next.

>   Drivers: hv: vmbus: Do not allow overwriting
>     vmbus_connection.channels[]

This one lacks a review-by tag.

Wei.

> 
>  drivers/hv/channel.c      |  4 +--
>  drivers/hv/channel_mgmt.c | 55 +++++++++++++++++++++++++++------------
>  drivers/hv/hyperv_vmbus.h |  2 +-
>  drivers/hv/vmbus_drv.c    | 43 ++++++++++++++++++------------
>  include/linux/hyperv.h    |  1 +
>  5 files changed, 69 insertions(+), 36 deletions(-)
> 
> -- 
> 2.25.1
> 
