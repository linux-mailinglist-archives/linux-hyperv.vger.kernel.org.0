Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DC51832C
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 May 2022 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiECLZi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 May 2022 07:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiECLZh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 May 2022 07:25:37 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5137417AA4;
        Tue,  3 May 2022 04:22:05 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso1084986wml.5;
        Tue, 03 May 2022 04:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiY0dGoIC8096MJoLsSBb1qNLHmagfKwvPsd98SImSg=;
        b=a0vixKdvtLv2O3//vtKss4jlgL8e/Gv+Cnvveuw82Z2bXYk08ZfM099wL9y9cdDOM0
         qohzpZu3t2pXzdNDrE/Sk1JXEi/vfWL7RTkGunyeM/pZubjD/8j+9REc2IeCwaZx+juU
         tYXbu5uzWQDa3tcawBAmwO44VXB8yv7/o0CHfh36DYTwnCbZ1UF8ZGYNyf1Z+uI6OVID
         ymqxlTw0vaVej9AqdE8j8wZqpB7MgGSPcVryknFcPV0DnM3UFefg9lO6pZMMaQePFIJf
         IwehEKrWXlbpxtreo8yksbrzjY+Htc6/hFX6YmfsbKi20Jo1jOcCxob1FIpIc1oZlVF4
         NBjQ==
X-Gm-Message-State: AOAM533K9wdI6sTRcRPnfjNINXNE9RMNENXvqu3ViL2fIgpRpu36KkBv
        L0mUck9gGVL5+M8Z3HzAhwI=
X-Google-Smtp-Source: ABdhPJxm1zYhvfWARYcqdPYfX+WBZx31HBYYbX9BTSG4b89PfKyAhJee2ZJz/esokNnR95scu5noYQ==
X-Received: by 2002:a05:600c:3b14:b0:394:1f06:37eb with SMTP id m20-20020a05600c3b1400b003941f0637ebmr2920891wms.193.1651576923857;
        Tue, 03 May 2022 04:22:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05600c1f0a00b003942a244ec6sm1465936wmb.11.2022.05.03.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 04:22:03 -0700 (PDT)
Date:   Tue, 3 May 2022 11:22:01 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, jejb@linux.ibm.com, martin.petersen@oracle.com,
        deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Remove support for Hyper-V 2008 and 2008R2/Win7
Message-ID: <20220503112201.hwzenitojimrgz3f@liuwe-devbox-debian-v2>
References: <1651509391-2058-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651509391-2058-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

I will wait for a week for people to voice their opinions. If I hear no
objection I will apply this series to hyperv-next.

Thanks,
Wei.

> Michael Kelley (4):
>   Drivers: hv: vmbus: Remove support for Hyper-V 2008 and Hyper-V
>     2008R2/Win7
>   scsi: storvsc: Remove support for Hyper-V 2008 and 2008R2/Win7
>   video: hyperv_fb: Remove support for Hyper-V 2008 and 2008R2/Win7
>   drm/hyperv: Remove support for Hyper-V 2008 and 2008R2/Win7
> 
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
