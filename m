Return-Path: <linux-hyperv+bounces-8138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B592CF2A06
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 10:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0882302CABB
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 09:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C6C329C7C;
	Mon,  5 Jan 2026 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWeDhtjU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceAPleqL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AD32939C
	for <linux-hyperv@vger.kernel.org>; Mon,  5 Jan 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603614; cv=none; b=Vk3aDGGj1izWhNTj9YPSXI4mkzhKXTFbvLAvZepE/G67Od4gy4oZalBqbdlTXE7Q1qfJzRYVQVQYUe6FN2WR+KgVjKfpFAyF+ekjWO46hoeo4yzqsLfZD9RLaWQiJqCm3dfjjWid3tyFezUIyx0YmobsKTw1X03wX2jf2x+e2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603614; c=relaxed/simple;
	bh=ajQxi6UwJp3C/EKgUIeE0e0aBYbCLoFLV3jCXPnSzV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tfx2mC7cgPDcYoJ26y+SAQuUlJgHQNc2XUcTqHJWgD0bAJH3O4kpRmH2/RsYdmtupRFu8jP+t5LZl0ZcrYTJUNOvlJplAWjQgbFnPxJf2+27Bhcwr7uMwNBD0UMAPm25qPwyOXyEedjat9Aip/hdd9ylq6tYFGCHon3nfr/PIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWeDhtjU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ceAPleqL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767603610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmolwYpg0GTIXzwxeSlS9Zjh3lPmDzNI91+vRS/C+K4=;
	b=hWeDhtjUTSJkam388dRAeOFixMFTA1kbRZWJWT+iDmxKJ4u5bh4bPh2R8bvSZDNmo4db0h
	z2Xa/KFXs12EitMyilOEdu9pcpWEi4z7IxgCMAoqUddH+bAZ8cdbu+smjxbw9tYCARreD9
	llxpy6km8qe00TnGNDuOSxHsCo9Loww=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516--EtkiyyxMBO3xYCXlTf_tQ-1; Mon, 05 Jan 2026 04:00:09 -0500
X-MC-Unique: -EtkiyyxMBO3xYCXlTf_tQ-1
X-Mimecast-MFC-AGG-ID: -EtkiyyxMBO3xYCXlTf_tQ_1767603608
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso184922955e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jan 2026 01:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767603608; x=1768208408; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QmolwYpg0GTIXzwxeSlS9Zjh3lPmDzNI91+vRS/C+K4=;
        b=ceAPleqLe38iHJ4VJ+fb9d/bUE/ldaRZ5WSAGTczgCh4r9WOpzMMtgTu1iZYzz5Tc3
         A9G7yV1THa9coxmq8nrnShEcIYvO8hshIPCbdrBBJ5/AQJJk+fCDqt0rZcpLFj+1RZUS
         47rD4ep2VKfFZB9IgaUB5MaAnHq1UxtGH7pmL/sMSI2VDjp73DhiZQ52koyVsg30EjZv
         iAnVmsiETv3klxh+LQXLcmXWY5RMKLOoMCtDcWE6lL6/SjE6Ve9Cy8Y33qjGbI8Y92Mv
         UHMbXz6pt44qkASLSr/qlNbYj8QIRRqi35Exs2ieeB4rEYZpwDOnrHLIetVXUv42PvRe
         Y5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767603608; x=1768208408;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmolwYpg0GTIXzwxeSlS9Zjh3lPmDzNI91+vRS/C+K4=;
        b=EqIY/dJbt3YBkBGN/bmN+Vsnp5+5ZZmc8NibKWzJrXvMgtLtz5iybZX/W/dfFJ6uEk
         HTCkRhSsy7dZ4Jkh/vDEnVRPfnRAjg4maxsIJWWFtSY7iYHj1dUE2gHso0mJeeaCidoy
         Qbg6CqWRDL5sk9geMn6ouYleys8v77oBCt2PVG1cate+NnWVW12uo8FLmpJVoMQN3plY
         B5mnTTUa1akV6qzewONlQh2X34bX/5qWD4hFZx43CQedI5XqI2FNTHHwQTiD6hTDbr5v
         hvFfdGlHmkiXByQfkjXXWvlTjVoRmxukhA/2q6F90Wu6EhC0HoRiAt7C1n21hYBidy53
         CIvw==
X-Forwarded-Encrypted: i=1; AJvYcCWmD7v6Tvth5Gc2C8Dd/tFJS5+vnFg6OCaAPXs204eMpJOheYFiCc4WTXgFlrf/h8G06+7cCyDVUPR1dU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWCd8kcXdVjLbIqANECdskHW1yAR1acB6KdzdKjEt7SE/HQDKO
	xiDc6tfpu6mtv0Cq+WpbSiTYusUDSXurbS0M+gtV1yrGWzTggMAIYmJEJ10qIgzvaY6RSwbyMm7
	dEL8wCyG1hqSkr2ltfuv2t5iEypqasdMkVmKSDRZIaoNRdSNubIpYe6D9IQRWiL6wpQ==
