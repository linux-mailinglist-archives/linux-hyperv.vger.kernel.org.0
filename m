Return-Path: <linux-hyperv+bounces-1423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D682BC2A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 09:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8121C218D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jan 2024 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A645D73D;
	Fri, 12 Jan 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qijx/7nz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF85D8EC;
	Fri, 12 Jan 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705046793; x=1705651593; i=markus.elfring@web.de;
	bh=iWbAIIX+icIq1JZBkElELi5uXNmg4ALYaNAZh981698=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=qijx/7nzPqlnT//NFyw0JGNqY28EfV7RPyyKO4yBeMogZW+8HHyYL6S/eA0agdiL
	 IB3nAer+ItIbrIq5UTFCZ7Dk7iYdjTwScP977GZpMjkcW98nb+U/9fl13vcmeVeu1
	 n1Iry9KMJWu3OFVr97h7S02OtzfeUiNkw+sf0Bs5vW5HOIonwC/HCMXnOsBWuH8EE
	 mI+u+z3Ky5ZhQNfsvbm3btRnCiwKDR6GZf+LuDQlGVj4SfV4BM4AmlGdR5j7GuF9H
	 X2ZqWamQ1lQR2wbwQH+SGfHwG5R9BPHR/5JtYWpS4Qt4lzDcsAWwnrSzUSj9poWrO
	 TDCnvNwXcGXnXE+8uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cLf-1r3KAe2iov-015dSC; Fri, 12
 Jan 2024 09:06:33 +0100
Message-ID: <de6c23b2-aa27-494a-a0ec-fe14a4289b38@web.de>
Date: Fri, 12 Jan 2024 09:06:25 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup
 code in create_gpadl_header()
To: linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org
References: <20240111165451.269418-1-mhklinux@outlook.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240111165451.269418-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ELgOWWzRZdGa9pAS99UTIjbdlACwEMf4d6E0mYuJ4b8U+LDcBdm
 HUpYCbXwslfhQuVPn6Ibd9g0mHpWCcha8Z1TNbbHFYJmMd4vc0FLc4b7L8c7dey9UJvE5SB
 KQKr7OWGscwJHrfFEqHIPJhmrRF+u0Rl8lwa5lzyD5vSQcpMuU4AIlYGiUdL79W9X7cPnYm
 uIqKJXGcMiF6aaBe5AU0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RcoDov58Jqg=;+gDjDq73QpiL7XoIE8SQz5BMft6
 wRAcizagoMXPjqLE1vyATncc7IVT+HkVDitM1kXhTTmMShR4t3IbsIunM7Fa98frWb9un6tfs
 vNvuL/Ra4xnoUpp0YztkueEq6Qky/+MEpVNkOkOQXGnoaW0BLbUMrmKHjt6eIG+YFKymyOEuC
 uWNqUpCPz+cGhGTSeNb3HG4Gh1Jrd5QUtiU1Nx8tGYKHmAQdjJ82+kkrHrQT+RSRFYc662QD5
 EGrhg26qHNlqab/FYIxir17VsBGJ0dGkpk92BAOC+YY51ezbpPH/tib1l7YpdBkiWGSeJCdP9
 bmZhij1W5Ph3TE2b/baUGuSK8Tu82R4rmiOCnzEEYOUI8HkULyjW20/U5cClG+h27qI9Rf1v5
 fWKs3437f26730bjnGWMP6GUwTKd/nc1+gkeg1xto8HmEFSou8xbYAHaE2JCdj9woFkdvAtKA
 lZGHPE2615+0+2aXRDr7k2j48XczqJTL4yaXQZ8V/kM42cjNE0T04a8YGR/lVW3YcshSw8eTu
 f1b7PNWmDgXcXaR+j+0/QHZcvR/Wvao+NH4EfbN9hIecXV9dWqRBrTj2wjEM+Z0Nrh4HWKMEp
 Sx7JMaj81KSGM1yhqPtUt7fwhD1FdBmPofENoOmXrjFs7iYjeGBwkqA03HEqFEE7Xe9oXcD1C
 RM9I7p7eFtugRbT5eirhTi8yxvVWf81V6UZ3vH6ZAEz22paX0zltA1g+qlp4hxPLKUsNkDIm9
 YrTiszCaY/Tz3/SOikI7L4KGpMyxmtpZGRnlFd95gVKBGMMR1wnAwp2tKYg1pgE7C2qM/theX
 Kens8z5+LjqUWh5l8qZiNK2kBdLLQIYZVuiaiLENUAIi04ysPRVQdfyEVFCnRN9lTeLr1stPX
 7ZIesFcPncZor0DUlS4RJG25ScaFeUjFxXotZSFAVvA7IPNOBKTisDg0ijEhS+MCgdF2mGMXV
 4Yjy4Q==

=E2=80=A6
> Eliminate the duplication by making minor tweaks to the logic and
> associated comments. While here, simplify the handling of memory
> allocation errors, and use umin() instead of open coding it.
=E2=80=A6

I got the impression that the adjustment for the mentioned macro
should be performed in a separate update step of the presented patch serie=
s.
https://elixir.bootlin.com/linux/v6.7/source/include/linux/minmax.h#L95

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.7#n81

Regards,
Markus

