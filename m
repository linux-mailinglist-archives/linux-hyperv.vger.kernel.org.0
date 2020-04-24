Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6C1B71DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2020 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgDXKVZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 24 Apr 2020 06:21:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52118 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgDXKVY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 24 Apr 2020 06:21:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id x4so9856289wmj.1
        for <linux-hyperv@vger.kernel.org>; Fri, 24 Apr 2020 03:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MmLDIEQPEK6prLoOwttf0C8u7YQaeDzuN9P1stWinjc=;
        b=bwIez1C2DD/SAn+Lkecx3tN/x63I93dD9g19QF8XcbM3XpZUQ5XAliPmckJBJUp11P
         R97vjDqE8Lf5QLtZK4v7+wJ+2xposEk9i2NWIuYlYpc5nUkQGP4HUFJsqQp5m9QymS/h
         wJfWKLFFxklna023gBvGYcIQXP7QsboiCXmKv2dWXL2xxx8gbaWSS5y9h6vEVe5Q3wSv
         A59uYZbTUz+p7Y4fUX5VnQDnftwk4dnYDT8IHsmGRs9tSOKgpTBT5HO4L12LV7WzNtfp
         nPCfePO7qtHNR0WB6jiwaYW55VTzhCbn+UiQq0pGd8sdE0QsflUqdqOguNzDYNChEtEI
         NHVw==
X-Gm-Message-State: AGi0Pua1afE8Kp/e2mJirOjyaVdufahDxhJ5RqLh/A51wGpAfnk1B/QC
        YxcP+2UbPCiaJv5OmRJP9ULIvBgH
X-Google-Smtp-Source: APiQypIEVTTkWmJCxSgEHPqoR4CqtxjLi8wSYUoQsIE2versL9UAhToaSX/KLKp9yehhAHpKQzO5aw==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr9754694wmd.131.1587723682846;
        Fri, 24 Apr 2020 03:21:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d7sm7427230wrn.78.2020.04.24.03.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 03:21:21 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:21:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1 1/4] hyper-v: Use UUID API for exporting the GUID
 (part 2)
Message-ID: <20200424102120.ups7buvgv7gv3uay@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
References: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423134505.78221-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Apr 23, 2020 at 04:45:02PM +0300, Andy Shevchenko wrote:
> This is a follow up to the commit 1d3c9c075462
>   ("hyper-v: Use UUID API for exporting the GUID")
> which starts the conversion.
> 
> There is export_guid() function which exports guid_t to the u8 array.
> Use it instead of open coding variant.
> 
> This allows to hide the uuid_t internals.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks.

I have queued the whole series to hyperv-next.

Wei.
