Return-Path: <linux-hyperv+bounces-4024-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A130CA405AE
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Feb 2025 06:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EAB422171
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Feb 2025 05:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995761EE00F;
	Sat, 22 Feb 2025 05:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggntqJcR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCC770E2;
	Sat, 22 Feb 2025 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203056; cv=none; b=eXl+93ybzaKRKKbOOY5Rho+D/zVFAyma31r/H+E2uTiuLgoTXf0HqweIy2RserTr2Vw6CjXkg+nN1zSflv4XsgeLTfdrZdv4zj0QKMEhGvhDgTwMdr/MQD6QyUJxJugZxOdpN1oqjoYh/n7xgg+etsXHe7waqfXsH2Gf8l52XRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203056; c=relaxed/simple;
	bh=nkYM4x72HyPUHZHb8VHdX3lyx1EuaOkY2lCZ2Fwejl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2/cjec+0M4FPi8Rq1KpLCGxX/kebl/FPsAqNTYdeT8NsPZKMa22+DC7H7t7g6RDI1qg7/z3FZl730xNuNkYphU8r/EOISwqMvuQQAvsyEhDl0i7rSezmTNAOFBTcHmiG2wtXVKGZJPZeq60BNGBJ0RyNJqp6QgGYVo6Y8oYUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggntqJcR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-221057b6ac4so54288155ad.2;
        Fri, 21 Feb 2025 21:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740203054; x=1740807854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN6tg9jMolK9FtqTyHhvnK6PuO8bN0pSfEHBvSTQ+04=;
        b=ggntqJcR/mnOE8docqt4SI91ylMcJ4Fvnx2WaOc0UZLOvQQF1w0kNsF/T0+WEEbO0/
         KWLCK3heI27pAh6NC5JHSCctOIiw/e5Jycu+BNlVHxLYbhmIvBegmwTCU+gKecNWT+Ih
         IVzsCC3aTE+sX1bd8KdXhtayJwJGlaqaNfcSibLqhhLXD859eW/rdB7ly8Wu8l8aVs6k
         VBr7QfxsT5JkrxodDesnZGhhueJzEBdH/TxnFIc8YKZadnMPEcjrn5lY4lK55VUIDAIj
         wFjVkwNFP5ebd4tjrLmewQ2XGcW7DK+lE/kzxZRLQPq616cu1T9xYeEykydb/Jj2Cqav
         L1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203054; x=1740807854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN6tg9jMolK9FtqTyHhvnK6PuO8bN0pSfEHBvSTQ+04=;
        b=hOtMU/d3PahM8SE/NrhDvZj8+IIyovWvBHT7ZwwJAsljYFmSjNYSk3yr8HFFAjISs7
         J8W4QPskeYRVteYJUFwyONN/q3QEmsyu+ae1YMsFfbN1Dx395yS9BRU906TT1C55AdZJ
         U96c7qJaW3CqWDAwqhejiCfAmzJFgwiiWZKbevZB8qKWZ4zE8E0moNANXYDo5N2izaeU
         eY5F11nSiWQyRdcKgdVKGzFAX6UUW4yjjG7s7qwYHnKKvS/O7PbzQZzvq2Y4GI2oOO4T
         C1jQOrKlwt+Vpa7uwcuNZGabnmlJDKpOe4TEzLiAr/wLjBpInwJalXx2FUjpEdrtfeB/
         Nc2A==
X-Forwarded-Encrypted: i=1; AJvYcCVekdBH/1+7H3Rh8ZOBgSOk12E0L873zZq8vNAdBSfU7fkOH3ja+8LA3gqsKOlFIz4Wwe9oKEoNvY0h0TP9@vger.kernel.org, AJvYcCW3wkDg7HaiHVKYsY5SarO5UeaZ6YLiHZNDjGfD7ATn4yVghjor7U6NmzNfJAZWDphRwKXJvYCNoCgzp6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50AGU09GdopFfzhfYqktVmr3LILAjT3WEvJMdKI3vLubIqsQa
	i0SjwEubIZJdiCbACpmRij23zez77sN8BRfFG1/YUjjfNen5ZjYwYmbr8Q==
