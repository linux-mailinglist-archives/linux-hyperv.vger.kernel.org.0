Return-Path: <linux-hyperv+bounces-7518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C56C51368
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 09:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81361886D8C
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF02EE5FE;
	Wed, 12 Nov 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB9P5i6n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAQl8mqL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC822F2915
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937669; cv=none; b=XfMqio8fMGa+GlX/0H5h5OLrclesvbv1yWVfnKqVWYTSiSkNaOCgbYw0EIQsFyIEZq9tzlpgkpiN3bTVSflgoZwZAp5ntwnoy+BdWWqmS3l8zGvSCZc2x8Xg7vEvKEQzyBZieqIJwndBtD+kN1+jExzBgsju+b6a+mXftI+Z8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937669; c=relaxed/simple;
	bh=v38kEjuvcFgheQ99mZl3IS+J1wdYEbfdxCzmk9AFFck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+rZqx0mczt3Ii8vta7MAVbGluifRK87/7H4F2LV6X55lSDUZPAMpiRESF/XrpYfUfBn4yp2mh2iymMAk1tgeOHX90yr5rRi5P+dHEL0E+L9XhDNPsnPTMFe/04GAFbEWGP8ZyxrZYo1Q5uK16nJYze76Oa+7DD381h0z/Rl01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB9P5i6n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAQl8mqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762937667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhdcYap3SM+S5dOmiD2FLYCC8vjhARcXiqb+7x/90VA=;
	b=VB9P5i6nALpQBNMsraT2geFAM0LWhkvShaj02JUfWgR5PnRCBN+VwhR8m8ao8SDctrOQ1+
	l/sx7/9bjzQ/Z4zfXPWdKvRBZMlIU5lGIzplebfQiTX98X31q5wIPs3CqsXP0poIWNthz9
	c9dVWtcHEE9lR+3ujJnXrRqxZJJuxJ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-XcucOD39MZKsblegk3JeZg-1; Wed, 12 Nov 2025 03:54:25 -0500
X-MC-Unique: XcucOD39MZKsblegk3JeZg-1
X-Mimecast-MFC-AGG-ID: XcucOD39MZKsblegk3JeZg_1762937664
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so260995f8f.3
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762937664; x=1763542464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhdcYap3SM+S5dOmiD2FLYCC8vjhARcXiqb+7x/90VA=;
        b=iAQl8mqLQBsd/e779Q+yks8SzKBbyDpWkQYt8SEutnFhWM7OH2CUrbLTktgoi91hY1
         Wom1qLZ2WLWHEo03XRlqhFNPpVsUyi+7JVNU8NaNw/+mFBQ6kb74Vm+V79chyySPrVcC
         +9GAShlcpMRNDuoWK4QinFBBLTvRIbBYXMXH1AmHqYK0anImnDuJw1cJ63YdC7pnzkAl
         LXTGQ14ekvZk4I9PZnwxmiF25wSGrdlZrU5H8AsONg7jewFIEZRbw+y3g9vV/T1LEhNL
         uZ4VgBLwtECRUn0mfTHBJlEFnS5+yO2cONGQ53Sf7V03MQBjM+xNCs+6j9ONZR7KLD5w
         kY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937664; x=1763542464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhdcYap3SM+S5dOmiD2FLYCC8vjhARcXiqb+7x/90VA=;
        b=YEm4lVOalvgAAVpCeskE2J5W+y0CL7Kv64ZVeaRo82s2Yys4D8BT3meQPWgPSUlolO
         3ibsgasmDfIXndm5fhxDlHb9L5ttvqHyD8LJkS3Xm0aAYLBYn6EOCX4B1tSXRh+EWAH/
         kk8bBYl14ZBPG453RA81BO74y/kSV2YjKXXIBNE0Yvbs73VYDhuk8J80ip9NE61s5BU0
         NREEWuXtPwM9aU7rqaapo6Y/zPFg24QGVIfHmnchRo0mMtzimd0fMp5ajtcyOseLATnF
         hPJAoyMoWONYA+0Dd2thE1qaQx88ew48KvjzyursFSE5OHyc3f3Hu60k41P07eDuGTEK
         Tesw==
