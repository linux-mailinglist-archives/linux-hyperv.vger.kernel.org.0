Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0964E5B5CBA
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Sep 2022 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiILOx5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 12 Sep 2022 10:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiILOx5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 12 Sep 2022 10:53:57 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C67371A0;
        Mon, 12 Sep 2022 07:53:54 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id e18so1117958wmq.3;
        Mon, 12 Sep 2022 07:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=j0Coki9DMkC7fbhU7zutmHnadILl+DbTuX5RVwbWOKI=;
        b=F9ezCQ8PAtEX4ywXfSTa6F1NqyP0PucSoK0k/xyozu57zYLJllbbatUiWtajmLc4wz
         Ylp5vFyAW7EqNsB3cHBOgfGDcqU91N6loubA5Mt74kbmPXKRy7W9d3zHPw1ajUSpZIhr
         gZdd+SstuGprT63Vbe7VeVefsVVWzA0eySyDQVNl1AueqnfNi/zYNG5cyq7BPeEIFHkh
         zynRwIHjoH9iPQBv6XIbTpT3KUkj09COp5okHyaDB+Z7XuebfJ48JAXNUhGNdJXJDtPV
         4zzXbHMurVDc7ZkXPOpoy8nxU/TnhEiZuRtWgeMjDA6K8KTrm0upJLA4MxUE0X7DDEoU
         BdTg==
X-Gm-Message-State: ACgBeo2nMOOW/ZAuxu1BIru4qoljoSyEnVdIchWm5KouK1M4+zzLoqOq
        O7vyyqLdyo8yrVSut1pawC3l+9nLoeA=
X-Google-Smtp-Source: AA6agR6gxR/9t5/gelS0gxmdWQAVTjU58i5utB5d8uMkeTDaoaJZY6jg8kAsEbl56yj8DLbi5EeJ0A==
X-Received: by 2002:a05:600c:4fc2:b0:3a5:c491:5ee1 with SMTP id o2-20020a05600c4fc200b003a5c4915ee1mr13832558wmq.62.1662994432771;
        Mon, 12 Sep 2022 07:53:52 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d60ce000000b0022862fd933asm7567247wrt.96.2022.09.12.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:53:52 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:53:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>
Cc:     vkuznets@redhat.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "open list:Hyper-V/Azure CORE AND DRIVERS" 
        <linux-hyperv@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] hv: Use PCI_VENDOR_ID_MICROSOFT for better
 discoverability
Message-ID: <Yx9H+semY705LUkB@liuwe-devbox-debian-v2>
References: <87leqsr6im.fsf@redhat.com>
 <1662749425-3037-1-git-send-email-eahariha@linux.microsoft.com>
 <1662749425-3037-2-git-send-email-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662749425-3037-2-git-send-email-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 09, 2022 at 11:50:24AM -0700, Easwar Hariharan wrote:
> From: Easwar Hariharan <easwar.hariharan@microsoft.com>
> 
> Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>

> ---
>  drivers/hv/vmbus_drv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3c833ea..6b77a53 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -39,6 +39,8 @@
>  #include <clocksource/hyperv_timer.h>
>  #include "hyperv_vmbus.h"
>  
> +#define PCI_VENDOR_ID_MICROSOFT 0x1414
> +

There is a patch in hyperv-fixes that puts this definition to a proper
header. You can wait for that to land and rebase this patch.

In the future when you send out a series, please chain all the patches
to a cover letter.

Thanks,
Wei.

>  struct vmbus_dynid {
>  	struct list_head node;
>  	struct hv_vmbus_device_id id;
> @@ -2052,7 +2054,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
>  	child_device_obj->channel = channel;
>  	guid_copy(&child_device_obj->dev_type, type);
>  	guid_copy(&child_device_obj->dev_instance, instance);
> -	child_device_obj->vendor_id = 0x1414; /* MSFT vendor ID */
> +	child_device_obj->vendor_id = PCI_VENDOR_ID_MICROSOFT;
>  
>  	return child_device_obj;
>  }
> -- 
> 1.8.3.1
> 
