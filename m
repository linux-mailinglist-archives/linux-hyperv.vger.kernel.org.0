Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F41491AE
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfFQUvG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 16:51:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45446 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQUvF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 16:51:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so4626491plb.12;
        Mon, 17 Jun 2019 13:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLt4Zs39F8lYdKe/G8SBQLXzRRzi8LIVUs93jft3djA=;
        b=rp8NaVPiwZXvwCFwIm0d/wfkdQThdHujF+xou+5jQBnU5lO9T8ulJQxLDXLv98VAQE
         9yYqLy+9VIRRqm+Sxw7SD6oHxzjzC05ftH4zFAM5Sot2cbrQFz0ZACzLaYxGDqrTnDU1
         fRVSTyUvaUmz6QBTh4wMgK2Bud0q5y9wjeO67FYrw6T3slUYOnGn4Cjwv0yHEBQ6Kwtt
         3sX7MMK4N3hMES0nogwciaYevGcj60hvRgVIq8XovTo9iHtebIrkKQU0jrjx2xDXiSHU
         EVKsdIZGdHgtfCOTe91je1c1fbEY/BSOyOktJMRvud1fo8Bj0+aN2kEBivv1u1L8ULf6
         Z4kQ==
X-Gm-Message-State: APjAAAU3GDuJN0xvv2UbjqCdp1XvFqks47SZAuvi9GHM5QfVjUit7geE
        /wtFLM5Ys8owkrjfHvNsZX9Es5XK3JM=
X-Google-Smtp-Source: APXvYqxfD65LF5xW1tkyOSFFjVxBCQV0jCvC6DyiWqbQxQWcmGeL83TJb5rc62nhY/4o7dFairs0qw==
X-Received: by 2002:a17:902:4481:: with SMTP id l1mr111969435pld.121.1560804664671;
        Mon, 17 Jun 2019 13:51:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f88sm226851pjg.5.2019.06.17.13.51.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:51:03 -0700 (PDT)
Subject: Re: [PATCH 1/8] scsi: add a host / host template field for the virt
 boundary
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ea0f90cd-6263-6a9e-9c88-ed8a8017317e@acm.org>
Date:   Mon, 17 Jun 2019 13:51:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/17/19 5:19 AM, Christoph Hellwig wrote:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 65d0a10c76ad..d333bb6b1c59 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1775,7 +1775,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>   	dma_set_seg_boundary(dev, shost->dma_boundary);
>   
>   	blk_queue_max_segment_size(q, shost->max_segment_size);
> -	dma_set_max_seg_size(dev, shost->max_segment_size);
> +	blk_queue_virt_boundary(q, shost->virt_boundary_mask);
> +	dma_set_max_seg_size(dev, queue_max_segment_size(q));

Although this looks fine to me for LLDs that own a PCIe device, I doubt 
this is correct for SCSI LLDs that share a PCIe device with other ULP 
drivers. From the RDMA core:

	/* Setup default max segment size for all IB devices */
	dma_set_max_seg_size(device->dma_device, SZ_2G);

Will instantiating a SCSI host (iSER or SRP) for an RDMA adapter cause 
the maximum segment size to be modified for all ULP drivers associated 
with that HCA?

Thanks,

Bart.
