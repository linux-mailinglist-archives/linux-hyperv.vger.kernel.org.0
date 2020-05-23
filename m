Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444851DF62C
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2020 11:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgEWJEH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 23 May 2020 05:04:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37556 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgEWJEH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 23 May 2020 05:04:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id l17so12587824wrr.4;
        Sat, 23 May 2020 02:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wHEVgPYbInrmivVdwVmS/wLcMCPWwyD58Nhe2wcQjfs=;
        b=jKs1L/smdt6HZ/N/w6fAe2gFc4/U0gKsO7TuyY5l59qcVTDqNzcWZ1XAaVaBhXhQ/F
         waLzR6HMUtrMXA65Y4TGoupqFIJAN5HqSB8rNiDIE/ihJzsMAJsJ/ssSq1e+M+d+5C2v
         F7ZJPzSPl4nuLahNwyJYMabnbw2B0tWHqFklbfadHtMzW6gNfzYzXtcJ1/huHad0YMlk
         DOAWt7HopPvLp3wT8FP7jiEB+7gA/hFnheOK/PrQT3p3NaDQhSLrPwTFLh0B69kIsFyy
         UzyqL91/zn5mrDIdRSkjFr/nny/KS4q5okP1YJkTxhOkM8F9mvnlu4YMSlbG7laRtYdT
         +zNg==
X-Gm-Message-State: AOAM530DsqnkWwugULpeX4nntyDun10EIkByBZcoIL9OgQMqbn7ou9a8
        hE+igou+8vFDwAJSFKp8g7Y=
X-Google-Smtp-Source: ABdhPJwfXDlEVR+GjK8MD8CecRuUJ5OzBF1LGAGM+dByWZJ9G3u0arNxw5VIu+B5pcY8/pRP39nqsw==
X-Received: by 2002:adf:810a:: with SMTP id 10mr7088226wrm.101.1590224645436;
        Sat, 23 May 2020 02:04:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z16sm2645612wmf.3.2020.05.23.02.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 02:04:04 -0700 (PDT)
Date:   Sat, 23 May 2020 09:04:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] VMBus channel interrupts reassignment - Fixes
Message-ID: <20200523090403.hqyrdbbzgeckmi3q@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200522171901.204127-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522171901.204127-1-parri.andrea@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 22, 2020 at 07:18:59PM +0200, Andrea Parri (Microsoft) wrote:
> Two fixes on top of the channel interrupts reassignment series, both
> addressing race conditions between the initialization of the target
> CPUs and the CPU hot removal path.   (Fixes: tags refer to commit IDs
> from the hyperv tree and should be considered as placeholders; please
> let me know how you'd prefer to handle these...)

Thanks for the heads-up. I will change the tags if I end up rebasing
hyperv-next.

Wei.

> 
> Thanks,
>   Andrea
> 
> Andrea Parri (Microsoft) (2):
>   Drivers: hv: vmbus: Resolve race between init_vp_index() and CPU
>     hotplug
>   Drivers: hv: vmbus: Resolve more races involving init_vp_index()
> 
>  drivers/hv/channel_mgmt.c | 66 +++++++++++++++++++--------------------
>  drivers/hv/hyperv_vmbus.h | 48 ++++++++++++++++++++++++++++
>  drivers/hv/vmbus_drv.c    | 19 +++++++----
>  include/linux/hyperv.h    |  7 +++++
>  4 files changed, 101 insertions(+), 39 deletions(-)
> 
> -- 
> 2.25.1
> 
