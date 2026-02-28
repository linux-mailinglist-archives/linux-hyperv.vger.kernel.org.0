Return-Path: <linux-hyperv+bounces-9066-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePnhFfgio2mC9wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9066-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 18:16:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F81C4D7B
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 18:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A69930610F2
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0982C21F8;
	Sat, 28 Feb 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNvJHc3q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942B273D9F
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298962; cv=pass; b=UID/DqjwgMyKBJAbKwn4hh70jpgxaHZt71PXEheIlzXprYZpQaciUmQ2EIt+9tukKSr68YfCH1+emsRHB3gC3dLkBj5CfdZ6seyDLktx47H+xBb9y2vpIVETwNPMKVvFAWP5fXoW02my544z6x66FCpND1sZcacJp+5ebrxXXQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298962; c=relaxed/simple;
	bh=avNvfOjJqp9z7hadw55cTL//LJMC5x88fPGPdHcchEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cVFQTZiSuQ7IW4n2dLrScCL4sABX1LuFUYTzCb9y2r5ooORsVPd4qmhLlG4Gnfo7+3SegRmSMNce7BRnR2SeiX/EbKNFZu7L5DeZa9XWwVfoyoVx4jTI+Kru1r8EzUXvYhtKwcjEMIJRD8VbdJn/+Z4ef/k4bGVeHK1bZ5xz6r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNvJHc3q; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-389e268a9b4so45684501fa.2
        for <linux-hyperv@vger.kernel.org>; Sat, 28 Feb 2026 09:16:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772298959; cv=none;
        d=google.com; s=arc-20240605;
        b=fvVoZ4rddVkj8nYtsyQT61XyrgBR2YpkjfhaTN1HJGPoVy7J6yHq+hkIqys2mS2LBR
         wGG/MzBeoE45g+/+TfC44hXWzZNrSv9F9ybTZmSLS2QviFR2FI6xjRQRpXXgcOXDIp75
         54inU5gDsu8MAaZKw62PmFBeQjYzxCyJOJoohk2EDFmG4DUpixDAl007nl2vdKe9PLqK
         cvBWxhzsfUx+n0m306O6RkHNLO2JEjMVWuBVWLnGTBRjiZ9lW36ftiN6GExC6RI5Y9G9
         /K3JFQTC6TH6YvcJxMAVphlxEiLTwGJfyGVzg5uO3H+4rqisDpRO8lxToiObFucdOQHL
         KnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VrzlfI7NG3ENm+Yg4fOoafsJRKhJizauPoiXQuSg3fE=;
        fh=HMmLR856IhmVGagY6Ma1rK7XLZnmBt4vuM+hpX/tieU=;
        b=ao99QiUqm2/DqVbejeKXAVTxouXk1xtaEFWlzBuZuV0bSGXB0hfslBsOU7Ois/yImr
         MlG/RK+Am7JpB6pjC+y7HcLyBOyTWThTDsfFYtQ9vRX0CVHfgsktqMe23u8epBs80nEo
         Gs63MYBGukDrcXOBAwdMCGOKyEJh5OORltTqZ7N/c6V0xvHdVuGVKeYSJ5SBD9cH2eFf
         5o1fZ0STkSfdrMFIn7JWkl/Iccc+GnV4o2+INpswILcKs+N3ML6fez3n30HN1Hnqb9nG
         vlLzfgh7RP2AW/efRQLOF3i9j6OzL/q3PCOa8bZK/qoZEHFS/P9bHEgEG6NuXLt8ZfKS
         ebsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772298959; x=1772903759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrzlfI7NG3ENm+Yg4fOoafsJRKhJizauPoiXQuSg3fE=;
        b=BNvJHc3qZljaf9ja/L39hL7zqA1TjIbMtw+DupTPp2cM7wfu1iaOZHTA25skN5WeqJ
         m43dtBfP3rSxgUHpQg+A1oiwKbItMw/rRI7HrunfS3O55Pgt193y2aiZJsqIIteKSir4
         fQNNlP1iH3PaN0D7AjkHQpICXeV446zx1r32Ew8kkN2PpV2VXHaLESkmthrxUdrEq7e+
         ZrzYp+WBqTLIj/+QxchuBnS9pgAEyYtcWYIMJr6Y7XkzgiWN5A9aVyFmN5SGbtIkawW+
         O/vP515h7cnOgpip5/twwtYBW3xhQGPFYjqoCoepz+6TPP3K6N+IyozeA4GY2XK4DCxt
         3mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772298959; x=1772903759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrzlfI7NG3ENm+Yg4fOoafsJRKhJizauPoiXQuSg3fE=;
        b=TvNayu0rMt5I6cE0Rc+YoItjcrWZ7C1FzmfXnwOpjzQQeJl5o+Akq/fZEIeNYyoTPv
         3cyYcvGvGkbmpTVz/yf4omNIHYXHBUXd6ouDvZd8sixICipeTxhly0pBHd4OCuPJKeee
         NZSK3h3GC7MIg8nJoILhwkIhUnnfCN6YQdTyGmdY4WSmRzPRSgTeHJ9Jyw5xWA5dVbC4
         ffKujgt5U7xC2jYgXByIbwZn67uL4LkI8H6ud35d1vZz/BU+SpALtxT9mjWMazWaDrpI
         txw/PpcLt2nmy/m2F3Xx76vByH7jBN4sZ8NKgkYQeQ8a0jRw/v/koPz4WhHtcTF4nVxg
         qSog==
