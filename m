Return-Path: <linux-hyperv+bounces-1616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12586D245
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 19:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF28B281B3
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FB37D07F;
	Thu, 29 Feb 2024 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ft0sFR8H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEC7C095
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231301; cv=none; b=b0CZolJ+1G5VXxWgHEmTj7CvqRF7cxdf8ePPO/GFJ4EAwB2XJURcgEO8SjuYrmjpSu1hDRALDq801UMoqdb3OLsod9HrgZEjRo8hveYMt1R0Q6+gaXxbXoBOmivMqBxUQhXNtS/Po+KlT5heJtOitBbrajY4xzXiauRhJUfRR0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231301; c=relaxed/simple;
	bh=TsNS9H9GnTpwvcccMLUCGH9dbY20A+4uTVdeOoyOT04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhjLVrnJVzYoFH4v1pqaPrYQ7VI/4sBX55hoyUkitbGj2OUhEoqnDZnZ5r1jbBMMBbHnRUTsk07JA+/AZapihLcrbOcThFywmcZ2UKsK5zXPHczbmqTbJiSb7vY2ssYQrtzWZZ+qMTOzxAf/rMj4rZ2J1biGzMJouGZpbuHahyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ft0sFR8H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dca8b86ee7so12094285ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 10:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231299; x=1709836099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S7hpS9VpNEze5H4aDuNsMr11UTcGSJ5cm/3AR7/T5Hc=;
        b=Ft0sFR8H+zbuiyIAKexQ970Fx7JhlQ21wk125e53FUT7WAKC0Kv6b32aFjCXt31Cdw
         YwYLEbkFU1Po8mGu8gHM0AYQkev29ajaqmVNJ4DBrDOwUjH4EJ7hpCS/vvFEMnYKoku/
         +7G7W9Sd+q+dG+9hp6MIjgFNMao++iFBvT/iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231299; x=1709836099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S7hpS9VpNEze5H4aDuNsMr11UTcGSJ5cm/3AR7/T5Hc=;
        b=lIScRsorwisAwuwkAo+rfB00i6lDeXablhxtUWNJec3dOQeN6DSwwhln5PfrCDgkWs
         X3lsSA7V7jtqlFCBPE8cRn/xbDKtbCznQfFWeHKzWqdtF2qPNNuiyZ1hUjQxpLoViWhH
         bZOg7P8eH2JbslZoynWEjxOYobo53nX4DcGTALFAmm92ZJH5wkkpGsYW82j6E963I2DW
         k/X5X1a70HjsaNFIFHc60UfhfwPoEZJgj7RplxmKds3ZD1GrNCQ9hy7mOPA2fCU4h5B2
         d0Z9Y+5PrbLSs7n/Rf0sGnVO2xBxWf40N+g+Mjq583CcXK/04PLxJsP/39Uhd91E3ctq
         SrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI7nV1rcKnSt70DjM8VxE6NFCRnbAhgsKXdvp9D5lJkBdkZ6UtLOZ4m0c7/jQ+E2xIZWEr8GrZ0lEU8udxNVzrhdunmImDoDDofzht
X-Gm-Message-State: AOJu0Yznnz21xQvInKpDHZyDscimag9z6x50jwkN6N8A8VbSIkrQPg4W
	i9OmROtHccCe6PdPcYLajreQTgHosgKKqVRtzQo3Kxm+y2oFRvvXmUAoXFSMAA==
X-Google-Smtp-Source: AGHT+IFv6v7GCq84bRF/XSbui043ytODMyWUS4Rfqf+IDs54+SrN6ooF1PL5gcE4I2rCfOz2B9orlw==
X-Received: by 2002:a17:902:c394:b0:1dc:1831:8ede with SMTP id g20-20020a170902c39400b001dc18318edemr3025429plg.53.1709231299355;
        Thu, 29 Feb 2024 10:28:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b001dc391cc28fsm1798569plh.121.2024.02.29.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:28:18 -0800 (PST)
Date: Thu, 29 Feb 2024 10:28:18 -0800
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
Subject: Re: [PATCH v1 8/8] kunit: Add tests for faults
Message-ID: <202402291027.6F0E4994@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-9-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-9-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:09PM +0100, Mickaël Salaün wrote:
> The first test checks NULL pointer dereference and make sure it would
> result as a failed test.
> 
> The second and third tests check that read-only data is indeed read-only
> and trying to modify it would result as a failed test.
> 
> This kunit_x86_fault test suite is marked as skipped when run on a
> non-x86 native architecture.  It is then skipped on UML because such
> test would result to a kernel panic.
> 
> Tested with:
> ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_x86_fault
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

If we can add some way to collect WARN/BUG output for examination, I
could rewrite most of LKDTM in KUnit! I really like this!

> ---
>  lib/kunit/kunit-test.c | 115 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index f7980ef236a3..57d8eff00c66 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -10,6 +10,7 @@
>  #include <kunit/test-bug.h>
>  
>  #include <linux/device.h>
> +#include <linux/init.h>
>  #include <kunit/device.h>
>  
>  #include "string-stream.h"
> @@ -109,6 +110,117 @@ static struct kunit_suite kunit_try_catch_test_suite = {
>  	.test_cases = kunit_try_catch_test_cases,
>  };
>  
> +#ifdef CONFIG_X86

Why is this x86 specific?

-- 
Kees Cook

