Return-Path: <linux-hyperv+bounces-7968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EFCA88E1
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B08C8324C268
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 17:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176434D4C2;
	Fri,  5 Dec 2025 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTXnhn3Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E502DC763
	for <linux-hyperv@vger.kernel.org>; Fri,  5 Dec 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954034; cv=none; b=OznXY/3Zm0CvdGXEow1q/oQUoUEQPMLKUg75VqE5hZu1UsONNEsiD9naaPcj7nTiyQ+lT2/550uRIYfZsEMmtKXv5Bokm68wM0Wkt3fe3N9TXuQJpYMnkFghgqSFPwe1MlTuEdV5rynwmqc6uAoNGZGfWXSP6dzTolMxsf6HydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954034; c=relaxed/simple;
	bh=aaFpnj3IQFmy3xc/HrRZVS58s8ztekXzgqmlRlJFpFU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hFncb0kVFp2KzFaCSB4BCVyy4I16+ib5fXmOOZV8bW2e0nZplgdQHkxnb4CRxLXCPmYjoppxiIrE5bj650v7X2L/JpVrJwpP2qPRf2ADzRF+/Tb+oe2oVfse7wJbrF+D+O5YzJNSZbw6x0A8qKtSVVDp7XuS+PhSREVfeS4wbWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTXnhn3Z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29d7b9e7150so20152085ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 05 Dec 2025 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764954027; x=1765558827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDj3choeiT4e+El0IukGCUfkaMg0VC3BogLJ1vZELy4=;
        b=ZTXnhn3Zt9X0S7Em1GOBz0VFP7M/wgidB/siUCVovxIr2KYtOoa0siqTLlVS2mtTi8
         CsrFoYBLJTEJVIYMQZXQvs2W+c7mALXvUaPLZPQbw3mCD9z0yScgZ1uJKC4DfCxUvZFy
         8z5XPxuYen8S7XcvGaw9w300qva6RrvrIMEIzEsUgzoZ7DaviAq0WceL+s7UzmwtC/kX
         kNeFy+k8ZlakWPfSczu148WT42H5xAVzs6MRnJPD3aJjer275zYoWmaQgHaWiJey0iCZ
         DrQGoYOBYOypvPbRVxk0jt/otVmCjOLu/iS9Xip8ydvnF5v53kCP17SQjuHpP7u4QQvr
         pyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954027; x=1765558827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDj3choeiT4e+El0IukGCUfkaMg0VC3BogLJ1vZELy4=;
        b=Y+6ca+zDNu098NupXqWecysw3oNPigSHNPPK4ugfgI0AMr4M1r127N6x7/GT+nlvKH
         Kl4z7InDIyQ1nl+bR4Fzkjazxieji7uS/NqkuruS/OZlwmXHwriUKpikvPeki5G0tw2B
         FjnRqNY53j35a/0rkXsRPbXY9y1lyWrhbeLS/k1150fV72QeSWcIhD8z5SxARVVp98yo
         IU+P4CLnayrMZzm3e9OXwGrOQTdZ+BCWmdiyr28yUjjep6rO8C67KBOhwDTbxOO9owBW
         l4bHsTncyzbpVEVmV4y1bTUOBys4ZyPpCpAbA6/ruw63h4VgpTWA1zcyqMQ9l1zGMk7G
         coGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVDe+zZ9rx+vxYmpyZWLohOwiRF1Smw7VLx/vFwcydvghIwzmmEnHYXvY7NA/tLzMubPNBl+8p9e5ow40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLu+QSdJ8oBtWLeE8cmGwU+XXQpOB/RyR/uf8FRvGGC+3YsTp
	BbJDqA5bKi87/QeBy+f7wD0LxsC+wGUlhDb/ZCsghY6DZqng/jt9Wl+mICBf2HaFCsiCujD2w2d
	vfAU6lw==
X-Google-Smtp-Source: AGHT+IEfQPDZ6RmwciNkP/Py4ntixsYOUEMmkTHshPOm/gAzRnuAMijx6Hwt4UQq+2+N6jFtyA7/dYhw5eI=
X-Received: from plbmn13.prod.google.com ([2002:a17:903:a4d:b0:295:1ab8:c43c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:245:b0:295:6c26:933b
 with SMTP id d9443c01a7336-29d682be6a7mr123048855ad.1.1764954027471; Fri, 05
 Dec 2025 09:00:27 -0800 (PST)
Date: Fri,  5 Dec 2025 08:59:31 -0800
In-Reply-To: <20251113225621.1688428-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113225621.1688428-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <176494714145.295908.1538917525859193574.b4-ty@google.com>
Subject: Re: [PATCH 0/9] KVM: SVM: Fix (hilarious) exit_code bugs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

On Thu, 13 Nov 2025 14:56:12 -0800, Sean Christopherson wrote:
> Hyper-V folks, y'all are getting Cc'd because of a change in
> include/hyperv/hvgdk.h to ensure HV_SVM_EXITCODE_ENL is an unsigned value.
> AFAICT, only KVM consumes that macro.  That said, any insight you can provide
> on relevant Hyper-V behavior would be appreciated :-)
> 
> 
> Fix bugs in SVM that mostly impact nested SVM where KVM treats exit codes
> as 32-bit values instead of 64-bit values.  I have no idea how KVM ended up
> with such an egregious flaw, as the blame trail goes all the way back to
> commit 6aa8b732ca01 ("[PATCH] kvm: userspace interface").  Maybe there was
> pre-production hardware or something?
> 
> [...]

Applied 1 and 2 to kvm-x86 fixes.  I'll send v2 for the rest soon-ish.

[1/9] KVM: nSVM: Clear exit_code_hi in VMCB when synthesizing nested VM-Exits
      https://github.com/kvm-x86/linux/commit/da01f64e7470
[2/9] KVM: nSVM: Set exit_code_hi to -1 when synthesizing SVM_EXIT_ERR (failed VMRUN)
      https://github.com/kvm-x86/linux/commit/f402ecd7a8b6

--
https://github.com/kvm-x86/linux/tree/next

