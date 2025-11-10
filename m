Return-Path: <linux-hyperv+bounces-7488-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E1C4954B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 21:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247421884B8A
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974512ECD32;
	Mon, 10 Nov 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4ZEghTj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D5A2F5463
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Nov 2025 20:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808195; cv=none; b=pzjrFSKS1JYpeZgvsN+AEnObtY3xnbuvuMN8vWzwBc5KvFYwgoiKhkhKQDhbbxeu2l+byy3wbRI/tTp+1rtehEPYpsp/H7iz5tCGAEMSBytioMlWib8A3WDJ1ZYMqThtbDzmwbuKeWYE38L0JWAbqGXusEeWOfecbnJEkt5/Etc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808195; c=relaxed/simple;
	bh=nzONvQzcT0llpH+eHhBSyHjuk/OUfjr2rQUOpvgixH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILiLH1Pr2Y8yEGxPjy09Zwp9qB1bX7ntdTvVPn3nLy90gGwhqOk+zzTP3EoEiDU4QJmDmO2z1Ks4tcdP56tzRXTOpfoR7hE0SeKoKR6wQq4kSvSO0TWfK8NIC1RbcArsh/Xq61PFK6SLTDPJ/0XPYDRgFnESYVy76jBLN6Au+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4ZEghTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B84C4CEF5
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Nov 2025 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762808195;
	bh=nzONvQzcT0llpH+eHhBSyHjuk/OUfjr2rQUOpvgixH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g4ZEghTjl/w1Eri3237VMIGiqaOFTHdvPjN72icZ3cS1Y9eMdJ0vAc9muX7xXYhJy
	 GhTvJMT0OnzHgrjl9EsTlqgJROzG3rFL9YcdVBiUmVMZFkqf3FkZhiPTddT9rsFLnf
	 EjIUY7weA/O/YydVq3JV1Df6BcPd9cceNBuzPjkt9kNZj7ZRivUZcOn7K4f1PKpate
	 EGnwytxFhbGLVKsS6hVLn9koaC3kQeLKJ9ZaF8vLjMOJq7+Y9/r1oi0vtTDSW7oQ/n
	 fkvUXekwbdiBqiyH/4ZJscQTdsKVoaPINL6dHWKh6VBrO/SH614sXfzLD2Gl0Lsbl/
	 RlTy9jk69WhSQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6542eb6dae0so1629670eaf.3
        for <linux-hyperv@vger.kernel.org>; Mon, 10 Nov 2025 12:56:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTR51D3kQ9e8YP4Py2OM9vVjikZesUSf6QnZI6zbmrWob+X0elV1mBwhrPdqWBOXAKSMN/47IhqJwFKlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnVnEs5YZh3P0QZ0IR2VTUOmHQo4bZH9UjZChstQ6WxkzwlBSR
	AQrAWJ04Qg5Ft1OikKagNlCCu4KI72blGPs2MWrJ/wGzd3Ht75E2BQXYYV9POk+/kQEwJ/DEwy2
	HF21Iz8Unzt1hBXNyTI4Vw/2SC09FvsI=
X-Google-Smtp-Source: AGHT+IG9Pjhham/qiDKmpchvbrQfXUjTk8mGOJBEgwPxvNy79OZ7viUKrocFLv1OXkrYVlSrLtSQL71+JS5eADJZCUE=
X-Received: by 2002:a05:6820:2188:b0:656:735e:9f25 with SMTP id
 006d021491bc7-656d8e88d10mr4580147eaf.8.1762808193960; Mon, 10 Nov 2025
 12:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local> <20251027205816.GB14161@ranerica-svr.sc.intel.com>
 <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local> <20251030054350.GA17477@ranerica-svr.sc.intel.com>
 <20251103134037.GOaQiw1Y6Iu_ENu6ww@fat_crate.local> <20251110174938.GA26690@ranerica-svr.sc.intel.com>
 <20251110194638.GCaRJBHrJgwjRY5aQr@fat_crate.local>
In-Reply-To: <20251110194638.GCaRJBHrJgwjRY5aQr@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 10 Nov 2025 21:56:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmu4onvrp_it=xTHsScE98AjDkCg00Tdhhtiz93b=aqw@mail.gmail.com>
X-Gm-Features: AWmQ_blbmx2tUH8jtiT6HsqvdY-s9EsP0qINVvRWzIyPuM-EMjwcy7mK231nDL4
Message-ID: <CAJZ5v0jmu4onvrp_it=xTHsScE98AjDkCg00Tdhhtiz93b=aqw@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to smpwakeup.c
To: Borislav Petkov <bp@alien8.de>, Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:47=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Nov 10, 2025 at 09:49:38AM -0800, Ricardo Neri wrote:
> > I apologize for my late reply. Also, I am sorry I was not clear. I need=
ed to
> > consult with a few stakeholders whether they could live with the increa=
se in
> > size resulting from having CONFIG_ACPI=3Dy. They can.
> >
> > If it is OK with Rafael, I plan to post a new version that drops this p=
atch and
> > adds the necessary function stubs for the !CONFIG_ACPI case.
>
> Sounds good to me.

Yeah, sounds good.

> It is the simplest thing to do. If the size increase bothers someone, we =
can
> always do the more involved refactoring later.

So long as they have a good enough justification for it that is.

