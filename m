Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3C1B4D7A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 21:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgDVTi2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 15:38:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45322 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgDVTi2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 15:38:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id t14so3928912wrw.12
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Apr 2020 12:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGdFkDLk0ZFA9fwlfvECbg7zO6dW7VE4ynHV4nj7nNE=;
        b=RlW4Zfe7i6fiGqVDbkRH3nJAwHHOsXSZXPkX0GaKbdexDbv+3vQhge0aBAiI/3x6Ab
         BQQkPul1ztFYmSFIXZc8IPfbQ3Hs3kEZq+cTAb5wbjsWoUIi5NBVk3yV+QzaPaos/VFt
         DWbsj1wS9orOLf1t8kIfgC2CgCf1NV1CsrInwC946h4ClXsdXg3LR4wZRgFV/BidgCLR
         R9dgSE1aRtQ3WMsVwDhPwtNd6NPxGt9TTqA8dJicHvwPRIcCmAHFwDCSYP17yD2J2YUX
         0ME5Agg5UP2BbxNbT1wzIYmv4sJW2mN0rVqcxDh0Nq2VthpFNasXeYFutNSULP3rv6SU
         nzhQ==
X-Gm-Message-State: AGi0PuYmUFBaYTXkLHxDaiIEnrOpg/ekfBUqOtMakCGMUCLs5t7b8WJw
        i7MAabk6xAqRcSnscVifvM0=
X-Google-Smtp-Source: APiQypIAZxhEX1OO6P+R5KO/6KgmITqGqOPPGvLUDIngXHwiWr4QX2PinGyiLxFGQabGw+PY7CojWg==
X-Received: by 2002:a5d:498d:: with SMTP id r13mr723815wrq.374.1587584306481;
        Wed, 22 Apr 2020 12:38:26 -0700 (PDT)
Received: from debian (44.142.6.51.dyn.plus.net. [51.6.142.44])
        by smtp.gmail.com with ESMTPSA id j17sm278307wrb.46.2020.04.22.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 12:38:25 -0700 (PDT)
Date:   Wed, 22 Apr 2020 20:38:23 +0100
From:   Wei Liu <wei.liu@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v1] hyper-v: Remove internal types from UAPI header
Message-ID: <20200422193823.nwcjv2y4t47kghkr@debian>
References: <20200422131818.23088-1-andriy.shevchenko@linux.intel.com>
 <20200422134127.zgsympiwgvp7hdam@debian>
 <20200422141507.GI185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422141507.GI185537@smile.fi.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 22, 2020 at 05:15:07PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 22, 2020 at 02:41:27PM +0100, Wei Liu wrote:
> > On Wed, Apr 22, 2020 at 04:18:18PM +0300, Andy Shevchenko wrote:
> > > The uuid_le mistakenly comes to be an UAPI type. Since it's luckily not used by
> > > Hyper-V APIs, we may replace with POD types, i.e. __u8 array.
> > > 
> > > Note, previously shared uuid_be had been removed from UAPI few releases ago.
> > > This is a continuation of that process towards removing uuid_le one.
> > > 
> > > Note, there is no ABI change!
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Can you clarify why guid_t is not used instead?
> 
> It's internal type to the kernel. The libuuid or so should provide a compatible
> type(s) for user space.
> 
> > Is the plan to remove it
> > from UAPI as well?
> 
> Yes.
> 

OK. Thanks for explaining.

Wei.

> > Wei.
> > 
> > > ---
> > >  include/uapi/linux/hyperv.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/hyperv.h b/include/uapi/linux/hyperv.h
> > > index 991b2b7ada7a3..8f24404ad04f1 100644
> > > --- a/include/uapi/linux/hyperv.h
> > > +++ b/include/uapi/linux/hyperv.h
> > > @@ -119,8 +119,8 @@ enum hv_fcopy_op {
> > >  
> > >  struct hv_fcopy_hdr {
> > >  	__u32 operation;
> > > -	uuid_le service_id0; /* currently unused */
> > > -	uuid_le service_id1; /* currently unused */
> > > +	__u8 service_id0[16]; /* currently unused */
> > > +	__u8 service_id1[16]; /* currently unused */
> > >  } __attribute__((packed));
> > >  
> > >  #define OVER_WRITE	0x1
> > > -- 
> > > 2.26.1
> > > 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
