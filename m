Return-Path: <linux-hyperv+bounces-3276-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAAD9BFA7E
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 00:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2220B1F22005
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Nov 2024 23:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3A20D504;
	Wed,  6 Nov 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8KvauNM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXy4CBfQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7251020C49C;
	Wed,  6 Nov 2024 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937307; cv=none; b=laH519bqBVKbNsVHm/20itnLaP/HuWo4m0YoL6LXLGv9b/pm44EMuBX20GHjJ7jUNgaiggLuUgCa9uJkUqrY0jKnwR3PPx9d6NI++M3EPXFDD1BoodKjjjGnJu1Mq9eAI4hK8rqH4bZRYPTFfN9q7xq++2ZBfxjfbneHv4bD4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937307; c=relaxed/simple;
	bh=vNSvR6RPvToIboxnKWjgc1Wvy57AFHKs9bVAobojDsI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9NzPtl/nqn6O7SWdxJZWCQQbQOeLxSBZ3oN9NMFCNN7mX8taNvgndlEv7MUsGaqceGcaKxuu3WZ9cNNkeLWQbRAN/KRNe5LTiLn/DOV7loVqoHjrMKyNAUU3SOXJf60U6jw6B3mXL1mvhXC0OaRW7oWog1dBIF404pp19lyu+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X8KvauNM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXy4CBfQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730937304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBXHsZBlly+B2Lt9SYOMrYNWSUlMWOnyJJVlusbvvcs=;
	b=X8KvauNMp535HneoyTufxEYHA+4BGbwzdWwnI8d/BUb3rozDITicZZo9wbfxx5QCnpLyOk
	KLFsY284J4ggbawlughRISSfc9lD3NWss73De0pSau6WJCX28BGzR8aUwWGzzt/6l3eJj5
	zWSnUxS84K0iiY+/ksroQqVmbJa5aFRyF89oppWqlWcYwUu8pPDaDIY++IXZ9rkkAmD0mI
	9pVmvfY3sHnnu4hufxPEfj6ajkjhmsSenSoofHvsGb16Da0fdhAlhJyWNMXL2fvgMO/m1Z
	MyBItZpTNC7nNbEU9xv+IoyGbpXrFfY/n8M7yF5bSq3QRBirQkEB7dG3R5IKEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730937304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBXHsZBlly+B2Lt9SYOMrYNWSUlMWOnyJJVlusbvvcs=;
	b=rXy4CBfQ8Vb+0GN983u0SpHvrdvUUJUNKP3e9bgR+A75cA0HVAB8V9Epdn/ewfNPGnK7e8
	ocs1dS5lXF1kSZBQ==
To: David Laight <David.Laight@ACULAB.COM>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz
 <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
 <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Michael Kelley <mhklinux@outlook.com>
Subject: RE: [PATCH v2 1/2] jiffies: Define secs_to_jiffies()
In-Reply-To: <6acb24504a454638848dd9adff7cb5dc@AcuMS.aculab.com>
References: <20241028-open-coded-timeouts-v2-0-c7294bb845a1@linux.microsoft.com>
 <20241028-open-coded-timeouts-v2-1-c7294bb845a1@linux.microsoft.com>
 <87wmhq28o6.ffs@tglx>
 <CAMuHMdWFAgfgM0uCrG4uMz77-Y8CFSnpL-YM_VEFuvKTPNKZ5w@mail.gmail.com>
 <87ed3y255a.ffs@tglx> <6acb24504a454638848dd9adff7cb5dc@AcuMS.aculab.com>
Date: Thu, 07 Nov 2024 00:55:05 +0100
Message-ID: <874j4jq5nq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 06 2024 at 22:19, David Laight wrote:
> From: Thomas Gleixner
>> Still the macro should be documented.
>
> I was wondering if it really had any purpose at all.
> It just obfuscates code, doesn't even make it smaller.

What is obfuscated here?

secs_to_jiffies() is clearly describing what this is about, while 5 * HZ
is not. Nothing in a driver has to care about the underlying conversion
of a time delta expressed in SI units to a jiffies based time delta.

Thanks,

        tglx

