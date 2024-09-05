Return-Path: <linux-hyperv+bounces-2975-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD22196D049
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 09:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6EF1C22461
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF5192B91;
	Thu,  5 Sep 2024 07:22:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9321925BD;
	Thu,  5 Sep 2024 07:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520956; cv=none; b=uRGhmU4xwp6j/hR5k0WyCUKT02c3LRC8xJneZ3rG2UbcFDydsp0z94BqQMrZPcTO+cTYaKHMTF+4bvum4fr4lN5UbyhqN6O4Sl7kfEiSXuNhzdqd52VwnZvewEZgDAK1/Nr0qeOWxBfJLTw1D3KU3HinolMojcufm32FEnVhweM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520956; c=relaxed/simple;
	bh=nX6VM034dnkqkSSKLtabpgk4XUhS/uQXknAPvXSnVWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R43UHhItmZ6qmM764O4pxcn6ugvv7YYW1GrGDfcupx1GgVJM8mGOnQ8fHwK0muYVkKsCz0RAbGWIcmYdv3Y1qiA3VQ+3MJj4aZcuKHtn3B847Ar5+yJ1v8GcwBNfu6jrRn4QNKWArAeyUcwfkJnYWCD9n4S2V5+XjczfErwuzY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e0059dc06bso278050b6e.0;
        Thu, 05 Sep 2024 00:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520953; x=1726125753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A7tr+pBf2S7LxN9jZZTeyqRP+eePnFiaOGZty0NhrM=;
        b=X1mL9V1QTyy1yEiyOpQ0b1U0QmSmFV65jDk0lQC0wfLZcmLwj30/p4v/XwI862FqB1
         LAWvNG5G5+HPQPesZEo2qVix1UEJPhcWOvGfSdwpqjRt9mu/uA40Fspm0AAc+VZyKBab
         kJDJQPFN2smxJB6Ov0NpOaR5A6rpcZw05fTgVevnKU7UNnw+VhlRawa4R5kPIW1Oz/t7
         /H3YWzjSY+dxcxdvSIr63Z7DWOWhwMqz95sYcmuhaGv7LNHILQQtvw7/barXjnVrW9sV
         UnMvc96FsexZqaHKkyl3/2uartzneOb1PA1A1xip05K4qGy6ciKYSowI9BNi2EYE6+r6
         cong==
X-Forwarded-Encrypted: i=1; AJvYcCW0tfJK/NXeqtOIBi1JmEJ1G2acQiKTjkETOmwpG3Ex8lsRWQrlv5lmlL+6rcVWajGBtVEIcyfP@vger.kernel.org, AJvYcCWc4WmBGXPpqisqMeEBx+X1PXFvPWxu/MGuf4rAyLsApk/OBchrVwx7c4+1tTIB2GvwSHpB48ueyxApX0NC@vger.kernel.org, AJvYcCWdkF5lf3MkqNld7VyVsN/RKRUNxpwueLpgnE7YplV4KpoChBLQ4IOGb4H6WJMmxBwl7nwU8DD/WkzIwZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aMJyzP1VVQN1IkEPMAL2RLwOECXTcSYz9yftgr5ag7j2h8jS
	aXeFO2ITDZCl/z52ihq3iNaTpLCkw+mYfUqvaoMNClntx6orP9pG
X-Google-Smtp-Source: AGHT+IG15Yfr2iL02UahevJrc9mJRlhHeM3s5q5CNqQyRBUexfIQ/UyNF+VIpSEgE2qypJF8KPMz8Q==
X-Received: by 2002:a05:6808:1442:b0:3d6:2ff3:937 with SMTP id 5614622812f47-3df22d07304mr19507253b6e.40.1725520953195;
        Thu, 05 Sep 2024 00:22:33 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8cc90sm2743281a12.30.2024.09.05.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:22:32 -0700 (PDT)
Date: Thu, 5 Sep 2024 07:22:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Michael Kelley <mikelley@microsoft.com>, stable@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: fix kexec crash due to VP assist page
 corruption
Message-ID: <ZtlcKVmPYg7kOp8Z@liuwe-devbox-debian-v2>
References: <20240828112158.3538342-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828112158.3538342-1-anirudh@anirudhrb.com>

On Wed, Aug 28, 2024 at 04:51:56PM +0530, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> commit 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when
> CPUs go online/offline") introduces a new cpuhp state for hyperv
> initialization.
> 
> cpuhp_setup_state() returns the state number if state is
> CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN and 0 for all other states.
> For the hyperv case, since a new cpuhp state was introduced it would
> return 0. However, in hv_machine_shutdown(), the cpuhp_remove_state() call
> is conditioned upon "hyperv_init_cpuhp > 0". This will never be true and
> so hv_cpu_die() won't be called on all CPUs. This means the VP assist page
> won't be reset. When the kexec kernel tries to setup the VP assist page
> again, the hypervisor corrupts the memory region of the old VP assist page
> causing a panic in case the kexec kernel is using that memory elsewhere.
> This was originally fixed in commit dfe94d4086e4 ("x86/hyperv: Fix kexec
> panic/hang issues").
> 
> Get rid of hyperv_init_cpuhp entirely since we are no longer using a
> dynamic cpuhp state and use CPUHP_AP_HYPERV_ONLINE directly with
> cpuhp_remove_state().
> 
> Cc: stable@vger.kernel.org
> Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Applied to hyperv-fixes, thanks!

