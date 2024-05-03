Return-Path: <linux-hyperv+bounces-2074-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01C18BAE60
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079A01C20AFC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 May 2024 14:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1C154448;
	Fri,  3 May 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bF95IclE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760715442B
	for <linux-hyperv@vger.kernel.org>; Fri,  3 May 2024 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745005; cv=none; b=k4BTEuC1XLeLq8xPEcf0E4AK3DU36FLH+htpNROKhmFFbDUaU6p9WkHOJdEjMO2sO4H3tXgQS8hFPzSyB1B6Dmx469vlvWLzWIZlh/Mu1pXVz+Kf8Gq3yTlRyNzJPIQLcuCaOwC12HVH0FMNX62Wl2guz50BpjjkU+ANkvj8Kos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745005; c=relaxed/simple;
	bh=7+85l5gtG9BMCJsXUhbIe6mJsJUfD1GuV0eeYeZs6G4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q8cy1WclcfuucCHANbgttJhBhlgYvwoHUTwKB/aZojL7eHOrSyDrYW7zH6hZSK5A0qsohOE0zPKeLO2MN2szLnd+DQsGLekNZ/836vQvqvDCk+fc9FsdmmGzMrSUkugPWuZOq3n1pCBx6fa6Qx7GkjZXwy5K8ywNmNbgfxXEaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bF95IclE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59ff8af0bso13577754276.2
        for <linux-hyperv@vger.kernel.org>; Fri, 03 May 2024 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714745003; x=1715349803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a136SOKV90n/XcmvCvD6zgQKrJ5kR/Q+OhiUt3FbOiE=;
        b=bF95IclEvfWouhYNKzZo185b+kPSyCvdGhAB/HcI3+gO2u9Qva5QKOI9UBojc23RSD
         3WlhbYeb4zIlpbVbo8f9PY7DxRJJudohJPnX2n1XLiNQDHV4G186oTFYIcocjbp6LMNn
         f5sqSxaeMVBY1Oc6xRzM07z6tp6F8RKRESK0YIOpgdwQ66olItMpU7P0n80OypPETIRe
         mW4NZDMte/3F62OIBfeyn0WkvoByQZE28QNUpa9VJA8+zGwd7msbErV3T4NvqnYa+obz
         +WuDcfYnv1Re348zODbiUSpkIhCls7/DV5i1LlId6gsKr9yKQKG9He6E2TvG3hCMPCuO
         juPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745003; x=1715349803;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a136SOKV90n/XcmvCvD6zgQKrJ5kR/Q+OhiUt3FbOiE=;
        b=U186XGq9QvuNamBItEIUvr6oZxFAM2YCzeZrR9pRhLfztTHZpw97RadTWNPQCEANzW
         Zj3ny9KYvZ7Hlue86pkFNkYrjbHhBKf8WINzh2HFnhm3yoDV6UWkb1dvRHwHx9vUPmD3
         hcOgjKUDpI/U8nMDdvjdnVb62svGFCvCL3XHyBTpSzWeL1I/GDMQIQ2uOOh+BTgeEdc2
         Ta5dLn1JqRV3a0ycCKKL2OBD7C1QEqBqulE8gjHUzzf6xaAap/aIApRQqv5bk6go1u5B
         RHGMWxLza8Nr2yMbXmyt6x1xBk8sjhSgMZjRXhaMdpDm+onZUurYT7PK9fOsnUnIiBEX
         HLOg==
X-Forwarded-Encrypted: i=1; AJvYcCWezmjgvfAhxApTz4AgXsU0BzrCcnJGjilgcQXOaCs1yexGc7hxR9Y4Jo2WYkczAtwP8pCtw0QJVCcGzIpiO3e9p2CwXcB/n5B2ekbY
X-Gm-Message-State: AOJu0YwzGrf+vouOYglbxQvqoYx32kwPFMGncZ1qNnPsKZeWRP7CUjmy
	6cMM0lWHCFIR4QSE5VUEMT074iu0fkGzAdLujn2VpJ78s1GE3mR/dFPruvQ3Y4xH8BMbjPL55SH
	fyQ==
X-Google-Smtp-Source: AGHT+IG8Se+FDx3icVQiBS8y3Ql+XygTIGhFwTldpFeLgMxDQJNLd2QsRcCHI+DmhaCm9MeTHgIbmJIbKcw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1201:b0:de6:141a:b0de with SMTP id
 s1-20020a056902120100b00de6141ab0demr337561ybu.10.1714745003300; Fri, 03 May
 2024 07:03:23 -0700 (PDT)
Date: Fri, 3 May 2024 07:03:21 -0700
In-Reply-To: <20240503131910.307630-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
Message-ID: <ZjTuqV-AxQQRWwUW@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> Add an interface for user space to be notified about guests' Heki policy
> and related violations.
>=20
> Extend the KVM_ENABLE_CAP IOCTL with KVM_CAP_HEKI_CONFIGURE and
> KVM_CAP_HEKI_DENIAL. Each one takes a bitmask as first argument that can
> contains KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4. The
> returned value is the bitmask of known Heki exit reasons, for now:
> KVM_HEKI_EXIT_REASON_CR0 and KVM_HEKI_EXIT_REASON_CR4.
>=20
> If KVM_CAP_HEKI_CONFIGURE is set, a VM exit will be triggered for each
> KVM_HC_LOCK_CR_UPDATE hypercalls according to the requested control
> register. This enables to enlighten the VMM with the guest
> auto-restrictions.
>=20
> If KVM_CAP_HEKI_DENIAL is set, a VM exit will be triggered for each
> pinned CR violation. This enables the VMM to react to a policy
> violation.
>=20
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240503131910.307630-4-mic@digikod.net
> ---
>=20
> Changes since v1:
> * New patch. Making user space aware of Heki properties was requested by
>   Sean Christopherson.

No, I suggested having userspace _control_ the pinning[*], not merely be no=
tified
of pinning.

 : IMO, manipulation of protections, both for memory (this patch) and CPU s=
tate
 : (control registers in the next patch) should come from userspace.  I hav=
e no
 : objection to KVM providing plumbing if necessary, but I think userspace =
needs to
 : to have full control over the actual state.
 :=20
 : One of the things that caused Intel's control register pinning series to=
 stall
 : out was how to handle edge cases like kexec() and reboot.  Deferring to =
userspace
 : means the kernel doesn't need to define policy, e.g. when to unprotect m=
emory,
 : and avoids questions like "should userspace be able to overwrite pinned =
control
 : registers".
 :=20
 : And like the confidential VM use case, keeping userspace in the loop is =
a big
 : beneifit, e.g. the guest can't circumvent protections by coercing usersp=
ace into
 : writing to protected memory.

I stand by that suggestion, because I don't see a sane way to handle things=
 like
kexec() and reboot without having a _much_ more sophisticated policy than w=
ould
ever be acceptable in KVM.

I think that can be done without KVM having any awareness of CR pinning wha=
tsoever.
E.g. userspace just needs to ability to intercept CR writes and inject #GPs=
.  Off
the cuff, I suspect the uAPI could look very similar to MSR filtering.  E.g=
. I bet
userspace could enforce MSR pinning without any new KVM uAPI at all.

[*] https://lore.kernel.org/all/ZFUyhPuhtMbYdJ76@google.com

