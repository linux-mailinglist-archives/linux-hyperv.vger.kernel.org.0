Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B3366067
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhDTTt0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 15:49:26 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36845 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhDTTt0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 15:49:26 -0400
Received: by mail-wr1-f46.google.com with SMTP id m9so26189028wrx.3;
        Tue, 20 Apr 2021 12:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0ukk8PsmQlwN+Rn5D2gQhIuSsA6BZpFzPg9NcEGXp4=;
        b=skuH+Nsnefit62ZEPE1hVhjefn/dZC+6uC3ArvyIK2QU+7oAypnUcsXa3iy65Iy7B4
         iXbFjc1p89qFsq8Bqj5hKmEvCHTUhRhPGM8ouIL3yd3qjDkIBafTXuC+yUXdk70hYL59
         ycEuBa0OwKVdCYwfIXMjtvHNX6+CnOqroBa49mMh5JyL5s54uPYzRITPqV9hAmgUz0QE
         MmBTi0JLT3JCe0g9/BGomhMQMYyUDd3U6YPAg95zNLicdvLGfNKE1fuu4k39R0+L0WvY
         iFy44r5gaOH0mb9DLvAoNvKA+R0aGauDKHw739EZ3vBAQpS3dUdtIkE/uHbRCpbenqPY
         lPoA==
X-Gm-Message-State: AOAM533sBprE+ejd/qxmtAoHtpGo1/FmI6TYZMboJr+h+9RdwlR+ZUfR
        ES0hFDnnCukkjDr0bMs0Vfg=
X-Google-Smtp-Source: ABdhPJy0ZocLxNBmT+3nxOoxl9PzGDN9xmxdB2RMLTGXFgEvNocM1baf8kWI66gQWw/s/BQ9T+mPiA==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr22203180wrm.327.1618948131851;
        Tue, 20 Apr 2021 12:48:51 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d2sm10485wrs.10.2021.04.20.12.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 12:48:51 -0700 (PDT)
Date:   Tue, 20 Apr 2021 19:48:50 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/1] video: hyperv_fb: Add ratelimit on error message
Message-ID: <20210420194850.ykxb3yy75zvzqfun@liuwe-devbox-debian-v2>
References: <1618933459-10585-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618933459-10585-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 20, 2021 at 08:44:19AM -0700, Michael Kelley wrote:
> Due to a full ring buffer, the driver may be unable to send updates to
> the Hyper-V host.  But outputing the error message can make the problem
> worse because console output is also typically written to the frame
> buffer.  As a result, in some circumstances the error message is output
> continuously.
> 
> Break the cycle by rate limiting the error message.  Also output
> the error code for additional diagnosability.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.

> ---
>  drivers/video/fbdev/hyperv_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 4dc9077..a7e6eea 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -308,7 +308,7 @@ static inline int synthvid_send(struct hv_device *hdev,
>  			       VM_PKT_DATA_INBAND, 0);
>  
>  	if (ret)
> -		pr_err("Unable to send packet via vmbus\n");
> +		pr_err_ratelimited("Unable to send packet via vmbus; error %d\n", ret);
>  
>  	return ret;
>  }
> -- 
> 1.8.3.1
> 
