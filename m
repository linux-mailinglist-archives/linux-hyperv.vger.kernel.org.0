Return-Path: <linux-hyperv+bounces-2830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E58A95D8BA
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B9DB20EED
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 21:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7741C825B;
	Fri, 23 Aug 2024 21:51:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF91A08A9;
	Fri, 23 Aug 2024 21:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724449916; cv=none; b=k3q0kaVnNVMeymL7Hy2XYDzL846Dc03XY40gJMwveE9pW3ROqN6ou3r9obiDC5vgMYT/FyIZtH+0diaO3cp2IcZYSybx6ZhRagTONsIctZI8eeQGqsh07RlsmbFe1FW6JusG9X3PIqo7C3T7ns89dRctDt+VS1wRnSLB9akAKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724449916; c=relaxed/simple;
	bh=s5oPW1oBmBq/8RYHCHsStuTjDtxc02x0k0pmuf7BEIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t90hJYYUD6qFyPM+8gRKKBqeczj1cLaZUIOKaH0scGXRV3HxYOZQx9DovPJiJaAF9UvIgLS+melognxeGE5y4DE/qyXNpb4KpxeXFkLFQSX/MJf73SOWCO4GO6GFSqpNDVdwGcMTVv/bwnWgstS5lqfSTERfVNmD3qsUq+43RZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2020ac89cabso23838535ad.1;
        Fri, 23 Aug 2024 14:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724449914; x=1725054714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t48CfquwWHoE3xe3InKKDn2gYoOie8sw4tO5E5NyLfk=;
        b=G9Z5lKtUlbRxgYQ2fJDLhG61KSIIsQW0u09TlOtevRiJRPLyFbSdB1HXeSdYpVo0UD
         2YW5wtbuu7U6ULhbqgB9iTtM0YxTgwXUaPKZKs7F7YEdEiMOscxwilQTiqOSYBt06LHB
         SMAcwtZhuf1qDyRPKt/m386aul/CsAKlT1ZlK3Vli29sSAdy3i7s3+dC0ndv4yF2ge8J
         r4UHPLr04We8aOejAWUVZWLEhOd6nDAvQVHHuM/dGJCg/KcL5LvEf4+++VJRChXRQqup
         WtjqHg+yzoG22Dpd7eamkZWpyHPd99mkAXNjimGYX3h2lTk2WGQ7xG3dYP8IDzZsb20R
         2bdg==
X-Forwarded-Encrypted: i=1; AJvYcCUaMngvEMSXtZQy0Vl7WbxkWZaaS3L+g5VmxkXdPW7PR6GH4I2TZnqiEFLOATW7/m1InJSjC2tNtuMLCZo=@vger.kernel.org, AJvYcCWftnNpLbGjm2Re0B7lhzldmH/3AyQUR2EvgKXPHiX/WZUWvnj7kvGMf/s91iQ98WwDHi+YwZYt+0l7gvxO@vger.kernel.org
X-Gm-Message-State: AOJu0YxqhV38fdGBU/MbAMrTTAVAT4peo+kSRuqDg7eCjah2urWtAfEF
	Sv46cQbzwqjvtaLXYmskPgXMc0+OaIji0nPPDNMyL2/rKIlYGyBM
X-Google-Smtp-Source: AGHT+IF0Wi35Mm0OqbrfmaSoGOq4sUeiomEljmZv+JqzeRQScxXbHI0OS3QuIPAB6+kI22yWnChHlQ==
X-Received: by 2002:a17:902:f546:b0:202:17eb:2e8b with SMTP id d9443c01a7336-2039e4aa80fmr29689925ad.28.1724449913564;
        Fri, 23 Aug 2024 14:51:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df602sm32860805ad.149.2024.08.23.14.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 14:51:52 -0700 (PDT)
Date: Fri, 23 Aug 2024 21:51:44 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>, Roman Kisel <romank@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when
 Hyper-V provides frequency
Message-ID: <ZskEcN2e6-aY4kQV@liuwe-devbox-debian-v2>
References: <20240606025559.1631-1-mhklinux@outlook.com>
 <226804eb-af9d-4a56-aef5-e3045e83b551@linux.microsoft.com>
 <Zq1wkyTkWCrdYx2-@liuwe-devbox-debian-v2>
 <SN6PR02MB4157E061956EF4D394E587D8D4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157E061956EF4D394E587D8D4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Aug 06, 2024 at 02:01:55AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, August 2, 2024 4:50 PM
> > 
> > On Tue, Jun 11, 2024 at 07:51:48AM -0700, Roman Kisel wrote:
> > >
> > >
> > > On 6/5/2024 7:55 PM, mhkelley58@gmail.com wrote:
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > >
> > > > A Linux guest on Hyper-V gets the TSC frequency from a synthetic MSR, if
> > > > available. In this case, set X86_FEATURE_TSC_KNOWN_FREQ so that Linux
> > > > doesn't unnecessarily do refined TSC calibration when setting up the TSC
> > > > clocksource.
> > > >
> > > > With this change, a message such as this is no longer output during boot
> > > > when the TSC is used as the clocksource:
> > > >
> > > > [    1.115141] tsc: Refined TSC clocksource calibration: 2918.408 MHz
> > > >
> > > > Furthermore, the guest and host will have exactly the same view of the
> > > > TSC frequency, which is important for features such as the TSC deadline
> > > > timer that are emulated by the Hyper-V host.
> > > >
> > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > ---
> > > >   arch/x86/kernel/cpu/mshyperv.c | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > > > index e0fd57a8ba84..c3e38eaf6d2f 100644
> > > > --- a/arch/x86/kernel/cpu/mshyperv.c
> > > > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > > > @@ -424,6 +424,7 @@ static void __init ms_hyperv_init_platform(void)
> > > >   	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
> > > >   		x86_platform.calibrate_tsc = hv_get_tsc_khz;
> > > >   		x86_platform.calibrate_cpu = hv_get_tsc_khz;
> > > > +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > > >   	}
> > > >   	if (ms_hyperv.priv_high & HV_ISOLATION) {
> > >
> > > LGTM
> > >
> > > Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> > 
> > Applied to hyperv-fixes. Thanks!
> 
> Wei --
> 
> hyperv-fixes isn't showing this patch, or any of the others that your
> emails said you applied last Friday.  Hence the patches aren't in
> linux-next either.  Did something go awry?

The push was not successful. They should show up now.

Sorry for the delay.

Thanks,
Wei.

> 
> Michael

