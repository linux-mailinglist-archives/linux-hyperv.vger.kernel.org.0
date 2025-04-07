Return-Path: <linux-hyperv+bounces-4802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95CA7D561
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D55188EFB8
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5432288CB;
	Mon,  7 Apr 2025 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOamAa+x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD5C22837F;
	Mon,  7 Apr 2025 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010079; cv=none; b=u+zCCNHegIdPAJMuhRbiNkZaiLfQJpN3Emd7GnKcDDSeBfYH8zHjYa6S5+ipH/p/7D3nCs+Vkg6Q+pzTRYUzWOYBD+vb3SUr5JEL5ClujKs7oEPsRimSNeGHU4aM1Vt/HJs/qw7LlGvABv3bTtv6CpWH0L0BeFvlWJ1ouH/Kvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010079; c=relaxed/simple;
	bh=FP1SkxxlLN1o6l1fuR3qV3eVrpuL5VbTab6nmjVx/VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4UwQyP54uq0GeQL+IOlAwLtgT2CFEexK80z1e+xv/zJhZZsmjaIcvdrihSuzFCSWavrSMM/c8x09ffiEevWqcxyVt9DgY5gZMfbXC+W4RPJyWyy8j4+Qy8qWCu+X0dsHyCvyQU/euG2e/V7OawPctKbNF1OwvEZcMh/qCMHYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOamAa+x; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so636584966b.3;
        Mon, 07 Apr 2025 00:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744010076; x=1744614876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfpFjJ9Ywgo+fCsxfHoRVSozL31icc7S90ulPG/izxs=;
        b=XOamAa+x/nmtcAZ0CDwFa6yWlxoNgfXG6PRdrsfqPhBEVItGkFnnxt3Ox1B43zGX0n
         ytt5XpfmUbXQ1N0Spkfkr/gxqPbop5ZJ6+jgc+8hvOm3uaasAMoUi8Y5z4d6UoE97oMh
         Rhe9+oSB04GnTkN+BUprSEsc0QanThwyUTXwIqJ2YhHBsIK8u5bVIz1fBCrKUR65Li0I
         9nETxz9UuKUn/obqUAl9aahPqBxZ7x3CasOKfgigwrQbjmyfKgmLds/KY3+3ZdO2jCZi
         fEt/3mXGb7SYYUvNm15cpPAbpsqle/Clp1NoBrhwDZKbf0UmEbdOp/o0bBZYZydKTK+t
         tBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010076; x=1744614876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfpFjJ9Ywgo+fCsxfHoRVSozL31icc7S90ulPG/izxs=;
        b=B5chSrc2PeorTyIbkRu8Rg3VLkg+RfW5Dg3HCXIp4A7tY5kQD7TX8sjNv7ovbXyIZl
         a+iufoIP+1UXOPBoWD9pUwC0U0mxhh6N3GfhViPvLzwMNe2Ku4dWly35E4oBMKWiDWSb
         DL0x0fG++3u/rs4lDAr4TZ6M3kiWHPP8qB4p3ri9RROSl4dGN+JQIxcFCOPZ2h6Scc9t
         TgQQQaoN6OeEH6NNg7GmWIEZ2fCbL2ORBLgH5jcG8SDolwL8wtEsOTuGQA2PVTxljLzB
         foDtTFjRy2HJnbcbFR1ioJN7Il09hrLQcSx1TVtuuQNOXr1VvlEhUzTJ1aTaA8YjFyCc
         7YFw==
X-Forwarded-Encrypted: i=1; AJvYcCUMgWcV+b+2DIZvmgORiqyG7RTY349RNbc5Hnr7hOTgnRuT1rOQigxCUb+ztjglH75zrspVdPtjJTu+PeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3oK2GbB49zXA4pFv/LK9QbCWyw5HmDAW7kgJ2L0kXIQT80xL
	K0PB4a5TtYKy0k+BrE08HIzhBamnrEgYByNTxPSfu4z5XkNM0Fq0H30twfUBHOvOtYtjH1vhvTK
	mAs3sUCO3DmpZv1K8LVocG8FgdL5iQ6zvyut0JA==
