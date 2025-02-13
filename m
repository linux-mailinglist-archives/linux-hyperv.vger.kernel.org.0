Return-Path: <linux-hyperv+bounces-3943-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3EFA33D88
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 12:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB121620F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2025 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641162144B5;
	Thu, 13 Feb 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="naP3ufPc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ousbKIBZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BC020AF66;
	Thu, 13 Feb 2025 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445178; cv=none; b=oj+e7qr/vSctVppvmlBrjUHQN6F6aFLaiAnY32rjsJjX39OhbpPHt35MXAW9igudGnbvbwo/atKQ0cMjunLfC4nrCvjhw8aWzQWQdwpvhGSxXAQqngWXMh79PrQND6hOyGU+QmP1cFwDlgCuGPLxfxYvHEV+qcHuHnaLd760HnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445178; c=relaxed/simple;
	bh=OR5nQBHI4HVMEigRRodM8Wtr5yOnyxnjuIFM4Grfh4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrMIBqAWY719cGT62i5t0pP+iyD4Al/WrIMdJE3OcoUJz/k2IS2RcIBw6Dwq9o9xl2vWGBOflyAJ2dvl6e8GMrW8yZlhFYXH0Al4Qc6KvVDZzQupktcmYpuSgfooLRfP9PEvgaLj0QN8lUROf6dLwF66We6jlOhGG8ym2urwh2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=naP3ufPc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ousbKIBZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739445174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OR5nQBHI4HVMEigRRodM8Wtr5yOnyxnjuIFM4Grfh4s=;
	b=naP3ufPcsXpD2FEyWf/FFXqJeIE9MyRhwHSSAHdavTVrc6eeElAA5iJInFZZ5jjIh+7ua5
	GM5I1LDIZFmIM1WFYFBX+1HubEHgt6GxFtGKW43pFfXdGGfnYVY/HbC8OyRLf8kpIh21VA
	ZzsgdxL1Wz/ucEbNSCdntAHxZbGd4VY/Bh4HcEwzJAdqjkDrGXdMEFO8RiximKHja3Rs1o
	P6upmhJQvljRilq7Rve85ZTBYqIN6ZN+OPUzSK83QvgTjYgV4/00nCZgwvl1MTGwUaGAoU
	m6ocA9nHxCZECrrZTNXFcwpmXgO421QHn6M1jyQGD0isCfdJTAlKzCOakpTFFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739445174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OR5nQBHI4HVMEigRRodM8Wtr5yOnyxnjuIFM4Grfh4s=;
	b=ousbKIBZbG7igG+Vjg8sEvZRObAVn+UXLCggGNkX6tOMhtzaXpdf+EcNy77m7zSU0aaQ1T
	opsxVfOCpFmZ9KBQ==
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] cpu: export lockdep_assert_cpus_held()
In-Reply-To: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
References: <20250117203309.192072-1-hamzamahfooz@linux.microsoft.com>
Date: Thu, 13 Feb 2025 12:12:54 +0100
Message-ID: <877c5uksi1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 17 2025 at 15:33, Hamza Mahfooz wrote:
> If CONFIG_HYPERV=m, lockdep_assert_cpus_held() is undefined for HyperV.
> So, export the function so that GPL drivers can use it more broadly.
>
> Cc: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

