Return-Path: <linux-hyperv+bounces-6378-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31001B10925
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 13:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C7B5830B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1916271476;
	Thu, 24 Jul 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NMbp7w2o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3C2459D7;
	Thu, 24 Jul 2025 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356420; cv=none; b=c2/0uif5aAyltCYjtVierLgljMNI9NGlXvE5irU80sD3Wzb9G3umuE2J9SDAS0UWpMVIZ1zGRi2l9alThftQNnRaalHIEn6VWGjy1DXqyZgEDg8pjN/bvht8WDi2cVcpIagASHULJ+r4Ov0LLH+YckaH7KaB4pPhkbBLnSPF0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356420; c=relaxed/simple;
	bh=ZCDc1imp8AixzFdeyIVo2S7GQfCiGmC3wVqpiHjvD0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dY5dRBPDoD+qyb6uXSPyCmDfhvx75yU1OEz1R4aJaKf3iL/JrF0AzSQSDzfw1AwqERd7j6UrtvLK83q0ZyomDAOcEVmBXJ/0MiWPbwnrzTNszGQ4Qyr5W0oQg0g2+xi0IXrUufnZEsqwFbCRd1QS4khaGFywBKoZGA8Rl68YJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NMbp7w2o; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753356403; x=1753961203; i=markus.elfring@web.de;
	bh=ZCDc1imp8AixzFdeyIVo2S7GQfCiGmC3wVqpiHjvD0Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NMbp7w2owEFWge4MwpWyjA556xL1hWg2Y0+bw8nIX4WAQrPEIYBnkqOk4/6a7lTF
	 w5mK1RmT21WShUrz4nZRJJesON+lqAzrF637duJ+xCuyANVokNf7KmLUUVBe6FtvG
	 dQxmL5B97gAzaeV+aW/4qLnxNw6AFN5HrmHTQEIyv/vYgRc8+aiRDgUJGGfmXNxNv
	 SfAP/8m4xZyUol3baHfbf7DjD/n7elJ+0rM4Pbl3N8PvDOeH1Jkynq2MQZUWf0Zyo
	 ITecw5H6vewAnEmw1ZaDyunhp73Kq1FTAkFWiMS77jGUQEZfjDsXck6hGlWqTrxrl
	 bGB3oh7PY4b/ylnl1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MG994-1uvPos429c-007q15; Thu, 24
 Jul 2025 13:26:43 +0200
Message-ID: <8cfe5678-b8c0-471c-8ad2-2c232c4bbc24@web.de>
Date: Thu, 24 Jul 2025 13:26:41 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Drivers: hv: Introduce new driver - mshv_vtl
To: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 linux-hyperv@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <fe2487c2-1af1-49e2-985e-a5b724b00e88@web.de>
 <558412b1-d90a-486a-8af4-f5c906c04cca@linux.microsoft.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <558412b1-d90a-486a-8af4-f5c906c04cca@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C5N/36HT0gzsQNtQEb++wjbKpofdAZN1wXYHoyuYIuMaRyRGjT8
 MrJHg875tbluX+Oaw7EsLktrCBr7yN73ZA4wGnyLxCKb2S+We2hxQ0oamYQXT6mMu0CR7JF
 MjGjWVKrfCSE4nvgw7NdgWbbKG5HM82Isdfx1Kqe84KjaZb7ZJK//olH/h2JiqdZjVITvu/
 erXPFQxZVFwJp+5Qvrung==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7oabOFTcams=;egVRZqWvJJnq0eXv6SH9jZy//XO
 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
 RQ38IOXHvsRXIpjMtjrF/UE=

=E2=80=A6

>> Do you see opportunities to extend guard applications for further data =
structures?
=E2=80=A6

> So I actually extended using guard to all the other places where I was
> using manual mutex lock/unlock. I had to reorganize the code a bit,
> which made the overall flow simpler and more robust. If I am missing
> something, please let me know.

Can you imagine that similar adjustments will become helpful at further
source code places also according to other pairs of function/macro calls?
https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/rcupdate.h=
#L1155-L1167

How do you think about to fiddle any more with =E2=80=9Cconstructors=E2=80=
=9D and =E2=80=9Cdestructors=E2=80=9D?

Regards,
Markus

