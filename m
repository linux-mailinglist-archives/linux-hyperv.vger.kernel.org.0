Return-Path: <linux-hyperv+bounces-1613-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116786D217
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 19:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0BD286F84
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF967D081;
	Thu, 29 Feb 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGB8d3AQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8C7A138
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231064; cv=none; b=EnjcAqhtc9KQDKD48jLiHo5GLgL7NIchZpESHgrkRkh4xHDPWNjqHO3IAmM4uC+Ngr9GlOK7R2j5qGy11Off/bBZhQj1uvpuRwkzopvijzhHAtTql5PDVxjdMPoOH0tOI+uZlWik6wh4n0XScr8iEzAO8iSBhoBW6SNnVduSA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231064; c=relaxed/simple;
	bh=Y9KRbZhBlGJ/L8+onTzy/F5qfnhONJecU4/IHZrT6pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzfX1oQJXwZs0yneSmiuLrBryTKqvRMm/zPMdRU0Tsas7EZPkh1HcyrcZqdqz1VpuiZEjfz7HG6GOpWhZVHrPXW4YcXX32WDeRw6bhv8XGg2JlmARARC/sVuJkuaH420l/6r0v6PnrXOO5q7M7ym5VpBP2l0UYdMItPIk9ZkCwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DGB8d3AQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dca3951ad9so11569945ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231060; x=1709835860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pi3TKYGbYkDedreuD0VF7nTXnRCpQ3DLSOdVsFC+ytE=;
        b=DGB8d3AQl2+iH13eetsKydo3vb3vKmNPvdwsANlX2BfGL1DAG3u6KjA12l5TgeafeN
         9ds6vKjxHstX5iBQRgKg5KHOSOF0WV0/Z9kUXF6cBZZJbR924zVB3M9ievzHMEO/hDkx
         cgpQVyk+n/MzWXXKylu8Cz+BC8oJILk7P8g00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231060; x=1709835860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi3TKYGbYkDedreuD0VF7nTXnRCpQ3DLSOdVsFC+ytE=;
        b=FluAetv+MRDcCQvkSbJ8nRRW88LPK3MbGBuQFglUMW3QvuUj4UOHFiKbwtsyGC5GDW
         PNmrcam7nVhQHDpS1Pmu3KGyIwDiwtRWRUoH18T5/cv4ITj/ob0b1+fTcPguWwvZHbzZ
         HzMbEGnb3ITLM8RQQnfmAtl/K6LuZtekxT29MFpDh49fCEX2KKoIel492qrQJfd3MOWM
         Ahn4V/NESEMKlq19w6rVcUSY0tdN3zvCChEe/LkB2YzimoE+vV1RPNICvScBrCECeJsp
         8aucqrFp5ql97PLnkrAtG2E3OLDidQzqUwjDGtngmqJUNnsmgBHcr2erYQi9aH5DqqyS
         hNOw==
X-Forwarded-Encrypted: i=1; AJvYcCVOpksYx5E8dqJtg7i1usaWrjsVzVCUHogLsSHjbvm833NKeDs3098BXPoWIWMqYtwRI5mkD9f0FKjXM3+wqkZ7PWrhj92P4dL/1dqf
X-Gm-Message-State: AOJu0YyaBs/pZ+S5WJ06olwmwbhHhnC2YiwcmgSLoxJYUJ9H0DxR5wjB
	0NVQwDajralUAYEg7OYk+DWu9h8jqkTfo71CE+2FyD3mHCgqslv3ujJaahY/cA==
X-Google-Smtp-Source: AGHT+IGaWIUafiUvWzOx6gFaLolklPJ+XzrkV3hrkkZkuSARRfVzagRox8BqzdDqYvItAAhiU4VzEg==
X-Received: by 2002:a17:902:da85:b0:1dc:a60f:1b6a with SMTP id j5-20020a170902da8500b001dca60f1b6amr3395287plx.13.1709231060211;
        Thu, 29 Feb 2024 10:24:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001db2b8b2da7sm1793216plh.122.2024.02.29.10.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:24:19 -0800 (PST)
Date: Thu, 29 Feb 2024 10:24:19 -0800
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Marco Pagani <marpagan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thara Gopinath <tgopinath@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 5/8] kunit: Handle test faults
Message-ID: <202402291023.071AA58E3@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-6-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-6-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:06PM +0100, Mickaël Salaün wrote:
> Previously, when a kernel test thread crashed (e.g. NULL pointer
> dereference, general protection fault), the KUnit test hanged for 30
> seconds and exited with a timeout error.
> 
> Fix this issue by waiting on task_struct->vfork_done instead of the
> custom kunit_try_catch.try_completion, and track the execution state by
> initially setting try_result with -EFAULT and only setting it to 0 if
> the test passed.
> 
> Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> instead of calling kthread_complete_and_exit().  Because thread's exit
> code is never checked, always set it to 0 to make it clear.
> 
> Fix the -EINTR error message, which couldn't be reached until now.
> 
> This is tested with a following patch.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

I assume we can start checking for "intentional" faults now?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

