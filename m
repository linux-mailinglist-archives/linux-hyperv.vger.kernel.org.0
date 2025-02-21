Return-Path: <linux-hyperv+bounces-4005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0035A3EAB8
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 03:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A4D422604
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 02:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D736C18B46E;
	Fri, 21 Feb 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyQ5B6hW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAB286298;
	Fri, 21 Feb 2025 02:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740104636; cv=none; b=mcvPgMG8gCg4+p03PNbD90EufgUIWAyZny0APyQ33H82ypc9hd8K39NZWuVGCCb6s/LDK8pAUF5VG4nYq6Z6c4JJDWNKRN9CoN+kRI1SkxX+M04zXTD8z8Jje7vFos3jdq5xnTKZK1dDtWexMY+k010nad1WvmoGatB55oQt0Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740104636; c=relaxed/simple;
	bh=a82ArUzJQoYcMp9cxaHRf2oYxjAFMyRNIXGxoZAhWfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DC/gcjeJpC7Np73sFYuRYOmGTexGlC6ROylUoAKVkUAtlUkv0gcZKRKcxzMx15SI8LKRtt4UeHAk47SBdy0vEERjhs9g5zb8kRJNjAQd5faB8RDE0CMU6R69hZL7Y+STHkcFYZE/leIslwE/hrarbi4ZvENN7EfzX5lidlOxNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyQ5B6hW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso2507676a91.1;
        Thu, 20 Feb 2025 18:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740104634; x=1740709434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfntiJ3fYBa50PKAKPPdGY8NPBu/yzhOMOvddXZwlJU=;
        b=VyQ5B6hWhIvMCzYUEHhGxBGGEQo/2m/D76ja0BsoM6XZb6j2srfjDtfyB/qUkpfdVx
         3X6KWgMuEUf9bcnF4Sbi3PjfP8bP5hKcdFzxyRCacuhurPiC5qh4762bFUTu8pVlSt0L
         lEa6nz1H1kgHHA6WuIKidqEj0S71+0b7r3WOCuuWMbvgk11hz8MQ6UYd7kJhk5xAUY3p
         7APbND4GFOXl7uISGKbr9A2s826qavOVRJg/7zAo+N6UqkEY5Z2NZY0MDMqvrdue/USz
         nIzdGg4wkJUGmS4E339FV3H+98qjcmbKB8eLszE1FjE0LRNIY4Sk9mk1w5EiC1kk7pN6
         0MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740104634; x=1740709434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfntiJ3fYBa50PKAKPPdGY8NPBu/yzhOMOvddXZwlJU=;
        b=sEezOYUJQyUyKE52+KwG0jAmLLwjYWot6wlcpwv8ORtm5CvgvJqwmfBmBPioyzozA1
         C7u/XzkFRj/na8rFWZbDL9hh9al/A8WCengK+ED1YFkUNao44DWokcssl58QBkvV5I4c
         zNwxPj6QPcNNIbfyEE0+NRIB+qfIq3Iqa1PX9JKiCr5rINoThaHsr0qT1cAG8WHtU5nK
         jMTy7QJtgTMYPJFaoxKT9BWKKEnk9X+xdwAvoQYanpAZQSJzTcDALxG6MnrT8fnYYpW3
         8qjf5n7Tnrykja1gwhZMCICc6ehWWpc+E9zZh6c691Y3dyvRcSKsqP8l5sMK73hw5B0r
         6z9w==
X-Forwarded-Encrypted: i=1; AJvYcCUk/bxmhypdfF1PdH+acd4YlPCBldkKHdCZCB3EZIn6791IJsA2aSNnbAAIdJa8NEHWcS88BEN1VW/zTjum@vger.kernel.org, AJvYcCXoHZGMw4SB7DHBg06s0+QgZb/i0z74iXJtr0l7JurmLqk3lQA/D/KigagG8CHbtIS00FPogp2qPTnh6qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywad8dHMBZTKzIzbxNUsas+V0B5v/0QrFeU9VYxnk4gcOUOdDfj
	7OXwaMghScG4Bs415u6362S8fgOq3EneAy+dR/VkUPmlCh3XfPn9
