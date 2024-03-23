Return-Path: <linux-hyperv+bounces-1822-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC88875F0
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 01:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58755283865
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 00:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B985E182;
	Sat, 23 Mar 2024 00:06:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5622D7F;
	Sat, 23 Mar 2024 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711152386; cv=none; b=rkdNvdRR4gtYc7LGNUlTLL6k3cmyP6yAewk82doR6YRHK5nrLUaVFmH9o/AWI3Oy2ieMvjvTpppJY1V53W+qvvn8siOt8ar+ddqkWJGyE03nUjoLkKvv9vpzF812GcGrxrUvaW1t4RqUWdHFdJTujSUm6rSQ7BTVIDvatK7Q9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711152386; c=relaxed/simple;
	bh=VzpDiEWPnAsEk/5iGP3oHBJJ0IB6MBVELEeTguiY0Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V22hkfBSHbEoTclHW53gEh3/TGR/wp+0ZNNn3ywW+ROa9D4UpQQLzO7FHCYSe+2epXMy1l4N1maSJSRTtAV44nNfqIQn5AMFZ2vmASPTBFc74pPBDYYaIS/D4LtsvWcyE7ZyMZr0X6X89RUbDcICOD0vY19CRJYqyMiTi5Bhilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so1737949b3a.2;
        Fri, 22 Mar 2024 17:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711152385; x=1711757185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krLV3YhQmYtIvJgH51BE84Nmd5eLI+h9yVKFuEtOoQA=;
        b=RWAbfJB35zZZPA8JXn9Rr1bIt9dMKt67dW5AORYGc4mEsxU+kSswd4Ueb8fs2GcwaN
         yC8EoUCU1x1ju4v6o5KrRzkxFmS4W14e1PWl+GnItwp8s96M4skrNQVbYTgeFulpYXVq
         4vLQ8u6VfCen1NyqKK5Wij4c1txCfjyOccuOm6dLEnN75JDAcs+y2vtSJabVugjMoHTc
         eRCWpc6EAhLQMXc4VsdGDT0KvnFCLV0pUKwI6fgGrUVeE+5V9+0yewDaoMpmBMIVIYM8
         knYcaekvQOXVYUWboShCZTTtWXbGTdb3kldtTVFDnN7aSsfkmh2WmZMGC95gOU2mqNvp
         c2aA==
X-Forwarded-Encrypted: i=1; AJvYcCVVJnlZl3zsN3qF1i4o/uJ5q4rLGj3/dloYTmEZ6PUZSLRJ9r+7S4zCANoNK9rAD2jCr66ceoKdn7kraSbxWL/T5e6M7f1S6ekn9y3q5tiDax8Ffizi7f3kq55PJg7QH1mdKumtK7HAPkiH
X-Gm-Message-State: AOJu0YxGlAFSFGe0/yjuEj5y6H0qBnzwi/3ytGV3y1yILVkNykH8qaXC
	tJexnSHT5TFLpUVGALxvONprNKrBvkuEdoNeEcxgrzoZGcUYYbcaDbmu86Zl
X-Google-Smtp-Source: AGHT+IHJjw3TnE0Qfc9M5i8u4F+VIF/q687ujchV+4j9AyEHwJvFnGLCfiRSAa0jvEbgavADCjTfJQ==
X-Received: by 2002:a05:6a20:3d17:b0:1a3:a833:c25e with SMTP id y23-20020a056a203d1700b001a3a833c25emr1289294pzi.37.1711152384653;
        Fri, 22 Mar 2024 17:06:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b001db9e12cd62sm337544plb.10.2024.03.22.17.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 17:06:24 -0700 (PDT)
Date: Sat, 23 Mar 2024 00:06:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
Message-ID: <Zf4c-WYt2uhYXiPm@liuwe-devbox-debian-v2>
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
 <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
 <Zf4TXtFMURWnSvxh@liuwe-devbox-debian-v2>
 <CAHk-=wgfVQyT49aTbgY3_Z4iVxEwvxkj12YiW+WD_HrM_8V3cQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfVQyT49aTbgY3_Z4iVxEwvxkj12YiW+WD_HrM_8V3cQ@mail.gmail.com>

On Fri, Mar 22, 2024 at 04:42:50PM -0700, Linus Torvalds wrote:
> On Fri, 22 Mar 2024 at 16:25, Wei Liu <wei.liu@kernel.org> wrote:
> >
> > Hmm... I thought I refreshed it right before the expiration date. I
> > pushed it to Ubuntu's keyserver.
> 
> Ok, I can find it there.
> 
> > I will check if something's wrong.
> >
> > Do you have a keyserver that you prefer?
> 
> The problem with keyservers is that there's so many of them, and
> everybody uses different keyservers, and the propagation of pgp keys
> across keyservers hasn't really worked for over a decade by now.

I noticed that keys do eventually propagate, but I never had the means
to time how long it takes.

> 
> Maybe keys eventually propagate, but I have my doubts.
> 
> My default keyserver appears to be hkps://keys.openpgp.org, but the
> pgp key git tree on kernel.org is the one I then look at when some key
> isn't there (or is there, but hasn't been updated).
> 

Okay, so my key in that git repository has not been updated. And the
last time it was updated was in Jan 2023 (!). I thought it was updated
more often by a cron job but apparently not.

I will drop an email to keys@linux.kernelorg to refresh the key.

Thanks,
Wei.

>             Linus

