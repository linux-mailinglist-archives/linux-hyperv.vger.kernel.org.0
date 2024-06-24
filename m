Return-Path: <linux-hyperv+bounces-2482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D4D91432C
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 09:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7610C1C20CD9
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Jun 2024 07:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78271381A4;
	Mon, 24 Jun 2024 07:07:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2EF376;
	Mon, 24 Jun 2024 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212820; cv=none; b=Wpg2a0+yFJMikz+t5EJblQ/0OtEvwresobI1mpy50HIS9BgGhynJzYMCh4t0jleaTnq/OSZIMa7RFJPZ8KARlYp2BHSy9dMBQBv7rfBjCiac2hwOaHu5yqvl1rWHZO64hd4PdRGHVHpW9fF3HdRYaR8q+/fKi4iuWvmdzu+S9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212820; c=relaxed/simple;
	bh=zm04avjiqQZBn5KYoGNw+kGHuCoJrS4M9EjVbFU044Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScsW9Tm8SYAuMgpP8Pvo4+fU/G+722oG2RKL3Wxo+LIhTSYbcYKowCvECcv558JXelcSjZBp4Q/MyIQ1Gn/bBc2p+v7bhpE1WLD1JHUjvB36rQVWZQxoxJOg6NFEhP6zhggNDxcdzt36TMSBYYH/IhLaCd6l8Hs27PA7o2Aua6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9b4d69f53so2229152a34.0;
        Mon, 24 Jun 2024 00:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719212818; x=1719817618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr4VGylpKfe5jMi8mL9RhC6vYgLNd3Lq3GNPGy76NUA=;
        b=VskuYmLRIFp24qvPSbBE9jMM2ThFZSDA40rMutUFuBXdLhyblS72tFSmgNJV7VR5Qz
         vgMLQhojtp5/3mRcNDCv8Wwn6ixsq0i/GV8LDXpqES/0PMld86nLEn9UTFU15oVMvUMr
         /ZIqcz0Uj6k9w1fgEbhhPsHKXdfAFdP8QDVn1t5iuvF3gNHFFKWvoJKR33x/+awOzi41
         y39M5wg1w0LLVpPxKsQtrrkSVkY0Ebj+l00MOGjzcQJ5IUNZ4B//1Xwjnd+lVEYejzmC
         dIZ9ZbEEktew7V/PexX2+o3vRoKK9dpFFGE2eG334hzjVVgL1d6/mE04qdUj0s8A8rlV
         dZpg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Em0s2pqNmroWpJsJM97M3tDfR4yoRM04uQyvqYA987qDSK+E/umPpnSzK19VQuZR1c6Cu9kmb/JRaBqj2bjwIsEEWsGhXnIWPkev38JF7zr1NxYx4XjeANKw5/MhWszBP3x2rAAzgFDpbK3pQCe3FeDT0Xj7vCfknYEAscMX/zUP
X-Gm-Message-State: AOJu0Yxqte62CYApTmcrYw+50bn1/PYq96lOJl2OYpTwUfd5vMT6SasU
	rJwHzxnhgNJ3iX3POnduAHeFwsbMamSMGnQAqZSOYPAs9TfqSXsq
X-Google-Smtp-Source: AGHT+IFVgbLtqk9su7HvLOSkwZwXr3Asb6+QVGzFFmt6I+NRQOYit5CDFSpqlwRE6ZczWCj8iWBtig==
X-Received: by 2002:a05:6359:5a8d:b0:19f:1e0c:e1a5 with SMTP id e5c5f4694b2df-1a23c1b1f97mr554831255d.20.1719212817982;
        Mon, 24 Jun 2024 00:06:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba5b5f7asm4774472a12.64.2024.06.24.00.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 00:06:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:06:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: mhklinux@outlook.com, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org, Roman Kisel <romank@linux.microsoft.com>
Subject: Re: [PATCH v2] clocksource: hyper-v: Use lapic timer in a TDX VM
 without paravisor
Message-ID: <ZnkbCoLqm7wbZGch@liuwe-devbox-debian-v2>
References: <20240621061614.8339-1-decui@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621061614.8339-1-decui@microsoft.com>

On Thu, Jun 20, 2024 at 11:16:14PM -0700, Dexuan Cui wrote:
> In a TDX VM without paravisor, currently the default timer is the Hyper-V
> timer, which depends on the slow VM Reference Counter MSR: the Hyper-V TSC
> page is not enabled in such a VM because the VM uses Invariant TSC as a
> better clocksource and it's challenging to mark the Hyper-V TSC page shared
> in very early boot.
> 
> Lower the rating of the Hyper-V timer so the local APIC timer becomes the
> the default timer in such a VM, and print a warning in case Invariant TSC
> is unavailable in such a VM. This change should cause no perceivable
> performance difference.
> 
> Cc: stable@vger.kernel.org # 6.6+
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-fixes. Thanks.

