Return-Path: <linux-hyperv+bounces-2682-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C7F946669
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2024 02:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AF83280F9B
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2024 00:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC193;
	Sat,  3 Aug 2024 00:13:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E9182;
	Sat,  3 Aug 2024 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644004; cv=none; b=Rgak3YmjPxniEaLscMX28dvmiPA3KT2R0YW2CkdrKxilqDI52lq8LmNQi7oUaUH2d4ErCxmVD/D2C+TyOYMgVSNVvV5Sdwhg+OFSYfHz3mbrZKDgi6OmJAAooZ4NHyuSCOHshKYS6p3t0UqRuXzr5t0W2oxGUDyKw4Lgx9rkRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644004; c=relaxed/simple;
	bh=ZKZBS/MH7im0JwkEk0PsV+A2uYf8zojcYPPsjYAnhAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW2NEAtFPVeLq4iIqqtM3IaNZC/H1FzkAH0Efw+ZaWkGuGjw5soPQjZMvSOXtSK+DltVfH4yD8Y1TqDxIlpgsNMFf9HJ+W1keOeDHl0XMnf7jApcShBKYU7K3wrjStWuMplCtInkvdVdWbNYq1K2eWQi1k6bNyG4xpkwvMlO1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3dc16d00ba6so564762b6e.0;
        Fri, 02 Aug 2024 17:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722644002; x=1723248802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccJOGn30bUAN8TsbHnPAhjA3sjnjxhCGVa7sB/q0q18=;
        b=iEzvLhqckDH3XfXduYihNVvqwoR+cWigHfZlzLDUG1iWsHs3AgUr6NSLU2+lLS06iC
         rXwjUy5iaVWG+NtBP88uO3BGrFWxAXTpmPm02XfK+nO+rgrG21N6q+vDvn3a6hK0vhAM
         85gwHrPIfQLjljp4TCyF8tVEP4xgQhlf3uzIcLhhSw3AYyw4gs6w7M/aOQxTr870vpC5
         kpA1VpCvLZBcfVDHhRoIw2E1IIFs3QcJZc/l84qxU0tlM3jncIsaTjsuGJubb/mZXuiF
         uXHeHAFghpqz2lVIq2dmrVBrDbcysJNcpWfnLuZC1yF8ruPnnJnuSbvwPvgDc/sG7BgY
         ORHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy2aPRWZeJLCOmoag0esat+KdKiEtBgKS426LKGyPtKAPuUPlKRlQIFlD8dFp0m8SQ65TSwpUJfpYqGdcsu1zsbU6khyPC7cVrbHxkOjIc0moR2IeNOiGO1/PKru/3NqfhEUTyR4HULOO+
X-Gm-Message-State: AOJu0YwysYeJPtjHU0FYSnNYoQl69YUEhunv5v7zL/VbD9Hdszd4ZHt9
	EkH6WX3HAG2BJQx9eTEpiiYrq8Bktq7v2Pw/2srJMFgOhFwek2Vf
X-Google-Smtp-Source: AGHT+IE1UQJI5eUtHMF2/Uke5fcUQiEaNcSw/b2w90jpRVoUFSKMFk1ufL0TsbHnePiXIsxtcfxOrQ==
X-Received: by 2002:a05:6808:1449:b0:3d9:245c:4224 with SMTP id 5614622812f47-3db5582e282mr5345750b6e.40.1722644002134;
        Fri, 02 Aug 2024 17:13:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346af44sm1874085a12.30.2024.08.02.17.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:13:21 -0700 (PDT)
Date: Sat, 3 Aug 2024 00:13:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Roman Kisel <romank@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"apais@microsoft.com" <apais@microsoft.com>,
	"benhill@microsoft.com" <benhill@microsoft.com>,
	"ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>,
	"vdso@hexbites.dev" <vdso@hexbites.dev>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix the misplaced function
 description
Message-ID: <Zq12ILqoxEzjLOq2@liuwe-devbox-debian-v2>
References: <20240801212235.352220-1-romank@linux.microsoft.com>
 <SN6PR02MB41578B75E804B59A2B8A8E24D4B32@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41578B75E804B59A2B8A8E24D4B32@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Aug 02, 2024 at 03:51:37PM +0000, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Thursday, August 1, 2024 2:23 PM
> > 
> > When hv_synic_disable_regs was introduced, it received the description
> > of hv_synic_cleanup. Fix that.
> > 
> > Fixes: dba61cda3046 ("Drivers: hv: vmbus: Break out synic enable and disable
> > operations")
> > 
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> >  drivers/hv/hv.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index e0d676c74f14..36d9ba097ff5 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -342,9 +342,6 @@ int hv_synic_init(unsigned int cpu)
> >  	return 0;
> >  }
> > 
> > -/*
> > - * hv_synic_cleanup - Cleanup routine for hv_synic_init().
> > - */
> >  void hv_synic_disable_regs(unsigned int cpu)
> >  {
> >  	struct hv_per_cpu_context *hv_cpu =
> > @@ -436,6 +433,9 @@ static bool hv_synic_event_pending(void)
> >  	return pending;
> >  }
> > 
> > +/*
> > + * hv_synic_cleanup - Cleanup routine for hv_synic_init().
> > + */
> >  int hv_synic_cleanup(unsigned int cpu)
> >  {
> >  	struct vmbus_channel *channel, *sc;
> > 
> > base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
> > --
> > 2.34.1
> > 
> 
> Reviewed-by: Michael Kelley <mhkelley@outlook.com>
> 

Applied to hyperv-fixes. Thanks.

