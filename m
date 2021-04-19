Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE5363B4A
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Apr 2021 08:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhDSGKN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Apr 2021 02:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhDSGKN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 02:10:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2573C06174A;
        Sun, 18 Apr 2021 23:09:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u20so12923263wmj.0;
        Sun, 18 Apr 2021 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mOILbOxKaCLuuk29abCrHQQ55Mtc0Vk9dYwreZ0htoA=;
        b=nF4FIohEVZVLA3vapskqUWdf6YBKQbEjzNSA7d+WKCtHheH4vSUlbfNK6LVG6MhRzu
         oZQtcG9Bh7JIp+46Sonuk04NyP20d9jIhIwGYVfxgKBGRqTyLXJnh8x43nIhxPTzsFkg
         4dY2pRDUsrERQnXLLgrMUIKqitdGDzBEc6HM3htUmd+6SLHDnr580bWp4bR4Hk64+i/Z
         SOVAX1zRvTCMpf1LSTnJ/4BRRQx3f4ygAxGFvHnG2bY0D3u0oZIWznsWhdfLQkLYRHUb
         B0LeQcm+XjX703ekYFPtFJCa6lgo3wNbQUZB1CRlVsKrwBfXn/HV+NID8nmm8aF103b0
         5MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mOILbOxKaCLuuk29abCrHQQ55Mtc0Vk9dYwreZ0htoA=;
        b=I3rSHTxsq1Vu9w5XZ1U16C4bTpBvkT7Ha/wOzppakdmDcpmxHKjcUPDq6NNg6wB6d2
         Ds02JuTg3ALKi27JmNBTXm2E2ZZ55+tu2VFp71VKl7+GdUEqAEcDL+rHCIqmprATQoqE
         oVwDgOFaveuWVM/rvaUaex9DMwgTmGsAeFex2L3LMsdWcDVgWyEFambtQdlEssbwDK+a
         D4S4eTzNAiJ0T/VaBtnBZeZgwuviUY1n2JJm0zkslg9EMASwWAyf8mXsvymMaFmnxc3r
         H0XcwcKpsjLTe1RNhrqd7KK62kq/sTYonxPLytv/TMQ5kfzz9rmaU2pa/p9vzSD6+Ael
         2geg==
X-Gm-Message-State: AOAM533xsTYlXJ8SV0FcrFgzbT8ha4SceE6sw8vPZTPLDI2iU28DmXuh
        B8ChDjpBpPUcVzglVdbun+I=
X-Google-Smtp-Source: ABdhPJyPnyQS1fKA21J666ickvJFAnNcO+BBZdzA0k0HZQqTWGd5keCgHadtTwHlgX/owQtv5uc6FA==
X-Received: by 2002:a1c:4b11:: with SMTP id y17mr19414512wma.72.1618812582359;
        Sun, 18 Apr 2021 23:09:42 -0700 (PDT)
Received: from anparri ([151.76.104.230])
        by smtp.gmail.com with ESMTPSA id g84sm14476803wmg.42.2021.04.18.23.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 23:09:42 -0700 (PDT)
Date:   Mon, 19 Apr 2021 08:09:34 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: vmbus: Initialize unload_event statically
Message-ID: <20210419060934.GA1410@anparri>
References: <20210416143932.16512-1-parri.andrea@gmail.com>
 <MWHPR21MB159389AFC33EB4D799E4D6B5D74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB159389AFC33EB4D799E4D6B5D74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Apr 16, 2021 at 03:25:03PM +0000, Michael Kelley wrote:
> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Friday, April 16, 2021 7:40 AM
> > 
> > If a malicious or compromised Hyper-V sends a spurious message of type
> > CHANNELMSG_UNLOAD_RESPONSE, the function vmbus_unload_response() will
> > call complete() on an uninitialized event, and cause an oops.
> 
> Please leave a comment somewhere in the code itself that describes this
> scenario so that somebody in the future doesn't decide it's OK to "simplify" the
> initialization of unload_event. :-)

Yes, will do for v2.

Thanks,
  Andrea