X-Gm-Gg: AY/fxX45F4IQbXqhvgKcz1Xny34XMETG+VKhNtlCKVx5ZWmzTYFpmtkG+My6GbMJ4Zh
	TlKkkTotPLsM0nvxh3O9gSh15mfuT43rbqEpCRkFWltX6/HboxhzzO6enBn++Dy7+o7NRNNg9Cd
	qC0dvR3LgJPBZiVf8gkq1pBVnJukMS2q6v9j7VCc9n5pDZI707isj/CSKbwNd3WMvZj3fij0p7e
	QgytA70Y5Syzhe52B00k9bq8DE9JrtUElS38n2l+fRlCfo5d0bgtZprKuFBsDwcdBaTo3N4JGt8
	sOM+mH+3CkGDW1t1jOdmyH5XWEIIwVEH/WqqyhCZGawoppnEM+tA9FU8fHMwIVqYCwA96dWlUJS
	MLxHU/g==
X-Received: by 2002:a05:600c:3555:b0:47d:649b:5c48 with SMTP id 5b1f17b1804b1-47d649b5d5bmr187270395e9.36.1767603607361;
        Mon, 05 Jan 2026 01:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZIR4puYONtUAS5jkDiNPmcRew+6uEAxQeWfERZZ03vpK8NK5h9FGygT/q4u7IkopnNbAs0A==
X-Received: by 2002:a05:600c:3555:b0:47d:649b:5c48 with SMTP id 5b1f17b1804b1-47d649b5d5bmr187269565e9.36.1767603606633;
        Mon, 05 Jan 2026 01:00:06 -0800 (PST)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2c4fsm99649717f8f.42.2026.01.05.01.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:00:06 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, Mukesh Rathor
 <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
 <longli@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [RFC][PATCH v0] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
In-Reply-To: <SN6PR02MB41575124C6D2CD7492899991D4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251231012100.681060-1-mrathor@linux.microsoft.com>
 <877bu0au1t.fsf@redhat.com>
 <SN6PR02MB41575124C6D2CD7492899991D4BBA@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Mon, 05 Jan 2026 10:00:05 +0100
Message-ID: <874ip0bfje.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michael Kelley <mhklinux@outlook.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Friday, January 2, 2026 7:55 AM
>> 
>> Mukesh Rathor <mrathor@linux.microsoft.com> writes:
>> 
>> > MSVC compiler used to compile the Microsoft Hyper-V hypervisor currently,
>> > has an assert intrinsic that uses interrupt vector 0x29 to create an
>> > exception. This will cause hypervisor to then crash and collect core. As
>> > such, if this interrupt number is assigned to a device by linux and the
>> > device generates it, hypervisor will crash. There are two other such
>> > vectors hard coded in the hypervisor, 0x2C and 0x2D.
>> >
>> > Fortunately, the three vectors are part of the kernel driver space, and
>> > that makes it feasible to reserve them early so they are not assigned
>> > later.
>> >
>> > Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> > ---
>> >  arch/x86/kernel/cpu/mshyperv.c | 22 ++++++++++++++++++++++
>> >  1 file changed, 22 insertions(+)
>> >
>> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> > index 579fb2c64cfd..19d41f7434df 100644
>> > --- a/arch/x86/kernel/cpu/mshyperv.c
>> > +++ b/arch/x86/kernel/cpu/mshyperv.c
>> > @@ -478,6 +478,25 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>> >  }
>> >  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>> >
>> > +/*
>> > + * Reserve vectors hard coded in the hypervisor. If used outside, the hypervisor
>> > + * will crash or hang or break into debugger.
>> > + */
>> > +static void hv_reserve_irq_vectors(void)
>> > +{
>> > +	#define HYPERV_DBG_FASTFAIL_VECTOR	0x29
>> > +	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
>> > +	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
>> > +
>> > +	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
>> > +	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
>> > +	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
>> > +		BUG();
>> 
>> Would it be less hackish to use sysvec_install() with a dummy handler
>> for all three vectors instead?
>
> It would be, but unfortunately, it doesn't work. sysvec_install() requires
> that the vector be >= FIRST_SYSTEM_VECTOR, and these vectors are not.
>

True; then maybe introduce a new API like sysvec_reserve() without the
limitation? What I'm personally afraid of is that looking at
sysvec_install() it already has an additional fred_install_sysvec()
which operates over its own sysvec_table and only does
idt_install_sysvec() when !cpu_feature_enabled(X86_FEATURE_FRED) -- and
this patch just plays with system_vectors directly. Maybe this is even
correct for now but I believe can be fragile in the future.

Ultimately, I think it's up to x86 maintainers to say whether they think
that playing with system_vectors outside of the core is OK and expected
or if a new, explicit API is preferable.

-- 
Vitaly


