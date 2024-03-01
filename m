Return-Path: <linux-hyperv+bounces-1621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215BB86DE27
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67C41F22119
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0F6A346;
	Fri,  1 Mar 2024 09:25:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A61E886;
	Fri,  1 Mar 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285116; cv=none; b=LFnLQVTXFDu4i+ZUoF/sqPRw35e5bmWTA/XvMtZq/qYcZJt3EvjYzr2snUwLlp6bp0KeCdljfeA3/B8dnkGqxXWS9/x4RCR8evRRrAU4OZ5hBjJ3ZqFDi/Vh0NOqWKgJ7JcDE/g8CC7WeHjnSAh01Skco0R7mRV3IGhLh0NhXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285116; c=relaxed/simple;
	bh=yVMuyIEc7LLGjgbWP6hzU5jSUFMusEyr18P0nCgeegI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsYfX89mYysXFRqPXWWFmJDSxHT5e1DtP2i2eCnsKlaZQL2geeWreRnH8yO++FZtl2OCY4IwPKqWfgnUZ/P7/4fJIhcj4De3sXZSnOimZiHlXM8JQcdUaZxmkX2wnttce10zsMbpdYhvdBNdflQoaWRLTy9saoQaJ5fRb1kasco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e4e7e25945so1563474b3a.1;
        Fri, 01 Mar 2024 01:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285114; x=1709889914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95NVSl5kqQjXRRp6oZvU1o5DBG7Y5ZcxFhGuFfatWrU=;
        b=fvNjtafjqUET2w2HnpryLM2SnTqziZxsXgOSOPmxQPIJq4y7tHgDarYQe1XA440Wk9
         N7cBYJG6mJablklMxJIoN/3E7p2zrcIxSbyVtSJdWhLf0bBJSri2HWys0OEvKE3QffU1
         ypV3YmsqsJi60Ti0jnqG0L/SX8TFkN6wZe75Su56Ibj0oA6DyIpiLCNZ6EtF+8YBxDGZ
         aZ9ITaTjXpOiG0T0ZRzTRv7jzTvzZJEufqTPg0WxbvIEhl7WcV1gkFcNAUlTuXFu6D97
         bp+4qzZUDC4zPDE0yrlntWFRPxNlHsTlkKdAXDihcVuLoTVr2GPm8GO5UGKiRCPGF8U8
         g/wg==
X-Forwarded-Encrypted: i=1; AJvYcCX3hRZrRRSuPANlu4mkDAI3CvVd4oPgTyHZTW7gHAZ6G5RmJiYlibutcZNSfzQ75XkZzJCfEmH6OSVfcw3Jwg+8fjBGVeG0uNekgOwZITwqyC+t8UrLonUGp5hJfbEys4/eWVcKonqd0WdC
X-Gm-Message-State: AOJu0YxUXiB7pXjjRbcJSC1iwjpZMhI9g85GXVvMzKSfN6ARGRuTXKHF
	wNi/y0sPwOga4QLi0V+XjzUs41ospWnvmCw6q3BWnuHfMhE3JoCV
X-Google-Smtp-Source: AGHT+IFnhy0WYsNjWDw7l+Td6CleiRFV8As31aGp7T4lptLViosVmj0vQq+zEJTDFGhuu+2SEZmD+w==
X-Received: by 2002:a05:6a00:c95:b0:6e4:7a93:b627 with SMTP id a21-20020a056a000c9500b006e47a93b627mr1314912pfv.15.1709285113990;
        Fri, 01 Mar 2024 01:25:13 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id e20-20020aa79814000000b006e59290db4asm2497450pfl.168.2024.03.01.01.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:25:13 -0800 (PST)
Date: Fri, 1 Mar 2024 09:25:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Calculate ring buffer size
 for more efficient use of memory
Message-ID: <ZeGe-C9SYUYXPa_7@liuwe-devbox-debian-v2>
References: <20240229004533.313662-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229004533.313662-1-mhklinux@outlook.com>

On Wed, Feb 28, 2024 at 04:45:33PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
> requested ring buffer size.  The header size is always 1 page, and so
> its size varies based on the PAGE_SIZE for which the kernel is built.
> If the requested ring buffer size is a large power-of-2 size and the header
> size is small, the resulting size is inefficient in its use of memory.
> For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results in
> a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
> allocator, and wastes 508 Kbytes of memory.
> 
> In such situations, the exact size of the ring buffer isn't that important,
> and it's OK to allocate the 4 Kbyte header at the beginning of the 512
> Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memory
> allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted.
> 
> Update VMBUS_RING_SIZE to implement this approach for "large" ring buffer
> sizes.  "Large" is somewhat arbitrarily defined as 8 times the size of
> the ring buffer header (which is of size PAGE_SIZE).  For example, for
> 4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
> 4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buffers
> of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
> header.  In both cases, smaller sizes add space for the header so
> the ring size isn't reduced too much by using part of the space for
> the header.  For example, with a 64 Kbyte page size, we don't want
> a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
> of the space for the header.  In such a case, the memory allocation
> is less efficient, but it's the best that can be done.
> 
> While the new algorithm slightly changes the amount of space allocated
> for ring buffers by drivers that use VMBUS_RING_SIZE, the devices aren't
> known to be sensitive to small changes in ring buffer size, so there
> shouldn't be any effect.
> 
> Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
> Fixes: 6941f67ad37d ("hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218502
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Applied to hyperv-fixes, thanks!