X-Gm-Gg: ASbGnctIvAtp9xSVqvnm5juBh6mlcZWpJaBrB4GrevH8wAgTAr3ouif/7iPfqRJY+ol
	j4HUreL5UsrF/hjnVnWHM8VhMjOwhGUyODzCGWNAQPT1dWfEW4Jx/TpIVJ9WsDgoENnWFeYVgld
	SSUC+8sMs9jgP9NNhaL6Zw877oS2pQ1j914gV3so57j+JJ2xj841jeUeTy4O5kSgP7Usm5QrlJT
	5jHQ42mFoMzcqJpwNYBYym/IHgM1hfJyiJAW7mcBO/0ntJ0k2THrT0cL/ZwH1OK6Ei73HvWgiY1
	wafSohVrFEyXvr2ighGdpgzFqwEFSDkVWJtMuo/lvg0K+gycXiTVJ4mBz+jSHGE7UGNVrkFDWdg
	V697T5ecv/YgePUq9gi3zuFo=
X-Google-Smtp-Source: AGHT+IGvHwEGKp8bifeL0bm86Y95OmaukWAjfaQ8nmw/WGiKd2nKCTPuumT5A8GKXjkriJdOPJ7zsg==
X-Received: by 2002:a17:902:da8f:b0:220:fe50:5b44 with SMTP id d9443c01a7336-221a1103431mr100803975ad.31.1740203054179;
        Fri, 21 Feb 2025 21:44:14 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364351sm146183165ad.76.2025.02.21.21.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 21:44:13 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: hamzamahfooz@linux.microsoft.com
Cc: akpm@linux-foundation.org,
	bhe@redhat.com,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	haiyangz@microsoft.com,
	jani.nikula@intel.com,
	jfalempe@redhat.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	wei.liu@kernel.org
Subject: Re: [PATCH RFC] panic: call panic handlers before panic_other_cpus_shutdown()
Date: Sat, 22 Feb 2025 14:44:05 +0900
Message-Id: <20250222054405.298294-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z7juu2YMiVfYm7ZM@hm-sls2>
References: <Z7juu2YMiVfYm7ZM@hm-sls2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 16:23:07 -0500, Hamza Mahfooz wrote:
>On Fri, Feb 21, 2025 at 11:23:28AM +0900, Ryo Takakura wrote:
>> On Thu, 20 Feb 2025 17:53:00 -0500, Hamza Mahfooz wrote:
>> >Since, the panic handlers may require certain cpus to be online to panic
>> >gracefully, we should call them before turning off SMP. Without this
>> >re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
>> >vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
>> >is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
>> >crash_smp_send_stop() before the vmbus channel can be deconstructed.
>> >
>> >Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>> >---
>> > kernel/panic.c | 4 ++--
>> > 1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/kernel/panic.c b/kernel/panic.c
>> >index fbc59b3b64d0..9712a46dfe27 100644
>> >--- a/kernel/panic.c
>> >+++ b/kernel/panic.c
>> >@@ -372,8 +372,6 @@ void panic(const char *fmt, ...)
>> > 	if (!_crash_kexec_post_notifiers)
>> > 		__crash_kexec(NULL);
>> > 
>> >-	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>> >-
>> > 	printk_legacy_allow_panic_sync();
>> 
>> I think printk_legacy_allow_panic_sync() is placed after 
>> panic_other_cpus_shutdown() so that it flushes the stored 
>> cpus backtraces as described [0].
>> 
>> > 	/*
>> >@@ -382,6 +380,8 @@ void panic(const char *fmt, ...)
>> > 	 */
>> > 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>> > 
>> >+	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>> >+
>> 
>> So maybe panic_other_cpus_shutdown() should be palced after 
>> atomic_notifier_call_chain() along with printk_legacy_allow_panic_sync()
>> like below?
>> 
>> ----- BEGIN -----
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index d8635d5cecb2..7ac40e85ee27 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
>>         if (!_crash_kexec_post_notifiers)
>>                 __crash_kexec(NULL);
>> 
>> -       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>> -
>> -       printk_legacy_allow_panic_sync();
>> -
>>         /*
>>          * Run any panic handlers, including those that might need to
>>          * add information to the kmsg dump output.
>>          */
>>         atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>> 
>> +       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>> +
>> +       printk_legacy_allow_panic_sync();
>> +
>>         panic_print_sys_info(false);
>> 
>>         kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>> ----- END -----
>
>Ya, that looks fine to me, that's actually how I had it initally, but I
>wasn't sure if it had to go before the panic handlers. So, I erred on
>the side of caution.

I see, sorry that I was only speaking in relation to stored backtraces.
It seems that printk_legacy_allow_panic_sync() is placed before 
atomic_notifier_call_chain() so that it can handle flushing before calling
any panic handlers as described [0].

I'm not really familar with the problems associated with panic handlers
so I hope maybe John and Petr can help on this matter...

Sincerely,
Ryo Takakura

>BR,
>Hamza

[0] https://lore.kernel.org/lkml/ZeHSgZs9I3Ihvpye@alley/

