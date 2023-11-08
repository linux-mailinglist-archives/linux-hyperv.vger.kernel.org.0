Return-Path: <linux-hyperv+bounces-785-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A47E5D12
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 19:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F391F21E32
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Nov 2023 18:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE9536B0A;
	Wed,  8 Nov 2023 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uidFvFLQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBB36AE5
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 18:19:56 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B425C1FF5
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Nov 2023 10:19:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so663a12.1
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Nov 2023 10:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699467594; x=1700072394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPzDJOHXaMQ7hDr4fQaud0AOapaYXuR24Rsqmx39kT4=;
        b=uidFvFLQKH6OQ+EuPzqiej4boBUNsl2clO/meRsB93hUfbpqTXkLPf3FjPx3FoWbpQ
         HylpPoRgBKzhjL9TF1QKNpD3q8cYuahE/2S/7OLexwPuGuMks1mJEZlcOiAaeqfpXTKc
         JEljQO4zn3svcbWtV/y4GjmW6i7fiorUUyS4eYqVHbeGjBeCDxDquxoYIMjCxlmnp6ol
         jXMq1asrezkCwEfMIDUWRdpf3v5iiQkyHlueDWN3f65NnD84DUHi1guTYV4IhHpvOhQ2
         J9IqyBdUOZC5iZbs5MH+7UTLgGe9g0AfIiaCbUEijU+oajsCAWjuQvuso3Z4rvXaS/CZ
         4PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467594; x=1700072394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPzDJOHXaMQ7hDr4fQaud0AOapaYXuR24Rsqmx39kT4=;
        b=UWWFLG+OCyEJbIvESIyGXrpsOQWMwcV9cwk62IHvn4xYOpGYeHkKwgMVIRJ/m2KqH4
         thly/6PkMgXpdZeIj3whcZIX4sWTEcjqb/0FN4MzDy8UgybxkFdv+S6w0Uum+R1hYsCt
         weZ9GWcunZm+7DAeuqJOfkgGSG+kQyGwLq3+J9C5N/pfsVuqEfw4kVXSM3ECj4R8xzGd
         Noxk232UeY/q2JkEO1T6UzcA2Ny006s0vYoMPVm5LsucQna+t/OQqAcjHT8gdmvnAGIl
         jA5KoG8A63dxSMwqkEwRyQxXltoYHPv1KZbXUTyV/PCbfj2phh7Y/9s4clkX87jf1Tcl
         TQBg==
X-Gm-Message-State: AOJu0Yy0Oo0XIK/PSHDQELGQZUhMttVMJd0Tj9x8U4Y924mfLAUdjK3X
	1Kk/5JzX2Efuia6x0t84ExwyQwo8RRtQ2pGfCBYfIQ==
X-Google-Smtp-Source: AGHT+IHSTdnHpU+tkokUoN2IxJr6aTuVShMIUkzmKD2yI2R4C/2lgCPoCvm1H+r3Y/W0c7msPJZNhRs4cza7jp5Alq8=
X-Received: by 2002:aa7:d34a:0:b0:543:fb17:1a8 with SMTP id
 m10-20020aa7d34a000000b00543fb1701a8mr11251edr.3.1699467594084; Wed, 08 Nov
 2023 10:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-30-nsaenz@amazon.com>
 <ZUvDZUbUR4s_9VNG@google.com> <c867cd1f-9060-4db9-8a00-4b513f32c2b7@amazon.com>
In-Reply-To: <c867cd1f-9060-4db9-8a00-4b513f32c2b7@amazon.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 8 Nov 2023 10:19:39 -0800
Message-ID: <CALMp9eTmAR_yMMxujiMDQ6_VpUF3ghoKAdy_SYvu-QOAThntZA@mail.gmail.com>
Subject: Re: [RFC 29/33] KVM: VMX: Save instruction length on EPT violation
To: Alexander Graf <graf@amazon.com>
Cc: Sean Christopherson <seanjc@google.com>, Nicolas Saenz Julienne <nsaenz@amazon.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	pbonzini@redhat.com, vkuznets@redhat.com, anelkz@amazon.com, 
	dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net, kys@microsoft.com, 
	haiyangz@microsoft.com, decui@microsoft.com, x86@kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 9:27=E2=80=AFAM Alexander Graf <graf@amazon.com> wro=
te:

> My point with the comment on this patch was "Don't break AMD (or ancient
> VMX without instruction length decoding [Does that exist? I know SVM has
> old CPUs that don't do it]) please".

VM-exit instruction length is not defined for all VM-exit reasons (EPT
misconfiguration is one that is notably absent), but the field has
been there since Prescott.

