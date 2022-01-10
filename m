Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01748981E
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Jan 2022 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245052AbiAJL4O (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 10 Jan 2022 06:56:14 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43546 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiAJL4L (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 10 Jan 2022 06:56:11 -0500
Received: by mail-wr1-f49.google.com with SMTP id o3so26250437wrh.10;
        Mon, 10 Jan 2022 03:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5JGHooFXj2iz4QcgazfHEbKsX6GW7+vX5suOZ5p/SDM=;
        b=B5auyrNEqwfRdl75fjeIdWOx2w9nxkmZf4CQcNfYir5X0gmUHUOv6jeGh7AYkmKEyn
         oB83vsX7g+7J3fXCFCVyozb9ZnJ3alrjuOsIErhjparEPhGDCfXwSV855vSaquEtMNLg
         mb9k1P858V8IG8Bf5uQ644STdsSkYoQszKiuVh5nKnyeYL6JfkWV0zKJ+r0ix7zwAvl8
         FWC4Qu8Jh5mv9ehA6BsO5ju5bClVUwBsD3hc90H5LHM8e1fHfGTqUjn9VjE+Fcn0UaTC
         JjGKz4+A7FMLc/fBGLPxKyitei5Hldk3gGQ9mPRPX9U/wSwPAjWLBrbac+y+f9fV+E+f
         OctA==
X-Gm-Message-State: AOAM531+hO+HvqfU71aFVgiTTDC18OoW2RnRdMGntVYpOs6lD6m8h49s
        nzOhtzXvqnGFByxJm5w9iCw=
X-Google-Smtp-Source: ABdhPJxZBnLQMX3PWtG+rxuni0SASXbD4BM0W6Jr8VzSIuO8sHUMTwXE4vb7scyOzRBBUjBISGyLpA==
X-Received: by 2002:a5d:5847:: with SMTP id i7mr50225249wrf.450.1641815770104;
        Mon, 10 Jan 2022 03:56:10 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x21sm6307469wmc.24.2022.01.10.03.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 03:56:09 -0800 (PST)
Date:   Mon, 10 Jan 2022 11:56:08 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Juan Vazquez <juvazq@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, mikelley@microsoft.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianyu.lan@microsoft.com,
        longli@microsoft.com
Subject: Re: [PATCH] scsi: storvsc: Fix storvsc_queuecommand() memory leak
Message-ID: <20220110115608.sdsbnof5gtc6gu74@liuwe-devbox-debian-v2>
References: <20220109001758.6401-1-juvazq@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220109001758.6401-1-juvazq@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jan 08, 2022 at 04:17:58PM -0800, Juan Vazquez wrote:
> Fix possible memory leak in error path of storvsc_queuecommand() when
> DMA mapping fails.
> 
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
> Signed-off-by: Juan Vazquez <juvazq@linux.microsoft.com>

Martin, I can pick this up since the offending commit is not yet in
Linus' tree.

Tianyu, Long and Michael, the change makes sense to me but can you give
an ack or review here?

> ---
>  drivers/scsi/storvsc_drv.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index 2273b843d9d2..9a0bba5a51a7 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -1850,8 +1850,10 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  		payload->range.offset = offset_in_hvpg;
>  
>  		sg_count = scsi_dma_map(scmnd);
> -		if (sg_count < 0)
> -			return SCSI_MLQUEUE_DEVICE_BUSY;
> +		if (sg_count < 0) {
> +			ret = SCSI_MLQUEUE_DEVICE_BUSY;
> +			goto err_free_payload;
> +		}
>  
>  		for_each_sg(sgl, sg, sg_count, j) {
>  			/*
> @@ -1886,13 +1888,18 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  	put_cpu();
>  
>  	if (ret == -EAGAIN) {
> -		if (payload_sz > sizeof(cmd_request->mpb))
> -			kfree(payload);
>  		/* no more space */
> -		return SCSI_MLQUEUE_DEVICE_BUSY;
> +		ret = SCSI_MLQUEUE_DEVICE_BUSY;
> +		goto err_free_payload;
>  	}
>  
>  	return 0;
> +
> +err_free_payload:
> +	if (payload_sz > sizeof(cmd_request->mpb))
> +		kfree(payload);
> +
> +	return ret;
>  }
>  
>  static struct scsi_host_template scsi_driver = {
> -- 
> 2.32.0
> 
