Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27AC3F5DF0
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Aug 2021 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbhHXMZv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Aug 2021 08:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhHXMZv (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Aug 2021 08:25:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B73016127B;
        Tue, 24 Aug 2021 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629807907;
        bh=Edj68RKjcXX2r4keA5K6DEuxfBNmsQDCDQXdGfLJ09I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eKhRQQn91hAhG6loFGwgvUTfuk90J2t693MaoSzkx7rKuyyuInsQaMgZU5awAgMiz
         yFcJR6cf0jhhpE3vB4dGD9mLksEZzdr9I43oJSix1x0HOnWbmOZno+jd5ADXAhOGGw
         7VBsLN+b3JDEPIAjmTsNi7pKwnFm4uEa/5d+I/GkW3Y2DHZWzSNnsAGKr2+6tje504
         gdzarHSnOqsLqPhNt7yJfwf9JTDdZiL33VNsYfFYESXJXz9WctTg+j1c1a6yEUbDsV
         61jwiPYWc7G6JK/UAycvuK3BgJF/MSVl2HltSH/g+u4GP57GgpVtVUtg+V/PoVe45Y
         CkH0VXc58XDaQ==
Date:   Tue, 24 Aug 2021 07:25:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20210824122504.GA3452187@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1629789620-11049-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

"Fix a bug ..." is not a very useful subject line.  It doesn't say
anything about what the patch *does*.  It doesn't hint at a locking
change.

On Tue, Aug 24, 2021 at 12:20:20AM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> In hv_pci_bus_exit, the code is holding a spinlock while calling
> pci_destroy_slot(), which takes a mutex.

It's unfortunate that slots are not better integrated into the PCI
core.  I'm sorry your driver even has to worry about this.
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

A lore link to Dan's report would be useful here.

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
