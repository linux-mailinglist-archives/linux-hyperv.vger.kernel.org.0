Return-Path: <linux-hyperv+bounces-2980-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0396D089
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 09:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D8FB25038
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7F194096;
	Thu,  5 Sep 2024 07:37:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74047194083;
	Thu,  5 Sep 2024 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521828; cv=none; b=YA9oXObNvBa1gPYSBefpJTqhmWmMYN0/QZb/1Y3AweOV2v7+wG5xBsns71idF1/nh6kArx10aBM/MiMx+VkIBjeWO65Nr9RLh60MeO31/XrtysZWeHcoJzm7zpoTLzaYd7uBtwlXXHQ8cb0WGcaRfF+uAsT65yugn0Ob36R7Fmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521828; c=relaxed/simple;
	bh=kmOWTOJZUmdxh5seHPI9+cRH33n7yQT7uyeDFmEibL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIMJQer+GxZ7vs39OPSSjOA9DR4oRLuboBlJGmTduQzOQ0V9ZmJCT/Xcb47w3WaNi3Zd1U/tINOMkc/0j7kKOdXLF3Jp1xQhhNotKFbGU+9JajU7tVgeOEeyElbkGVC4V0TjpUcE04Jfdepfd7Nj/QXX+X26d3QFNcDeW+XW2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-717849c0dcaso375229b3a.3;
        Thu, 05 Sep 2024 00:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521827; x=1726126627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ODQeAxhj8C+Vf0cBMwsQnZXKQHVvgZ3tD1m/XY0lBc=;
        b=BrVQO7ODdgzGmA1J6RQcPXAs78d0iC6tSnLyz12K2n4/EQe8op+jJAydJHSTmtCfJR
         102rZZSfDMHcL1YdZMMDjFOegmmVGdE7Q8RLFTWa9pf0ssxtA26G46H7wmuVF2/CUAWE
         vOTss9JSeszqIRWl8gkDATuRgQ7KlsnoMQ+j2jl701MTEEGYjvtoRUezQoLIqIhcMdHC
         yqg4HA+ONPGIbexRwH4aC9tuA7ZJ2Nc5fF/Q8rBTwLE6KNmAD3oeCWoHrC6+1lPVCUlM
         qNklg7g0b0m2l3j5PcVJzSaUfwVmxwc/5dkYkfEbh0JBV4T+ZtRzDE25o1gpfmFoJXi1
         b4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUioV1DdjIRqmSHZBnGe9SYdntMMx1lhgcXcp3pMD12iZhwQV41jpxFYcVuCqzeUSgX/eZO3rBoEO5rJ08=@vger.kernel.org, AJvYcCV1gwZ89R0EriX5HseFt9ZQF4mqeMneaD6gbjIhRb4l6wIjfv9JnVsTks7z3kU6xF0bvCyNCVDCPSTE504R@vger.kernel.org, AJvYcCVkv14P96gWEPWtgMSAjsp/fQPpE3Yu/MIq4YufocO1E+D1v4+Z4dyMQOstyhai3A3Q4Foj3OUT@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnixILHgKqixbQKmrrRgVCGIArRtyK/uyf/CXn0K8iQpDUVw9
	gPi0cjHYuej66XdWn7kACBvQZKtEVte/ZHqm1aN+X1ZAjiJRGang
X-Google-Smtp-Source: AGHT+IEZgwgOSSM01I0VRMqayl9Y4ZRbrb59ToFyPhvJ12lC31UCMBI70PuWzYn++d65mlqIOy25+g==
X-Received: by 2002:a05:6a00:2e25:b0:717:8d52:643 with SMTP id d2e1a72fcca58-7178d52087cmr1633850b3a.11.1725521826523;
        Thu, 05 Sep 2024 00:37:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785989d7sm2659588b3a.161.2024.09.05.00.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:37:06 -0700 (PDT)
Date: Thu, 5 Sep 2024 07:36:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Fix rescind handling in
 uio_hv_generic
Message-ID: <Ztlfkl0eJT6r7h30@liuwe-devbox-debian-v2>
References: <20240829071312.1595-1-namjain@linux.microsoft.com>
 <20240829071312.1595-3-namjain@linux.microsoft.com>
 <20240829134016.GA29554@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZtleAkNfOIwmY8iN@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtleAkNfOIwmY8iN@liuwe-devbox-debian-v2>

On Thu, Sep 05, 2024 at 07:30:10AM +0000, Wei Liu wrote:
> On Thu, Aug 29, 2024 at 06:40:16AM -0700, Saurabh Singh Sengar wrote:
> > On Thu, Aug 29, 2024 at 12:43:12PM +0530, Naman Jain wrote:
> > > Rescind offer handling relies on rescind callbacks for some of the
> > > resources cleanup, if they are registered. It does not unregister
> > > vmbus device for the primary channel closure, when callback is
> > > registered. Without it, next onoffer does not come, rescind flag
> > > remains set and device goes to unusable state.
> > > 
> > > Add logic to unregister vmbus for the primary channel in rescind callback
> > > to ensure channel removal and relid release, and to ensure that next
> > > onoffer can be received and handled properly.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > ---
> > >  drivers/hv/vmbus_drv.c       | 1 +
> > >  drivers/uio/uio_hv_generic.c | 8 ++++++++
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > > index 7242c4920427..c405295b930a 100644
> > > --- a/drivers/hv/vmbus_drv.c
> > > +++ b/drivers/hv/vmbus_drv.c
> > > @@ -1980,6 +1980,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> > >  	 */
> > >  	device_unregister(&device_obj->device);
> > >  }
> > > +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
> > >  
> > >  #ifdef CONFIG_ACPI
> > >  /*
> > > diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > > index e3e66a3e85a8..870409599411 100644
> > > --- a/drivers/uio/uio_hv_generic.c
> > > +++ b/drivers/uio/uio_hv_generic.c
> > > @@ -121,6 +121,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
> > >  
> > >  	/* Wake up reader */
> > >  	uio_event_notify(&pdata->info);
> > > +
> > > +	/*
> > > +	 * With rescind callback registered, rescind path will not unregister the device
> > > +	 * from vmbus when the primary channel is rescinded.
> > > +	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
> > > +	 * Unregister the device from vmbus here.
> > > +	 */
> > > +	vmbus_device_unregister(channel->device_obj);
> > >  }
> > >  
> > >  /* Sysfs API to allow mmap of the ring buffers
> > > -- 
> > > 2.34.1
> > >
> > 
> > For the series,
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 
> 
> Applied to hyperv-fixes, thanks.

Since Greg has already applied this series, I am dropping them from my
tree.

> 
> > 

