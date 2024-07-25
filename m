Return-Path: <linux-hyperv+bounces-2585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 196B993C68B
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC302846C9
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2024 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78D19D06A;
	Thu, 25 Jul 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PZiGj4bk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8054E1D545;
	Thu, 25 Jul 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921720; cv=none; b=Ep+sdDAYq+jKrHUUR/Zy+npcMkhQ6CuGLgN4jr0/y58WrGSY1tmlwV8R0V3kHOhCre37dwe2VRtjWRDu0lV5ZyTxKBoOQWYOW4fzMHQTw6oEAkecHLIv/SAi4UixVMaRIbfV776t3FVYS9GNULkI0+zq7pOiK9JUUazZuQyDzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921720; c=relaxed/simple;
	bh=Av13jV9WXAR2oP+oHIDPBK5vyTkEu7d2MaZAlZ8XFuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/W9fx/nk8gFJLipJB6goikIayGaDNkbHkYNlBHhQb+w+4sg6mb7zQUtB1DOugU1IqqXa2ujL1Rq6L1fPh+K4nc38GqIBhZkJCHvQ0Tdg+unQx0IjkdSMXy3s49fnZHFr81Nn3T0pN7OXWITpAkS0JQlEGwfyfjPRY7C3oTE0tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PZiGj4bk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 35DC320B7165; Thu, 25 Jul 2024 08:35:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 35DC320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721921719;
	bh=s8siOKYtL6p+6N0ViUiM0Lj1P9rlJj2iJn8RkO8aNns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZiGj4bkPmMFqlVmwznYlEjKxjVSuteatPh/LGjnjZlRj1kBXzk90/G3euIlaRWWe
	 A7uE9eze6jA7agUd9hgZ0iak1M1pGvcE3UES6JYnScm4f/wSr2CAQb6pi6erNyO0c1
	 ic41spFGFNhytOhhU4sDE3glTJJutoVU8XmOZOCk=
Date: Thu, 25 Jul 2024 08:35:19 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	srivatsa@csail.mit.edu
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
Message-ID: <20240725153519.GA21016@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
 <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Jul 25, 2024 at 08:23:21AM -0700, Nuno Das Neves wrote:
> On 7/24/2024 10:26 PM, Saurabh Sengar wrote:
> > Currently on a very large system with 1780 CPUs, hv_acpi_init takes
> > around 3 seconds to complete for all the CPUs. This is because of
> > sequential synic initialization for each CPU.
> > 
> > Defer these tasks so that each CPU executes hv_acpi_init in parallel
> > to take full advantage of multiple CPUs.
> 
> I think you mean hv_synic_init() here, not hv_acpi_init()?

Thanks, will send v2 correcting this.

- Saurabh

> 
> > 
> > This solution saves around 2 seconds of boot time on a 1780 CPU system,
> > that around 66% improvement in the existing logic.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c | 33 ++++++++++++++++++++++++++++++---
> >  1 file changed, 30 insertions(+), 3 deletions(-)
> > 
> 
> LGTM otherwise.
> 
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

