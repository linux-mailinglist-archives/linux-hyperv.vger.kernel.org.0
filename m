Return-Path: <linux-hyperv+bounces-5412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA70AAE674
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3707502A78
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F0E28C017;
	Wed,  7 May 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHBFoFRA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC43289E3D;
	Wed,  7 May 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634597; cv=none; b=Hzp3E0PKS5i/Fz6b7A+Ww6BBc7z+O14jRM9sPaIUVFIwAcqbHqK/481EwQalaLEurKhpTVQNHu2M6Jy+wA4tkJN3xZChwQMyabT0wtuHgrzAB6RmTptwa5Hq27CspNiZRO5EWAYFFNyf7O+nvd3pkzuU00V2cRTYKPjkbZeGUXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634597; c=relaxed/simple;
	bh=Gtl8PbEyhoKv1YG3WJ45EifWQqMO/IqX3r93tm1T2yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VppL0avb0fjLm/b5m+tPCEMQsRvAhRTExbltMgaPjOSqqMd2TRZ8BHmKTw+db8Xszfz6w/4ple38aZtb4ivQE0e6mAxGSNKMG5Y8UschwP6gLIj67ME3lZLKJv7xF2SD55kpw2zRp8I1RCqrtZ/c4mvkrLEB+VnoMVlUPn9JUkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHBFoFRA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af5085f7861so4927038a12.3;
        Wed, 07 May 2025 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746634595; x=1747239395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j17lkgZ0i5giGTN1M4ncMFFUQ17d9DULg0i12XyB+2I=;
        b=EHBFoFRArV/2TN+YEz0ZpEc/a9dBbRKxtDGJnGljIMa2+u87FoLBNILrKNTQfo8x5b
         v2KAbTokUi6Tcau4LEeeskb3MlNgqOYsJXyYEAgoJwHo9YMZWcCvnoTMEhvWjT+NC1Np
         MlFh0FEywDPbFvEpvb73qjIvBo1jP5Pn/H49f1Xg61svIy8pBEyTzxXWCTEe7NUF0qIi
         F0szm4fdnBuLJ4vOWA2uO1F35Y6foFll6s94ZhBcihEwDAgLNEmumfzoYrD2+GZ+pI1d
         AmmY5cUfGWFScW0dnjAu9donIIGKPO1L9ioTTWHWQLGJv3HDMqanL831Z7h6ga73n4Pu
         HHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634595; x=1747239395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j17lkgZ0i5giGTN1M4ncMFFUQ17d9DULg0i12XyB+2I=;
        b=EcbHWh821EN3/1uXI1HS7cj9boqKmRJMGQowA3TCYyAjwJkV2rduEvwtAG0CAWpHe1
         ylL5iMaaXCZtK6MlDU6XKLAwqpRZQF8/KoRIrsr8U3Yl58bxKImfOudgJu3Y31NPJiiO
         xsr8ubK6vu6Wu3DIyQ7bXfCAGlTtXCRBcKDvufa6mEKOG3Vmboc8WwSDkJXeUiSjNMdu
         eZ7laOvJApIXc4Zm+RuMK8VBWctOJljLf3qt+aUdGXdBDeZEw0HuazrOinu1fBggNV2N
         uWZHENz8Wt2zxoutiZmZHJnKMfhUu9JdhxByCNPaiNZ77opoKjFVn1ZaMZS7PXtn/1z5
         f08Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgryot/UcTuKihvNUBLBFArgnOwxuncinZlEnVNtfVtwqQJSAaB8gT8QUVTNY9fCArRUVx5ipZf5CrrOY=@vger.kernel.org, AJvYcCW8tADdJhqJIBla4SP0mBUrl00BEof3UYUwEIkEp3v7JG3xszQZPeQiPIFrnygTHhFSw/v8Kns4KT6oHFx+@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVNaVg9WLa6WLQqfEyaBCHEXM4HIy6IBQXE23AdN30c+AiGNO
	0Jk2rJkViX1bnE1dvTuJqedS7L1vm+Mp1f9DFAWDQCE9TVexvI7e3XKJylb8c578uPsagGBM6Dr
	RTemuptvKiH3pTsuXaFMQF7FaO7w=
X-Gm-Gg: ASbGncsWy4vDI3G8rgmvp99+AZF1eQFuZWKuL9yyVPkQ7nglpntMcRovMQ3MIGGcPY5
	1i+UyNQcC58uKNWUhnEDeZHJeNhZsYf71EZilZGoby668+RaqjbtXyr3j38IJVrq6DrUIf9VPQ2
	GVG/rqjDblQrVIUR5Ig4CG+Eu+P40G+RTitnFV4uCg
X-Google-Smtp-Source: AGHT+IGTIe9uRy0Xzu8B1msEpH8qSQPQsCucO/QI/s81DF9hHniR2AanraWlOZQoeKS9/RQTP4kEywjkXFLI4Bv3yQc=
X-Received: by 2002:a17:90b:4fc9:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-30aac21f5b9mr5317880a91.26.1746634595574; Wed, 07 May 2025
 09:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506130712.156583-1-ltykernel@gmail.com> <20250506130712.156583-3-ltykernel@gmail.com>
 <52e41530-f93a-4fed-8229-ead4e806a5ec@amd.com>
In-Reply-To: <52e41530-f93a-4fed-8229-ead4e806a5ec@amd.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 8 May 2025 00:15:57 +0800
X-Gm-Features: ATxdqUGTLSKRd7rVX2-xM0T4obKEbuDayq_eRlveI-qo5JQvKRLHFod4e9X0Zx4
Message-ID: <CAMvTesDWCbg8=YOpc_8CQW_ufhat2uQ1J+Ar-HoB39Sa29A9PA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] x86/x2apic-savic: Expose x2apic_savic_update_vector()
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	yuehaibing@huawei.com, kvijayab@amd.com, jacob.jun.pan@linux.intel.com, 
	jpoimboe@kernel.org, tiala@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 11:57=E2=80=AFAM Neeraj Upadhyay <Neeraj.Upadhyay@am=
d.com> wrote:
>
>
>
> On 5/6/2025 6:37 PM, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> >
> > Expose x2apic_savic_update_vector() and device driver
> > arch code may update AVIC backing page to allow Hyper-V
> > inject associated vector.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
>
> I think this new interface is not required. Device driver arch code can c=
all
> apic_update_vector() to invoke APIC driver's update_vector() callback.
> Or is it that I am missing something? So, can you explain why this new in=
terface
> is needed?

Hi Neeraj:
       Thank you for your review. Agree. apic_update_vector() should be eno=
ugh.
Will update.

Thanks.

