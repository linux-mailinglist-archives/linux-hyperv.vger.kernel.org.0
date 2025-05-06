Return-Path: <linux-hyperv+bounces-5389-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B88AAC7D3
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 16:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662014E643E
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 14:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874CD2820DC;
	Tue,  6 May 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1anhYLmF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE474280CD5
	for <linux-hyperv@vger.kernel.org>; Tue,  6 May 2025 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541476; cv=none; b=tBhQZSffrQ74RoO1vC1DEll+RrvCiPQ0Z27n26JoMG0Yej1PnUBZdmms2TWzEgntH80ytadkJyoL7OvGsUKH/hnOZ+EW2QzHRQBMEJ4sgEc6Q3MNomsR/API6caTjHFHXOGE2UDaDauvPH7MiyXRvpidkSJca/v3s/a9OYt+T3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541476; c=relaxed/simple;
	bh=uzGnvzipjJmvydYRycycUL4dqtdvUfmsqIjQ4aKIEHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKii4GJY89mY0X3TaeL+manH5AOTxIKuBR47PuWZt/fdFpSjMLsIEDWNsK5/AAexLAcCKIPW5FShjZ7icQEnXHJDguCwv3Yt9hlTTq/bY8Rf8bLzvrr66Kqhj2wzYfWSeOaQDrNRXJ4243lOzwsBUmWEVjXPA1wdEj6SI29z00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1anhYLmF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ade807fso84464665ad.2
        for <linux-hyperv@vger.kernel.org>; Tue, 06 May 2025 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746541473; x=1747146273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvQ0P+wUKfaLn/ATwLSuvFKy87onNqdIa1sjwEnWlHA=;
        b=1anhYLmFXvFTtqII7wywKetk0UHFM6DC90GPVFRZm8Eewiv4IJTTcmQMt7/mgjR3yM
         u7BX//fjGh9uMQTjItuGfliy0Z+4jjrXZ1hCMXNYeemmBS5ULkzirqBQlLAAWtym5u5H
         BUTtNx8B6R4GlGy0rXf2goMVSFbav965WhSu8szua6qoBY29bxF9av7A1qUUXeHhNEeu
         ujJF8d47ImvOb4XB0iFzjvpCuHRHIBx3wDzYodcT69wuZwEkQCDd6Y8WVf8X0ZSsQcac
         ggsGHK91n6cC/pLVVgd6NbyxOO21OMXAbPlzy4mw4tPhzrIpGmUejU8CSG/qnMUtqs8W
         JyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541473; x=1747146273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvQ0P+wUKfaLn/ATwLSuvFKy87onNqdIa1sjwEnWlHA=;
        b=S5Den5OdmUAg00pwgmiIPTvgMshjieZ3BjgdGLjcEcR8686idzsdztuQQYFT7EqAoP
         WlPRoEy9E1aN4dUNrVAcpFpoO9+YB8F+5QWRMeG+pEZlGAp09xAcIJd2z3CtG/cj4VBR
         H2AMFlmEtVzN730xXiYbxSJQZ7hAZEr70DBX0xWg0ppmvPA0AE0uQZYTveeCMd+e0Ugt
         WykXbLWMCw4VzZ+C1HK4UI/3VNiq8T62P936lKsScAmoJFRQBn538ury6dmLblZAk7Ot
         nE8lJ/fKSwcCCvP1XGVSEgoahQwddNd9sWrjyZ6c3C2Sd1AD9te9PiLaLR735TTE5kGL
         wG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXi7WAxBBhOegtu5oF0WRAv6yoHF9ZgY1aJg1v2HCCOx5fXy+9D4Xc7v9R9sl185UqDqMOescS/3lJkQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nGF3+xByz8zXDnbO9GqbkHvtjZ7Ec5+YZLf3L02oXysZHOsE
	lErWYFL537R+4L6Z5mEZSWJDuU5xg5324vKdlnPIrASvhJgmpnsbT4TIMLGCyorhE4EE+NYF4r3
	bQw==
X-Google-Smtp-Source: AGHT+IG+tb6DAqfEkF2OtffXMj0e0GMqYjoEo/yCNWTnFNMEaweQ67wd6DzOO6xB801yCXPJlU9wA/n2y+w=
X-Received: from pfay24.prod.google.com ([2002:a05:6a00:1818:b0:736:b2a2:5bfe])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf42:b0:227:e709:f71
 with SMTP id d9443c01a7336-22e1ea822aemr186821615ad.29.1746541472989; Tue, 06
 May 2025 07:24:32 -0700 (PDT)
Date: Tue, 6 May 2025 07:24:31 -0700
In-Reply-To: <20250506092015.1849-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506092015.1849-1-jgross@suse.com> <20250506092015.1849-4-jgross@suse.com>
Message-ID: <aBobn8kaiDVCEqK4@google.com>
Subject: Re: [PATCH 3/6] x86/msr: minimize usage of native_*() msr access functions
From: Sean Christopherson <seanjc@google.com>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-hyperv@vger.kernel.org, 
	kvm@vger.kernel.org, xin@zytor.com, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 06, 2025, Juergen Gross wrote:
> In order to prepare for some MSR access function reorg work, switch
> most users of native_{read|write}_msr[_safe]() to the more generic
> rdmsr*()/wrmsr*() variants.
> 
> For now this will have some intermediate performance impact with
> paravirtualization configured when running on bare metal, but this
> is a prereq change for the planned direct inlining of the rdmsr/wrmsr
> instructions with this configuration.

Oh the horror, KVM's probing of errata will be marginally slower :-)

> The main reason for this switch is the planned move of the MSR trace
> function invocation from the native_*() functions to the generic
> rdmsr*()/wrmsr*() variants. Without this switch the users of the
> native_*() functions would lose the related tracing entries.
> 
> Note that the Xen related MSR access functions will not be switched,
> as these will be handled after the move of the trace hooks.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

