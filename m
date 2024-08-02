Return-Path: <linux-hyperv+bounces-2680-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046CE94663D
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Aug 2024 01:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B5D1F22450
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 23:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5165713A402;
	Fri,  2 Aug 2024 23:49:44 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F5131BDF;
	Fri,  2 Aug 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642584; cv=none; b=NWJw3+/PzH8X+IuVGtDbfMGRWCCdKarNk1wjKN9Sn7YeKy+85tVPVRiNxi9Fw6cC2tBD0t+iDNoyZ47PZxjzIZE4n4dHA6fzyiCueoi+NK+idvWlgooKHC+4bYqbo1Y/bali8K4nL/Pb5rwfPdHvvL7w+TyFOaaG/Nn/vuR/pFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642584; c=relaxed/simple;
	bh=n8Y2VMeCRiA6ByTuqabmUKSjG/QoHJuvtYzMs/0+0HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rwnj34qRPJvKN6gPlJe7JzbH6Mt0AWZnW5XJAMLtGXUnRL0oJCiyQPtiq7Cwth47rbDGbizqrsKe3Hx6YFv9ArawTeGIlIzjMFqqEzZob1bWGhG4pxGEI5wItiY6QFqTmy8PLZ0GpSREBg/kesJE1QhnnK1fjluvxg8ViFYu3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7104f939aa7so3095299b3a.1;
        Fri, 02 Aug 2024 16:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722642582; x=1723247382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBt0rxqRNApZOCvMG2qCYs3y/OD2WKvEOzNF7v5wI34=;
        b=YUv/Y5R66E+ZiSANAK4WTvIgmskekLT7W76keQflx1St+wIIUNMV4V784QzY6J2/+C
         O4L4T5R5Mwqx+D2Xpbo75qbyb8vDA5cMdRnT8lejGAs1slVKYf0pVvv6tsRcsFNWmdYg
         bPjKjpNfENMvNMQ3szUxThrM7iLfylJ/U3bzQSHJTrAFFUiEwv2X8UgHr07yd5rBukWB
         xZ1uGenzgUgKayv9oGzx1KQJhZBswgwFJbw2vur/7AoghZvO3GFaGs3PZs0H04MyETU5
         gy7D0DXt9xVzCNTJCR0pKoAHvR4N3vF6yFSpiU7Fj08j9ILvH5PNhsxD79pk3SaEU0fH
         c5og==
X-Forwarded-Encrypted: i=1; AJvYcCU0lSw1Jw9HE3xEteN00hbBeQt+KQ6qy97nzClT4GEuxXRwzNM19I8lJmA5vQijJGDMhYwMJgUzYoBGNRMgPFEXJqfIDgDpuJI9Jnc8yJHtYXoe4Z6lAeXBsBLg/2uHR4JMXjM5krPaL9Zp
X-Gm-Message-State: AOJu0YxMpm/Ci1tFXcUO74UWXbwR8IR2bSDBTVNp0s/O1kdHj0Lli/k8
	82R2zOPbiXaV4L/yyLAMwXZLvBuFrxl2ACf0IKx8+ALhpoAj/iEG
X-Google-Smtp-Source: AGHT+IHSF+GoiOGbkdc8iANr9+zyXDDhhq6xVG+vBaGL8Vpck6Gl1fx6CvHQXNwLiB3W9DiHuPlBlw==
X-Received: by 2002:a05:6a00:9459:b0:705:b6d3:4f15 with SMTP id d2e1a72fcca58-7106d046699mr5700975b3a.25.1722642581992;
        Fri, 02 Aug 2024 16:49:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfccd3sm1894599b3a.144.2024.08.02.16.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 16:49:41 -0700 (PDT)
Date: Fri, 2 Aug 2024 23:49:39 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when
 Hyper-V provides frequency
Message-ID: <Zq1wkyTkWCrdYx2-@liuwe-devbox-debian-v2>
References: <20240606025559.1631-1-mhklinux@outlook.com>
 <226804eb-af9d-4a56-aef5-e3045e83b551@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226804eb-af9d-4a56-aef5-e3045e83b551@linux.microsoft.com>

On Tue, Jun 11, 2024 at 07:51:48AM -0700, Roman Kisel wrote:
> 
> 
> On 6/5/2024 7:55 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > A Linux guest on Hyper-V gets the TSC frequency from a synthetic MSR, if
> > available. In this case, set X86_FEATURE_TSC_KNOWN_FREQ so that Linux
> > doesn't unnecessarily do refined TSC calibration when setting up the TSC
> > clocksource.
> > 
> > With this change, a message such as this is no longer output during boot
> > when the TSC is used as the clocksource:
> > 
> > [    1.115141] tsc: Refined TSC clocksource calibration: 2918.408 MHz
> > 
> > Furthermore, the guest and host will have exactly the same view of the
> > TSC frequency, which is important for features such as the TSC deadline
> > timer that are emulated by the Hyper-V host.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >   arch/x86/kernel/cpu/mshyperv.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index e0fd57a8ba84..c3e38eaf6d2f 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -424,6 +424,7 @@ static void __init ms_hyperv_init_platform(void)
> >   	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
> >   		x86_platform.calibrate_tsc = hv_get_tsc_khz;
> >   		x86_platform.calibrate_cpu = hv_get_tsc_khz;
> > +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> >   	}
> >   	if (ms_hyperv.priv_high & HV_ISOLATION) {
> 
> LGTM
> 
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

Applied to hyperv-fixes. Thanks!

