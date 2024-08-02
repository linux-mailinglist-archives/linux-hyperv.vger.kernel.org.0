Return-Path: <linux-hyperv+bounces-2669-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD53945C71
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 12:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45391C2175C
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Aug 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACB1DE85D;
	Fri,  2 Aug 2024 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sm/p7mRZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7cjAgSA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780F1DD3A3;
	Fri,  2 Aug 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595775; cv=none; b=GueCEa1g84GvODgNttawSgfPj5A/Z22icsYKpq6/oSB0ZrV8MHEL47GQiv5QMhZDfGsDjDu94MNhqu9Y37FZqhf3KV4NxBsmrK5nPHj16opsUU5Qa/7GjJe2dfuPM56FdXU2U6NnzTLuUictgUUlOEsYjsM8SncTch6qPioVn8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595775; c=relaxed/simple;
	bh=uKD5n+Fyw0Tc++G+1tWBwfRqWW4+SIcM2EoHyUoa6Ys=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSjYwcBn5LcCnblyoaO/yG/vo+S0TgLAXH9B8aRvWCBA8Y3HtmQRpLte83TW6RkGDyURKvyrcySscQL9rOgfzzO4+v5KKk218TX94oiibbKkyRlaIWQHrM8Ukq5Pe2wuO+RIWwmJkNttfKzZD5QGWjNAdvwPi/1n1nVreaxQWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sm/p7mRZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7cjAgSA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722595772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQt8wBPDiuKy5NmhfMiZCL2jdGAW+eRJfAbnOWADkhs=;
	b=Sm/p7mRZvo7SS9biUuWJoGsAKBrMo1ThxReiCIdJOiZuzc8992sPBMqu86aGNaEvT98rQ6
	n0EkpqrGZ9BtNm5M3l/gbe5HeWqXS3IIsbNhoQ3mU2Y2M+yoBK9gQgG3lIG9UDri5RmbwK
	pgRJEglOg64v6JUUgDwsU0aKt6n6g7vuzF4KXTlFC9VuLXHS0Yg/3JLK9oioDHLeSXiSGf
	/9vDcPF4QQoeM1p0JKM1vv9iGVL8j+eFcgGQtzCVN9eWeCJILpQTUG1Mnz05GPs/AIe5AV
	7Bk6GqK3I1vyUi6DeWbuHtCC7C07z2pnbzyP0Wr+P1mxFzynF5oQ17KeeSWdWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722595772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SQt8wBPDiuKy5NmhfMiZCL2jdGAW+eRJfAbnOWADkhs=;
	b=X7cjAgSAAz4Fw7ci80yDFlWubGjjgzyUmarxj5H+Oozgd4vRyX0oST3WaeEpIucCYBWjGG
	z2eVaAcL4XECMrCQ==
To: David Woodhouse <dwmw2@infradead.org>, lirongqing@baidu.com,
 seanjc@google.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
In-Reply-To: <56d3780bc42c98721e15129b7fd53080c4530760.camel@infradead.org>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
 <87ttg42uju.ffs@tglx>
 <e9a9fb03a4fd47ebddc3bf984726c0f789d94489.camel@infradead.org>
 <b781a3f94e7ff1c2b49101255d382ab9d8d74035.camel@infradead.org>
 <87le1g2hrx.ffs@tglx>
 <56d3780bc42c98721e15129b7fd53080c4530760.camel@infradead.org>
Date: Fri, 02 Aug 2024 12:49:32 +0200
Message-ID: <87plqr19oj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 02 2024 at 09:07, David Woodhouse wrote:
> On Thu, 2024-08-01 at 20:57 +0200, Thomas Gleixner wrote:
>> It's not counting right out of reset. But once it started counting it's
>> tedious to stop :)
>
> My reading of the data sheet definitely suggests that it *shouldn't*
> be.
>
> Mode 0 says: "The output will be initially low after the mode set
> operation. After the count is loaded into the selected count
> register... the counter will count."

Hmm. Indeed. That does not stop the counter, but it prevents the
interrupt from firing over and over.

So fine, we can go with the patch from Li, but the changelog needs a
rewrite and the code want's a big fat comment.

Thanks,

        tglx

