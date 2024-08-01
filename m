Return-Path: <linux-hyperv+bounces-2653-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C95945309
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 20:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B4D284BC9
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F551465AB;
	Thu,  1 Aug 2024 18:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wkXYC/Ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GiCscU2m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B486143883;
	Thu,  1 Aug 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538481; cv=none; b=rgToqwyVMDtXekMZqXXczT39rYJVssVILD7PI5ToziS50VzLZEn9ezVAOJvsfI5RjI6qNxWuaxHrsi8fi7fEuFtb0hlgF9aA/zMOmpPRfz2fLOhJaZPBGIOiDbmcBsN7F/ZUYPUD86Tvh5U0H6BqJPbV4hr6aTC1r2/kXy3mma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538481; c=relaxed/simple;
	bh=kWffsiYHwoKKNACI9laEYkWDmHZg3X6mCuJ3ldcJSKQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GsH/T0//N5YmfTRwyQV0dahc2G+RK02vVuofFvrCFuli4jBh0SPS9bZBmhtffbJKcBd5PiQmFntGz3pnJ8xnOs3cio2vDn87iTI3bniTskvUB70Zm/vR+ZYSdngH36bkSiBzsCvAQIpS2uhu51KY7urU5xib2OZfUTSnSKsjrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wkXYC/Ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GiCscU2m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722538478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M//ODzVh5P13cpCwoX7OJ9hVnwQy256PpCbS0qxq1k8=;
	b=wkXYC/KoEGmVN2GDQ5N+YaV1LrftIsSI4bi+crzYBsgmmrRpoHQ/VcOXw7o+ZW3VVnBdxc
	NUkFnm86pzkPf48X6l73d2Hsg4y+evMOhbyHx2N04g+JEExd7SqFyLAweEiUdfHtbpnkNg
	HTj1v81AvhlrRTeYbMxn1MECY/gnND2cAYGxMjZlVc7f8mntg9fOW3nWjKddJwMwL2G+zz
	6EYKjE7dGkiJg4bucvgwMCLgsv6t0PHvpTJGn3SthiW39moeWCeqAgK+NQIbKJe3cN4n/X
	kYLM84Sik6MI493AQakGSfdrDbjAjV0Ztlm7ncWsr4mrWbJ9it1cGFLyGtGXTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722538478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M//ODzVh5P13cpCwoX7OJ9hVnwQy256PpCbS0qxq1k8=;
	b=GiCscU2mwyle5h1o58MGZUqFmIqdHMWOvnDTV7MKlLhARwdHrDsMpl4YZJ4m21mVB1x8+T
	72x+I8j3OLoWWTBg==
To: Michael Kelley <mhklinux@outlook.com>, "lirongqing@baidu.com"
 <lirongqing@baidu.com>, "seanjc@google.com" <seanjc@google.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
 <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <SN6PR02MB41571AE611E7D249DABFE56DD4B22@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 01 Aug 2024 20:54:37 +0200
Message-ID: <87o76c2hw2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 01 2024 at 16:14, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, August 1, 2024 7:21 AM
> FWIW, in Hyper-V guests with the Hyper-V quirk removed, tglx's new
> sequence does *not* stop the PIT. But this sequence does:
>
> outb_p(0x30, PIT_MODE);
> outb_p(0xff, PIT_CH0);
> outb_p(0xff, PIT_CH0);
>
> outb_p(0x30, PIT_MODE);
> outb_p(0xff, PIT_CH0);

That works on bare metal too

> I don't have a convenient way to test my sequence on KVM.

But still fails in KVM

Thanks,

        tglx

