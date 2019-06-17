Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E0491D0
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFQU7M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 16:59:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45879 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQU7M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 16:59:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so6303953pfq.12;
        Mon, 17 Jun 2019 13:59:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rHIyU01hnGOwsvfBG7AIRuhj4MaQwQhxtb0qU2ma0Tw=;
        b=YcRzJ7rnHoQwgmbgnGUP5cXXaXKQhlaqDJRfXbOqh4Vnl7saD/fX2Om/sqExuYCZqZ
         Yv9HHl2AQF9+tlB2387B+ArUg0pdc7V2AkGLuc9dPCNQy6OqHaRofyuJO7lj+J1iEn6d
         iJDEZriKr7KWwrHWt1G0SK8FG02j1jdvQbcKk6thDthJ9hOg7zQBQvTHxzFteLutUIJG
         cA6I1teE273YY7yrpuS66vnnXYZy6INcQlMYyr3bkAkn8BPZaAK3/qG2+Mufudnd1TI9
         tGUFWYgB746gkyao1Kg2+j0Nv47/j5leusCNPS2qDE2UfyPF+lZTKBBdIBwgidWbEFSK
         rYTw==
X-Gm-Message-State: APjAAAVS64nUedo5WwXaBlNPpbA3cMingw7tqhDWsc4wWggEapPsjW5f
        PFQumztUd88meTcqk7osWYYIJHlLItc=
X-Google-Smtp-Source: APXvYqyHO7JLS+3zWn4jMgqTtAZxGDmLfr7jj8zmPXm8ih+uXHUsbX/jHmqsNRktyxUpaSffr8aiRA==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr1044136pjq.134.1560805150995;
        Mon, 17 Jun 2019 13:59:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a13sm11200233pgl.84.2019.06.17.13.59.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:59:10 -0700 (PDT)
Subject: Re: [PATCH 4/8] storvsc: set virt_boundary_mask in the scsi host
 template
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e2ea87c6-a6ba-149b-f99e-d2980f5cd9a0@acm.org>
Date:   Mon, 17 Jun 2019 13:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/17/19 5:19 AM, Christoph Hellwig wrote:
> This ensures all proper DMA layer handling is taken care of by the
> SCSI midlayer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/storvsc_drv.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index b89269120a2d..7ed6f2fc1446 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1422,9 +1422,6 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
>   {
>   	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
>   
> -	/* Ensure there are no gaps in presented sgls */
> -	blk_queue_virt_boundary(sdevice->request_queue, PAGE_SIZE - 1);
> -
>   	sdevice->no_write_same = 1;
>   
>   	/*
> @@ -1697,6 +1694,8 @@ static struct scsi_host_template scsi_driver = {
>   	.this_id =		-1,
>   	/* Make sure we dont get a sg segment crosses a page boundary */
>   	.dma_boundary =		PAGE_SIZE-1,
> +	/* Ensure there are no gaps in presented sgls */
> +	.virt_boundary_mask =	PAGE_SIZE-1,
>   	.no_write_same =	1,
>   	.track_queue_depth =	1,
>   };

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
