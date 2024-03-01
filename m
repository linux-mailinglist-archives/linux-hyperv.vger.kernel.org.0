Return-Path: <linux-hyperv+bounces-1638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0610A86E93C
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D4AB25FFD
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060339FDA;
	Fri,  1 Mar 2024 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="dnzKh2OB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C439AF4
	for <linux-hyperv@vger.kernel.org>; Fri,  1 Mar 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320190; cv=none; b=Gat5NDaQ22MfTNaDXZXkvoGa7A4eaVaOhbmfELZLZnmnQFWw8+Co7smdRmR9+xJcitl3WAvk8hDjIItWfE9VrJIq+O8AQOTj2m0GxOaAbhis9T3E81DdsjdF5f/ldpu7GSVxW2uiFXBnw1b9zmKyPCI1QFQ4fjrZZN60Cyuugts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320190; c=relaxed/simple;
	bh=rjofMt5czWAZ/8UdgmbuNLIMUbqVfuBuDdVqP8nEB2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaotNkRSQ6e2nWQwckGmljR6L67XP75AAIoQFc3KtvlBrNbd+yb1PqqpdSPlfMEc705nYwTnpSUt6v0xICsVdJ+Ln1Y5R3jFj9w8hQh/ubbKdpRfiB2740kh2sRb4hfA1sksLuYSQyFh7YkQ90VGH0kCN54VT7+w7F5TviBWdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=dnzKh2OB; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tmd1t6YX5zMyYJT;
	Fri,  1 Mar 2024 20:09:38 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tmd1s45G5zMpnPg;
	Fri,  1 Mar 2024 20:09:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709320178;
	bh=rjofMt5czWAZ/8UdgmbuNLIMUbqVfuBuDdVqP8nEB2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnzKh2OBS0YkrIYpEspkpvDAydMZFIZk4Nh0+Gbx0+8Lk3b671LXi4kdNjVmCBsTZ
	 Rm7K2WbZWudBEHrEPsAMJOJB+6kHAUx0XE/0mQzOmvZ1EZHpPA5fTAcSzByG999MpW
	 RTwlsi3ZWspSksJZHRaVH8PWKdKF1bQBjNrpiNAw=
Date: Fri, 1 Mar 2024 20:09:27 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thara Gopinath <tgopinath@microsoft.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>, Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v1 5/8] kunit: Handle test faults
Message-ID: <20240301.EeyeePa2lien@digikod.net>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-6-mic@digikod.net>
 <202402291023.071AA58E3@keescook>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402291023.071AA58E3@keescook>
X-Infomaniak-Routing: alpha

On Thu, Feb 29, 2024 at 10:24:19AM -0800, Kees Cook wrote:
> On Thu, Feb 29, 2024 at 06:04:06PM +0100, Mickaël Salaün wrote:
> > Previously, when a kernel test thread crashed (e.g. NULL pointer
> > dereference, general protection fault), the KUnit test hanged for 30
> > seconds and exited with a timeout error.
> > 
> > Fix this issue by waiting on task_struct->vfork_done instead of the
> > custom kunit_try_catch.try_completion, and track the execution state by
> > initially setting try_result with -EFAULT and only setting it to 0 if
> > the test passed.
> > 
> > Fix kunit_generic_run_threadfn_adapter() signature by returning 0
> > instead of calling kthread_complete_and_exit().  Because thread's exit
> > code is never checked, always set it to 0 to make it clear.
> > 
> > Fix the -EINTR error message, which couldn't be reached until now.
> > 
> > This is tested with a following patch.
> > 
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Cc: Shuah Khan <skhan@linuxfoundation.org>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> 
> I assume we can start checking for "intentional" faults now?

Yes, but adding dedicated exception handling for such faults would
probably be cleaner.

At least we can now easily write tests as I did with the last patch. The
only potential issue is that the kernel will still print the related
warning in logs, but I think it's OK for tests (and maybe something we'd
like to test too by the way).

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -- 
> Kees Cook
> 

