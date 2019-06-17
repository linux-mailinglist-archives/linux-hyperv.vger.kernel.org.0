Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA369491BC
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFQU4h (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 16:56:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43406 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQU4g (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 16:56:36 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so4638398plb.10;
        Mon, 17 Jun 2019 13:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaUF+IVfxLkFEOX3EdWdqY0MW6ieO175zRASbw5HHZM=;
        b=In45RciiYycSqmGUdJVle6PXKgp27Jun83jcfNaFIWxUh+nu6S7hGEwwIyxJocZJWT
         mGlVFcevrfTBcxOXw6X2qvuIfTNXez1swbd03ntboTL0nem4WZrx31X4pjJoP84AKVFi
         L+eU+ocYLl2Pe1qZ5fnOTe3E0DcC8zXsZVBXwB2Ia7EiEyTvkvN0SBnGM1OJanw1gcjt
         gnbH6CCtegHpz+1xeU4F84+YmRqccWdXELzmRCC0iBnIl6FtWwwgM0a1hZevfmCcY+1b
         7EefNT9Nm4Z6LbhWq7o8I+0WNkpcFfqD5jRPBKISAGXGFBPwESwFRXQlBl1rMMNr4q6H
         UDjA==
X-Gm-Message-State: APjAAAUTYWWzYCdpFb0vIbIXNS+5KK8cfm63DuzxCzC/U+utgDZMWRsB
        lcoXQEJNarAhpKJpZFg2H4oe09jTYuI=
X-Google-Smtp-Source: APXvYqyW1uX5YVD0oJTXzOf/KTeNCXdXhtPN2mMaP3rKDVGtTCu0tZAI6kQEifd7AGUdvUb3udfRmg==
X-Received: by 2002:a17:902:760a:: with SMTP id k10mr89887792pll.83.1560804995269;
        Mon, 17 Jun 2019 13:56:35 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r9sm12006074pgv.24.2019.06.17.13.56.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:56:34 -0700 (PDT)
Subject: Re: [PATCH 2/8] scsi: take the DMA max mapping size into account
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5d143a03-edd5-5878-780b-45d87313a813@acm.org>
Date:   Mon, 17 Jun 2019 13:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/17/19 5:19 AM, Christoph Hellwig wrote:
> We need to limit the devices max_sectors to what the DMA mapping
> implementation can support.  If not we risk running out of swiotlb
> buffers easily.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/scsi_lib.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index d333bb6b1c59..f233bfd84cd7 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1768,6 +1768,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>   		blk_queue_max_integrity_segments(q, shost->sg_prot_tablesize);
>   	}
>   
> +	shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +			dma_max_mapping_size(dev) << SECTOR_SHIFT);
>   	blk_queue_max_hw_sectors(q, shost->max_sectors);
>   	if (shost->unchecked_isa_dma)
>   		blk_queue_bounce_limit(q, BLK_BOUNCE_ISA);

Does dma_max_mapping_size() return a value in bytes? Is 
shost->max_sectors a number of sectors? If so, are you sure that "<< 
SECTOR_SHIFT" is the proper conversion? Shouldn't that be ">> 
SECTOR_SHIFT" instead?

Additionally, how about adding a comment above dma_max_mapping_size() 
that documents the unit of the returned number?

Thanks,

Bart.
