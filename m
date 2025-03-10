Return-Path: <linux-hyperv+bounces-4348-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05801A59E7C
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 18:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031D2164EAD
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973423371E;
	Mon, 10 Mar 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ul565pyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+1cZvXlr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF5723370F;
	Mon, 10 Mar 2025 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627872; cv=none; b=qNTfa9bsJa8DUcOUH7W/ceQVy1NBgThwmf8NPE+sQMthfHRomBCObTkpQ0yD+zPPgpfc86IMgCN2kQynlG0RHauX0K81oUJzwo36kk6cFuCOg+HF+2RGVzztHsPUrWavwoWvV5FmYSxJKmNtqg/L+jRJPbwzn+8RlhaO06v2qnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627872; c=relaxed/simple;
	bh=K5a/n3k2IMqq05srX3keh8AHLyS8gdBd7xrkRpohd/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m6VUXn4oKaJjfAvKEYFiELEhZHL0xxGyhMM4wRTOkHPe41KxbmhGvc7qQjEpzxKox9lCyOXQF43O5UuangqmqS8V1rK9qNUIRvu+b3cKrULbzbaEgTFTPctwJcTs9bCk4avnKqKUjuS1ck2ct3xcqMpCJJfUTZNzWztba2bbjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ul565pyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+1cZvXlr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741627869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5a/n3k2IMqq05srX3keh8AHLyS8gdBd7xrkRpohd/k=;
	b=ul565pyZF89oi4JPI3tSen6XWAClieQ3+K2Jw0ulUf9HsyzlA9tTrswXT1P+mYPUizhFlZ
	UfFMAsBZuk9tbR+Zx4PuGnwQ7vtqL40FjUsEblDTCwDdSI9iRd1DnOCbVBzd5o83YP6vPZ
	fyaDNG9XrU+RmIJ6mtn1zC+WwTwVuEj9dH35opr9agmxNva/49B47aXTx2exzj2sfdowEb
	tAUCvnesb6/+q96pvKa5OaQxsTDU7WgGXu6e1GGThxpHayqYCE+O5Mk+Fb7wxlPTqsLo+T
	PiQ1MCddzDQht5fvF1dyFxGL+0bv+wHBIcURKLd3nq5v3bOiP8yxY87OjP0KsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741627869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5a/n3k2IMqq05srX3keh8AHLyS8gdBd7xrkRpohd/k=;
	b=+1cZvXlrO7xL17nKz0wAoF3KK5YeFS9Q7mzVtMeDAU1hO4zhZyymaYoKjN/77vVzbho1hb
	zzTSCVhRPHG6TNAg==
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Subject: Re: [patch 00/10] genirq/msi: Spring cleaning
In-Reply-To: <20250310165146.GA553858@bhelgaas>
References: <20250310165146.GA553858@bhelgaas>
Date: Mon, 10 Mar 2025 18:31:08 +0100
Message-ID: <87r03423oj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 10 2025 at 11:51, Bjorn Helgaas wrote:
> For the drivers/pci/ parts:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I assume you'll merge this somewhere, let me know if otherwise.

Yes. I intend to get it through tip.

