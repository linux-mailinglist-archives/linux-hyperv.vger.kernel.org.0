Return-Path: <linux-hyperv+bounces-1821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327538875DF
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 00:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625D81C213A8
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 23:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C961A82C67;
	Fri, 22 Mar 2024 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gB0g/n1f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC297F7C0
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Mar 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150991; cv=none; b=iOeXojytJrJ6E0Jl8VMaFHytxQMx8XL+fcf1ipJ8mNC7ZID7RtlBbxTwydr0r9OT3BiifuOqxmoQxFP7W/iV/cEV2U86z9cqfhfb4J+9+z4/Duz5VHJrTq2ZDH7u7sbCFYcXOGMyL6CQkopnmqxnvPvo8FADHTXHNzsxIsQkfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150991; c=relaxed/simple;
	bh=qv8aRawdQ6LCLH6RsJCtG2XeAHlJMlFTehACCccBvUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gezyf2cw+EdFCyHrfPeSWR4AhLiTobhlVKj8HV5bzFP1VV08Cr4wlRpvS4WuJc6F4T9//iatZMaAbiuOKI3REHtBKvsF1bi0/E2XgkX8IFMCZ3WuFuswMuONWovScDs56uIUVeWmHjF5HLyXgmCnknd8Da8lvHUZyjBTil6bVmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gB0g/n1f; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a468004667aso371442566b.2
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Mar 2024 16:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711150988; x=1711755788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wTH/TzF3hdRrcmsJ2UF7R/xyErYsBP+Qut8pJJOygI=;
        b=gB0g/n1f24RHXzAJ9osVgqEsnviXm0zCY5fSXSWW37wqs32+NfzWz1w4Xj/khjiu/H
         vAh8uGP8/qrS1UjNBgCdtSer4NkAOrGqHOecuIy6md0vUMUnvcjt91BtqfjjLHk4vnpr
         y+gci9JosOlG99fDM7o+ppZvxCqX1ndEDyfh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150988; x=1711755788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wTH/TzF3hdRrcmsJ2UF7R/xyErYsBP+Qut8pJJOygI=;
        b=I3uNFm4Jj7XXehmNGKprNC4jXfOe6EOo1iwr8dpFC07kYElY63O4a0WZhiXEZg2jwD
         UElprrnz38qqMHkawoqgaDG1uYt8aYMZObN3PJo4FxzO0agCq7i1IBAtOyLUpvQDExWD
         CBKIlYCpKiPx1sAt8uMNY9DhkmkSQrCU0tOGRm2AmJErtKnP82X/iWNoE8UpUMl1qDVi
         ov3P4T3TpTigpYa3lPb+x92XbsNLdQF1Q5ZLHWTL/xatZvifmhNZf1dapso4AGNjt7CO
         qwWZKQwE5VjBIck0WOMsPu18pEMXLryXL5Mkf8I+rUOVCtQOBfWTQfDwWNDsbiYesNI0
         VyKw==
X-Forwarded-Encrypted: i=1; AJvYcCURGXCJlVhjj0goFSY5iG3phwjf0r54iiuaX577Z54ClaXYOl7nngWzhZO88XKhuuJWXS+NqeJRwhACS2Es423cf4KgznFabVHhHbG6
X-Gm-Message-State: AOJu0YzpETWoiQPOgt4i04PXPeNXlleAt+Vk5YLSjG+LhnnazrmM1KTJ
	klJYyRThsONQMHmQLyIAnciIAkD2tnK49kkebxbAcvxvTAb9JHsm1ENqjvwjIeNfxbiFTUZD2Yl
	r3pg=
X-Google-Smtp-Source: AGHT+IF8aUyLCvhycdtwrDveR+3JZFgLp6U42NSPKXJ3M1HGk/SDcRb1AMFJIpUjBU4fauwzFl5pWQ==
X-Received: by 2002:a17:906:1b52:b0:a46:1fb:1df with SMTP id p18-20020a1709061b5200b00a4601fb01dfmr803034ejg.42.1711150987967;
        Fri, 22 Mar 2024 16:43:07 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709061c9900b00a46a71c5324sm326979ejh.34.2024.03.22.16.43.07
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 16:43:07 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso316182866b.1
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Mar 2024 16:43:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLE6sBn7xZgHDQSWOCsyqcTHD+uMsyemPnoIdq7p83FSy0wv8V2/GPjT6TJ6p7BjcuX6pnWyRd3ACLbxR8FNZElkt8Q5R+iyH02xYh
X-Received: by 2002:a17:906:408b:b0:a45:c99d:3625 with SMTP id
 u11-20020a170906408b00b00a45c99d3625mr882537ejj.23.1711150986670; Fri, 22 Mar
 2024 16:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2> <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
 <Zf4TXtFMURWnSvxh@liuwe-devbox-debian-v2>
In-Reply-To: <Zf4TXtFMURWnSvxh@liuwe-devbox-debian-v2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Mar 2024 16:42:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfVQyT49aTbgY3_Z4iVxEwvxkj12YiW+WD_HrM_8V3cQ@mail.gmail.com>
Message-ID: <CAHk-=wgfVQyT49aTbgY3_Z4iVxEwvxkj12YiW+WD_HrM_8V3cQ@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 16:25, Wei Liu <wei.liu@kernel.org> wrote:
>
> Hmm... I thought I refreshed it right before the expiration date. I
> pushed it to Ubuntu's keyserver.

Ok, I can find it there.

> I will check if something's wrong.
>
> Do you have a keyserver that you prefer?

The problem with keyservers is that there's so many of them, and
everybody uses different keyservers, and the propagation of pgp keys
across keyservers hasn't really worked for over a decade by now.

Maybe keys eventually propagate, but I have my doubts.

My default keyserver appears to be hkps://keys.openpgp.org, but the
pgp key git tree on kernel.org is the one I then look at when some key
isn't there (or is there, but hasn't been updated).

            Linus

