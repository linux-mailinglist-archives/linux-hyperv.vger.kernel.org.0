Return-Path: <linux-hyperv+bounces-7102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABDCBBDD93
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Oct 2025 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46D0F4E051F
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Oct 2025 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2C265CCD;
	Mon,  6 Oct 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCIj/JQy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C59233155
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Oct 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749599; cv=none; b=pzpLm7zl6fSrZMnXMr1EiZW/tmSsgNBEzs0mYHYXrbBkCxGb3XM5w6sp8L3PAnCbT74r0+PD1Rt5CwSaX7OZgMRDIzfl9AXi65E5+sysvWxRSQjC4i+B9+gurUP7k6cuuSdgfgHCpNLz/PzOQbK28mlXj82LxIypU4DViOZOLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749599; c=relaxed/simple;
	bh=e9xb/cs1uM/HOBk0nUjXpMXhvzMw2StHNqtblnVPXNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYtYEiorbKAxuMhhTo7ODIy4iZo4i5Q2BMsSDJTSUuKHd6X0Jovvd9Sjuxu3PCYh5XUGkDmyliXNvdMHkSC39NKk3uQCSnSfHl+c7h4V3Gsiaz+oIt5sPTL2s/Ld4Fqjoem540Xp1QlvhnOicc3/egm0QLN08Z4UPi7ljdcYwbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCIj/JQy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759749596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9xb/cs1uM/HOBk0nUjXpMXhvzMw2StHNqtblnVPXNE=;
	b=SCIj/JQy8l+2mKabwtN3KV4SH+60VAE846oSPb9w4UxAOLfsT/NdQNRSiAcwj/2RE/JpoW
	16lK0d9ysxT4MvWKP6/6cK3NU/tD0qWgh12F5T4bwOitruGpDiQRHYHn+EkfSuIcT6SqKQ
	0OYjIwT2Yn+VJS/XxtYciHgKZy/wkSM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-otKonN6IN4KT_UfA1xTVhg-1; Mon, 06 Oct 2025 07:19:55 -0400
X-MC-Unique: otKonN6IN4KT_UfA1xTVhg-1
X-Mimecast-MFC-AGG-ID: otKonN6IN4KT_UfA1xTVhg_1759749594
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e4cc8ed76so19547795e9.1
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Oct 2025 04:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759749594; x=1760354394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9xb/cs1uM/HOBk0nUjXpMXhvzMw2StHNqtblnVPXNE=;
        b=o0Ecw3XaLtG6TOrExv4Bdq5n7xSdSnG5MEyZGoSEIpwr1u+8xjyHWAITueZcnm0MTv
         24lBe9HWIiZqksOEZaA3sBJjQexqOuBHrU9aquFKuyRcTjHFiOQE+bARg/1fHVDXGnOs
         /YgoPEupAIneP21a1faTJLS6xQmcFaYgzHT0VkbrisBr7USFjK2WJV4q1+X8aTCOa3iI
         IK9nTrgJH9mX+aFXUlAGl6INlaEfHZh2oIUq1LWE1ujVOcq/Y1MjOuW0dQVaV7lp/DU1
         vXnzEwxU3TyT+3yF1Pe7KJFQ1OWKTXTEPoTz4kZvz2Vnsn2++YIaoWvJUMnQq/h+hEzW
         BNHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsKBb1/1a48XJhrAyxo9aqoNa6wDrtmQfbnLB6YizmU+tX423El+wXqURKXidNMfuyhfKzPtdBjCe4dt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz355/+EnlDRohuCQMMmBIIT0aGdvn9qpVwF7g1ED1JT3AdEk0
	sufiqibomHH/V4xI8zEGKGhJ6qNhoFyjJARowV3nIZNMbpJqDgZxfldyAPBrwx1DgjWU5Mh9BpK
	yxRSKmVYbxIowF5XrAV4s5JENHxlvuT6PamCXcV+Xz4FrrGG3e2dPu6daTVZ3LJppgLodT/PSLe
	vcCj/ZCiap4U8pUEcSesId4qkiAYWyLZIkL8wHiozJ
