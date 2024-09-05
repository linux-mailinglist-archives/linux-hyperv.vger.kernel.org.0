Return-Path: <linux-hyperv+bounces-2978-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C712F96D062
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C439286AD9
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344DB191F75;
	Thu,  5 Sep 2024 07:30:28 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44392E62B;
	Thu,  5 Sep 2024 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521428; cv=none; b=Z40s3Kp768lkApUXYBQBWurpNMZBUzhbGi8J0nUECzmze8yYfLn1D1EImEgwlt5aAcKBrzB+5SgANJf3flx82mrHOo4VPgjfFROwBIRRR/OaMdClwHH9SnmKewPoj0wajHGuea1SIjKxtlBN+CyTvJA5VF0SNgSMgIuyb5zdP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521428; c=relaxed/simple;
	bh=3rmpJjWUC0XeHH8B43pIpgS9cYoD8EzuQbs7K98v9V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esvxt0FtrIGO8OCRalUd+hK24mL9QMR3+HoskfMyhQYAIBZ+Am0UwjS4xqwrDhVqhtPVtpmDt+CvYT7wxWwadrFHxUf4e5/cpvGfRdh48gWDHxf0alm/c57LJfB+MpSi1qiUIxS7B/zig+j6VlgbJM4EtPS9uP4htLPPVORlqLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-714302e7285so383436b3a.2;
        Thu, 05 Sep 2024 00:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521426; x=1726126226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICWFQgoawKg6CqMavRC6NBu5HUkpzYtH/+Vzl2PyfB0=;
        b=tqdudjihq/bdcye4ylbodPxtOmQn+juT3Y9ghjeSwtTD4ueXdSQxzud37utR4bCvLS
         sQdt+DEpRf8Z7ri0bK2Mv+9tdsh8VG0K7vaF1eC545TNPs//4brbXfjByWk31cxdWJeQ
         4OGc1dkeiot0x+mifV2iGn6Z9q0Dc5Pa+47chW67C6tmt5wNeO2qJzueeMfsHTqxr7QZ
         J67ev6kSFzr2jih4vwY6nBH1i+fGSQI4fBVfGSYu5fbQPIenyfJqIB7ITNfYBYxOHzE4
         stW4+oFpJVPgLfJ7qOjtD8XLjZBi3FROxKVDhVTCJ6Lf7To1IoFF7oPXgS6XMSGd5Reu
         jjtA==
X-Forwarded-Encrypted: i=1; AJvYcCUCaratzRxOEeAtMubCIYUmuHmxcKbUYQd74FPjvU7kJOFGik3C54NYC/AhxvubeleX3xPb9EU7E2IFkf/e@vger.kernel.org, AJvYcCVKguUgMwaNMdy0qku+nKhY0qiXaH0rgYz4mCgqUhHO47mqEA46622QCETOFIuLnaHsxB0C6G+C@vger.kernel.org, AJvYcCXajcDoMsAyPE/YAfWnBDBuJRBjDqfUMM0NqN1IQLftBhI0/F+wk8c0b08QY8sCzpX1W3IylBeQJ4h2ByM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTFv9p1ChKD+fddrkW77WJY8Svjib8ZO6nVTgmznVKaKrpdpox
	gCfIoM+AcKGi75jTh4fXou6Ek/1CyT9cnkgNKixNlTvjsC+padik
X-Google-Smtp-Source: AGHT+IEZYs3qBJudMr+iCysyP7/1XThoV5qkkR4Aa6WUPKssVArxeTynn3ulTpIdbJO0HySpSP6f1w==
X-Received: by 2002:a05:6a00:1304:b0:70d:2b95:d9cd with SMTP id d2e1a72fcca58-715dfc502edmr26719239b3a.16.1725521425752;
        Thu, 05 Sep 2024 00:30:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd91d7dsm2724718a12.41.2024.09.05.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:30:25 -0700 (PDT)
Date: Thu, 5 Sep 2024 07:30:10 +0000
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
Message-ID: <ZtleAkNfOIwmY8iN@liuwe-devbox-debian-v2>
References: <20240829071312.1595-1-namjain@linux.microsoft.com>
 <20240829071312.1595-3-namjain@linux.microsoft.com>
 <20240829134016.GA29554@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829134016.GA29554@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, Aug 29, 2024 at 06:40:16AM -0700, Saurabh Singh Sengar wrote:
> On Thu, Aug 29, 2024 at 12:43:12PM +0530, Naman Jain wrote:
> > Rescind offer handling relies on rescind callbacks for some of the
> > resources cleanup, if they are registered. It does not unregister
> > vmbus device for the primary channel closure, when callback is
> > registered. Without it, next onoffer does not come, rescind flag
> > remains set and device goes to unusable state.
> > 
> > Add logic to unregister vmbus for the primary channel in rescind callback
> > to ensure channel removal and relid release, and to ensure that next
> > onoffer can be received and handled properly.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c       | 1 +
> >  drivers/uio/uio_hv_generic.c | 8 ++++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 7242c4920427..c405295b930a 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1980,6 +1980,7 @@ void vmbus_device_unregister(struct hv_device *device_obj)
> >  	 */
> >  	device_unregister(&device_obj->device);
> >  }
> > +EXPORT_SYMBOL_GPL(vmbus_device_unregister);
> >  
> >  #ifdef CONFIG_ACPI
> >  /*
> > diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> > index e3e66a3e85a8..870409599411 100644
> > --- a/drivers/uio/uio_hv_generic.c
> > +++ b/drivers/uio/uio_hv_generic.c
> > @@ -121,6 +121,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
> >  
> >  	/* Wake up reader */
> >  	uio_event_notify(&pdata->info);
> > +
> > +	/*
> > +	 * With rescind callback registered, rescind path will not unregister the device
> > +	 * from vmbus when the primary channel is rescinded.
> > +	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
> > +	 * Unregister the device from vmbus here.
> > +	 */
> > +	vmbus_device_unregister(channel->device_obj);
> >  }
> >  
> >  /* Sysfs API to allow mmap of the ring buffers
> > -- 
> > 2.34.1
> >
> 
> For the series,
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com> 

Applied to hyperv-fixes, thanks.

> 

