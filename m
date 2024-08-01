Return-Path: <linux-hyperv+bounces-2645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C9944DD9
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 16:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A4B28273B
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 14:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA21A3BDD;
	Thu,  1 Aug 2024 14:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQkaNtkh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HD78aHQF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B80E16DECD;
	Thu,  1 Aug 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522075; cv=none; b=p17TYEhRBR1FXqeC4BRdV9XXgXn6lIdiKfGsuoiGSOTbkV6C8uAz8YvL7JQit/Pz4l+5NOReC+IIsHWGwmPpAs1lvfbrRT4PTwxLxAzs6L53OhjMgVSmbuk9mryGxL8cf7ZM+1HNriD6hrOZqMSDqCUI9WMhAs64BJ5n8l+H6Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522075; c=relaxed/simple;
	bh=66DldeezUXbnzndN81lPVl07zQL+s3SPThLGy8JIpCU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKLwyPi5BLuuRsLMrnfeRkd8aJqhIW0s+YVe9B+Abb+NRdOU1+s3GuLpnG5xGsmv1/+KT0SjzCnRW0r0pffk5Evgxkpz2f0d1EtI0avWzuUHkYPAVrnl7PZzKiolXvR1v3j68zCNY8VbKwHlkHaGhe4XGLEuNP639BsVOh94TOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQkaNtkh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HD78aHQF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722522069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rt3z7nmsAy1iVRNu1qoH0jivbksGRZkXgLeIxLHG+Y=;
	b=dQkaNtkhf+eC8Fsr2vcVE0tQeIUEmTHbEH1szqytac97B46ZHSfycsEpOgV+1ieDS12W3g
	WlAMOPt9+GaXHu9aOGhqw6ROajxUuGUd1J8ZTCSmbm4qYrjbh1d6L+81Ufdg+FeAsNHVD2
	rcNRINzkKyHCyfnioGsSeBBeRBq6gVfS2PDySWtr+vQeCV29Qug/nEmBwaPeYtewYjjKL9
	G7rZYUI+65HLZg0NGfXEsDaLrt57f8PR2PMyO5DhTI9sPsuadbFxPPhLgZx+ezxRUfvCQI
	T8Nz75pmjGpiYiotuobL/Q6CeOPdzbNCzqWoGbF0JtLnJ5yOM6NAhm30Mi689w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722522069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rt3z7nmsAy1iVRNu1qoH0jivbksGRZkXgLeIxLHG+Y=;
	b=HD78aHQFHPsxsif4t7hY9exPdUNsZ0iOvTiTYitsp3CVzH3SSIvXW/d+Y1n7JZfITkJf7c
	x1/nCmNpBXqBtjCQ==
To: lirongqing@baidu.com, seanjc@google.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
Date: Thu, 01 Aug 2024 16:21:09 +0200
Message-ID: <87ttg42uju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 07 2023 at 09:14, lirongqing@baidu.com wrote:
> @@ -117,11 +110,6 @@ static int pit_shutdown(struct clock_event_device *evt)
>  
>  	outb_p(0x30, PIT_MODE);
>  
> -	if (i8253_clear_counter_on_shutdown) {
> -		outb_p(0, PIT_CH0);
> -		outb_p(0, PIT_CH0);
> -	}
> -

The stop sequence is wrong:

    When there is a count in progress, writing a new LSB before the
    counter has counted down to 0 and rolled over to FFFFh, WILL stop
    the counter.  However, if the LSB is loaded AFTER the counter has
    rolled over to FFFFh, so that an MSB now exists in the counter, then
    the counter WILL NOT stop.

The original i8253 datasheet says:

    1) Write 1st byte stops the current counting
    2) Write 2nd byte starts the new count

The above does not make sure it actually has not rolled over and it
obviously is initiating the new count by writing the MSB too. So it does
not work on real hardware either.

The proper sequence is:

         // Switch to mode 0
         outb_p(0x30, PIT_MODE);
         // Load the maximum value to ensure there is no rollover
         outb_p(0xff, PIT_CH0);
         // Writing MSB starts the counter from 0xFFFF and clears rollover
         outb_p(0xff, PIT_CH0);
         // Stop the counter by writing only LSB
         outb_p(0xff, PIT_CH0);

That works on real hardware and fails on KVM... So much for the claim
that KVM follows the spec :)

So yes, the code is buggy, but instead of deleting it, we rather fix it,
no?

User space test program below.

Thanks,

        tglx
---
#include <stdio.h>
#include <unistd.h>
#include <sys/io.h>

typedef unsigned char	u8;
typedef unsigned short	u16;

#define BUILDIO(bwl, bw, type)						\
static __always_inline void __out##bwl(type value, u16 port)		\
{									\
	asm volatile("out" #bwl " %" #bw "0, %w1"			\
		     : : "a"(value), "Nd"(port));			\
}									\
									\
static __always_inline type __in##bwl(u16 port)				\
{									\
	type value;							\
	asm volatile("in" #bwl " %w1, %" #bw "0"			\
		     : "=a"(value) : "Nd"(port));			\
	return value;							\
}

BUILDIO(b, b, u8)

#define inb __inb
#define outb __outb

#define PIT_MODE	0x43
#define PIT_CH0		0x40
#define PIT_CH2		0x42

static int is8254;

static void dump_pit(void)
{
	if (is8254) {
		// Latch and output counter and status
		outb(0xC2, PIT_MODE);
		printf("%02x %02x %02x\n", inb(PIT_CH0), inb(PIT_CH0), inb(PIT_CH0));
	} else {
		// Latch and output counter
		outb(0x0, PIT_MODE);
		printf("%02x %02x\n", inb(PIT_CH0), inb(PIT_CH0));
	}
}

int main(int argc, char* argv[])
{
	if (argc > 1)
		is8254 = 1;

	if (ioperm(0x40, 4, 1) != 0)
		return 1;

	dump_pit();

	printf("Set periodic\n");
	outb(0x34, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();

	printf("Set oneshot\n");
	outb(0x38, PIT_MODE);
	outb(0x00, PIT_CH0);
	outb(0x0F, PIT_CH0);

	dump_pit();
	usleep(1000);
	dump_pit();

	printf("Set stop\n");
	outb(0x30, PIT_MODE);
	outb(0xFF, PIT_CH0);
	outb(0xFF, PIT_CH0);
	outb(0xFF, PIT_CH0);

	dump_pit();
	usleep(100000);
	dump_pit();
	usleep(100000);
	dump_pit();

	return 0;
}

