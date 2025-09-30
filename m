Return-Path: <linux-hyperv+bounces-7033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34239BAEC58
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Oct 2025 01:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E39FB3C78BD
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 23:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935424C068;
	Tue, 30 Sep 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLWpZ2LS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F99D2E40E;
	Tue, 30 Sep 2025 23:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274936; cv=none; b=ZKEv57Bom8rvAPFkJ1P6SfyQJGNBAAygO7IVcOW8A563E4I3UyDWEERZdC8hzlqUQlsrsVLXfCa3JmAxDA5Z7hk3GNOHGThuW2w5rpx0vujaE1hd2A9tmdn6fg7X+aEU67lf8xMKJrAkmHSt0Rvb/2VI9qtuAiYRVAf+xhP2Nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274936; c=relaxed/simple;
	bh=zYOVhnM7v92JtWcSwj+YPO/nMTZXcJPR3E0KM4g8638=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfigYon6DEQnKNaEdvRr/EEAMJb70hVo4XUZ8SwSbTub5zfolstPpLpgGiWeE+LbIVp62mb5Ltv8jXXr6tul8J7EpLU50symiXcrk/A+Qt4P61qXlYeYkGbDlb/EKZxogPKrJPsMCzGkq8CxZpUDDRfzib8mhq3sUSrqxU7KSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLWpZ2LS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F3AC4CEF0;
	Tue, 30 Sep 2025 23:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274935;
	bh=zYOVhnM7v92JtWcSwj+YPO/nMTZXcJPR3E0KM4g8638=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLWpZ2LSgww9bezxm9fXzF7UT2PdKQrhM+Ok0QKcjaSbmiwJr1bUirJ83QKSaEqOH
	 4dGU5gWJxcyLAbynbW9rPWTh13FVIlJLOOEKYqe+SeCwqUmNEHDg/r8eK5Dh0gQ3yl
	 EeahXgOoIV+KDZoaRnMRHm/FiMMMutClbECZF7E3g48+cXJhAnnPYai3MQIwb/iRx0
	 c7WF1VtsmgIQWAFCRLqnsrckdsOXyzxMwyoNwSj2RroRg+E+fPO1hlkk/N/zYPC0kJ
	 DxUdfGf28zyyzJSf3gv0WabDSLVNlXVduKNgBefwFrf+SWAASbrQfzyOHtkcbrAXJa
	 mpOxLqGAB87UA==
Date: Tue, 30 Sep 2025 23:28:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: hv: vmbus: Clean up sscanf format specifier
 in target_cpu_store()
Message-ID: <aNxntvKl4QigqMzY@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250917085933.129306-1-alok.a.tiwari@oracle.com>
 <SN6PR02MB4157E58381C62CCC2681A20BD416A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157E58381C62CCC2681A20BD416A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Sep 18, 2025 at 03:51:00AM +0000, Michael Kelley wrote:
> From: Alok Tiwari <alok.a.tiwari@oracle.com> Sent: Wednesday, September 17, 2025 2:00 AM
> > 
> > The target_cpu_store() function parses the target CPU from the sysfs
> > buffer using sscanf(). The format string currently uses "%uu", which
> > is redundant. The compiler ignores the extra "u", so there is no
> > incorrect parsing at runtime.
> > 
> > Update the format string to use "%u" for clarity and consistency.
> > 
> > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > ---
> > v1 -> v2
> > Rephrase commit message and subject to clarify
> > that there is no incorrect parsing at runtime.
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index 5b4f8d009ca5..69591dc7bad2 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -1742,7 +1742,7 @@ static ssize_t target_cpu_store(struct vmbus_channel *channel,
> >  	u32 target_cpu;
> >  	ssize_t ret;
> > 
> > -	if (sscanf(buf, "%uu", &target_cpu) != 1)
> > +	if (sscanf(buf, "%u", &target_cpu) != 1)
> >  		return -EIO;
> > 
> >  	cpus_read_lock();
> > --
> > 2.50.1
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.

