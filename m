Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F98489859
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jan 2022 13:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbiAJMOy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jan 2022 07:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiAJMNm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jan 2022 07:13:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61830C061757;
        Mon, 10 Jan 2022 04:13:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w7so11596736plp.13;
        Mon, 10 Jan 2022 04:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fbOxJDANUz+2+2qCoHOMwGC4CRiXyfuTnOmOD9TcJf8=;
        b=Fiu9MAGTT75MlG8IWMPFEkw/Jv7kqDLzkv89w8Q5fFB0QhTi/B1jkfS9DdkJnwhqPt
         xAC77qsUbb2DkYKgUvJ22MKqRGe//xlyLxLxfukQLJKXSqsi+ElMZh4bxYp51S14FPeF
         icpAJr1/qVXf5N8J33F8c5HWz8tvVJEpXm2nECjTZent7Q6N+fm68qX0GJEc1fSZgJzC
         CRPwzgU7v8jznS/0gv9Phuno1gMG9oNv1I8QhgHqLA54r5UhbcGtQgGcWjgUfSFcrWXh
         D2uPumGVVAHBZIkAHI43WT/GVnnNGrIiyb4kjCm0/wHblNWji7OeJX3e8uuAv9OWpu2k
         HAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fbOxJDANUz+2+2qCoHOMwGC4CRiXyfuTnOmOD9TcJf8=;
        b=YZ7UgXNYwlSpSfAISkX145sfj+tZsB+r8aJDThCziD2N6ur4kqhvhZO3HZqGlFG6dA
         8a/hOJTbyX5iG8/Ktoz7w7kwv5wEkUS8VuHmt0rWFDkI+0AxA+enO/rD5DQ6jfKz1HBj
         Wy8D+8cHOAOpdFHKp/TVYEmkXqr9/5HdCVSHbJDSpAw4fgAKPBh9LXEd6CAad53H+vBm
         mN6I1DM9gR33/gheQup2dmVm3OgdgAzux6EoH1FX+KzJiNY9rwQBWtTM6mT99pHDGVTQ
         nQB3lLPh+me2O10crpuZBns0Da6/2zZCy0WBWg4IDdMvMDiMIwWaTvhYfeYxHT15sEy8
         sxJw==
X-Gm-Message-State: AOAM533aXks9+x2o5OW9sTurTrZFf90apYa8PmlHT7zUNhaAinEbZThf
        8coiXynVub5OCR5mmm0biuKu6AGW5AzmSQ==
X-Google-Smtp-Source: ABdhPJzyiTSpPFaIoc8j5dO5ENVip8t+1AYfxXd6TE9cyhN7D4KVg4OJJo1Ax5gT4Yq0JSWQxhJYFw==
X-Received: by 2002:a62:6445:0:b0:4be:9d1:1342 with SMTP id y66-20020a626445000000b004be09d11342mr6745184pfb.29.1641816817966;
        Mon, 10 Jan 2022 04:13:37 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::50b? ([2404:f801:9000:1a:efea::50b])
        by smtp.gmail.com with ESMTPSA id g21sm6615528pfc.75.2022.01.10.04.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 04:13:37 -0800 (PST)
Message-ID: <7354695e-a8dd-8c6c-ee7e-764280184863@gmail.com>
Date:   Mon, 10 Jan 2022 20:13:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] scsi: storvsc: Fix storvsc_queuecommand() memory leak
Content-Language: en-US
To:     Juan Vazquez <juvazq@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220109001758.6401-1-juvazq@linux.microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <20220109001758.6401-1-juvazq@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 1/9/2022 8:17 AM, Juan Vazquez wrote:
> Fix possible memory leak in error path of storvsc_queuecommand() when
> DMA mapping fails.
> 
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
> Signed-off-by: Juan Vazquez <juvazq@linux.microsoft.com>

Looks good. Thanks for the fix patch.

Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>

> ---
>   drivers/scsi/storvsc_drv.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 2273b843d9d2..9a0bba5a51a7 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1850,8 +1850,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>   		payload->range.offset = offset_in_hvpg;
>   
>   		sg_count = scsi_dma_map(scmnd);
> -		if (sg_count < 0)
> -			return SCSI_MLQUEUE_DEVICE_BUSY;
> +		if (sg_count < 0) {
> +			ret = SCSI_MLQUEUE_DEVICE_BUSY;
> +			goto err_free_payload;
> +		}
>   
>   		for_each_sg(sgl, sg, sg_count, j) {
>   			/*
> @@ -1886,13 +1888,18 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>   	put_cpu();
>   
>   	if (ret == -EAGAIN) {
> -		if (payload_sz > sizeof(cmd_request->mpb))
> -			kfree(payload);
>   		/* no more space */
> -		return SCSI_MLQUEUE_DEVICE_BUSY;
> +		ret = SCSI_MLQUEUE_DEVICE_BUSY;
> +		goto err_free_payload;
>   	}
>   
>   	return 0;
> +
> +err_free_payload:
> +	if (payload_sz > sizeof(cmd_request->mpb))
> +		kfree(payload);
> +
> +	return ret;
>   }
>   
>   static struct scsi_host_template scsi_driver = {