X-Gm-Gg: ASbGncsKnNVKuLWpXH5WWBWpGYyjS0ohXmwpp8SU39STWemXi9elb9cX/BXuk4Jq/wP
	q83uFEwAtdMyB5WAjBuySXil0V7THyNbtHnmqQrOrn7EBWsSRgIPCvtMAM4GFZe5Rp688QRlIpk
	KY+ua7YDw8S5mnbxd9hUgtc8E6Rf7pXsqOgqScpHKrUrsvql28mLgQQehMb6BMLcQCJNdOhrn18
	8ztopshc37GXhcHr8fvdIZPfYO2sw==
X-Received: by 2002:a05:600c:8b71:b0:46e:36fa:6b40 with SMTP id 5b1f17b1804b1-46e7113d33fmr83447105e9.24.1759749594128;
        Mon, 06 Oct 2025 04:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbqtbJYLR8ceIMKOZchD2SlRztTVxtYv5IyEe2m+2UvRLBKG5/dghTnVx3dy0HWe/rMdYCxUmq/ncf+PqEp0I=
X-Received: by 2002:a05:600c:8b71:b0:46e:36fa:6b40 with SMTP id
 5b1f17b1804b1-46e7113d33fmr83446915e9.24.1759749593741; Mon, 06 Oct 2025
 04:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
 <20250825094247.GU3245006@noisy.programming.kicks-ass.net>
 <f154d997-f7a6-4379-b7e8-ac4ba990425c@linux.microsoft.com>
 <20250826120752.GW4067720@noisy.programming.kicks-ass.net>
 <efc06827-e938-42b5-bb45-705b880d11d9@linux.microsoft.com>
 <27e50bb7-7f0e-48fb-bdbc-6c6d606e7113@redhat.com> <aMl5ulY1K7cKcMfo@google.com>
 <56521d85-1da5-4d25-b100-7dbe62e34d1d@linux.microsoft.com>
 <20250918064713.GW3419281@noisy.programming.kicks-ass.net>
 <9f8007a3-f810-4b60-8942-e721cd6a32c4@linux.microsoft.com> <20251006111030.GU3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251006111030.GU3245006@noisy.programming.kicks-ass.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 6 Oct 2025 13:19:39 +0200
X-Gm-Features: AS18NWCFaGLcZ1HmHv7CYb10Vst98efNPIQgk39cycZ73lZFzqBywBB7HWghsd4
Message-ID: <CABgObfZFgHY_ybfSnyzEF1dFr5c1s=_r+tAnHa6Q7rzFUUdt3g@mail.gmail.com>
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
To: Peter Zijlstra <peterz@infradead.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, Sean Christopherson <seanjc@google.com>, 
	Roman Kisel <romank@linux.microsoft.com>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhklinux@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:10=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Oct 06, 2025 at 04:20:03PM +0530, Naman Jain wrote:
>
> > I am facing issues in this approach, after moving the assembly code to =
a
> > separate file, using static calls, and making it noinstr.
> >
> > We need to make a call to STATIC_CALL_TRAMP_STR(hv_hypercall_pg + offse=
t) in
> > the assembly code. This offset is populated at run time in the driver, =
so I
> > have to pass this offset to the assembly function via function paramete=
rs or
> > a shared variable. This leaves noinstr section and results in below war=
ning:
> >
> > [1]: vmlinux.o: warning: objtool: __mshv_vtl_return_call+0x4f: call to
> > mshv_vtl_call_addr() leaves .noinstr.text section
> >
> >
> > To fix this, one of the ways was to avoid making indirect calls. So I u=
sed
> > EXPORT_STATIC_CALL to export the static call *trampoline and key* for t=
he
> > static call we created in C driver. Then I figured, we could simply cal=
l
> > __SCT__<static_callname> in assembly code and it should work fine. But =
then
> > it leads to this error in objtool.
>
> Easiest solution is to create a second static_call and have
> hv_set_hypercall_pg() set that to +offset.

Yes, my idea was to add +offset directly in the static_call_update, as
you sketched below. Sorry if that wasn't too clear. I didn't think of
using a static call also for the base of the page, since that's not
what the assembly code needs.

And I think we agree that you absolutely don't want indirect calls, as
that makes register usage much simpler. This way static calls end up
killing multiple birds with a stone.

> Also, what's actually in that hypercall page that is so magical and
> can't just be an ALTERNATIVE() ?

Do you mean an alternative for VMCALL vs. VMMCALL? If so, that's just
not guaranteed to work: "An attempt to invoke a hypercall by any other
means (for example, copying the code from the hypercall code page to
an alternate location and executing it from there) might result in an
undefined operation (#UD) exception" (or it might not).

Paolo


