Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C732B08F3
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgKLPwR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:52:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35190 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgKLPwQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:52:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id k2so6526551wrx.2;
        Thu, 12 Nov 2020 07:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k07t8PwybZxtbCrPL/7Du9KIxCNFtVk3g/FoEkvWuKQ=;
        b=spfkCiz/Pk/29NjRpDPIkj9Tq6B1FcVjjTJXY6/SWbdFzHVEdVIiDZthsuCwMVBC5/
         iXLieRqvrw5hfMCcdfHWOxYUrm5at+mMIo+lytfuq0jHLQWyVkEndr/e6UFpybPps4Hw
         v3Bnn0Lg1K0kpf43UWCCCV7oZGlct3j0bHmNDngumKtIrw157JC1SG353LrlqB1h8pYm
         Ew1DMDOVmvFADDO4I/2ybvRMX4IKbLrYfiDVbVXyzWt2s/yoyUIAno25lA+QIKVfr6yw
         0uUErkriKhpek3MJVoRaFSzKrlrN9S9Sfiw0MDgowYTds72TajtXUWqYpUm1nhbVtQKP
         53gg==
X-Gm-Message-State: AOAM530gBvhVEkRUj8woToGDve2G9GI4iyB0wcW8k7Y24xlC5Ww6/SKl
        U7HSrMjAuICgvmI6rcSVk6w=
X-Google-Smtp-Source: ABdhPJxbmSkWXEUAhLwzzGSYqAcBhvEj5M8opeo42HFLa4+0jVYjoeIHWoWx3AgLjPqfggXdzZ/fFQ==
X-Received: by 2002:adf:e2c9:: with SMTP id d9mr177680wrj.11.1605196332801;
        Thu, 12 Nov 2020 07:52:12 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g23sm6987164wmh.21.2020.11.12.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:52:12 -0800 (PST)
Date:   Thu, 12 Nov 2020 15:52:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 05/17] clocksource/hyperv: use MSR-based access if
 running as root
Message-ID: <20201112155210.dwpzbyf6ytsmt2dh@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-6-wei.liu@kernel.org>
 <87d00iy4lq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d00iy4lq.fsf@vitty.brq.redhat.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 12, 2020 at 04:30:57PM +0100, Vitaly Kuznetsov wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> In the missing commit message I'd like to see why we don't use 'TSC
> page' clocksource for the root partition. My guess would be that it's
> not available and actually we're supposed to use raw TSC value (because
> root partitions never migrate) but please spell it out.

See my exchange with Daniel.

Wei.
