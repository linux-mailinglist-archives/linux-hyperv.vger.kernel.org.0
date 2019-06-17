Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5920D491CD
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Jun 2019 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfFQU6W (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 Jun 2019 16:58:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42735 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQU6W (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 Jun 2019 16:58:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so2424720plb.9;
        Mon, 17 Jun 2019 13:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3asWb+msWGw1j4yltc/+ryybgDy37jdG08DZDWZ/paI=;
        b=GZKyD2ZHLy6Xi3PsfKL4Dr0a+N2l7TskzzR2voktGQc/sFCoNiwEdHUf1VndDNgEP6
         g+DJ4Bn/UWM3hF5SyxQuc8Lfk9e6Yz7Mxu+9g1YTNqs646VupW0u9YjiV+waE3eh8fC8
         VNE8gAV8721ZUt1S4oWGeXPuys/moeJXWGDbE2o/+5wz/oyA6DOTv3WGfM/vA+DaR50b
         dUqfMLJ/7A221vPuK4S7uIXvEVA85+vGwB9BUSh431xCXZvGajKU4ZJMzJF4h0lIM1cn
         CrdJYDS/sozRkYWzXfqU+40DKGIXl1+hcGvu8CmjoXtDDqxSgYOWrui9Qrr3z+xmkaDo
         zqKg==
X-Gm-Message-State: APjAAAWxqQyi8c5KwYKSogZs3hHdFY40EWQt7UsCzc9XwkT7EELi/SPp
        7Y5tBqxE/POHo4NC2jqjlXoA6WNv2zM=
X-Google-Smtp-Source: APXvYqw84YUDedrfrj8WdCb+ch56o52YCu/qbb53tTZsJEbeT8baUUbToJrEhkITh4E5QSvgFyQbwA==
X-Received: by 2002:a17:902:b609:: with SMTP id b9mr30920714pls.8.1560805101145;
        Mon, 17 Jun 2019 13:58:21 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s66sm14614231pgs.87.2019.06.17.13.58.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:58:20 -0700 (PDT)
Subject: Re: [PATCH 3/8] ufshcd: set max_segment_size in the scsi host
 template
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9afbf4d9-3a15-bfb4-bf5c-64a1c224cc2c@acm.org>
Date:   Mon, 17 Jun 2019 13:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 6/17/19 5:19 AM, Christoph Hellwig wrote:
> We need to also mirror the value to the device to ensure IOMMU merging
> doesn't undo it, and the SCSI host level parameter will ensure that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/ufs/ufshcd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 3fe3029617a8..505d625ed28d 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4587,8 +4587,6 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
>   	struct request_queue *q = sdev->request_queue;
>   
>   	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
> -	blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
> -
>   	return 0;
>   }
>   
> @@ -6991,6 +6989,7 @@ static struct scsi_host_template ufshcd_driver_template = {
>   	.sg_tablesize		= SG_ALL,
>   	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
>   	.can_queue		= UFSHCD_CAN_QUEUE,
> +	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
>   	.max_host_blocked	= 1,
>   	.track_queue_depth	= 1,
>   	.sdev_groups		= ufshcd_driver_groups,

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
