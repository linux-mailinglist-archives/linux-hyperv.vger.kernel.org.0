Return-Path: <linux-hyperv+bounces-2143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7666C8C6D43
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 22:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA8283591
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 May 2024 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9975013FD85;
	Wed, 15 May 2024 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoC4VFaV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AA3BBE2
	for <linux-hyperv@vger.kernel.org>; Wed, 15 May 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805149; cv=none; b=nriI16Jx+qzJjyzDb5Dx4KbK867/2laiQDs5gYcrwD2PzupjFHRP4GJuhKeAxv2XC1hYnJ1EBLI2ovWtTD272LmOr6YqOOTkWDXPtul/Y56V0rN+IqsgMqvoz3gPArtdijvAsP0mxEn+5/p+25KhazaOgkcy0gX4akyMBLv8nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805149; c=relaxed/simple;
	bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hr0F38RtrR2TTBjKGMzIRGqSyi4gapgPMuFzNBqHXUouFNZBWf00XKmH6GYt9kbKpIuwmufYKM55nT7mpWm2Nl2yK4W3vSmwP82CUWfLS1d3+/PaWlK4ysP0y5rkdgPKy4JH+laM/kiIhyQ+bG5K5eaLs6HyeVTbcE1M8uGthX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoC4VFaV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f454878591so4557594b3a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 15 May 2024 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715805146; x=1716409946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
        b=IoC4VFaVrOG9IwUtxlTf5JQhRfjVAINdoFMaz2K6UvhWAZaGiWDmBx7t5fZQyuYCnw
         cwFP1+Sfgf9abXcU4uYL0yISHzKKG/IdIJe4U0dvVGzIX4MD9fmH0Dg5bxuDS9DHvNlL
         KlT5Iaz1KjBHhHpiOfQrZzn3eAv7mPADawJZeV2tMMYA1UEHuZiJdVwbSvBkiAinsbrG
         6fD8RqoYI7ZP+1p5/rcLleSTBA6EqC0nV2aWhqYQ1owIpvlkHcBMTHfrpI8YlR4N1Zia
         DPmP8ZAUkw+CKu9y+agPDM+5zMurYcsKCkOmQJz1pLhZt24Vh4vRXJM1DrZHnPmPMzdq
         Wmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805146; x=1716409946;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
        b=R2IExEeystqAVbqjrqJQq6pEtOoGaJPcNDsKGr6vdCIAaBf+V0j0d5cxVlKNCa1RaH
         2D9YJdTzBTcnBIGw7dFx2Am+mydyC85Rcyiw4Def2a4OLxgBSVvbX5pQ/R954A46C+5Q
         GhBqWzctWF8UmvrdDHjXFu0qflo+B3syp7LZqFCfVrkLkLMUo9uMRwfc5/I+3ldK9PMJ
         b6PsQDqMdIjbXXT/Y4nYUwKZs+tmaVm3kH7iyN3j2/H2WDlxG3+D+E1jyDDtgQNesrdH
         dVFcGatrPcpB4A47cv4VkNu3mDqqydu/5hN7zPp1UDysAQajrmWGOCEOyIle0PFO7T6s
         VQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUDqi/O5XRr/xabQx0MQVpaMcv7sGNmVixzMPjORfpCjJmeGblzLP3vExypRcpBkJImPnOolZaIlfffhxAHwV5eYQ7lFU1RfVurQb3B
X-Gm-Message-State: AOJu0Yxeglpn9EZEoKqBv9gsYdEUA/iAvBykz1vO0O82XuR97ABXP09I
	55VL4Q6BGlG3HGQiAdlFBiEmneLPclRIGqA+hpDIwsxiy1WfJ2f+mtRjPXB2ldhwk2Jd8HzHwO4
	o1Q==
X-Google-Smtp-Source: AGHT+IECDBDOitjYW0H0HtQ+B5fogjE5oB/VbBha173B4uff3BsqArnMeFZozd93oJEEJOGvPRJpNAKBnf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d26:b0:6ea:baf6:57a3 with SMTP id
 d2e1a72fcca58-6f4e0431a08mr1169393b3a.6.1715805145969; Wed, 15 May 2024
 13:32:25 -0700 (PDT)
Date: Wed, 15 May 2024 13:32:24 -0700
In-Reply-To: <20240514.mai3Ahdoo2qu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
Message-ID: <ZkUb2IWj4Z9FziCb@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
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

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> > Development happens
> > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> > branch, but I'd advice against looking into it until we add some order
> > to the rework. Regardless, feel free to get in touch.
>=20
> Thanks for the update.
>=20
> Could we schedule a PUCK meeting to synchronize and help each other?
> What about June 12?

June 12th works on my end.

