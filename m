Return-Path: <linux-hyperv+bounces-4194-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E324A4AF6C
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Mar 2025 07:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF216E573
	for <lists+linux-hyperv@lfdr.de>; Sun,  2 Mar 2025 06:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958B411CA9;
	Sun,  2 Mar 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqB5MsIX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36751876;
	Sun,  2 Mar 2025 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740897405; cv=none; b=peM28zYpweluN1nHNOH2QG/JVM4rjkYE8QyypsPJrkpnPlyoYfTSkz4jgzLchJ7YQTuFOgzBsNg+5QnDvClsCJnPdEegguTpis7OufbBst0fW7zryLZzIvJm+ztGBK7uE2ismG54UyZQL7L2W4RDURg2tGNzLvVVycprHWUXhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740897405; c=relaxed/simple;
	bh=IUCDtHJxXpP/1YHLV1yE44JHu9HS9K3SjWdER+7D04I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xf5aRF7sVXC8JlEjKUZRJG4WeuEo9Ikqtp6zw1otRaUTljDJNsBHE+gfS1nLVbfAXzS4img/3YLH4nca8X9wHUZKduiHJ+jSijRTYrjC77fBYfGAdZcLAbwNvA/miJ8Y+AYs+Tj3jTfZPrkIQIpGkhqB3ANvmCf3mYXuK4We7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqB5MsIX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22356471820so53352585ad.0;
        Sat, 01 Mar 2025 22:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740897403; x=1741502203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzMGwPnvoDSEYaK16KRAWfgUItfUZTdq/AQjm2L9eII=;
        b=WqB5MsIXwyv5QFJBZzN1Wtt4qBFfszNTW6xgJe5ZPqJpplJk4TmIoAj2F7QUP6p+9l
         9fStNaT3NylyTkvx20T8e1f2gquIq5eYVf/uxJOixssxIszTSkUvwOWqIA5eXomr4jMf
         9sDJXk63m1hLj3prca3kPXhfF2puwYwM3JsTsckqnUe4NFIv3BO9zyBStjnvEtGkx8MD
         f6b5Q7H73KvI2dkwZEW5eYoubgYu26HFNpLABRIH11amyGiI65jA2B/2AqnHAXwEsF3G
         2OJJ2AY1Uh8WlJMkbDPDSIQwz5pF2W9CoS517Xh/Z0p4/bgGhgLwfAwY/ZNBpbcjZq07
         Z9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740897403; x=1741502203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzMGwPnvoDSEYaK16KRAWfgUItfUZTdq/AQjm2L9eII=;
        b=jihfvmO3lvoesLUB+EP2THmIKhHJk0vY5Q8CbOAyADPh3xCKdfvRr8X7ogGDFZCWUt
         TOgE+ybSgAFSlgfuOYB2fL36tgygqF3QGJCK4vEcNZ8rf88MZYA8oKNJCWfodz504Nkd
         HkHePRFPe6POxFOyQXgq17cK3i58XwmKNRe+QGUU7gGY1tZEntbLrBBVDmHNaVv0U0pG
         xNJLVy9F1iC9okcCeYB/2U0NpZK8ZxwWVlL67XkIXoeccTmqMPbrYkrI4yOTiKBRqBpM
         vU/MV1XdD5RlG4gZHFNqwvhB4gIQHCHL6CoNrU1aC2Sx5Q3owaKWPShTVUaxA/67/Sou
         aauw==
X-Forwarded-Encrypted: i=1; AJvYcCUjhzjHiqkIJk18H6JmfxJKWYm6eKCSpPv+WjayP1umtzV1JOU9RcP0+sGF+E11REHsBDp7hNxmbYhRnwQ=@vger.kernel.org, AJvYcCV8I1r2lHgOAUnP56uYZ0s60bJcgmpyKc6hy+/e/cQ9V/pxwCPmby89Hkm58ttSFiFQ9POgibGcBGop8rcr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3mtbiLVhbtXLHp4YiEd54eH+xERfMw5CWvyor/P3fzIbpdbv3
	+TzfQWUH3A9Ii5cuGl3JkIG51JI6bIB8HzGbrisLoqNMZlcmvNnq
X-Gm-Gg: ASbGncudX0DcS1uw7F5iFWfIC3BVXQ5rLbuxpnD+ivKZN/ZMJ5a1SX+dfheRChRfr7X
	bspo6jr26jXWgwZnT2kfgK73vbdlVY3Z78obXy2+bsFCW4HR3GNdoZJUdrZohJRiCZiRxL6Nc4O
	vDgGjUlcpjN+87I/hs+fmzgZu1royt+/9Cs1J+Z6sI60uUKzpTVKSZTnOUbHy9WFBdT9b4K01aj
	FAxWl+Bxje5T1SkerdWLfPHFqGtwoRC34mv7lZUv9bGasneus5HcRMQPbfGZZZaHTFTogPXApAL
	SP6j4gFt/wzl5rzku+aJ3Uda7/ZGFEQiuZnRGXOaM2lgvVzsQ2VJwzPgw1v5CZjRsMBI2Z2JypT
	tlm59sq+nVKy4zLWTIkVDk6vjnIjbCS06ahddxTQkag==
X-Google-Smtp-Source: AGHT+IGkIQOFiqEmXNxzFZzG41J/khfewlbZBC3x8j5mgOuLU5OdWYSntHHWFj3iwpDvjlgDAnZNXA==
X-Received: by 2002:a17:902:e54e:b0:223:53f2:df0d with SMTP id d9443c01a7336-22368bcef7bmr135603185ad.0.1740897403179;
        Sat, 01 Mar 2025 22:36:43 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c82dfsm56994255ad.114.2025.03.01.22.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 22:36:42 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: pmladek@suse.com
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	hamzamahfooz@linux.microsoft.com,
	jani.nikula@intel.com,
	jfalempe@redhat.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ryotkkr98@gmail.com,
	wei.liu@kernel.org