X-Gm-Gg: ASbGnctsLc0URfxwR5YTGh1v9v0Ix3Uhuvy1ISW6FdtDBZkKPXUX723A+R/bOgifJee
	EMA04yRH3eEpXNHXcPDJ9mXp7WMdMAA8MPuxQrNDzClS1MDocNRzX2jONY3bhwQSybXkXpgXaDl
	U44YyAtPv9d5la1ScfIIQS/hJKnVVB
X-Google-Smtp-Source: AGHT+IEL6GSQKfnlmteZNhU5B89hKWABObXNBz1o6Dmpp3gIpzoQTW1m2Z1rOVB5g7oh2gth+A1Sf5dOyUdJI9Pvd/o=
X-Received: by 2002:a17:907:d25:b0:ac3:b12c:b1f2 with SMTP id
 a640c23a62f3a-ac7d6d81279mr787300666b.35.1744010075353; Mon, 07 Apr 2025
 00:14:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322164709.500340-1-malayarout91@gmail.com> <Z_NknPrx26vMuJ-9@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
In-Reply-To: <Z_NknPrx26vMuJ-9@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Mon, 7 Apr 2025 12:44:23 +0530
X-Gm-Features: ATxdqUH7z8xaH6QNtmM_fJi0hPTpTyUOipii1PSflJyBXO0W8DmtmRLctdSVMX8
Message-ID: <CAE2+fR_t2-207Ji+YoFKt2QrotCfAME0Ean9EbPEn-9c7HuONQ@mail.gmail.com>
Subject: Re: [PATCH] tools/hv: Memory Leak on realloc
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 11:07=E2=80=AFAM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Sat, Mar 22, 2025 at 10:16:47PM +0530, Malaya Kumar Rout wrote:
> > Static analysis for hv_kvp_daemon.c with cppcheck : error:
> >
> > hv_kvp_daemon.c:359:3: error: Common realloc mistake:
> > 'record' nulled but not freed upon failure [memleakOnRealloc]
> > record =3D realloc(record, sizeof(struct kvp_record) *
> >
> > If realloc() fails, record is now NULL.
> > If we directly assign this NULL to record, the reference to the previou=
sly allocated memory is lost.
> > This causes a memory leak because the old allocated memory remains but =
is no longer accessible.
> >
> > A temporary pointer was utilized when invoking realloc() to prevent
> > the loss of the original allocation in the event of a failure
>
> While this patch finds a problem, it misses the big picture.
>
> If realloc fails, the process quits. It depends on the OS to reclaim the
> memory. Freeing this one instance to prevent a memory leak is not
> sufficient -- there can be already memory allocated prior to a failure.
>
> Unless this program is sufficiently reworked to be resilient against
> OOM, this change itself does not bring much value.
>
> That being said, thank you for writing a patch and went through the
> trouble to submit it.
>
> Thanks,
> Wei.
>
I greatly appreciate your prompt review.

Thanks,
Malaya Kumar Rout

> >
> > CC: linux-kernel@vger.kernel.org
> >     linux-hyperv@vger.kernel.org
> > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > ---
> >  tools/hv/hv_kvp_daemon.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > index 04ba035d67e9..6807832209f0 100644
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -356,11 +356,14 @@ static int kvp_key_add_or_modify(int pool, const =
__u8 *key, int key_size,
> >        */
> >       if (num_records =3D=3D (ENTRIES_PER_BLOCK * num_blocks)) {
> >               /* Need to allocate a larger array for reg entries. */
> > -             record =3D realloc(record, sizeof(struct kvp_record) *
> > -                      ENTRIES_PER_BLOCK * (num_blocks + 1));
> > -
> > -             if (record =3D=3D NULL)
> > +             struct kvp_record *temp =3D realloc(record, sizeof(struct=
 kvp_record) *
> > +                             ENTRIES_PER_BLOCK * (num_blocks + 1));
> > +             if (!temp) {
> > +                     free(record);
> > +                     record =3D NULL;
> >                       return 1;
> > +             }
> > +             record =3D temp;
> >               kvp_file_info[pool].num_blocks++;
> >
> >       }
> > --
> > 2.43.0
> >