X-Forwarded-Encrypted: i=1; AJvYcCV/rEBA60I65hFEcByFO3Gf31XLtKMCLIiu++NtEnELYjRLw3QntSw10u3wPOSJ7rEicurnAJF7xHNvQUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4NheAkUspuebEHR+mtrKITOFGahAm6l1IwAHTzTyzMviUzOh
	FrC4RedCCdC31Ee4bKWjX1PdN/7vEugsG9c2OCkhg5wTuFYRRro/9E/etXljYvOvLHR507f3aPa
	WN+TgRK0dWomyHbCYC9egKay3QYh8hYpolfV1/cAz6ZRJejP03bFSosKJveasbNHEGYFgXMQgaZ
	PmoQOHGdDmKJFhbS9spqFM9tyQ/W6c0ddDG6xYJ+yi
X-Gm-Gg: ASbGnctFQEjQdlUvg62JPTXTlDvbsqEQwCoan/ZBq7A1k7xzf00+4JRroRC8bRhb4kV
	AnE2lZp8eADpj1G1NBGvXH6ceJ/S1McypBsCWnG0Y2wFWhiIeGEZJVvV+USpkfYLL7/hyiwyitd
	8/w/RwS/x+ALMLDwqeky6az2D6GkoDkL/wgZHn7NEvNd3578TmT1K2jsVcGwHhkhLBJmwApBRUJ
	vbFCOxCKa1STkhhLHCO8uViJXC7l2a4Jc9YnUBDnKgY5Qz2O8mOvybegrnTpQ==
X-Received: by 2002:a05:6000:2509:b0:42b:496e:517c with SMTP id ffacd0b85a97d-42b4bb8b30amr1769389f8f.13.1762937664153;
        Wed, 12 Nov 2025 00:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5HytOk020zd6ytbKUrg7KNXg5lABAprL5NDx0eEspz2lKER1LucpgvormZhbxSAhpxmVsf111duOtSAVjnFI=
X-Received: by 2002:a05:6000:2509:b0:42b:496e:517c with SMTP id
 ffacd0b85a97d-42b4bb8b30amr1769371f8f.13.1762937663794; Wed, 12 Nov 2025
 00:54:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com> <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net> <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Nov 2025 09:54:12 +0100
X-Gm-Features: AWmQ_bk4MkmpxDnQL63Mwoi6uHLO0j8XzL8o1Vqxo1_9pTEPZ48l39f_GOUPifM
Message-ID: <CABgObfa7eZXs75F3F9ycyip_LHMYq3=VZHhuar76Bji1OOBXHQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Michael Kelley <mhklinux@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Naman Jain <namjain@linux.microsoft.com>, 
	Sean Christopherson <seanjc@google.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Christoph Hellwig <hch@infradead.org>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:12=E2=80=AFAM Michael Kelley <mhklinux@outlook.co=
m> wrote:
> > +     .section        .discard.addressable,"aw"
> > +     .align 8
> > +     .type   __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercal=
l_662.0, @object
> > +     .size   __UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercal=
l_662.0, 8
> > +__UNIQUE_ID_addressable___SCK____mshv_vtl_return_hypercall_662.0:
> > +     .quad   __SCK____mshv_vtl_return_hypercall
>
> This is pretty yucky itself. Why is it better than calling out to a C fun=
ction?
> Is it because in spite of the annotations, there's no guarantee the C
> compiler won't generate some code that messes up a register value? Or is
> there some other reason?
>
> Does the magic "_662.0" have any significance?  Or is it just some
> uniqueness salt on the symbol name?

It's just a counter coming from include/linux/compiler.h:

#define __UNIQUE_ID(prefix) \
        __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)

#define ___ADDRESSABLE(sym, __attrs) \
        static void * __used __attrs \
        __UNIQUE_ID(__PASTE(__addressable_,sym)) =3D (void *)(uintptr_t)&sy=
m;

#define __ADDRESSABLE(sym) \
        ___ADDRESSABLE(sym, __section(".discard.addressable"))

You can replace the whole ugly symbol with just something like
__dummy_SCK____mshv_vtl_return_hypercall if you prefer.

Paolo


Paolo


