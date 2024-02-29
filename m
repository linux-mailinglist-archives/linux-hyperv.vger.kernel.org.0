Return-Path: <linux-hyperv+bounces-1614-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824C86D220
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 19:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5159D1C237A9
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51F87E76F;
	Thu, 29 Feb 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENGQZjPM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756047A14E
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231099; cv=none; b=pe+Kwh07i8rq7+BSV2ODjJ9sSDO/sUudZj82hUj1h2Cl/XpYy7KyEnrcY0DE/MD3ts1VpRW4cos8pOki7UPdBr+H8kduX5RAkmwjCzRZUR9Jp/QickQlgpF5R6tUZ3/7zccbP8rlq/vu2F9W0FPIYeqQv5AuppTAsPfWxkcFjmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231099; c=relaxed/simple;
	bh=Ce5pyQnb9GRcPSheUoJZhjpUrjGnCB77xYc5gcYNlxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKaH9GSww5CUvFyCWJXo2D8oOtgvMvdL6jfzioIfYD6VaN5uoHqmI52lGbtENG5LM+n8eU50g2+7JTRBDylA//dbTrFJGEK3ULw6g/yYCD5eTDdFob0KxPcACwEeNbeHU2W3kFEiRfhpwYz4AXcyd9tkoyHjdvuQLjratBCHD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENGQZjPM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e56787e691so1550866b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231098; x=1709835898; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqInfZ8mOq8nYZAY0kAdxi4SUGFvyqMPNmMOUUeoyfg=;
        b=ENGQZjPMfEh2sAf36guydCaOXrhzFaPN4I3K5F3QN2g7nWsuX9IC1WQj2/cLxkTHdi
         Qo5DZpoRSvdZZ7OuoVu0wrLcKPFz6BMXzeCZhehz9AbQaFwUOvTLl5YX7GMzj4yrJXJZ
         N8m53e6FL/rmWDTyAqgK+cvAkxUMAA5y2bUUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231098; x=1709835898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqInfZ8mOq8nYZAY0kAdxi4SUGFvyqMPNmMOUUeoyfg=;
        b=UhT0pcD8EG16QEtoqAPb3pC77BglXHRUzr2vXA3PCP/IonOwbPOUHwLSsy7jcm76EX
         ReKLKipKtJ0OFyKPZNW0FfjpWAujglIN+XaGgOucKjRG2BsVd3S/NkLLc2/JluLkY9DH
         q1GxeTCAYcLZqom3OU1wC7XcnrHFN8/BXXizPOGiMUHDBp1tnUAzBeVhg4t7HmSTMNJk
         ODYq6xsLcyiRm+vSoxlWBR5ceGklSOsv4jfxb4aG2I//3zmvr6zp7LiV9iN+mIwA2lLG
         SC7un0N42szgUXkQPOZYHyamF49UaOkkn5+D7swc//DFyGQL2OPFcBhEHnwrkvAeaRPi
         fe9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZeuugaPcBLcsOCIANDfg8lmAL2gIEwTtLH5t98xCTrDSVwSWryZ5s2KhkrCXrxXuWL0J9gVbcF+3RGEvNOO5cq23DVsAOmmb1HNO6
X-Gm-Message-State: AOJu0YxlW+GYmwDL9YA8nowXHxu0NUMCi7UnV5z6nLwgTWrFQe6oprWW
	ru6TdSrXGpQRMZp0fSTMHe0kEv6ge3/+E+m6e0TjHMNp5GGQzKPlsPE6cumgdQ==
X-Google-Smtp-Source: AGHT+IExuEVVJmKP2BNOyB+LtexDDJxYmvvXcikwCbgKNASK/A5xRah0QTnX1g4AE8/nsBFkMxCoNQ==
X-Received: by 2002:a17:90b:343:b0:29a:c992:198e with SMTP id fh3-20020a17090b034300b0029ac992198emr3923483pjb.15.1709231097697;
        Thu, 29 Feb 2024 10:24:57 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id pl4-20020a17090b268400b0029af4116662sm3911274pjb.21.2024.02.29.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:24:57 -0800 (PST)
Date: Thu, 29 Feb 2024 10:24:56 -0800
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
Subject: Re: [PATCH v1 6/8] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
Message-ID: <202402291024.CE0082115@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-7-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:07PM +0100, Mickaël Salaün wrote:
> Fix KUNIT_SUCCESS() calls to pass a test argument.
> 
> This is a no-op for now because this macro does nothing, but it will be
> required for the next commit.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