Subject: Re: [PATCH RFC] panic: call panic handlers before panic_other_cpus_shutdown()
Date: Sun,  2 Mar 2025 15:36:38 +0900
Message-Id: <20250302063638.7096-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z784BiUZohADyoOW@pathway.suse.cz>
References: <Z784BiUZohADyoOW@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Petr!

On Wed, 26 Feb 2025 16:49:26 +0100, Petr Mladek wrote:
>On Sat 2025-02-22 14:44:05, Ryo Takakura wrote:
>> On Fri, 21 Feb 2025 16:23:07 -0500, Hamza Mahfooz wrote:
>> >On Fri, Feb 21, 2025 at 11:23:28AM +0900, Ryo Takakura wrote:
>> >> On Thu, 20 Feb 2025 17:53:00 -0500, Hamza Mahfooz wrote:
>> >> >Since, the panic handlers may require certain cpus to be online to panic
>> >> >gracefully, we should call them before turning off SMP. Without this
>> >> >re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
>> >> >vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
>> >> >is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
>> >> >crash_smp_send_stop() before the vmbus channel can be deconstructed.
>> >> >
>> >> So maybe panic_other_cpus_shutdown() should be palced after 
>> >> atomic_notifier_call_chain() along with printk_legacy_allow_panic_sync()
>> >> like below?
>> >> 
>> >> ----- BEGIN -----
>> >> diff --git a/kernel/panic.c b/kernel/panic.c
>> >> index d8635d5cecb2..7ac40e85ee27 100644
>> >> --- a/kernel/panic.c
>> >> +++ b/kernel/panic.c
>> >> @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
>> >>         if (!_crash_kexec_post_notifiers)
>> >>                 __crash_kexec(NULL);
>> >> 
>> >> -       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>> >> -
>> >> -       printk_legacy_allow_panic_sync();
>> >> -
>> >>         /*
>> >>          * Run any panic handlers, including those that might need to
>> >>          * add information to the kmsg dump output.
>> >>          */
>> >>         atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>> >> 
>> >> +       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>> >> +
>> >> +       printk_legacy_allow_panic_sync();
>> >> 
>> >>         panic_print_sys_info(false);
>> >> 
>> >>         kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>> >> ----- END -----
>> >
>> >Ya, that looks fine to me, that's actually how I had it initally, but I
>> >wasn't sure if it had to go before the panic handlers. So, I erred on
>> >the side of caution.
>
>The ordering (stopping CPUs before allowing printk_legacy loop)
>is important from the printk POV. So, keep it, please.

Thanks for the check.

>> I see, sorry that I was only speaking in relation to stored backtraces.
>> It seems that printk_legacy_allow_panic_sync() is placed before
>> atomic_notifier_call_chain() so that it can handle flushing before calling
>> any panic handlers as described [0].
>
>> [0] https://lore.kernel.org/lkml/ZeHSgZs9I3Ihvpye@alley/
>
>> I'm not really familar with the problems associated with panic handlers
>> so I hope maybe John and Petr can help on this matter...
>
>Honestly, I do not have much experience with failures of the panic
>notifiers. But I saw a patchset which tried to add filtering of
>some problematic ones, see
>https://lore.kernel.org/lkml/20220108153451.195121-1-gpiccoli@igalia.com/
>
>I did not like the way of ad-hoc filtering. The right solution was to
>fix the problematic notifiers.
>
>Anyway, it went out that the situation was not that easy. The notifiers
>do various things. Some of them just printing extra information. Others
>stopped or suspended some devices or services. Some should be called
>before and some after crash_dump.
>
>The outcome was a monster-patchset which tried to fix some problematic
>notifiers and split them into more notifier chains, see
>https://lore.kernel.org/all/20220427224924.592546-1-gpiccoli@igalia.com/
>
>Some of the fixes were accepted but the split has never been done.

I see. I went through some of the discussions on the thread [0]
and I can see how complicated the subject is...

>My opinion:
>
>1. The best solution would be to make the problematic notifier working
>   with stopped CPUs. The discussion around [v2] suggests that the author
>   made it working at least for x86_64, see
>   https://lore.kernel.org/r/20250221213055.133849-1-hamzamahfooz@linux.microsoft.com

I agree. But I also like the below solution as well!

>2. Another good solution might be to do the split of the notifier
>   chain, for an example, see
>   https://lore.kernel.org/lkml/Yn0TnsWVxCcdB2yO@alley/
>
>   The problematic notifier can be then added into a chain which
>   is called before stopping CPUs.

Thanks for sharing this! Such an interesting discussion on what and when 
should be handled in panic path. I think I have a better picture of panic()
now :).

>3. In the worst case, you could change the ordering as proposed above.
>   I am just afraid that it might bring in new problems. There might
>   be notifiers which were not tested with more running CPUs...
>
>
>In general, the system is in an unpredictable state when panic() is
>called. Notifiers should not expect that non-panic CPUs will be
>able to handle any requests.
>
>Also it looks like a good idea to stop non-panic CPUs as soon as possible.
>Otherwise, they might create more harm than good.

I see. I also think that 3. might introduce new problems...
It goes against the general statements which you pointed out 
in which case its not really a problem of handler anymore.

Sincerely,
Ryo Takakura

>Best Regards,
>Petr

[0] https://lore.kernel.org/lkml/20220427224924.592546-25-gpiccoli@igalia.com/

