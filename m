Return-Path: <linux-hyperv+bounces-1611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C40C86D205
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3041F21752
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B315E134412;
	Thu, 29 Feb 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="B9KciT6Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FFD7A15B
	for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 18:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230938; cv=none; b=RQbdDqJrQLHeuuda7buW8wgDBu4b3X7oCywvGG7+tMzV8uFbRbojk4SuSlcBfW/bwBYcsTPYQnzogQRQgkaVrC1fzNDjyo5W+hNY6ScLA5CajDlepMTu9zNNTDbmBmjc2tIkWng5+9PQOXh7x2zaZsbh7HUl3SWG2AkIUcN2tMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230938; c=relaxed/simple;
	bh=fDc9Uwhm++z7zUnn73jE8m6PTGMIZXn9lNaCfrSaFKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEdRWUvfSFq2OF0M8u4/yIHloz2W9oh2/+fTh7OCkC8zTfYnzF73mFMJdKSYWMxQVUPoadCfBtSKICCBgy6ObSSyFHT2eMcdKol9C0ySAkrzeNFEHsN8hISvSaIuJVommL9H8eAq2CJ17RDa7igNlC1MPgZZ91WGuKAfR+ijhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=B9KciT6Z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc9222b337so13176185ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Feb 2024 10:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709230935; x=1709835735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0x4aOlew+ChlnlW593MwGC8/uLA2yAII6jDpil+AZo=;
        b=B9KciT6ZaaZF4rRQhqyiILzLdNkpla2QbXXkNeuCqrChpu0qtMIaDWenDbQ8rrSIFh
         9XynGDga/vimj3ueeTB3rdqIRVOjTHTM95CYqqb8qeQr22gNsndvohB4T8KofRerc6rN
         48/S2kHkaGM+eNJMxTNvKpqQO0LME4EEwFUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230935; x=1709835735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0x4aOlew+ChlnlW593MwGC8/uLA2yAII6jDpil+AZo=;
        b=oP2bgB92F5SSbxWP/jFJdq+XudvBugt7gl+L9ibSY6j8zms5o5GmqHVuCkiW5KJx6U
         nQOY6ra5zQjOSRa3jTFON4rJ8ThqNskxYrLZjWQsJrb/t/cde96iC1ctOnprh4oA6kMu
         LvzxphHaElQqsMrygYsZnIuArAOsKpp7sx3W7ofo6/fqbzR6g19nzRrm4FGHul3DxsCc
         oK0PDddYqTLJDM+9iyBnNzTEtwhL6FMU05pKBm6jA3E1kVMPuAro14SavtjKSvNx7ls2
         28Y2aiIts18MAM+53iULWbLwFa1QKAmlBt/YHYnrrFkyFxPikJNU4dRh9MDtyIo++MWz
         euig==
X-Forwarded-Encrypted: i=1; AJvYcCVVn8RAdzWn/0c+r6cp/JNWQEh+FS9n/C0aW69b1iy6uQaAB1NC5YM9brbDjCk6LnHMqA+GvPU/PgNOSk4YikGWG7lvA4dnoVEeZpMg
X-Gm-Message-State: AOJu0YxgGAzjH20KHNbVCPykTaiVAKzbeVLyjJKTDcPAjwqBVXHqgXq7
	4TA2sstE8D0TWzSRA4lN3Shlc0puvb0YXAOJkyWZX0BKOlOopEA93enHsVlKBA==
X-Google-Smtp-Source: AGHT+IFHZRhftFXgpyhoht+oIaLzwS0XuiJOF7tco0dVyJI5zhbRvtaKiuO5uiLkXREbQDVyDJP6vw==
X-Received: by 2002:a17:902:6547:b0:1db:e7a4:90a5 with SMTP id d7-20020a170902654700b001dbe7a490a5mr2736748pln.12.1709230935335;
        Thu, 29 Feb 2024 10:22:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b001dcc158df20sm1813098plf.97.2024.02.29.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:22:14 -0800 (PST)
Date: Thu, 29 Feb 2024 10:22:14 -0800
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
Subject: Re: [PATCH v1 3/8] kunit: Fix kthread reference
Message-ID: <202402291022.A8E2AB8A@keescook>
References: <20240229170409.365386-1-mic@digikod.net>
 <20240229170409.365386-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229170409.365386-4-mic@digikod.net>

On Thu, Feb 29, 2024 at 06:04:04PM +0100, Mickaël Salaün wrote:
> There is a race condition when a kthread finishes after the deadline and
> before the call to kthread_stop(), which may lead to use after free.
> 
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

