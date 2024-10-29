Return-Path: <linux-hyperv+bounces-3208-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8219B4EEC
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 17:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AE6B21834
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Oct 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5634B198A07;
	Tue, 29 Oct 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VA1FDloE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4Yk+RZ1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7B194A59;
	Tue, 29 Oct 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218141; cv=none; b=F7sDMLbbuYF4e7i1Z16xHOWaXqgZY8WFNR6PDxLVgBeXxLi+u2OYOp1AZWU5qCSrwe4uoo3LDQywZ2pRWiW4zq+2kYiwduV7+uLNk/teWd2eCt3EMTZ+DlqD7pWJWx8xhzeULts1QKfDSPUdV+CPhbzNUJd0ji/PgERWMzvwljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218141; c=relaxed/simple;
	bh=FJ7ih4wVzVmz7IZ8q1hdSb13yLioBwCb1hNxFl/N67U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q48HNAnx9AfsqstJ3iznbsZIlwk0CIduWgPwr5JoMqo2EcMQLW5cx2an/S9rkWdLTJ8IEXL384wRZX1SEN6V3egYwXoO2AQaJ2RB3ApPXCeQxVwjRDmRQ7bMDXtSu5ladwBxZvVjUOTkBYt3vONNH6N8Ig2hIAs4Lpu7RG7M4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VA1FDloE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4Yk+RZ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730218137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jykMmJYhDaJHRipy5cvwqmR/xcPHbnkQh612edkXqpU=;
	b=VA1FDloEdUAMtvuS3R5YQ0Vkm/izejUl6U7ShPPX0sZJayeBaabNPS/rad/vbk0WBKoQj8
	TsIUqOPffyc6xpEb6UYpFNzy/Elyj47LWVYvkE+jjqVyGwBFGPhYNjI5ReUmWYBqBq6rCo
	Z0jAb3Cj/k32/OMF6BE9dOahy52MxTs2yEbaigKFGUd5MIIPmHe4t+Hnxv4BchpwXC5L42
	sxtW0R9ji6BXiiDryfOeKgM50/bLTExZ3h3/OmWsNxkQA05VKmENhzUPwuoHJi7Yl4ygfO
	Bwdjy0w/e+7vc5+L7SLpdksezykycncg7c6XDsGxqy3SbFOi1/RWLEnWwFWgFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730218137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jykMmJYhDaJHRipy5cvwqmR/xcPHbnkQh612edkXqpU=;
	b=Y4Yk+RZ1BRbuI+WT4ORr5kW/2pA2soW+mh+UDSs/ApLwQwyqxgd/59Kiar0s4kDLUUtiB8
	yIjflgoRX9ojPVAA==
To: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael Kelley <mhklinux@outlook.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>
Subject: Re: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
In-Reply-To: <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
Date: Tue, 29 Oct 2024 17:08:57 +0100
Message-ID: <87wmhq28o6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 19:11, Easwar Hariharan wrote:
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index 1220f0fbe5bf..e5256bb5f851 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>  	}
>  }
>  
> +#define secs_to_jiffies(_secs) ((_secs) * HZ)

Can you please make that a static inline, as there is no need for macro
magic like in the other conversions, and add a kernel doc comment which
documents this?

Thanks,

        tglx

