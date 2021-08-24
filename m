Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D977E3F5CAD
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Aug 2021 13:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbhHXLC6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Aug 2021 07:02:58 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:42937 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbhHXLC4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Aug 2021 07:02:56 -0400
Received: by mail-wm1-f44.google.com with SMTP id k20-20020a05600c0b5400b002e87ad6956eso348296wmr.1;
        Tue, 24 Aug 2021 04:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=usZCgUnmy/C/PHJqn4fGun/TO/sNvOWBArrpSOrh8r4=;
        b=WteQERNJxIOAhkfrOpXlAu5/upcAvdfs6iBWklsaqBSgx6MMOrcOIXfHNWHwFXy1qF
         mTwoWJPccYlWLP6reEuy0SuZtQmqzERAN3V8jCBxgiFhwjkurjjNlDpQFEJ0WJkBK5Ay
         HAuwar4yKqletRe028hOXky00suoQtHlXhO/QAAPSAndHFKwt1n4DqpBL3dWob+2K7+U
         2mC+pH0BgpBIQRVCacI0ny5+97Uj9ocUKC8bMbsGVk8NEd6Hh1JyHJQi4mB17dLI5cN+
         hACGQTTCBLqnVHTuGaEtrJkcs+mBZRJMxLAjWQq9vcF3mOfQqfcBEtNlFPJl5BLWeZOv
         QwxA==
X-Gm-Message-State: AOAM532vD7dvF2Tr8mIEz3dcz1O7VPn0OIha8TegLjx7ouALbF4zmOD9
        8VM3Z52k7ay1bRgl1CQwUkU=
X-Google-Smtp-Source: ABdhPJxakZtWQlD5SBo/2sMDWicjLfQc70XCGpLnsqirbb8TG3DtMOAcieJ1RRSC2CuHadbexjsXUA==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr3564259wmb.79.1629802931140;
        Tue, 24 Aug 2021 04:02:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z19sm2416079wma.0.2021.08.24.04.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:02:10 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:02:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     longli@linuxonhyperv.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] PCI: hv: Fix a bug on removing child devices on the bus
Message-ID: <20210824110208.xd57oqm5rii4rr4n@liuwe-devbox-debian-v2>
References: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Aug 24, 2021 at 12:20:20AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> In hv_pci_bus_exit, the code is holding a spinlock while calling
> pci_destroy_slot(), which takes a mutex.
> 
> This is not safe for spinlock. Fix this by moving the children to be
> deleted to a list on the stack, and removing them after spinlock is
> released.
> 
> Fixes: 94d22763207a ("PCI: hv: Fix a race condition when removing the device")
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: "Krzysztof Wilczyński" <kw@linux.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index a53bd8728d0d..d4f3cce18957 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3220,6 +3220,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  	struct hv_pci_dev *hpdev, *tmp;
>  	unsigned long flags;
>  	int ret;
> +	struct list_head removed;

This can be moved to where it is needed -- the if(!keep_dev) branch --
to limit its scope.

>  
>  	/*
>  	 * After the host sends the RESCIND_CHANNEL message, it doesn't
> @@ -3229,9 +3230,18 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  		return 0;
>  
>  	if (!keep_devs) {
> -		/* Delete any children which might still exist. */
> +		INIT_LIST_HEAD(&removed);
> +
> +		/* Move all present children to the list on stack */
>  		spin_lock_irqsave(&hbus->device_list_lock, flags);
> -		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry) {
> +		list_for_each_entry_safe(hpdev, tmp, &hbus->children, list_entry)
> +			list_move_tail(&hpdev->list_entry, &removed);
> +		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> +
> +		/* Remove all children in the list */
> +		while (!list_empty(&removed)) {
> +			hpdev = list_first_entry(&removed, struct hv_pci_dev,
> +						 list_entry);

list_for_each_entry_safe can also be used here, right?

Wei.

>  			list_del(&hpdev->list_entry);
>  			if (hpdev->pci_slot)
>  				pci_destroy_slot(hpdev->pci_slot);
> @@ -3239,7 +3249,6 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
>  			put_pcichild(hpdev);
>  			put_pcichild(hpdev);
>  		}
> -		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	}
>  
>  	ret = hv_send_resources_released(hdev);
> -- 
> 2.25.1
> 
