Return-Path: <linux-hyperv+bounces-1615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB4786D22C
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD07A1C2361C
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B484134403;
	Thu, 29 Feb 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GWtPP+Gs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90B7A124
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231167; cv=none; b=R/w4TlIhNrxliU2RWawq3KNY4J6vQKVEuFOEDPeOy4puGEkyPmMHizPASeuw2YExG8tGOK8TfxJqvS7RctJHWW2SpJTrRbHO5uvP3iDl+5j/B56e38Jr2nrk78RxAwZEhNbVSzW1HkSr2SxBsaRQtJARz2dR2wGy9ImRPRE2bVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231167; c=relaxed/simple;
	bh=GMRN6SUrrHoEIDYQZaXbYank+mE4jIYwZGljGX8JzRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ar8cn8ltE14Wy0sLJNdQs2rr3NutRCXNJt7t0MsIIgDGemmMDT8J/IJ5nH5dhyXE4OmvI7Q7jbb53Dkho5b152hZrlchRJ21/WM+wwvykVX+oq2T1ulIXnJ/TNeOT7FbD5egE9Dgl6YVB8twfGjyPMwZubfyMHfa4CyaOQnxgfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GWtPP+Gs; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc13fb0133so10492495ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 10:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709231165; x=1709835965; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=onsMWwzpvtENple3SFlR2LMD09MQgc6sYAmAsDrNdvU=;
        b=GWtPP+Gsy8M3uLFQ3Bn8eCkaLfwMSCXbCoiwv7X9D6CXKax2kNaR0Yit3mNLBqIftB
         UBUbEj3tonKTijg/2l0GXZlW1Y1C5l4OuQ6c7+OlA8nofTANoAHX5RPdp3PVZcuzyOP8
         oK8vndSURR2ikGP6Tv+IZmb/ahraIVLlxtEwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231165; x=1709835965;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onsMWwzpvtENple3SFlR2LMD09MQgc6sYAmAsDrNdvU=;
        b=t53SpshPPkKsV1577Sxtreyk9TLqaKL5Xwne9gLhF8y85lYtIDKXwlSQXdyAVCF0sB
         9psIM8WbFkqJpmVNXeX3Je7tbPPaJqTprJIzYHKpifu9dAzDgX7nSBIG2PReCmpqwa1r
         1I6xHKvCiAwjGa/k5Brfvj00UMulbDDlHby+WW7Vm9xzqJWE8UnuOc3ZfkrZhade2gDH
         DNj0k0DnhY22H5bQl1a9mWaTOTCRDATJEu3+C1insHKJPdT5WA3Zx7MC0HepZfxKiJ+M
         5zJzh6HJWqHFKYCKG+/PYhB+0NCPe7gkqGjdRhTy3/ezF00CqAU2COqXzpl4RebA48Gz
         QboQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGBtbNbSyBA8odLjXnkPeZfOIN9sB67T2TM0jUNR6vEtblUCL4gx9iSoGWTshtB4kY38xRXRMQvLTlHB1n8EUBUIGUXWorZpNXWbN2
X-Gm-Message-State: AOJu0Yz9RgG/CuWbemnBZNH7nKmK1CoAwX8a5kXK6cVskO6ZRaipB8gv
	bR38Z7lISW0rR01ca1+rre30bUuZom0c4jXwV+e30MMCY4I5NH11fcXiOZ0yAg==
X-Google-Smtp-Source: AGHT+IFaOyXib1ZvD8HKP8qWNtoqD6PNUUwUwDcIGpR6CELmVt23qtsOEdbZ9mepYl+BYt4oLI9EwA==
X-Received: by 2002:a17:902:a3c7:b0:1db:c6ff:664a with SMTP id q7-20020a170902a3c700b001dbc6ff664amr2752373plb.53.1709231165470;
        Thu, 29 Feb 2024 10:26:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001da1fae8a73sm1821003plg.12.2024.02.29.10.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:26:05 -0800 (PST)
Date: Thu, 29 Feb 2024 10:26:04 -0800
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
Subject: Re: [PATCH v1 7/8] kunit: Print last test location on fault
Message-ID: <202402291025.0BAEBC1@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-8-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:08PM +0100, Mickaël Salaün wrote:
> This helps identify the location of test faults.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Much more detailed error!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

