Return-Path: <linux-hyperv+bounces-1817-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAAA8875BC
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 00:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DF31F22B01
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 23:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C898F8288D;
	Fri, 22 Mar 2024 23:25:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4009B8005C;
	Fri, 22 Mar 2024 23:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711149927; cv=none; b=ehEv5GcQvuVkI3qmvI+/G5jP7OHgsaMbfAUz2oUBh0V9KYYAz/mtEDSrGOmbleGo1qDExvubGJwaXzZP1AYhvqZ56uUVvkmGAumUJQqny7OUAZSoqGXMcubdDLTySa6RmSQ05U90FEQ76sF+kAWO0c/WVth/P4Wuw9ckJ/Mdt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711149927; c=relaxed/simple;
	bh=5RYkymBYdPWldH4GqePzR7As5ngYcFHxLJCbmvwwcN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN4/hwqMiJ7iynUVjZfbk8CKhDlAtyTIfka2xSHuk15oTie0JMWSd4FTZkAWCGRwd5Ddle7cJ8o4iPnmbgay1Ge7hQOp3q8fO5ziiUHAmRqCWySLqAk4NPTxQzj+kLVmGawhSJTQElhWyjwRkyeI6yW9FGQd/9Dmq3O8zgoPgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a46ebc0f49so1102458eaf.0;
        Fri, 22 Mar 2024 16:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711149925; x=1711754725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seDqwfxKtP0d3EGvOIEgfuMWw/AVxjr6xapW+SLKXjo=;
        b=W0soTc9pDmC2pfAFMZMjV22OluU1grxN3UZnKLU3NfwYb9EkV/wzE3Lo+T+HBbHO5u
         YlFS1kZ8Jn6ppn2wQ++iyXPizj3YGQPFP/BFAEtf1j4QalISlmJiaOBdt7zdBOXFRxn0
         KxFWlwCISDDAov7c0LaG6qgn8QG7zWsBtM1XYtemJJ4zI0O+mgwhaMS1L8xnk2+Q3q7C
         Vo49eJI1X1+VRfLFwM1cIW6LhvMQ9pGobhbKebft3UniXP6pwUgdXBncwREFOpOQ7pHn
         3TMmNHuElWY572BsGT3gcXdG3bXNsnZRynuIgKj9sZINHvPQ0orUbcOe83oaugjXznJU
         M2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGK9hSPTMP/j3LiHWVoyOS8RGK0A6t6AShQvUJCPFMomeKELUKV8o0zZP/uVL9mbT2vvR3rYwQ5+nhkqQMJ4xF4ofgmv3tBPo6V8dEVT6TfBtHHcRQNIRvi2vhnTP8mdOnyG5oIYtF7iZW
X-Gm-Message-State: AOJu0YwaLpVaCnZjV7TDAVFb9Ip2tKmoW1tyIIjSPqxDaHghsTTBbsHH
	atw43qKPgq2QTyYAOCIhFNiPDP1mQBlEHFyi7hd7I37XVOdsNI+w
X-Google-Smtp-Source: AGHT+IGp1ShymcKvguACWQ+punzelgzjxb1l7bH0I0950Yz3/jIfbFZO8iAZOHnMW38U18fSi3+SJQ==
X-Received: by 2002:a05:6359:45a7:b0:17e:a3c0:f000 with SMTP id no39-20020a05635945a700b0017ea3c0f000mr1107653rwb.5.1711149925130;
        Fri, 22 Mar 2024 16:25:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id h185-20020a636cc2000000b005e4fa511505sm2082616pgc.69.2024.03.22.16.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:25:24 -0700 (PDT)
Date: Fri, 22 Mar 2024 23:25:18 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
Message-ID: <Zf4TXtFMURWnSvxh@liuwe-devbox-debian-v2>
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
 <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>

On Thu, Mar 21, 2024 at 10:06:53AM -0700, Linus Torvalds wrote:
> On Wed, 20 Mar 2024 at 21:09, Wei Liu <wei.liu@kernel.org> wrote:
> >
> >   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240320
> 
> Pulled, but...
> 
> Your pgp key expired two weeks ago. Please extend the expiration date
> (and not something small!) and make sure to refresh the kernel.org
> repo and/or other keyservers.

Hmm... I thought I refreshed it right before the expiration date. I
pushed it to Ubuntu's keyserver.

I will check if something's wrong.

Do you have a keyserver that you prefer?

Thanks,
Wei.

> 
>                  Linus

