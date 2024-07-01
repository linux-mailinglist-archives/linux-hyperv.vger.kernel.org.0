Return-Path: <linux-hyperv+bounces-2511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418A291DB70
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738BD1C22EBB
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FD53804;
	Mon,  1 Jul 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="H/D+Q2VC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5842C859;
	Mon,  1 Jul 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826272; cv=none; b=lNqqlkjD5ME3IIloUL1b0yVqhjmhlSJ5vvXWnv4XeaZHQIDtgIW/gxVfxSE6Wf10iatJUT/lLOIeU6pUu6N34O8BSMRheSeXR+jslUHCjht3zhvp2wMclQHfm3gdANIUnwIwG0q5ARU+PMINz5m6ZJHXjvsbxVqMtFrF6vaM6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826272; c=relaxed/simple;
	bh=U9zvGVR6EM9VmPPgkNfEiRVaS2I3tAhr6eAPgnKQLfY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZSLtGfxyNSgSKfqCErz3g5wAU+Z9wMonWxpX3KZItzS3hJEwqJBySXxi2LILAQMle2ldm2GcetjMZ2oBCFnYk5p5c8iLoSGlXCpFeuI7Z/pCeoPbphMYgNpk2TTBqjozXd5BzIkcoR7da/FRtnfjKnS8XCPRPWRup4nIuT/fZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=H/D+Q2VC; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719826236; x=1720431036; i=markus.elfring@web.de;
	bh=0n79Gfup/hAkeMvlN7WvUCrlNjugDCmGLSow+BGQudY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=H/D+Q2VCEGNpgZjCQoz5qfWGbAGoxvEpb3BnHr6WhxJa238nWq3xEx3tNKKhrcsX
	 +vqj7W5CY2Rq3U/4a7WqR3ZMyIF1AG9hlc9OpUvQ+gnb2GaHRCKw5EhsE/1c3JAH/
	 uuisi/h97NoYLKf/IvE34dwAJ28Af+bZdBJfa5n+3RtqKb+MCTYg0ODQNsKhiyPN8
	 C1Q7Uj2iTFcUNxar2lfbCpCnQuI/dYvpfTz+lrJNDtU0i5BN+HM45K2XzbWE+szjZ
	 kDXtkQIf0RHI2HywE3mEDtqW6LNxjE94eQkrJQ2HkN7RR7QPhMcxEdiMazPZ8cAyM
	 el8AMWLxoNGPgZaaWw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0Zns-1sCABs1tOm-018I67; Mon, 01
 Jul 2024 11:30:36 +0200
Message-ID: <6e5dffe8-69fa-4d91-8cf1-136265bb5500@web.de>
Date: Mon, 1 Jul 2024 11:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Haoxiang Li <make24@iscas.ac.cn>, linux-hyperv@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240701023059.83616-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] Drivers: hv: vmbus: Add missing check for dma_set_mask in
 vmbus_device_register()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240701023059.83616-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oj/fHA+sMZUu4U5nVZUuyMGcCxNNLJ8V8FmFWYOwlpnsBvPbOmw
 VsYOXmr6EXKAUde4IUSN+xXPQALYyhWCkF0W683c21KV5aqbdt0EBckVJlJgq8o9e/PCZDG
 0b1a23dmIcN417xhKaQDL5VJjuPqc8rr0mnPYxDkJ95lvnpAfK1nzEU58aJiWW9kJBFw8D4
 bBJxD4aZjN9Ytf3WPvylQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nqZCyd0z8HM=;0q72lLX8mmvOxhJ5Agdviowh1UU
 TkZ+qORi6u9sNW+4yjdp8/Qc/VkOHdQREMhCtOSzkkwUR0Za11AoxuIgLcPrAWnNuOGrxj+m3
 HDJqzCBm2VF18Xh7yQxzL/MWk3bHFptjN2dyJc1qwMkRV3mJPiu8e/+9MNpCLq0cIK28Ciob6
 iUro3RzxdrUf5eJmENHJsJRY7xfxvyzMXy0X9UhYprRTzNuPbq4irRQIucQIXXlvK2YhsH44B
 a/e7PYhATvE2AjCQwRDctxldwgSiYlNzmbO9+QRn/IMXpwcLMysORi2t01JXVz8Ege0fjaEVk
 Bo8vb61rlzu3LWVdpaq/hrb1zFPGaoZzcOKrKRs3ke0mOnUhpYMu78LL4wELLxQXANx2uuIi5
 wgsXhnw4W9i1bIM1z/s1VHqlhPfuAF2qYGJqxsomihXlNGJ5HsCJbNOnEvgkrJv3vIf0liRkP
 kFbec3C/kdMDPsEhUl1Au5TurYB3crGwDo9q/noyYKUnBLyASdyi/ueormOitoDno4MRLgl89
 UeAGZDcBxQVIdn8pW3E7BP7ChwolkTyB3076Jwp8Pvz8TD/M3cnjt01KAsFnVZst4uaZwQSRu
 ff8VLNpwAB7quC53cDfEWFw06vPbozchbvhZZYbH0qnXOfp4fMRbEi4sQb9dFk9//aoLaRzTO
 ZK/nhPEujrgiMHPQej/Fhkes1P8DkPBIm9nRlyrjJcjGNJ9nFupamutkf07eWk0EJnAMZsHKD
 Ip1XfG+JDzgZTF+72VMX6kVSApklwi7TOF0KjXZdac+eVfrXYCMlWi/Y8IcCWXZp3nand/kRF
 BXgAmp2bB1YulO80ylQZL7XznVi0cAmSLzmTMEsYknD3U=

> child_device_obj->device cannot perform DMA properly if dma_set_mask()
> returns non-zero. =E2=80=A6

Another wording suggestion:
  Direct memory access can not be properly performed any more
  after a dma_set_mask() call failed.


See also:
https://elixir.bootlin.com/linux/v6.10-rc6/source/kernel/dma/mapping.c#L80=
4


>      =E2=80=A6 child_device_obj->device is not initialized here, so use =
kfree() to
> free child_device_obj->device.

How did you come to the conclusion that meaningful data processing
would still be possible according to such information?


=E2=80=A6
> Signed-off-by: Haoxiang Li <make24@iscas.ac.cn>

I find it interesting that another personal name is presented here.
I noticed that some patches were published with the name =E2=80=9CMa Ke=E2=
=80=9D previously.
How will requirements be resolved for the Developer's Certificate of Origi=
n?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n398


Would you like to append parentheses to another function name in the summa=
ry phrase?

Regards,
Markus

