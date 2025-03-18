Return-Path: <linux-hyperv+bounces-4570-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB66A66DE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 09:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25D53B067C
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 08:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD251EEA5D;
	Tue, 18 Mar 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="lLIlbkEJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1541A8F84;
	Tue, 18 Mar 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285771; cv=none; b=b1jr1TlIWok+ojKal2aelof6iRGx2MncKi2RKhN9C9d6UhPW12bzBtWnrPARx1coqyJDdl8NYXLAD8Uvg3GOSuV3dkz8Yxuc2SRno3PcXdF9SXMKETpgGjoMTSgYsv20T1UFjXrrbARdy62b5TeEgE4uJoBqIIa+R5zc7MCOmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285771; c=relaxed/simple;
	bh=o9PpqIARMYKNl9rl5Eql67tC06Ez0ljyIXFqaTyXSpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfnn1emZuxqgP4arWSGMRpq5M3MHIQplLEkT6mW7iBXBBP6vQEUO1auk1GQ2MjcVgAMQ7Jv9z4dPk1fvEaSl6DSEysodW7Nqi24wGZlfOx98/6LJpwR3SG3JvC+iiEoj6zrdkNpuGW24epgok2mpjN+Vsf5u6yrLhRAcxuCdNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=lLIlbkEJ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742285760; x=1742890560; i=deller@gmx.de;
	bh=QRL1pbeWlCSuACH899FGlA+wi8PGFaSt0lGRJNOjIYs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lLIlbkEJxCrW4xrzMxziAFD2f0MQFrBmH9fT0ekDqS1eMy3ytRa/w2UEQ076ubLv
	 NMGJfEwwa1mdnktcPUNpqxo6dLwPC/Ov+wjJJZxunwDhvVSQ67umet/HYpgaI7GzQ
	 OXWnjjLslJgbfOxygNiULZH9+Y3mUU2cIP2+LC9Jn1bSLx3bRFuiOSzeDexbEpy06
	 A+u9YMwJTurZRabR9BWx4VbuzZm35111Pz2QJ52ICQcteGrsJlx7XyzASllggNpLd
	 ibL6JCgINpZrIC3FFjTjXnWOmBvX27vs3OfScmz0UNhgnrKg/dBDNTvZG0ExVFe/f
	 /FPdbvIbUNMTuvmp3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1u3UPL2gtv-00H6Hl; Tue, 18
 Mar 2025 09:16:00 +0100
Message-ID: <303572c2-4839-4dae-a249-9967fcc9cf03@gmx.de>
Date: Tue, 18 Mar 2025 09:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fbdev deferred I/O broken in some scenarios
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <SN6PR02MB4157227300E59ACB3B0DABD0D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h6IbDFzE9ZC39f8QGGyS33kteNG8TDJeo/g33UNpQUX7+Obx+YZ
 xmcT8aykRHC4zuorTdGKVkf7eJz9g9VwGJexJA1t/SNUFX2EHtLDxFpa5149pmeq0EgiEAg
 XfPsxigXErEWhHQYvVo+3Cpew8BTEYiKHkh8D9nBfa1B/O+6vxy9U5D5S0yluVzYdrLaiLZ
 N6/0ZLzbNTqa2aDue+BQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LckJYOJ+0bU=;8djNMexVcPxrSbksl/9o12xzadH
 rHAtx48xAZUGOmv71WLisQgOluv48sxusH8MzHLYh+856OqLf42SMQwr2eB6s2JfzGG6KgWPS
 YS+tYDdUkMuI7ya7q9WYGvQklniRNLbb0RNsh9udclZ1Spxl08AyVJnfQ7XP++iWSDiPJouYm
 2A9KekW0CUjHJksSqTKhIOXMDtLLQk2ZSCKj/bW7V9ZRn5TLLqMouz15nuuAAo3AEsir96LEe
 iHNXKVxJ8nJxWSHnrgUwPPAOD5yp2xLul6G0rxCzUu8xgy0K3xS/Phsdv5qxIrcSROu10FmlW
 GI3ync9CXEknnmw+OyU82BkPGLlQMk3Ei8jMXFkpdx7PrmmOuOnMIR+Ml2+wlV4C4ejN4NEfY
 kqg4VpydYJ7rWqWitFZPn3uhkpH1zmX2OGNrBM2xmblDT1ZVAkYKS8zJJPGlFQN7MA6WA38Wx
 PGrrOgdDGt13hFPzRqevotMLKrqMZpYFt3wQBOXt9yXZCH1p6VEWkcA6yp1YMMlbNlkq5D5t+
 9D/nO83qASq6H1x+DsIUnFx+g8KYLmDPWMNssKY9rBisD9HBfqNsfzVCtsBrkfdrgJQr92SG7
 prqzUEXM+oAIY7evw7RAHGBWjIxDYD/BiVTgx0o+8uePOz2mhcabWNK47rUkM86Z7vFrXUas8
 Fgo1D2EY/nEMVKjbS9f7WSPT8VXdRppw7NrsI6jVc+01J5igA0BhjxVpXRwR3qQ63C4LLhr9v
 SsQ9XfW9N66+4OEnIUSJGPPE7Rk7FIfko/FSycADtApyh8RmdVJMbTdfZAdneSTSKiC2UpxbC
 92kDD9U/d+kwG5aJmsWqC7GgTNjEUspR9IBQ35UISAEoXDs5b9OTt56Gs12LcwflHHtu4z3uo
 krKC5GmdJPWUTkK4Xxbe4HXvRz8mZCJ3ZFs5dGjBw4x3glcG8fhCZRpKnk9g1JOqSUIpkT6pD
 IjtOCMyVoxmcxiTkhu1OsblY4SxY+OJjRF2nIKoQ3TcQH4M56j/xqmy1BrFWNqqTn0bqb+ma6
 CFRk6Iqm966hZdKV14KBMTPiW7YvPY1dzRqTfQlO8FhMhJ6WNRUjNyck+5WdMnDcEE8p+Hzo0
 Oh48ceBr6si8nFCAS3NpY46UGDuDLDqXFIZ046dcSVHgesfhHNyy0FudeiaSGi/yCNNGrWyQC
 ePnOGu3dyV4aGgO+5DSyutanTHRU1D1c0H7riwnuM2MRdXlapd/nKnqlsjMiymz3ULAYcjFr2
 5pPQheu/4nbh1ajdtyiQ40Rt1TioqKnqF6BFxZ+mMmKAjYDSviVAZdQkgyvjMIN7T1Z/GS7cV
 uXazjkEIyYY2+/9rZtH1/0UvwouS5oq94UUhGLFSBgvf/ESIJ1eS9V3c3A2JgCE07ejd+vtJ/
 1269BTm3LwfxGwTFOAfNrJSNXzQgx0JfR0DfvWm4UpGWv3EwfU5j6XXp0EgGLFOlSoTgq+h/t
 eZ6BqaqbPxeqMWr5sl0thvuknOa8=

