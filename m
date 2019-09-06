Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 745FFAAFCA
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Sep 2019 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389976AbfIFAUW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Sep 2019 20:20:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41499 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733029AbfIFAUW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Sep 2019 20:20:22 -0400
Received: by mail-io1-f66.google.com with SMTP id r26so8824255ioh.8
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Sep 2019 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fcZ6RhjZIkyA+SXbOHFG43SR1YhKTQF+JKeGixWFyx8=;
        b=S54ixsoKqgMmtMTdG/PtHFmFCRUezETcWqGMYnhRL/9sRpPuNJTUv0uKsoQ9PcAIJZ
         pQCwmxHNuS0BWD08xa/+EPKsYdLzK6Z0g3BtMGhgGRTHLZUb/GHue2jms6OjAcLLYXSC
         fRM2hlMi5qYAHkP5vaY7C2ZH7r27EOvEAU+ZmPLeU9I2QExIXO5nqKilHed3maDpKYdb
         NhCHm8e2JwPTLtDAzXVgtAmZtQEHQ+OsHYyFUwmi8eWB1ueNvlQTKzbCIe6ondQFWurs
         9NesD2RwG5QPnFUlpHCD5mJWJZVN1TmMEYgCpeM1xMaNIKeGMDuq7PG4OIV1ALajWWte
         PAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fcZ6RhjZIkyA+SXbOHFG43SR1YhKTQF+JKeGixWFyx8=;
        b=jw3SWCFbvCQEmi/XUbkGe64uYs6C03WqvpPaiKu0OHytTOWMDA8YThk1+SmMfKFlZA
         OFqdKt0897ydTrjDV1wqZzxXVlnMoFDMruixqaiUTLdom0zX2qZuMcrM4ID84eqxGY9N
         ER9QchcJLcncYWHfg1r1iYj8g9Nr32FEgsPN0vLqRgWre+5GGFsBCV0A54a1qKsrNfZO
         tT8H3wjdPPtKzDf6ljWKkmHjdAXFvlA8UmhAxebDmVYLhGAqmL+ZyTEUwEvWnG8YHIko
         1zaaI1ZVaTdYvOa2ZuNfWc+PBFVJGU4fFJTLFLyuHkqbCxiEb6bmUnQltvvZPVw/tyWj
         PmPA==
X-Gm-Message-State: APjAAAVIL8vzANWXp8EtmHicTSLy6L5QIJP7dWQ815QagQXUUfNzu+RV
        N46FzACzurvcTIipWeeNdA==
X-Google-Smtp-Source: APXvYqy9Rk6mZTNEMENKEcuehtLzL9bu2MCwKKStR69UB1Q/Vfb5xSrXoL6SEPUehWWNNGM9+5xftA==
X-Received: by 2002:a5e:c644:: with SMTP id s4mr6925690ioo.36.1567729221692;
        Thu, 05 Sep 2019 17:20:21 -0700 (PDT)
Received: from Test-Virtual-Machine (d24-141-106-246.home.cgocable.net. [24.141.106.246])
        by smtp.gmail.com with ESMTPSA id 67sm4310412iow.84.2019.09.05.17.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Sep 2019 17:20:21 -0700 (PDT)
Date:   Thu, 5 Sep 2019 20:20:19 -0400
From:   Branden Bonaby <brandonbonaby94@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, sashal@kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20190906002019.GA17427@Test-Virtual-Machine>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
 <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566340843.git.brandonbonaby94@gmail.com>
 <20190829145715.41df52e0@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829145715.41df52e0@hermes.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 29, 2019 at 02:57:15PM -0700, Stephen Hemminger wrote:
> On Tue, 20 Aug 2019 16:39:02 -0700
> "Branden Bonaby" <brandonbonaby94@gmail.com> wrote:
> 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 9a59957922d4..d97437ba0626 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -29,4 +29,11 @@ config HYPERV_BALLOON
> >  	help
> >  	  Select this option to enable Hyper-V Balloon driver.
> >  
> > +config HYPERV_TESTING
> > +        bool "Hyper-V testing"
> > +        default n
> > +        depends on HYPERV && DEBUG_FS
> > +        help
> > +          Select this option to enable Hyper-V vmbus testing.
> > +
> >  endmenu
> 
> Maybe this should go under the Kernel hacking
> section in lib/Kconfig.debug?
> 

These lines are the same in the v4 patch I sent a bit after this
so in my v5 version I'll update this.

Thanks
