Return-Path: <linux-hyperv+bounces-4427-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A5A5E303
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818CF1897CEF
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 17:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4391DE894;
	Wed, 12 Mar 2025 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NY2EZKCL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y52XRB6j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C0155A4E;
	Wed, 12 Mar 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801611; cv=none; b=Rln6bgZIn1+CdsAERpOcF51BCqCukhal1XMdX1yxzW5WwKkIwYEt1L9NlniROqCbsthty9lm1Cd3MgCq65z4W4RCD2zjtsL14OAbvrgJkbVveieUIcyoyP2L4c8AswgWsMnRK84fR2Hpm6J/q7lHEuT4u+eTasOwj8SpDLmG+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801611; c=relaxed/simple;
	bh=NKCxgHuPZ4uFj78qPOvbD5XkJF4OK5o+IevOA1kfUSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekALh8ehhUj4Im1tDTTpPvYi8Vx1DePAa3BtOWPaMH12Hm+UTjrgws1QDigusNzAWXdIpZOMeQn6tIiqP8+8YzaHoVfcTUfXEyASf0NFXXb4QEPSfcRSdOnaPT3m7BjFPnJ8fZb+tzHZR4Ry+qTvocu56vreplHzz9U+ckMG9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NY2EZKCL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y52XRB6j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741801608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPfbVqo+JayHch2aOVHEH7XB7D8qrWAXL1NgHAeSYLA=;
	b=NY2EZKCLiZU2Y4wQcE4LOXg/1j2pRcNxi3Ho9trmOgRgRaS2UqHnTCqJHHgmOdKQd3DKhR
	W13TQfShCDsPCuLdCQJ8YG+y6Lzhr4Eyrla/Q60ETGo6+l+oU1s8Z5fo7ERxR7qOsNTFtI
	LcW1D/ooIcXosUCzQ9/PUPVjd+QVYfbI8yLKMam6tDgKjSp+UJZ4xrquLPnsA3ZA+xfgva
	mrlLK2cbgO/sosvRIvKJZHJx/c6yQmEo9t5nFdwg/V3a7Cinll+uwJtJDrTMyE1NGHccMj
	bg7owk+w1KV3941nd8Q40YU8cB5Huduy8d3y0eXiq8r0FuyVf7TjT1WKK5xEZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741801608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tPfbVqo+JayHch2aOVHEH7XB7D8qrWAXL1NgHAeSYLA=;
	b=y52XRB6jA0wammvGAVfdCKbqX8TE1dpTb4rvqoeLv+K5axv4dqlXpHmS+o1HhcnKxmzg9+
	XQbw0Erqc2PC/pBA==
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Dan Williams
 <dan.j.williams@intel.com>
Subject: Re: [patch 02/10] genirq/msi: Use lock guards for MSI descriptor
 locking
In-Reply-To: <20250312150835.00001851@huawei.com>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.267883135@linutronix.de>
 <20250311180017.00003fcc@huawei.com> <87senjz2ar.ffs@tglx>
 <20250312150835.00001851@huawei.com>
Date: Wed, 12 Mar 2025 18:46:47 +0100
Message-ID: <8734fiywe0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 12 2025 at 15:08, Jonathan Cameron wrote:
> On Tue, 11 Mar 2025 22:26:52 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>  
>>  #define return_ptr(p)	return no_free_ptr(p)
>>  
>> +#define retain_ptr(p)				\
>> +	__get_and_null(p, NULL)
> Single line?
>
> This sort of thing got discussed in the past though I doubt I can find
> the thread. There was some push back but maybe now is it's time!
>
> Probably worth shouting about it a bit to attract attention. Maybe
> a separate patch.

Yes of course.

