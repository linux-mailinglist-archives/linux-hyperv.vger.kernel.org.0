Return-Path: <linux-hyperv+bounces-1407-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA5682982D
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 11:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314A91C219AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B7B4439B;
	Wed, 10 Jan 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SDpSBKZA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D6405C3;
	Wed, 10 Jan 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704884304; x=1705489104; i=markus.elfring@web.de;
	bh=tY5224BW7/3IjkY5UwNCaDae9HcTzJg5/+WPa3JcuU4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=SDpSBKZAnOLO3DFkJSvDRCP293a6xEV68IB5KjSUmeLQn5G4RGABZ7Pd5CyWKf4I
	 Q2sE5dWpeDpbOqiDad3drrZks7wKlPPPiCr6DgxUJ1tEusfbAqjNHWk5cfMLkoCc4
	 URHjcWQ4vtPw7lAGih6Vnzv7VG1lY53DpYE4COO8srVccjcJLs8HXvxY+jp57zre3
	 45F612Ya5EPcj6WejT+ac55rk78BY+achTNU7vrJ0TxxVuzhqj34Bq8QiJnwehq9t
	 1XQpn90idWpEEKbpmvCDLfDKrKVzZ2Qatr8snAvQ6OXtATlynlIzFp5t3ZbqFEHlJ
	 sfBoaPM8vTSGBxjnHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1rbCKE26Pu-00LvHW; Wed, 10
 Jan 2024 11:58:24 +0100
Message-ID: <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
Date: Wed, 10 Jan 2024 11:58:12 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "cocci@inria.fr" <cocci@inria.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KCTONhzZ1zvlF5SZjQrJ7BayTBtq1VFeyAJQcMCYzcZztdwB970
 tEgvF8y4qMkcyeF40hwN74l8dTUTfEuqSbmmuIziS5yNHZbcp6Fw7IWEGTXtO3+M3+lw0DA
 DmLy5NDffGEuZW00nKLPaCCVV63M3VxI9TKeohJLxoXysSNiz2p58g4OTXbXmRZJIXzRJ+2
 IXj5ko0xyxr8zm9N/277A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8VsTKgjF7kw=;gQzASWqNdbCpILehGdiYjzn+qi4
 Br75jSeb/C5j0J96bJCnxCHa5kEwVCBf/zernQWtcDavb6tASaSu8+X5ACzeCO3MrknR+5upl
 wxCh8AciATerCMiC9WbikoycuNIpYW2Lg0U2Kq/mUQbpxIAWBD1U8I84p4Pnw7x7JemDS2tbj
 NS4Pa7zZ+Sp4ogozFvgNj8RZyEz9VAAQ32Y5uT1qsxfIaUAMK2CxiNT7lyFOKccZTny86yAv7
 1p3jzyENhzS4nqKzPznntbcjur6R65yu0WVYh46jAmHJsA02FDxjGLfciqd51zE0diCYORJA/
 ZD7hj3pJVDlavAG7LtMBuoiGcpgHKmXxRduvYbAsOYWedeGG3nKyzv+x5yiri+Bf3xIaos+aK
 7VfbEyMHB0/nLhibxGvQrZaLp65/BU1W/Rt9owh+WvQ7nflWwIYIYFeNHwL+c52oaxql2Cu47
 yUldPpDTBzK14O8ze5lIJNk941HpeqlFfhAPqVnwTOhcxSCstmJuGZyoWK2j+n0iwrBaemS+9
 qLRY9FEe6C9ADF7cVhzn9s+0RbNFAF4wekeyJorapvQlQytgeJtoVBtRx5MPtlSg+Bi7spPNt
 MBm/KC1sxlPUQQYq5hl7aZUhCW2WdHw7zVQvLgDXdND9bhlogJNnFLsfjV1CDVz89MTlPjEsg
 LjHWoqFRKVLTXSitUcAWCk6u1cZXP3Md71eUHTueQjTY21+lzwacl970ZfyaEIsa75rQ16823
 cSaD11Fh4n3VysK9nDfsGXNJPw/aLJZY4xOVtBV+4wkZ2stwUpNuyoS7Q+GRfjMJu2Oge/shX
 VRiwrs8YgydN+mJv4GMSglRkzFkTwdKTEStolt0+swgKtkmNOkxmb+WE7wJY0imnBLTZCJUA4
 QqlziK/M4gU48REOqJt5YG9EUdefuK3VRjfQoW5Ya7fT+KLVzv+8Ycr1gJmv/3VVAq7zM6lAP
 WVWJjmrSYW+NP9vEXdm6pqgj0Lc=

>> The kfree() function was called in two cases by
>> the create_gpadl_header() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>>
>> Thus use another label.
>
> Interestingly, there's a third case in this function where
> "goto nomem" is done, and in this case, msgbody is NULL.
> Does Coccinelle not complain about that case as well?
>
> As I'm sure you know, the code is correct as is, because kfree()
> checks for a NULL argument.  So this is really an exercise in
> making Coccinelle happy.  To me, the additional label is
> incremental complexity for someone to deal with when
> reading the code at some time in the future.  So I'd vote for
> leaving the code as is.  But it's not a big deal either way.  I
> can see you've been cleaning up a lot of Coccinelle-reported
> issues across the kernel, most of which result in code
> simplifications.  If leaving this unchanged causes you problems,
> then I won't object (though perhaps that 3rd "goto nomem"
> should be dealt with as well for consistency).

How do you think about the clarification approach
=E2=80=9CReconsidering kfree() calls for null pointers (with SmPL)=E2=80=
=9D?
https://lore.kernel.org/cocci/6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00096.html

Regards,
Markus

