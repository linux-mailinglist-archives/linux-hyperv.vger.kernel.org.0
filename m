Return-Path: <linux-hyperv+bounces-3209-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D4F9B4F38
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7631E1C208D8
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A461990C1;
	Tue, 29 Oct 2024 16:23:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4552A199E80;
	Tue, 29 Oct 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218985; cv=none; b=VNgyul50vI3eaEwOx9PSvHbwikMkSHV7qnAzChj3j8mGKaxcPJMfP9jHR3p08eJAAPYMNSLLoKhP6H7dRSqc8p6bQPAgNC0Hq20eXIECiZo7TAHHlOg5aUMEeziyf0uahinDbcVXaT1sedwIHeAuufKHzoG2rTvfMW7aD+08lCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218985; c=relaxed/simple;
	bh=hnw3a4Xz8giAfeEUrg7HVp4lhnxcTB5sn16ndm/j+k4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGNZ5jIRbELIuW5txmZ1TS9FSqwfuXdo2zbGjt8nzq+28f9ZKRXorQq76CqB3meqMftT/jFRdVThuzB+A9C+SGpkA+YFYPiBH+PhNgRlpycPCWjRV1Mz6v6S9kJ31h7qyLGhYnRjroeM05eRUndrHhoMtRgUzXMQJNrUZHnmKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ea051d04caso20386167b3.0;
        Tue, 29 Oct 2024 09:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218980; x=1730823780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROSe2v3U/1vSKBR72rtEBk3p8buCmeo4JYHedEhiUX8=;
        b=VeWUUKRTPd/D66AKb+4KT3nswjq5Dhd6PI065BceAQmMApAtCluXkIzyNjYAx3hkUH
         2EtvdCqG3wm/25D0nwwQ098FJ9MuCyKbp9ow9/0PRVZWpYWqL0Ug84KDzf34T6lXxxpk
         xa8Z+P7ZSPo6bDlUJjqVF5vLLw3Imwq2NDuUkODqQGifjqIes+c8wJ0BsSBxi73IlGru
         rTzy6LLopmLTerF3fCz5BscCI3zFI1xPntQiw1SCBY/M8VmqTmbaVUah8FyvzBAZ8TwJ
         c79hr2Tlio6xnX9HPJAwLxE+D9ujCuzdImfgNL+x0j3AYMjbp/Ko3KwsKSdYtjyXsiOE
         nazw==
X-Forwarded-Encrypted: i=1; AJvYcCUTHplA4DGtCeblf3JpTODtajLRqcFmlNJsZ1MCeHeQyGMsZ8OBfv8MAIwpDDAmmN2jTki3e4EYdMtr/Tgs@vger.kernel.org, AJvYcCWQALwzlZWzdEm77yBFJJ7Xii2490dy/eQe3qvKu6vbcNv1bAza6HB2T/gaOgTyhkj9liKhOs7SNsUNMQUIfhs=@vger.kernel.org, AJvYcCWmLKFNg2UHgarc1Kj6UDXjCFokT9z/IRpws0tP7+z0CXhbrMjrbBtzsWfq1DcuiuSlKIW2MGLE/rQQFSxc@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy71aOv5gKXCV8deOHu9WBy5lcxj4ed2ZYopTaSy5RWgFY5BLN
	YirntAKmTUgHGCjNPS8WTZtmFd/IstDKF7MNAJGslOiX3yc1dMvEksfcBnXH
X-Google-Smtp-Source: AGHT+IEiJzMtBL2USODF9wB49pZtOjVi7QAC4ridp46IJDGW+slkjk9Xsih4ve2PBsxn8bpOMq5UdQ==
X-Received: by 2002:a05:690c:6085:b0:6d5:7b2f:60a0 with SMTP id 00721157ae682-6e9d8afb26dmr131442847b3.34.1730218980363;
        Tue, 29 Oct 2024 09:23:00 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c193b6sm20001877b3.66.2024.10.29.09.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:22:59 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea051d04caso20385607b3.0;
        Tue, 29 Oct 2024 09:22:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkIyt1iOsZ8/lmwDQE4HSNwnIxEKdjV9AU5+tJYLFdOd94g2oEqxC1L/CLvZXrOeMB5SUdDWSMbspX2k3O@vger.kernel.org, AJvYcCVtgarZtNV5XeVSPDi8+JDYNYZmLQfy/0Q5LZ2Er66wkK+kHCJJw7b5kjdGrHfLqdlEkpjlJScB+HwgX1cG@vger.kernel.org, AJvYcCWGC1JusvWfaC8ok+B25eeldXRhu7NqTCXAXJeG285DjNnvusAkK7Q2a/so5UkyZDnPg22qeeiaOWtUpwkOLOo=@vger.kernel.org
X-Received: by 2002:a05:690c:60c1:b0:6e3:36cc:eb74 with SMTP id
 00721157ae682-6e9d8afa635mr145747877b3.32.1730218979252; Tue, 29 Oct 2024
 09:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com> <87wmhq28o6.ffs@tglx>
In-Reply-To: <87wmhq28o6.ffs@tglx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Oct 2024 17:22:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
Message-ID: <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Tue, Oct 29, 2024 at 5:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
> On Mon, Oct 28 2024 at 19:11, Easwar Hariharan wrote:
> > diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> > index 1220f0fbe5bf..e5256bb5f851 100644
> > --- a/include/linux/jiffies.h
> > +++ b/include/linux/jiffies.h
> > @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffi=
es(const unsigned int m)
> >       }
> >  }
> >
> > +#define secs_to_jiffies(_secs) ((_secs) * HZ)
>
> Can you please make that a static inline, as there is no need for macro
> magic like in the other conversions, and add a kernel doc comment which
> documents this?

Note that a static inline means it cannot be used in e.g. struct initialize=
rs,
which are substantial users of  "<value> * HZ".

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

