Return-Path: <linux-hyperv+bounces-2765-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD25C94FA83
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 01:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63E5E1F21D12
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 Aug 2024 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C118E022;
	Mon, 12 Aug 2024 23:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jaUCRFJ7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346C1804F
	for <linux-hyperv@vger.kernel.org>; Mon, 12 Aug 2024 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723507184; cv=none; b=A5/tRuk1GLV4vCJINqHI/P/pxfk7nbiEcC9Jatz4aYEcZDYn1mY2wLufrkqgZ2INzT5WwDnNnXPATB2aPiAOKmnCf7kVa8jjAg++Y1p3KLfaNiX8V+H6DhdkORWY8DjqpUIZu3lOYjGhn3aZokgXujVl62W+OwYTKIQ/Gx+J7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723507184; c=relaxed/simple;
	bh=g0tyl5PUP+wK9NuBMt6TH2vOO/Fwr+C64cHZyDZ4lDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NQqcbgjmOx2dLL1H9hQ6ln0Jv7hQ7FuRiheOY8EZmlBzYOUBtwdrsIo9eYYLSF7iRNH279arfOL9V71kXICaPrBmKBS3NRmFJAHJBf6LGvUl+zuqEcpco4uCyNhZLcsMWEI32Ch/IVMIrfqEDEcDWhj6fO905tiUGg+Bfq1BfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jaUCRFJ7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc4e03a885so41571225ad.2
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Aug 2024 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723507182; x=1724111982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkVLv7LlrGu9r3Iv9qG0e2Nje3x1aHRRiIR2Xt4n2gc=;
        b=jaUCRFJ7VnQ4Zh+zkARZDOII52M0Bv3V0vDHmmz7v3GNbyNldjhOlcjTcL42z7rIc3
         3w9TsaNLkZDSUSAebxqTIKqfQk1ORNnKJ/s8609G/x0zvZVbyA2bD+IZ6C07ovd5+N1B
         myp9oIOmsHgqIsPYYnjq4qULIH9PrSoOLhiAdL3aNPNlOjeFkB2XPvkZTPGkYvTal1TF
         1ryqbngTFFYT/JZBCKJ3cpxKSBtYtOssgJAjC/7NhyzzItHfz/pXdK6m+1Hw4mGEDm7S
         82M8xUJI2TAhgrbrD/8Dp98sgYJ1Kr75eO6p1no59w9I7Zlbw3fCl3VT+m8ceolAPQCH
         0sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723507182; x=1724111982;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkVLv7LlrGu9r3Iv9qG0e2Nje3x1aHRRiIR2Xt4n2gc=;
        b=RDKfZ71x1w4mWDFp4HMYRWWbFLGgYg92LOcqHOTm7VKo/prga+1KtF2rcFUnpJT/pl
         ujCvemAhyLgPjkLUQO7FzLsfSMGb7AM4XjKVluOrVP13lyhdnz0OG04GbysFNWB66nKh
         HgU93BT+g7e6DD/XOJOkg30pJgMkImKdjY8glXtsX9eIGGu/Odug5o7JRrP/00Nni8Dg
         cryj/DBEwzHBBxdB5lh0PpHHd1kZsTF1TXvp3De6cpxnYwWpbZoyVBQgF6oSP3IKd6g5
         OyhF0afs+Q+4tufAkbjyjg69EJsTshn6Z8OHcKEI8V+H057IOoF7+RdMqFjSAXXEnF6I
         9QNg==
X-Forwarded-Encrypted: i=1; AJvYcCUHJuSnnE/LXI2mTB+SimsehuoEIgkJMlOFkwzndlmq0/JjoshtR5133jDqGUHWbDVTrgyzG546wcVNckQN/Hd/8nBEkgzEKxY8SPfE
X-Gm-Message-State: AOJu0YwfJaXKj8XFDtlRJjT/BpRqJwATiZmDMSCisKQDOqhBZMYMvCFJ
	KtA2eRPfaMQhTZ7va2tNc6sr2ZxdoQqsfA1e7kVr9Dytbx5wtVHkFMpG7kt0o7NGTg7MZY2Fab8
	ezw==
X-Google-Smtp-Source: AGHT+IE54zpvNYRIpauQx2fUW2c4J1ybAMAV0sQcl0g+l007AvifWUKHU2UqnMcCve5fnXfoOaV5cigMM/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c406:b0:1fd:9d0c:999e with SMTP id
 d9443c01a7336-201ca19e6e6mr690325ad.9.1723507181791; Mon, 12 Aug 2024
 16:59:41 -0700 (PDT)
Date: Mon, 12 Aug 2024 16:59:40 -0700
In-Reply-To: <35624750846f564e6789c22801300a542cafa7fb.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx> <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87o76c2hw2.ffs@tglx> <30eb7680b3c7ae5370dfbf7510e664181f38b80e.camel@infradead.org>
 <ZqzzVRQYCmUwD0OL@google.com> <35624750846f564e6789c22801300a542cafa7fb.camel@infradead.org>
Message-ID: <Zrqh7GlPMRVOVtvY@google.com>
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in shutdown
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Michael Kelley <mhklinux@outlook.com>, 
	"lirongqing@baidu.com" <lirongqing@baidu.com>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024, David Woodhouse wrote:
> On Fri, 2024-08-02 at 07:55 -0700, Sean Christopherson wrote:
> > On Fri, Aug 02, 2024, David Woodhouse wrote:
> > > On Thu, 2024-08-01 at 20:54 +0200, Thomas Gleixner wrote:
> > > > On Thu, Aug 01 2024 at 16:14, Michael Kelley wrote:
> > > > > I don't have a convenient way to test my sequence on KVM.
> > > >=20
> > > > But still fails in KVM
> > >=20
> > > By KVM you mean the in-kernel one that we want to kill because everyo=
ne
> > > should be using userspace IRQ chips these days?
> >=20
> > What exactly do you want to kill?=C2=A0 In-kernel local APIC obviously =
needs to stay
> > for APICv/AVIC.
>=20
> The legacy PIT, PIC and I/O APIC.
>=20
> > And IMO, encouraging userspace I/O APIC emulation is a net negative for=
 KVM and
> > the community as a whole, as the number of VMMs in use these days resul=
ts in a
> > decent amount of duplicated work in userspace VMMs, especially when acc=
ounting
> > for hardware and software quirks.
>=20
> I don't particularly care, but I thought the general trend was towards
> split irqchip mode, with the local APIC in-kernel but i8259 PIC and I/O
> APIC (and the i8254 PIT, which was the topic of this discussion) being
> done in userspace.

Yeah, that's where most everyone is headed, if not already there.  Letting =
the
I/O APIC live in userspace is probably the right direction long term, I jus=
t don't
love that every VMM seems to have it's own slightly different version.  But=
 I think
the answer to that is to build a library for (legacy?) device emulation so =
that
VMMs can link to an implementation instead of copy+pasting from somwhere el=
se and
inevitably ending up with code that's frozen in time.

