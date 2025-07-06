Return-Path: <linux-hyperv+bounces-6115-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A148AFA440
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 12:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 712307A9245
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB382E36EF;
	Sun,  6 Jul 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbhMyGGT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LX6+KQuA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0875019CC27
	for <linux-hyperv@vger.kernel.org>; Sun,  6 Jul 2025 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796101; cv=none; b=sP2N1fMpEe0iLHBQHV+j4xOf+RnTiHn6HrpEk0bwLCvxGOOyprAaIgFQY5Irh+s5IRvHRtlPw/A0yb9Ka9yL8j/7ZBkKUqhwsmqoej4x8XZ1KV1w5Q4njN6nY+Lihn13LuyVjMk0oetk6EmcxFxT/tvTSCoQczEgfsWcXVEWmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796101; c=relaxed/simple;
	bh=+/KV6sbAKNR6BW+bIeCj6/52jsDMeiaB/Zj6+XTGzbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ej/WEwLICVL6HxWfvd9990Vh/4r5RQ+gIB/Uqxev9OxVbE6x1a/EEwOJr3ulRjHotBPSkSlMUqg7rvMYNDYCS28GE3tH5t8kv+KMGwdICTz67SJxQLbFgrIUIH9dujvG6uMM949ngY8pPi7AdU7BJcVx28+2Xi1gdr3DP6+HHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbhMyGGT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LX6+KQuA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751796097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KV6sbAKNR6BW+bIeCj6/52jsDMeiaB/Zj6+XTGzbk=;
	b=XbhMyGGTSJqhFNCHyV1O7PrsQI63AG64/wW7+Naax6oyaBoMoTTP8Y0cIOLv0G0T+7Lgag
	IfN1EBstYSJ9mZgCpLCWK4Zxj8f7Kn/WqD1XIxXnl+kiFoEhCmX0N93dCsRxpfOsulQj3J
	Vh1EUOyBdPqFnogZsxX+RrlDA2gkrz41juJruOciZVYeB0oe7vxTNVDUQptE+Qg6pcbKGg
	nk9TRDhAa9zynVbgSjlvOAMG/UKrNDj9Taz9xa3ootNL5HM6Qz8xrq0OF+FNomnIHFxOxx
	teF/8aaYT6H/LeQIbFVqM2ev6nkbRXZgl3j+0G7h1ZK9xIjslTH9GWkhlX50iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751796097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/KV6sbAKNR6BW+bIeCj6/52jsDMeiaB/Zj6+XTGzbk=;
	b=LX6+KQuAH144xbQvkyRKbKQk9aUL/lB2WUbhPtw7p8078n+cdPwRsoYM24YjUi9d1Qj9BJ
	Stg7lGcQ7XjY3YDA==
To: Nam Cao <namcao@linutronix.de>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 linux-hyperv@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] irqdomain: Export irq_domain_free_irqs_top()
In-Reply-To: <20250703212054.2561551-1-namcao@linutronix.de>
References: <20250703212054.2561551-1-namcao@linutronix.de>
Date: Sun, 06 Jul 2025 12:01:35 +0200
Message-ID: <87ikk5skn4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03 2025 at 23:20, Nam Cao wrote:
> Export irq_domain_free_irqs_top(), making it usable for drivers compiled as
> modules.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

This should go with the fixed-up HV driver.

