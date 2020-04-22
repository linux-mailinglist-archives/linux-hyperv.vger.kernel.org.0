Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3C1B36A8
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 07:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgDVFCV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 01:02:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34128 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDVFCU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 01:02:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id s10so476530plr.1;
        Tue, 21 Apr 2020 22:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Y3JOgDdi/qzWwkBW1eBh2RUmKgV1nI2eSmuF35GA7M=;
        b=YTKEogafeL3tobDMTGWs9NUVwCw19/hslBdUjhA4eaDwW2a8nKEedWaoxqhbzhZn4f
         yfLIm24p03N+UzN3W+AA3+ll8gnM5cWu6Mh73kMO3mgF/GaH38bXcpQ577ixAIVfLZ3t
         ODw6EwruwlHdMQ4UVC/w6dLPYosb6KqQ6lM+XOAcLCORxEZfd3HcRi3s6g5JFUogfXKQ
         Ent2+rCnzCBJzgibJX7hmId6C4mnRtVQc1aWc5Rk0KiUiIOvr/JgGtyIM8b6/mBBXiUT
         WjB6esybv+aEPV51TUJ0HNyxkOGBEuTWJrQw57cEJX8W7udGm3yl4pJ7d1HL1luMc0eM
         ZSsA==
X-Gm-Message-State: AGi0PuaiMWVx3UfEOd12EYQjlhZySNz6D3/G0+LlzUZcwaljEQggRFi2
        fJa9n5NJFtIvbOq6V8ZJoek=
X-Google-Smtp-Source: APiQypI3///m3SJ+Me2ARabRUnrFSj+sVGpwwqwJtktTRinzXdL6smikHe8w2qAJtue3JUvxR/hmww==
X-Received: by 2002:a17:90a:fc8a:: with SMTP id ci10mr5897206pjb.152.1587531739736;
        Tue, 21 Apr 2020 22:02:19 -0700 (PDT)
Received: from [100.124.11.187] ([104.129.198.54])
        by smtp.gmail.com with ESMTPSA id z13sm3964425pjz.42.2020.04.21.22.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 22:02:18 -0700 (PDT)
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
To:     decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, hare@suse.de,
        mikelley@microsoft.com, longli@microsoft.com, ming.lei@redhat.com
Cc:     linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
        sthemmin@microsoft.com, haiyangz@microsoft.com, kys@microsoft.com
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
Date:   Tue, 21 Apr 2020 22:02:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587514644-47058-1-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/21/20 5:17 PM, Dexuan Cui wrote:
> During hibernation, the sdevs are suspended automatically in
> drivers/scsi/scsi_pm.c before storvsc_suspend(), so after
> storvsc_suspend(), there is no disk I/O from the file systems, but there
> can still be disk I/O from the kernel space, e.g. disk_check_events() ->
> sr_block_check_events() -> cdrom_check_events() can still submit I/O
> to the storvsc driver, which causes a paic of NULL pointer dereference,
> since storvsc has closed the vmbus channel in storvsc_suspend(): refer
> to the below links for more info:
>    https://lkml.org/lkml/2020/4/10/47
>    https://lkml.org/lkml/2020/4/17/1103
> 
> Fix the panic by blocking/unblocking all the I/O queues properly.
> 
> Note: this patch depends on another patch "scsi: core: Allow the state
> change from SDEV_QUIESCE to SDEV_BLOCK" (refer to the second link above).
> 
> Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>   drivers/scsi/storvsc_drv.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index fb41636519ee..fd51d2f03778 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1948,6 +1948,11 @@ static int storvsc_suspend(struct hv_device *hv_dev)
>   	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
>   	struct Scsi_Host *host = stor_device->host;
>   	struct hv_host_device *host_dev = shost_priv(host);
> +	int ret;
> +
> +	ret = scsi_host_block(host);
> +	if (ret)
> +		return ret;
>   
>   	storvsc_wait_to_drain(stor_device);
>   
> @@ -1968,10 +1973,15 @@ static int storvsc_suspend(struct hv_device *hv_dev)
>   
>   static int storvsc_resume(struct hv_device *hv_dev)
>   {
> +	struct storvsc_device *stor_device = hv_get_drvdata(hv_dev);
> +	struct Scsi_Host *host = stor_device->host;
>   	int ret;
>   
>   	ret = storvsc_connect_to_vsp(hv_dev, storvsc_ringbuffer_size,
>   				     hv_dev_is_fc(hv_dev));
> +	if (!ret)
> +		ret = scsi_host_unblock(host, SDEV_RUNNING);
> +
>   	return ret;
>   }

I don't like this patch. It makes the behavior of the storsvc driver 
different from every other SCSI LLD. Other SCSI LLDs don't need this 
change because these don't destroy I/O queues upon suspend.

Bart.

