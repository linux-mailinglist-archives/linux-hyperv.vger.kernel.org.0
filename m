Return-Path: <linux-hyperv+bounces-2244-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 270148D17F8
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 12:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E2E0B254B8
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA1D16B732;
	Tue, 28 May 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9MBWC7R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED6516B750;
	Tue, 28 May 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890505; cv=none; b=X0Dfg7bvfsqEXigmnNVc6/7J6EBbNBzInsyLVYbA1mbaUgIxSj7wXJWX0FwBZJGLgoYkCTlwlByTc9ho9T9gc5Si+NFfNK2MOQ7MlqSNObT8iCLYg41X/XBg65HRCznA+eiDg7HJQIeIcxlkAuMj+b4Xf+tj67c+EzRHcMfvZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890505; c=relaxed/simple;
	bh=Y2E9LMJOmZGaKwGYezKBuZaUNvib7wYH8wfYOZyvMfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGK03OkdQckLcm2ILaj0RbCsJtm/GzloNDZhEtaTptJ9uMdbxScpwpvaOeioEjEpRtTRNHTm06JZHG+DjFY4V499G0jdyu5syiJ/3whgMOQjXxqGypQZrtf/O3B2g9NPVfLYodW8aj90mB8cs66fhJlfdzqMNvMPFw4d+kzLv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9MBWC7R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540EBC4AF12;
	Tue, 28 May 2024 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716890505;
	bh=Y2E9LMJOmZGaKwGYezKBuZaUNvib7wYH8wfYOZyvMfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S9MBWC7RSuhidbunFi1mTZaZNejNJVPTNwja0NCLR0wVZCce5l+mzOL8xKzZmZrLz
	 48YvBlO1cRZyCk93QJwoC5Vbwj6w4a4XHfuC/liSpBb0Ew1Fomiw1pZEexAWt8NSdm
	 4xDM+23raWUvURKpmPJ92TKCiSYEIw4QWD9IkpQQb1lYBuR/OvmSMeLV03AQjH4FPX
	 GN1YxNPLOlC6NoNPHX79dPQjVtMAVg2GFLjNV8XyJcDNQ6v5ooeD7zQMRnrKiT20yu
	 JE9R8Wk6S8WXf75L6S6pLdLrQlLMu0Ca/zlLHW96SttvgXd+xrYCg0zCm2ReYENyq6
	 IqEdaDJWnOYUg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2dd35212fso92851eaf.3;
        Tue, 28 May 2024 03:01:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXj7jLauCLS2PhuJRmEG6kwt1C4FtKzbMa04k44ISGae6JbDBFxb6exhzqdhvM1cbO6b0f+AGFM4fSLcRFfh1zQRO3lb+xag6ZankmNE+TLV349WOHwhGQngh77MyADQgdc1rdH2PoOipqo5RQ+NwudJBKyJvp8/yeeJR4sRoIjYXpYpzEC7g==
X-Gm-Message-State: AOJu0YwjmXYHW5S9eSXogGJkNA8h4PrpVL20KKGyO1lhtcfM2QgQKKl8
	/rm51S9SgonM4vGrFYqTGJL6m4UsaqTwPNcsAnIIMd/ys0l7uuNEvUgG1/grLIewj6j93NynpJo
	FaTj8wi4TCsWCYgRn7gqtANJTjlU=
X-Google-Smtp-Source: AGHT+IEfjO0Flb77SUHaCU5yQoE4DJGVCO3ob7qAG4UYz8mL7NteXu7Bev8T/M+BiVOKp1HzWSxUqAEZSBrZ2ld8T3I=
X-Received: by 2002:a05:6820:2e02:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b961b691eemr11395573eaf.1.1716890504453; Tue, 28 May 2024
 03:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 12:01:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUq6n4U50eqKrvdxjYxXxcUbJaYGmuyO4uWWDzc2C_Bg@mail.gmail.com>
Message-ID: <CAJZ5v0gUq6n4U50eqKrvdxjYxXxcUbJaYGmuyO4uWWDzc2C_Bg@mail.gmail.com>
Subject: Re: [PATCHv11 00/19] x86/tdx: Add kexec support
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 11:55=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.
>
> The last patch implements CPU offlining according to the approved ACPI
> spec change poposal[1]. It unlocks kexec with all CPUs visible in the tar=
get
> kernel. It requires BIOS-side enabling. If it missing we fallback to boot=
ing
> 2nd kernel with single CPU.
>
> Please review. I would be glad for any feedback.
>
> [1] https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher

For the ACPI-related changes in the series

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

