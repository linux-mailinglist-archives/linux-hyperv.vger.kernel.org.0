Return-Path: <linux-hyperv+bounces-1988-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E18A8EBC
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Apr 2024 00:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0991F21C4E
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Apr 2024 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652F480C14;
	Wed, 17 Apr 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b="TwPGGHTi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE98312E1DE;
	Wed, 17 Apr 2024 22:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391708; cv=none; b=N4CeR81hhRx7RLGCQwnahhDMckNRJfwGXRguIld4xvFZlICbQSnmoR5zdXEk7SYKqjTvfZ1aywGLu8z5Weg7ZKZdkONaOOiK97xf8xpFYoJUSP5yPI0xz4LKRKlDksa5zNWd7LGn4lQg01uOwjmbwPZ+NBz4qTqYWaOVkeiAUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391708; c=relaxed/simple;
	bh=mEM8gHXG/HxaC8h69ROEnCM+V1EJ1N7csO+Pc0JoaIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngUlM8F2wpkohmfK3KJS3Xe8HZGxiSTbBEWWjjtvwkqXux+5Ora5IGSsb/aOEfaNygwJ2Mrq40FRm3X5pUimDyUXIl3RugMbk3Q+32ZnTGHngCRuIBZmXqGbNlBt/LSsVtBUHahLhDBq/6TyCf2goCbw6BdnDwIa+d51dRd4Bn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=schierlm@gmx.de header.b=TwPGGHTi; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713391701; x=1713996501; i=schierlm@gmx.de;
	bh=mEM8gHXG/HxaC8h69ROEnCM+V1EJ1N7csO+Pc0JoaIw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TwPGGHTiibQIqYRZzgJePwRjI/s0G6R7rt2hfAOJOVhqlQGi9C6tuSYQCjjRHmxk
	 zXZNuF73Yuq5Duq00sk406HG15LU4aDY29AUXLz8W1iJdRXFUptixqz0qQlxP2ydh
	 0h/KVKA5Ty57IUCS+0WUySsYZIJocTrFn3o9YRev2x6MNdZiDWpJfDlq8pvwA7vtl
	 H62U61dgHRirpyMxpWg30UQvIV0jW58eS6sTJQ0EntTWm91KluvuXC94/vZGxyHPB
	 ZC1YMNyUliCMDs8AKX6Xt5Llh0EwXjEe/ncy6xScnpdIpc47v6/DU+wx4j+KxVZtK
	 etvQYyZhHirzQcp3fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.56] ([84.145.176.14]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoRK-1ruWYt24LW-00EqgY; Thu, 18
 Apr 2024 00:08:21 +0200
Message-ID: <143afb82-dcc4-4fd3-a851-a03b01532694@gmx.de>
Date: Thu, 18 Apr 2024 00:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: dmi: Stop decoding on broken entry
Content-Language: de-DE
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
From: Michael Schierl <schierlm@gmx.de>
Autocrypt: addr=schierlm@gmx.de; keydata=
 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
 uxTR60TDY/d6Kz8=
In-Reply-To: <b702b36b90b63b615d41e778570707043ea81551.camel@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dIKsefGdEySh3Ykba5hNpP8J0uk+A9B0UDyZ93+aL//4edatlHv
 mL1GzioOT3Wbi7U1aYxhk+97wyyOEkT5/tyhhLv0Sos5FGwfUJuqEjc3AXedmmI+b13zjVi
 B8rxVIzwapQDYWNxw/MkEUmuvfaflQ0T1Qk+N+Z0ctHg/vi+afxwcF1V4kKibv0GvOGrR9r
 JwG8UUYJlsYvxN7Owz4aA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rcZhV4wFv+0=;HnOqxM3K3kp9qAvmz3WXmQ1gyWh
 PLDLt5gH1pFRY6oIWjYMScD2GV7Oq9OJ+pt7Ufeo+IIXpZKkZNMQwuhNMgguVYPNluxaHl80M
 gFnZPE9TgA94MCOlj0U9BTaP/dq6I1O09TfklOHQ37hNvAk9zv/ohkxjcuWdz4WwfQ43p0l1i
 dHAsi67wxdyB0m8Ke3X9MrJUhChCv48l+ujhLdJWkIXHUQfYTu3vOfRHljDY2PFwYbrchOEHB
 CLOSeu6i05SHeWr9fvHmzuTKUiNL/VdSt0ansuSBadfx3a59g/+4QmrVKiBhSGTryAfOMdEg8
 BGUFgWQeHZftMG5z/Bf7keC3bZajYaff/VPhxQHxVMbsY4ymJhjPuPdJGg4CznwbfoPfba8JS
 NQKZQXH3VfOO/t2NfVE4FtBMus6XVgisgxOHisQKFfDoCNchU5z9NUL27PSCus7PfKB5peHm2
 1o9jgHU686R+dhi4+pUXsMagVdM5pQPCoOYF702nAmA9cYChXtfwUjv2CO9tMlukc4NWY44ju
 kZ/CVl7HjirY7SjCmfmvp1jveU9LTD61T33QcbKjkLJtVlBiNaadD/NaCTV2ht6iDWH6+jvUZ
 0/VRtw0xQHa4ODFz/iZkutdOJ7Z6UQnYHtqCGUmUYBwkDh9D6iS3DR9o353KE/2FwykDnkQB4
 u51hPZu8pkPTGvw4z/zOqGuHE6A7I/hzE6EjlBVmE6Y9GjtH4IfbwkiXVEwLaSZCIEKI3WQgb
 r0cMz5JiFp/5IdRrmCgRRBQCpsw6N7hU7UtU+tKrMdrlZ07EaHnuAywV7Tg1TkT4OZE549EOG
 7rVcq2FJXIFfoxeheCuN/sa/ZZ95Hyg8XEkmlYUGuWYUE=

Hello,


Am 17.04.2024 um 17:33 schrieb Jean Delvare:
> If a DMI table entry is shorter than 4 bytes, it is invalid. Due to
> how DMI table parsing works, it is impossible to safely recover from
> such an error, so we have to stop decoding the table.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Link: https://lore.kernel.org/linux-kernel/Zh2K3-HLXOesT_vZ@liuwe-devbox=
-debian-v2/T/
> ---
> Michael, can you please test this patch and confirm that it prevents
> the early oops?


Tested-By: Michael Schierl <schierlm@gmx.de>


Applied on top of 6.8.4, it prevents the early oops I previously
observed when booting with 2 vCPUs.


Regards,


Michael

