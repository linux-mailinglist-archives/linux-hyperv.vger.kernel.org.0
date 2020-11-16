Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58D2B42B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Nov 2020 12:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgKPLVw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Nov 2020 06:21:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38983 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgKPLVv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Nov 2020 06:21:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id o15so18269530wru.6;
        Mon, 16 Nov 2020 03:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4otvzYMRpn5u2dT1OEQuqZOqoSrTSB+6sK/i5vken88=;
        b=RnCcBHYpHtEsgBXymt44xatBlkg7iduGqvZ44z89rcw7mq2U836Wd89Nlq2cZJCRXp
         h4cXIU3mpKVRFywhCvtVN4ZDdRcokYbos/Gv9RfhRXPRLw3pOTRJjIUiw6PSH/xRdY9u
         NiA1IbOLPts8H96/YMJvn/9wzQdminIoohbVodwcZdAc4TMuemC/BqtA8hQN+LTN8fMA
         fnZ+MU+u8dKvaHMemrlKevgZkx4VsTJoRfX32yCOLXI2lcMAvlKK+3/wfbc+rhV+VOs+
         QXorTU4sK9Evy+rsHP7xnWbUkvo9/eNQMapHyw85dktcNwAggJzdUHwvWqthTnomgPyk
         rBLw==
X-Gm-Message-State: AOAM533Eq15PTNgrA1nC7efgUoU2/FpFGaUq9AikfSMRQrszGAue9ovM
        eJ6U7XbfAzKxkRGg9AFpQpswDwVvG9g=
X-Google-Smtp-Source: ABdhPJzQBZE1F78B52wEvpk1lDVAOhLMvV0VJ+FgXT8Mk+avsBREiHlAytaZ6ty4YqnjAz+kmGIV5Q==
X-Received: by 2002:adf:9163:: with SMTP id j90mr17944799wrj.323.1605525709927;
        Mon, 16 Nov 2020 03:21:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a14sm2518903wmj.40.2020.11.16.03.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 03:21:49 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:21:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, sashal@kernel.org, Tianyu.Lan@microsoft.com,
        decui@microsoft.com, mikelley@microsoft.com,
        sunilmut@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drivers: hv: vmbus: Fix unnecessary OOM_MESSAGE
Message-ID: <20201116112148.xfajvts4gtoibs65@liuwe-devbox-debian-v2>
References: <20201115195734.8338-1-matheus@castello.eng.br>
 <20201115195734.8338-6-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115195734.8338-6-matheus@castello.eng.br>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 15, 2020 at 04:57:33PM -0300, Matheus Castello wrote:
> Fixed checkpatch warning: Possible unnecessary 'out of memory' message
> checkpatch(OOM_MESSAGE)
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  drivers/hv/vmbus_drv.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 09d8236a51cf..774b88dd0e15 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1989,10 +1989,8 @@ struct hv_device *vmbus_device_create(const guid_t *type,
>  	struct hv_device *child_device_obj;
> 
>  	child_device_obj = kzalloc(sizeof(struct hv_device), GFP_KERNEL);
> -	if (!child_device_obj) {
> -		pr_err("Unable to allocate device object for child device\n");
> +	if (!child_device_obj)

The generic OOM message would give you a stack dump but not as specific
/ clear as the message you deleted.

Also, the original intent of this check was to check for things like

    printk("Out of memory");

which was clearly redundant. The message we print here is not that.

See https://lkml.org/lkml/2014/6/10/382 .

Wei.

>  		return NULL;
> -	}
> 
>  	child_device_obj->channel = channel;
>  	guid_copy(&child_device_obj->dev_type, type);
> --
> 2.28.0
> 
