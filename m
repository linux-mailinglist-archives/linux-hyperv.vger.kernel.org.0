Return-Path: <linux-hyperv+bounces-7906-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDD1C9858C
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 17:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE2B3A13DE
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 16:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21F30F92B;
	Mon,  1 Dec 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IrwZ8jtn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE997202F9C;
	Mon,  1 Dec 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607579; cv=none; b=GJ0by780/O1ZJn7m2eDAB6dq+aILP9t1GkGxLuznHrBlFRm6koryVSYndkOJNaQ8XdlelWaCmuJwI9ykL0eZrKjyelku+vduoGfq6fFB+FEaqXKUgoRctvfxxL+Et5ji6RvZshfGjldGzbhbkWFCxhNv/NOJ8qUILr6m4Lp45nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607579; c=relaxed/simple;
	bh=j+bwTcmz8TTn5+UPwe8RMaMw8yQJCZ5kf6WCkf/cmec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMZOmrSjQ72JPKJIuTPFsuKO2jOEdvMESVg3nU0CWcDQJcpKXn89H8zqcMwhgdfFGDCFDoR9aze7xC/HZVpU0b78Gf1BL+BDi3ZwKtNm/8EnJJLufz3yaspqFGZ3brM5D91jM965W1AB1sCGN1nHly0SniCPSVM0QDqEN/ne+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IrwZ8jtn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-166.hsd1.wa.comcast.net [98.225.44.166])
	by linux.microsoft.com (Postfix) with ESMTPSA id D0F532013378;
	Mon,  1 Dec 2025 08:46:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D0F532013378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764607577;
	bh=ZALpCX6tDx57hAge8ebdVjzbNUCB3fqVF6dcSARCOvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrwZ8jtn80SPGbQ8Heh44rawP4TTtXQxrBLvokF+EX40EcdQhmYAZmcNrwdHhZMjb
	 D6rK7CclV5kOsqRVQ5/sct+gRbEaToKeHau6EjvvJiZlnOQQ4Er2PMzgE8mn+IE1Lx
	 5sKRGgDo+1fk0Yg9jQ8UwXo23+OgY6xHujfwttYo=
Date: Mon, 1 Dec 2025 08:46:14 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/7] Drivers: hv: Move region management to
 mshv_regions.c
Message-ID: <aS3GVmV_c5lhyLAB@skinsburskii.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412294544.447063.14863746685758881018.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <aS12nwVq_jWGwpNI@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS12nwVq_jWGwpNI@anirudh-surface.localdomain>

On Mon, Dec 01, 2025 at 11:06:07AM +0000, Anirudh Rayabharam wrote:
> On Wed, Nov 26, 2025 at 02:09:05AM +0000, Stanislav Kinsburskii wrote:
> > Refactor memory region management functions from mshv_root_main.c into
> > mshv_regions.c for better modularity and code organization.
> > 
> > Adjust function calls and headers to use the new implementation. Improve
> > maintainability and separation of concerns in the mshv_root module.
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/Makefile         |    2 
> >  drivers/hv/mshv_regions.c   |  175 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/hv/mshv_root.h      |   10 ++
> >  drivers/hv/mshv_root_main.c |  176 +++----------------------------------------
> >  4 files changed, 198 insertions(+), 165 deletions(-)
> >  create mode 100644 drivers/hv/mshv_regions.c
> > 
> > diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> > index 58b8d07639f3..46d4f4f1b252 100644
> > --- a/drivers/hv/Makefile
> > +++ b/drivers/hv/Makefile
> > @@ -14,7 +14,7 @@ hv_vmbus-y := vmbus_drv.o \
> >  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
> >  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
> >  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
> > -	       mshv_root_hv_call.o mshv_portid_table.o
> > +	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> >  mshv_vtl-y := mshv_vtl_main.o
> >  
> >  # Code that must be built-in
> > diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> > new file mode 100644
> > index 000000000000..35b866670840
> > --- /dev/null
> > +++ b/drivers/hv/mshv_regions.c
> 
> How about mshv_mem_regions.c?
> 

I'd rather rename mshv_mem_region into mshv_region instead, as MMIO
regions aren't memory regions.

Thanks,
Stanislav

> Nevertheless:
> 
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 