X-Forwarded-Encrypted: i=1; AJvYcCUb3JwPjYYFs89Xy3gs7XsIIcRQI2qXA21Hje1pdFX44L9IjZLAuvCojRffDx9YPvONKXbRK/9QsDEdWhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrixzPJY7oQINPRNt1XloJGKDCYIlJR0sQuDoZsssweJUwlFPT
	hDlJAHRSnHCKDrc7FUc/7W/kr7OnMOhI9qlPgEGGy4h9JxfWxD7Uh+mxJ7xAALYneyEt/bilK+Z
	ClGunqnL2K3lYnUAlQjEtRBHAoObcd8s=
X-Gm-Gg: ATEYQzz7zoqm2zTRzyx65s36FY7DjTExJ2TJ3+K5+20EgY/gzYwNdmovk0jRjI2AEye
	r/mS5KF93yzDHN/f/6guWr9D23OoNLBpEIimhK2yFCHXnL19sguxPdUnwepE5zEqAHKZ6nRT9fx
	spZTj3cKNmoSYy10V/6dvUNBW4YoMTn3bBolm1IvuN2J98mE/XwCjYG3Y3Ga1C/WQvrLxoGY1Gz
	1w125ONf889CjquaIrmS7w7wjm+c0oigGC1EUA/3Io6bJDF7OpnNay5NtlIRijl2Yr1Oxnbu8uf
	AoPqF++pVLkPbeZImrhRH63EbHdM5aTerfR2o/sgJ8TnPa0w0cpMl09SE2djYrws4lxXqFlgliU
	N5Xe4bbKiOH84zXTsVd/H0SBYQgyj0UhwrD/WxOq4drk=
X-Received: by 2002:a05:651c:2116:b0:387:760:4c75 with SMTP id
 38308e7fff4ca-38a08ba39a4mr16711301fa.39.1772298958810; Sat, 28 Feb 2026
 09:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227224030.299993-2-ardb@kernel.org> <CAFULd4ZYiSWciqo94yaLvB43z_+jqgXa2gy8DOEQQp1W8yFF0w@mail.gmail.com>
 <a80879c4-10d4-41a7-8043-290b92a0d9fc@app.fastmail.com>
In-Reply-To: <a80879c4-10d4-41a7-8043-290b92a0d9fc@app.fastmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 28 Feb 2026 18:15:47 +0100
X-Gm-Features: AaiRm52HEFWCS6tx-SUvg3R_cxlAlW8zBdOI948czq6_tr49GDgsxtm2MIVsoyA
Message-ID: <CAFULd4Z+d6utLk-3nCnn3gpz=Ch2sNJtPQKzrwVREnJHqbfj5Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/hyperv: Use __naked attribute to fix stackless C function
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Mukesh Rathor <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9066-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ubizjak@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hv_crash_ctxt.ss:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B30F81C4D7B
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 5:37=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
>
>
> On Sat, 28 Feb 2026, at 10:38, Uros Bizjak wrote:
> > On Fri, Feb 27, 2026 at 11:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.or=
g> wrote:
> ...
> >> -       asm volatile("movw %%ax, %%ss" : : "a"(ctxt->ss));
> >> -       asm volatile("movq %0, %%rsp" : : "m"(ctxt->rsp));
> >> +       asm volatile("movw %0, %%ss" : : "m"(hv_crash_ctxt.ss));
> >> +       asm volatile("movq %0, %%rsp" : : "m"(hv_crash_ctxt.rsp));
> >
> > Maybe this part should be written together as:
> >
> >       asm volatile("movw %0, %%ss\n\t"
> >                     "movq %1, %%rsp"
> >                     :: "m"(hv_crash_ctxt.ss), "m"(hv_crash_ctxt,rsp));
> >
> > This way, the stack register update is guaranteed to execute in the
> > stack segment shadow. Otherwise, the compiler is free to insert some
> > unrelated instruction in between. It probably won't happen in practice
> > in this case, but the compiler can be quite creative with moving asm
> > arguments around.
> >
>
> It also doesn't matter: setting the SS segment is not needed when running=
 in 64-bit mode, so whether or not the RSP update occurs immediately after =
is irrelevant.

x86-64 still implements the stack segment interrupt shadow for MOV SS
and POP SS, even though segmentation is mostly disabled in long mode.

Uros.

