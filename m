Return-Path: <linux-hyperv+bounces-1661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAD38711AA
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 01:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E321F212B7
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Mar 2024 00:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6B363A5;
	Tue,  5 Mar 2024 00:26:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6467610B;
	Tue,  5 Mar 2024 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598418; cv=none; b=empGyCVo+FkeOzubyl0Jca1/jbhx2zbWc7PzcxRPf17QDDUKiFruMz3o43xpzJZHCnmxkoxKtggGlaGg4rkjJ7NIGzUJQ8UeB29oBEbybSSxVCtNXh8jN1NX5znoqh1KyfSAUBPU8uyA1NCUcCaR2G1NCzRr/pSR4RFCfnlPqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598418; c=relaxed/simple;
	bh=I/fv5QjfcioRRSvSneTM+YmY+iE+AQw5ADJfDWecOEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJkipVZbtBeM5LaS7skFXVYgQ7HRgF7oPWm1Ldlfqf5okrGwsiPR4gOJhLkIqo5GTVOW1H+FIgjHEKZQFEsn7t0xHd6Cgd3EJhJup4f0KKr+PGcaYjTjw67il8vKAcDx77h22oey+d5A+6Hnm8LxC+QmtIBsOjlC65lJOkciJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc9222b337so50674315ad.2;
        Mon, 04 Mar 2024 16:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598416; x=1710203216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vaTAt59v6hDHMmG33vSBdoXtjWvwKkVZnRYvNr3jeI=;
        b=O5b2dW7O34e8v8/0lfD6zSviNVlNiFRoUY787x5WhE5HKD5iL4Q4cyPB9OuHDqR3jk
         iftD5WwUL7vvOLSSc1n4wd3flO6jGYRNeIX4PIu4oDPTv0KGJDblRBmVZJBMq3Llz1gc
         l9iKudufJmdf4P2l1z1/+FLm98r5MlSbqgHiYEQOSdoHag+2FChxVvmS7WKWBeKFHbWv
         QvpzIwx/ngGrkbpaXd15wwvaDFyLXVICOiV8RKM6NN3ur5BBVeB8GOzuWIhgdc021m0C
         kgcwdviH4oyOera9xrPC2SB4WKteXKV9ZvUJ9Ex406hgdwGden8R2UVbUIsOomcam0rI
         GGQg==
X-Forwarded-Encrypted: i=1; AJvYcCVOnXeH+xoY9beof323mBTPFyHM05wGiwrUB0dr0xz7Rjr2dWYpQxopZlr7W6A+HnJXH8b830FLd8VtBjchdOUCw+JlM592ISkqC2E+sFfs5/8opX3fO8FRi45rLHwsne6VlvTnLR2VyW1k
X-Gm-Message-State: AOJu0YywuF+O/kOfPOrjxKUnsRl3hc7HuuRoOYvUF5eqTyqTXhv/iaZn
	izEZu6NHLffz8a9bCFYVgvM/MDn6gFQjW1HNGi0QoG3/ocOni80D
X-Google-Smtp-Source: AGHT+IH/HzcC8hXY5G/8U2V3qKMMaRE7IT9QPLDcKWvYWsE8385LzOpr7tcmDHfDgo/jbVNyIvIVzA==
X-Received: by 2002:a17:902:e744:b0:1dc:d722:4c08 with SMTP id p4-20020a170902e74400b001dcd7224c08mr533863plf.5.1709598415935;
        Mon, 04 Mar 2024 16:26:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001dca9a6fdf1sm9141431plj.183.2024.03.04.16.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 16:26:54 -0800 (PST)
Date: Tue, 5 Mar 2024 00:26:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, dwmw@amazon.co.uk, peterz@infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v3] x86/hyperv: Use per cpu initial stack for vtl context
Message-ID: <ZeZmysa1x4dogjQs@liuwe-devbox-debian-v2>
References: <1709452896-13342-1-git-send-email-ssengar@linux.microsoft.com>
 <ZeVpG07p9ayjk7yb@liuwe-devbox-debian-v2>
 <20240304070817.GA501@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304070817.GA501@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Sun, Mar 03, 2024 at 11:08:17PM -0800, Saurabh Singh Sengar wrote:
> On Mon, Mar 04, 2024 at 06:24:27AM +0000, Wei Liu wrote:
> > On Sun, Mar 03, 2024 at 12:01:36AM -0800, Saurabh Sengar wrote:
> > > Currently, the secondary CPUs in Hyper-V VTL context lack support for
> > > parallel startup. Therefore, relying on the single initial_stack fetched
> > > from the current task structure suffices for all vCPUs.
> > > 
> > > However, common initial_stack risks stack corruption when parallel startup
> > > is enabled. In order to facilitate parallel startup, use the initial_stack
> > > from the per CPU idle thread instead of the current task.
> > > 
> > > Fixes: 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
> > 
> > I don't think this patch is buggy. Instead, it exposes an assumption in
> > the VTL code. So this either should be dropped or point to the patch
> > which introduces the assumption.
> > 
> > Let me know what you would prefer.
> 
> The VTL code will crash if this fix is not present post above mentioned patch:
> 18415f33e2ac ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE").
> So I would prefer a fixes which added the assumption in VTL:
> 
> Fixes: 3be1bc2fe9d2 ("x86/hyperv: VTL support for Hyper-V")
> 
> Please let me know if you need V4 for it.

No need to repost. I can change the commit message.

Thanks,
Wei.