Hi Michael,

On 3/18/25 03:05, Michael Kelley wrote:
> I've been trying to get mmap() working with the hyperv_fb.c fbdev driver=
, which
> is for Linux guests running on Microsoft's Hyper-V hypervisor. The hyper=
v_fb driver
> uses fbdev deferred I/O for performance reasons. But it looks to me like=
 fbdev
> deferred I/O is fundamentally broken when the underlying framebuffer mem=
ory
> is allocated from kernel memory (alloc_pages or dma_alloc_coherent).
>
> The hyperv_fb.c driver may allocate the framebuffer memory in several wa=
ys,
> depending on the size of the framebuffer specified by the Hyper-V host a=
nd the VM
> "Generation".  For a Generation 2 VM, the framebuffer memory is allocate=
d by the
> Hyper-V host and is assigned to guest MMIO space. The hyperv_fb driver d=
oes a
> vmalloc() allocation for deferred I/O to work against. This combination =
handles mmap()
> of /dev/fb<n> correctly and the performance benefits of deferred I/O are=
 substantial.
>
> But for a Generation 1 VM, the hyperv_fb driver allocates the framebuffe=
r memory in
> contiguous guest physical memory using alloc_pages() or dma_alloc_cohere=
nt(), and
> informs the Hyper-V host of the location. In this case, mmap() with defe=
rred I/O does
> not work. The mmap() succeeds, and user space updates to the mmap'ed mem=
ory are
> correctly reflected to the framebuffer. But when the user space program =
does munmap()
> or terminates, the Linux kernel free lists become scrambled and the kern=
el eventually
> panics. The problem is that when munmap() is done, the PTEs in the VMA a=
re cleaned
> up, and the corresponding struct page refcounts are decremented. If the =
refcount goes
> to zero (which it typically will), the page is immediately freed. In thi=
s way, some or all
> of the framebuffer memory gets erroneously freed. From what I see, the V=
MA should
> be marked VM_PFNMAP when allocated memory kernel is being used as the
> framebuffer with deferred I/O, but that's not happening. The handling of=
 deferred I/O
> page faults would also need updating to make this work.
>
> The fbdev deferred I/O support was originally added to the hyperv_fb dri=
ver in the
> 5.6 kernel, and based on my recent experiments, it has never worked corr=
ectly when
> the framebuffer is allocated from kernel memory. fbdev deferred I/O supp=
ort for using
> kernel memory as the framebuffer was originally added in commit 37b48379=
59cb9
> back in 2008 in Linux 2.6.29. But I don't see how it ever worked properl=
y, unless
> changes in generic memory management somehow broke it in the intervening=
 years.
>
> I think I know how to fix all this. But before working on a patch, I wan=
ted to check
> with the fbdev community to see if this might be a known issue and wheth=
er there
> is any additional insight someone might offer. Thanks for any comments o=
r help.

I haven't heard of any major deferred-i/o issues since I've jumped into fb=
dev
maintenance. But you might be right, as I haven't looked much into it yet =
and
there are just a few drivers using it.

Helge

