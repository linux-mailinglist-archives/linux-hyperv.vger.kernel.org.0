Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADC518456
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 May 2022 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiECMfH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 08:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiECMfB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 08:35:01 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B625E1EAC0;
        Tue,  3 May 2022 05:31:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so19651433edw.6;
        Tue, 03 May 2022 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8YM2dc3Lj2iqFmnWMin0ar9E2yzV5t6KJp8upB+s4PM=;
        b=oxm5Dbh7bnrEcep/5H5IbdiNiqPOec5bdXe+GKf8c6LL0zS/nrqHVxNgh+yCSbGdzU
         WGCzuwY1oXA6zsoLzYgZspCQKJcxclHsOgfU494LpsHGGeEVCDG2KcmXoHZY3yi/WslV
         Q9I+RpAlbkWs8/jAkY7lOBpb1rX/1g68NAyzG7B3eRSCQIZD6K8LGQU65MZL2MCQ6tac
         A7j1rA5VfHj/YQ02dzBquSIAwGjigNJ3ZJ9ii/60hollhY6yFD/o3DX5UQGOCkgOXrR+
         arUg+HJvdhbCSGlGZcvt5m8QmdL7tNeeflxuISuKa+w/z025KGCi70TGqSRLd2lKcxmE
         istw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YM2dc3Lj2iqFmnWMin0ar9E2yzV5t6KJp8upB+s4PM=;
        b=aSZIeBVFE4gyUTim7Kk0RWc5FTYCgmPOYDw7JBnajdrBZV7MXCOYL97zHjY22x893y
         EtPwxCkUYv5pMh61C3A7H6Fs6WRvYGVTYlQKSF2taNejZj+7iTT7tsIw4+Qp0IpN9Wu7
         OCNxtw6v4xzvPGeF+AIJZk8cciUatzDZC+2o0v0By57YfOqRNLzVEEYB9yoYuGe6vJRa
         0iymlurNdkcAkkzikyMDMqktk95IJ6/JbLKtPfRTjJAiGip+bbiU3C3Fc9vvuR1Ys0SV
         jaI9kf4EZn7/oskhiH6OZ2QtQqB32LmAh5wGKqDi77MZcJ6qZBbHB5Y64Dn+LFfMYt+S
         sEDA==
X-Gm-Message-State: AOAM530c0st0k/WWoUCD41Y+orZs3ANvH7Afipq8XTc+ej4kY93bVsLI
        dXIjcn2+UwvH4+tcaDRbFuM=
X-Google-Smtp-Source: ABdhPJwL01DktolWLuTqjgKLl4GybEuGnHg3PPyHsnp4FL0NxG7V9tWDzk7OuCu6uK3vQXkjHD+4Lg==
X-Received: by 2002:a05:6402:3711:b0:425:d3d6:2b65 with SMTP id ek17-20020a056402371100b00425d3d62b65mr18102385edb.328.1651581087167;
        Tue, 03 May 2022 05:31:27 -0700 (PDT)
Received: from anparri (host-79-49-65-106.retail.telecomitalia.it. [79.49.65.106])
        by smtp.gmail.com with ESMTPSA id dq9-20020a170907734900b006f3ef214de3sm4571504ejc.73.2022.05.03.05.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 05:31:26 -0700 (PDT)
Date:   Tue, 3 May 2022 14:30:46 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, jejb@linux.ibm.com, martin.petersen@oracle.com,
        deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove support for Hyper-V 2008 and 2008R2/Win7
Message-ID: <20220503123046.GA448894@anparri>
References: <1651509391-2058-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651509391-2058-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 02, 2022 at 09:36:27AM -0700, Michael Kelley wrote:
> Linux code for running as a Hyper-V guest includes special cases for the
> first released versions of Hyper-V: 2008 and 2008R2/Windows 7. These
> versions were very thinly used for running Linux guests when first
> released more than 12 years ago, and they are now out of support
> (except for extended security updates). As initial versions, they
> lack the performance features needed for effective production usage
> of Linux guests. In total, there's no need to continue to support
> the latest Linux kernels on these versions of Hyper-V.
> 
> Simplify the code for running on Hyper-V by removing the special
> cases. This includes removing the negotiation of the VMbus protocol
> versions for 2008 and 2008R2, and the special case code based on
> those VMbus protocol versions. Changes are in the core VMbus code and
> several drivers for synthetic VMbus devices.
> 
> Some drivers have driver-specific protocols with the Hyper-V host and
> may have versions of those protocols that are limited to 2008 and
> 2008R2. This patch set does the clean-up only for the top-level
> VMbus protocol versions, and not the driver-specific protocols.
> Cleaning up the driver-specific protocols can be done with
> follow-on patches.
> 
> There's no specific urgency to removing the special case code for
> 2008 and 2008R2, so if the broader Linux kernel community surfaces
> a reason why this clean-up should not be done now, we can wait.
> But I think we want to eventually stop carrying around this extra
> baggage, and based on discussions with the Hyper-V team within
> Microsoft, we're already past the point that it has any value.
> 
> Michael Kelley (4):
>   Drivers: hv: vmbus: Remove support for Hyper-V 2008 and Hyper-V
>     2008R2/Win7
>   scsi: storvsc: Remove support for Hyper-V 2008 and 2008R2/Win7
>   video: hyperv_fb: Remove support for Hyper-V 2008 and 2008R2/Win7
>   drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7

For the series,

Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Thanks,
  Andrea


>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 23 ++++--------
>  drivers/hv/channel_mgmt.c                 | 29 ++++++---------
>  drivers/hv/connection.c                   |  6 ++--
>  drivers/hv/vmbus_drv.c                    | 60 +++++++------------------------
>  drivers/scsi/storvsc_drv.c                | 36 +++++--------------
>  drivers/video/fbdev/hyperv_fb.c           | 23 ++----------
>  include/linux/hyperv.h                    | 10 ++++--
>  7 files changed, 52 insertions(+), 135 deletions(-)
> 
> -- 
> 1.8.3.1
> 