X-Gm-Gg: ASbGncvP5EdpIr38J47TCsOZQkVnQU7iF1QM3740LwM+QOONOZ5PI4/z/1iAekjVWvZ
	UrCnWSJo3+2D12nyexhUvFpPhr8wlP5iuCivNXBPjqHGvOnEmFLWZEsdB03QrnJOC/Tc4WqIwjr
	vQZPmrUeYZen0mGJm+JpkjbGEPr7q2voCLadWC/MxOundhlkp7fFalm4j7bujDNWMwrE+JR0S+m
	KZyiUPD7ougWOQ+vJ2H5JdYkJWe+j0zhSHzJERAJNnTcqvBLn7gv5QqQLW8bzGFDfAhSOKocj7e
	iWH/diWVxNvurp3W5WCQ+bsAxLSi+O52KpDJjjSsq0ZgTQMs//Oi/aExo0BeXEX0mPhuf1x+iLt
	FciyV2B3bnKiB
X-Google-Smtp-Source: AGHT+IFrVYcY+5mfs4yqK5pW6TklQ6vVhp0egUh2wUZJJnoFqTzcnMio+PLM9VRHLfREmSaQCB7cLw==
X-Received: by 2002:a17:90b:1e47:b0:2fa:229f:d036 with SMTP id 98e67ed59e1d1-2fce7b356d2mr2424030a91.30.1740104634468;
        Thu, 20 Feb 2025 18:23:54 -0800 (PST)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb065299sm157916a91.29.2025.02.20.18.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 18:23:54 -0800 (PST)
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
	takakura@valinux.co.jp,
	wei.liu@kernel.org
Subject: Re: [PATCH RFC] panic: call panic handlers before panic_other_cpus_shutdown()
Date: Fri, 21 Feb 2025 11:23:28 +0900
Message-Id: <20250221022328.47078-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220225302.195282-1-hamzamahfooz@linux.microsoft.com>
References: <20250220225302.195282-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hamza!

On Thu, 20 Feb 2025 17:53:00 -0500, Hamza Mahfooz wrote:
>Since, the panic handlers may require certain cpus to be online to panic
>gracefully, we should call them before turning off SMP. Without this
>re-ordering, on Hyper-V hv_panic_vmbus_unload() times out, because the
>vmbus channel is bound to VMBUS_CONNECT_CPU and unless the crashing cpu
>is the same as VMBUS_CONNECT_CPU, VMBUS_CONNECT_CPU will be offlined by
>crash_smp_send_stop() before the vmbus channel can be deconstructed.
>
>Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>---
> kernel/panic.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/panic.c b/kernel/panic.c
>index fbc59b3b64d0..9712a46dfe27 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -372,8 +372,6 @@ void panic(const char *fmt, ...)
> 	if (!_crash_kexec_post_notifiers)
> 		__crash_kexec(NULL);
> 
>-	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>-
> 	printk_legacy_allow_panic_sync();

I think printk_legacy_allow_panic_sync() is placed after 
panic_other_cpus_shutdown() so that it flushes the stored 
cpus backtraces as described [0].

> 	/*
>@@ -382,6 +380,8 @@ void panic(const char *fmt, ...)
> 	 */
> 	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 
>+	panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
>+

So maybe panic_other_cpus_shutdown() should be palced after 
atomic_notifier_call_chain() along with printk_legacy_allow_panic_sync()
like below?

----- BEGIN -----
diff --git a/kernel/panic.c b/kernel/panic.c
index d8635d5cecb2..7ac40e85ee27 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -372,16 +372,16 @@ void panic(const char *fmt, ...)
        if (!_crash_kexec_post_notifiers)
                __crash_kexec(NULL);

-       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
-
-       printk_legacy_allow_panic_sync();
-
        /*
         * Run any panic handlers, including those that might need to
         * add information to the kmsg dump output.
         */
        atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

+       panic_other_cpus_shutdown(_crash_kexec_post_notifiers);
+
+       printk_legacy_allow_panic_sync();
+
        panic_print_sys_info(false);

        kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
----- END -----

Sincerely,
Ryo Takakura

[0] https://lore.kernel.org/all/20240820063001.36405-30-john.ogness@linutronix.de/

