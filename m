Return-Path: <linux-hyperv+bounces-1563-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BA85954F
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 08:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AFF282076
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398E7492;
	Sun, 18 Feb 2024 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cUOauHq2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23DC2CA8;
	Sun, 18 Feb 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708242676; cv=none; b=JD/jdvJlkqNRlWlGzZDVMBb1gI0C6Vqa+12q57kMPGQyx/4u/EdfqP4kNmdLj+T4nzcY7hTdvPx61lMVj9E//I1d/Rwf10fesBEuEA0M90Tx5FxrNQE1mIigsJBCcZWOxsLDNuFQ3paBEFbyaw9iK9kXpe4/IUgqYNyHcbfv5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708242676; c=relaxed/simple;
	bh=+beRej0JiAH+KQ+1Zd5BJpT5yXcWRQSBj0KOOBD0VHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QReYNLCasU63pr3D3Z/4EaBdyeVW5VFFJprcnb6/gJqNjdiRQkjNG/EW8IFKR4YQukDlVgf0Hz+sVbUewP2ijBaceW44Qil4T3JfWa93tUFwZTxATqIg3v8vmt9xscKKzRCyil3pWSV9D9nMUzLfQGG1F1N91382zg3LChGd5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cUOauHq2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 72122207FD52; Sat, 17 Feb 2024 23:51:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72122207FD52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708242674;
	bh=JV/50whYYZ3nO5k5NOeOO8QTgzGo7YFHJsOq1PEVhvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUOauHq2+/JDCIK9DsguPgKMnLGaiDZ0r+LPSMx2A0qQQIZ29lEok8Czc+KwAkAyK
	 jsBu/LoSnmsEkkALY8yV7jcAthkwlCiYrsaSaMCpvw9nxv8msX5OlU+Q9AMNWxWJjH
	 Q3G2NAHhXdPBWUn2Av536OJ1SZEnp89teNmmO2uA=
Date: Sat, 17 Feb 2024 23:51:14 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 0/6] Low speed Hyper-V devices support
Message-ID: <20240218075114.GA24453@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
 <2024021812-shrouded-fanciness-06ec@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021812-shrouded-fanciness-06ec@gregkh>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Feb 18, 2024 at 08:10:36AM +0100, Greg KH wrote:
> On Sat, Feb 17, 2024 at 10:03:34AM -0800, Saurabh Sengar wrote:
> > Hyper-V is adding multiple low speed "speciality" synthetic devices.
> > Instead of writing a new kernel-level VMBus driver for each device,
> > make the devices accessible to user space through UIO-based
> > uio_hv_generic driver. Each device can then be supported by a user
> > space driver. This approach optimizes the development process and
> > provides flexibility to user space applications to control the key
> > interactions with the VMBus ring buffer.
> > 
> > The new synthetic devices are low speed devices that don't support
> > VMBus monitor bits, and so they must use vmbus_setevent() to notify
> > the host of ring buffer updates. These new devices also have smaller
> > ring buffer sizes which requires to add support for variable ring buffer
> > sizes.
> > 
> > Moreover, this patch series adds a new implementation of the fcopy
> > application that uses the new UIO driver. The older fcopy driver and
> > application will be phased out gradually. Development of other similar
> > userspace drivers is still underway.
> > 
> > 
> > Efforts have been made previously to implement this solution earlier.
> > Here are the discussions related to those attempts:
> > https://lore.kernel.org/lkml/1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com/
> > https://lore.kernel.org/lkml/1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com/
> > https://lore.kernel.org/lkml/1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com/
> 
> So is this a v4 of the patch series?  What has changed from those
> previous submissions?

In the most recent attempt we introduced a new driver uio_hv_vmbus_client
for slow devices, where as in this new approach we are making use of
existing uio_hv_generic driver.

We also introduced the function to query ring buffer sizes, this is an
attempt to address your comment on earlier series to avoid kernel params.
Comment ref: https://lore.kernel.org/lkml/Y0bipdisMbTNMYOq@kroah.com/

We later tried to have ring buffer sizes via sysfs for which we wrote a
new driver uio_hv_vmbus_client as explained above.

This is the next approach in an attempt to address all of the concerns
with all the previous series.

- Saurabh


> 
> thanks,
> 
> greg k-h

