Return-Path: <linux-hyperv+bounces-4790-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C964CA7A48B
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62643B61A9
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Apr 2025 14:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C04D22331C;
	Thu,  3 Apr 2025 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TUEv1Oem"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3FE7F7FC;
	Thu,  3 Apr 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743688939; cv=none; b=FKqAivU1lU92yJ3EyYqep6eTEttY7rNfHoqTQgZIe2WM9Ltb9YCrvjozEOG17I61S6tsKwS6D0NEepFHvOTsEpDsJEG4C6gFnHvaczeFlibS/EmKb3zXFDUnOWl9ijDpO4NQSkB1Q0DM3HFAy9V4+8rYWndMGtPjjoJgTrS/l4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743688939; c=relaxed/simple;
	bh=XqMDyOW2yJwv3psBvj5za4J5At4ABkybEXd0TlK6Q30=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NY+bSraP6Jm/IodsLKLYAlZALxHzBZitkaezxr3Np4WVvqFtNwp/T8BU5xu3ls3KtLlcxighD/pr3c9lA3x+HmluqH2QoAXh1E88FOr1cxHb4qqpMvZTXY1i1yK4kCV3eictlHu9v0R12ytv08Jiql9XoioYz5HsV3obITPxtz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TUEv1Oem; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743688927; x=1744293727; i=markus.elfring@web.de;
	bh=XqMDyOW2yJwv3psBvj5za4J5At4ABkybEXd0TlK6Q30=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TUEv1Oem/XV4LfSsW23cBa/lGUUAKtogNZV78S8Fzkbev5XKUTcz/RDliuS3hh+V
	 979YGjGbdLun4MLPTM4zPayjQIPBXyDYzUu/6lrg5WH4R8m+K31r8RnY2CMGoZj+j
	 WK3+x/6udxv+QO4XZwbgTbCLicgjQ9nTFWoMGcfcHJcip3UvEIeccDHE/qYpiwBiw
	 V29pYTkEagABJSLPeuq1Ila/TYqk8AFSIq3bgPQv7TKqJ+s3d4MNx1LYcEkYiFt/F
	 XyqKPH44xpm1+cfRO88shIfjHAEgUdYFfvT1qmFFlyuS5o/PxiDFWJ7CGORUk4Ts2
	 WJX+VVTBka5c5d3mpw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.50]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGWe-1tr1kj1mh0-000t5L; Thu, 03
 Apr 2025 16:02:07 +0200
Message-ID: <af37c1e6-4d94-4259-b5b3-0cbc60b6beb6@web.de>
Date: Thu, 3 Apr 2025 16:02:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>
References: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH] Drivers: hv: Fix bad pointer dereference in
 hv_get_partition_id
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4soC8Y7HDAB2C+/opn93GBf/dFZc9OVykMt2hGl1RBl8RjC5+yB
 PNh1OxTNy9xsJ3qGpEV6XZ4RZUT1XxWbZBJefb+nA537oTIbVNbhkp4olmUZcnFkvPvCZEC
 H31rWxYyySNg3htu5Qo4GE0KwqVHBBKlkz0Mpqn100RUiAE/K3dGL30Ygp8rEhRui/wWS+n
 aft7zZuFUKe099aOFTTqg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Bp8ihSXAuvs=;7UzbwVDmDIPJp6SaIUQzgzqcqLr
 Hiemp7hCBvmz8XsSzw/Z/vzcGdZ443hhztz6Ty3d+7/8rbUlqJ/f6F/livazNaZWbo3JGTyLg
 3KgQwKltvqvijozV71yYTIoibQJC0B+SEeiNyEzUS1xDdjB0RG+lQPJBrK086qBqP4TaF7676
 UFGteWp4sFicZJIsH9LJDxnNyjO53rwB4C+4HqEIvFutYC0m9zRjsXmc0vNGkN6hCGrraH+uW
 KesXq2dumrzDPrX+FkQHNg8USV76jqv83FhcMrVqT+PRZDx58aZwJ0nWAROeJgNT3BjtFLZVG
 aUiq0eoUYyRNpErYwAHtQBazQ7BFC5sxly53JW5fVFMyz8AG/d61kzFjLuO3zOiTsZuimc0ZA
 zhTGEWoTwrtKmbC4Q0TK4djYu07tCgpZ4pZ7bhXPjR7d6lMtOxBJu7xQmRld1VRGm4lGFmv6E
 xn1EHjUbRdVzB2SBt7B6AYyW5RO9c7vvL9nETW+ltCnRcALWBr8+MqWNkz31KZ6AgfGhMGdJg
 7UtUGA7MXmYsJkmNm9XTY69DcXTDMz6H7AOK+eaJfzteoq3O/qQs9aTuHGNp/uXXCbNEyQu/B
 qK7aM/WPNwmt3b5/HjFkvOMiOkXASF233I5JeLP2Td66uReZgQrjazVwxI1g03BUf6BtqJ23X
 6YvHFJLM/twIqTuH5edDuEMo3oKew36Eid//7HxsDY+VPebQvmEp5sRwAUKmA2lqEaYvDW8Do
 WD07Eyuqt7WtZTzGtFout1illg46SuTKGcHRKZTbDhRvkAPiHhtwgg9+S0Vzu8qPJnM1WyYj+
 xtCZOx9lq3U9W1aq0Yq551TMIs+2t4w3QXLBVvoGdyILhCoF6vhV/UPabjBEd0a1yKDDdmh+t
 n0RMURdKS0OuYyVEROtdTWPkHjRw3d9ZSPk6EeIpm3ERWiaYRDoeZnfTt3VBJbQGK6YycCYp0
 E1v0rAF4xJU8PsFMwADACLXiLqgGpP8Qww11Nh2jSbKvT+LrkI5Z0Jf7tQNlroifAjvJBeyof
 obUAiAtrPt+6AT8T91owxytYUKRFH9i8OVlninuDaa9PWDWGVCHNNrmBQAYyFIfGm3PTXD7KW
 bE1kKej9WXbpqDA+AjUKzQMG2u2JeiIPULAdvMkq15UL14xVFsamLpRhv8PG35OAXU5xnt8o6
 f7NaLvV5mWMj1PjRYb4C9JWfg7xULGSFxx2tab9cUnenRc3M5ZZzSCwS3CosDBMA1wTW8SY+3
 a8UeZGEHrjxsTUmu/egaSx0il8sNu3x4t6dW5Lw8HxMbbM/4tsXlDB5neExI8mVjOyrR2ZOkJ
 73wTMMgxt/mw1MuvNtZOvQ0MrJ20PSiKfv1jnqVRbKJSFzUiADxNzeGqtUEr0XifCqY8nmXIE
 6lVqXo+0sDEI1uVMwPk3x4cze8UtYJ21yAvotCEkPc3vV6Pcx5m0p8wp8k70pY7hJr+m5OcT6
 1QXfPQrRyj+mxuuviBcTpLgZb4bpdx3blECUH6zNYVMfiXKcy

> 'output' is already a pointer to the output argument, it should be
> passed directly to hv_do_hypercall() without the '&' operator.

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14#n94


How do you think about to append parentheses to the function name
in the summary phrase?

Regards,
Markus

