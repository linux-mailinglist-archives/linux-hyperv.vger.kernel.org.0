Return-Path: <linux-hyperv+bounces-2287-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9D8FA703
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6093F1C21DEA
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Jun 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C538879F9;
	Tue,  4 Jun 2024 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjKbQmWW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6028F4
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Jun 2024 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461017; cv=none; b=ciQGjSRZ65WranIsvOcQjg0pNYQRck8sOxpPPTm2U3j7H+ubFHbVwYwjFss64TW4OY+XZztSmILiARB+BZmvLNNl4xtoS2cPQNOsv4stBhKIPM2NYx8V2c91OFL8B7h4PG1XWY52z6B1KoX9NiNAyFzOpUA4sMLKI06ox3CyAeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461017; c=relaxed/simple;
	bh=bvM0pADJsf/ny8qy1qpxXNEPBHi9kStugKigbeIsfP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QSNjBx8Rb3uN7Sk3aNDT6dCuocUpucjFuUHkIFJrDW4o2pSalmTi9MXslKfT0oSYrLpXjFA42ckqOx7wjP01YSrTcvNMPQlC7GewpPDgoQrZ0PCJmfZy/4+RdDPidQSJpEDlSnfG4daz0luv/L/wN3GP2GRwK6J0qWrUtabPVhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjKbQmWW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c1ad0f8aa2so4308818a91.0
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Jun 2024 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717461014; x=1718065814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
        b=TjKbQmWWDoMpkAd9X5sHMGOnBrJE/HzH87Y0he5kdF9BcUFrDkCVEx5N1uXi7/d7CS
         jZF111xLizarNuKMuuHQdC0G7Gw/EKdOapyYPa7EllO4gmeC/IE7id5N5i4D98NXjjpt
         IIBJPkPheAi/5LaNnHhPHbVBKIZcdrrPGL5y/bE1dUeLDX3VvON58aob5hng729yVLPu
         TSKUzyXs0Bw/9JwJbI+PvpAoJTPWKNRITOz4VeuV4Fd8CNEFsEqQ/mYJWEl14S9UzjIR
         tw5Td+aLwUQMq2tul35iIRMvcTZ/LpXyv2v3OKnq49QKNjtGXxZIuTcIQUhF0WfwNCJO
         nZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461014; x=1718065814;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
        b=sdp2BZe9UzR1RgE5Jnj0kopsWi+Fy6XNZg3Sw3BVzTgM4GF8Kq2xtX4j5CzvIuBA2c
         XVbRj31nnzaRyq19WN5ZMQhEO7zbftpKorYDHz3rd7beiJ/GB4WxygNrhH7m3emke3tW
         r79X4qMxO0bLoad11So6YYnrH6tR6e1TJk4v4ivJ3GVfie9XYRO4DxEpL4EctMJAXXBx
         D/3oBdm/f7LrC+flKNwrktw2Rh0ERG9tCbpVnYWZiDgmkqYlyczK3cz2PKfa15H5VNTM
         63ZfTsly4xkB5o+8cmd9ayUSOdVRsi8j/pYsjfklkZxdr49O/4CB2aAxxz6Gdl26DaDt
         sjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX38oaTCNTGZZInDYFvaUxg9qeufgUiK43hIZGrSFWutWliVf/kt4GzqijCH+QKhjewbXkiWTOfHqF1m9FlWQZJDoKFEGzwONMUB4Il
X-Gm-Message-State: AOJu0YxAYEbFp9AAKggA5l65gbJeuIFjrQcGq8Ilam7e/BJJN8hy6qYU
	ZRhpy0zTC4d28X2dQIIzOFjRvHzhNLBjFRRrzqpzmA14vMYNaYOeCZPhvWYwtowu5yV3StVBXLp
	fWQ==
X-Google-Smtp-Source: AGHT+IHQGaBTeBmAnXtOHPKtCDExst6sxM2uUbRh6POZbhCe3IxNIvO17m1N9WlbQ/aSMCylqTV+FPzEOtI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2c86:b0:2c1:aa8e:13cb with SMTP id
 98e67ed59e1d1-2c1dc5e0ab2mr29758a91.9.1717461014195; Mon, 03 Jun 2024
 17:30:14 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:30:12 -0700
In-Reply-To: <20240603.ahNg8waif6Fu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-4-mic@digikod.net> <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
 <ZkUb2IWj4Z9FziCb@google.com> <20240603.ahNg8waif6Fu@digikod.net>
Message-ID: <Zl5gFMJp3nECJVW-@google.com>
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

On Mon, Jun 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, May 15, 2024 at 01:32:24PM -0700, Sean Christopherson wrote:
> > On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrot=
e:
> > > > Development happens
> > > > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-n=
ext
> > > > branch, but I'd advice against looking into it until we add some or=
der
> > > > to the rework. Regardless, feel free to get in touch.
> > >=20
> > > Thanks for the update.
> > >=20
> > > Could we schedule a PUCK meeting to synchronize and help each other?
> > > What about June 12?
> >=20
> > June 12th works on my end.
>=20
> Can you please send an invite?

I think this is all the info?

Time:  6am PDT
Video: https://meet.google.com/vdb-aeqo-knk
Phone: https://tel.meet/vdb-aeqo-knk?pin=3D3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=3DY182MWE1YjFmNjQ0Nz=
M5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb=
3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986S=
ngGlhPH?resourcekey=3D0-FDy0ykM3RerZedI8R-zj4A&usp=3Ddrive_link

