Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2325349312
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Mar 2021 14:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhCYNaq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Mar 2021 09:30:46 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:56306 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhCYNaj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Mar 2021 09:30:39 -0400
Received: by mail-wm1-f41.google.com with SMTP id 12so1177540wmf.5;
        Thu, 25 Mar 2021 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1KxpzHpBzHIIR0d4+mLxk0ks65hJp0uLAyGQBVQSIeU=;
        b=iVj+00kb7wVQood9ljjGeRAmPkYTvdKdhEJE7+DWUZsdj+mP6SwxqMQcb89U120V1C
         rgAqsrbG4UJKmGUH6ehyvcoVk2NAMKzI9APEOI0XWJt1t31apWh/UZye7qtAILZNvhAa
         UfNjmBYNnjAVyv2XCfFPluz97uDipAgbivw932doD0QahVv5irrwmK6W/lKejI7r25Zs
         um2aoIqiRnbQHkPvMDGOFrVeHDaD4nogFT8U0RE5VShGWdcQux0qto/fxX/2NfyEB3T2
         yYBsrJsxa/dbnYp0Jlje3xB5mYoXg9+XReamQvSzMFhO5UgtGAarpBRLsWvRcqqhftCI
         7xmQ==
X-Gm-Message-State: AOAM533ddLkDXI/uAk3VBGuSG1RNlmxmjmr6Ve4EYRW9DeihuPyRPO2n
        TRM/jpIw1EWffjvPuBacBC2rAOIWhqg=
X-Google-Smtp-Source: ABdhPJyzGQH/0Iivphr0ruNHgmB+wKVIcHSWa+rCvr/aADGIZVWt+a3LXw8EM4wj0nir7SJxq10PfQ==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr8045770wml.103.1616679038124;
        Thu, 25 Mar 2021 06:30:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d18sm7685472wra.8.2021.03.25.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 06:30:37 -0700 (PDT)
Date:   Thu, 25 Mar 2021 13:30:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] video: hyperv_fb: Fix a double free in hvfb_probe
Message-ID: <20210325133036.rbriezf3v32wofkl@liuwe-devbox-debian-v2>
References: <20210324103724.4189-1-lyl2019@mail.ustc.edu.cn>
 <MWHPR21MB1593F19EE7AD10698582FA78D7639@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593F19EE7AD10698582FA78D7639@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 24, 2021 at 01:46:39PM +0000, Michael Kelley wrote:
> From: Lv Yunlong <lyl2019@mail.ustc.edu.cn> Sent: Wednesday, March 24, 2021 3:37 AM
> > 
> > In function hvfb_probe in hyperv_fb.c, it calls hvfb_getmem(hdev, info)
> > and return err when info->apertures is freed.
> > 
> > In the error1 label of hvfb_probe, info->apertures will be freed for the
> > second time in framebuffer_release(info).
> > 
> > My patch removes all kfree(info->apertures) instead of set info->apertures
> > to NULL. It is because that let framebuffer_release() handle freeing the
> > memory flows the fbdev pattern, and less code overall.
> 
> Let me suggest some clarifications in the commit message.  It's probably
> better not to reference the initial approach of setting info->apertures to
> NULL, since there won't be any record of that approach in the commit
> history.  Here's what I would suggest:
> 
> Function hvfb_probe() calls hvfb_getmem(), expecting upon return that
> info->apertures is either NULL or points to memory that should be freed
> by framebuffer_release().  But hvfb_getmem() is freeing the memory and
> leaving the pointer non-NULL, resulting in a double free if an error
> occurs or later if hvfb_remove() is called.
> 
> Fix this by removing all kfree(info->apertures) calls in hvfb_getmem().
> This will allow framebuffer_release() to free the memory, which follows
> the pattern of other fbdev drivers.
> 
> Modulo this revision to the commit message, which Wei Liu can
> probably incorporate,
> 

Yes. I surely can incorporate the changes.

I will also add the Fixes tag.

> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
