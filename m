Return-Path: <linux-hyperv+bounces-1023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A37F4DA0
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2053EB20B29
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3859B63;
	Wed, 22 Nov 2023 16:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nze2GiZ4"
X-Original-To: linux-hyperv@vger.kernel.org
X-Greylist: delayed 408 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 08:59:34 PST
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9828191
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Nov 2023 08:59:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700671964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jr/Y7V7f6fGAsxzikGQR3EngaKckAlq67YJMnyebHus=;
	b=Nze2GiZ4tmmrzUZaJsqvtJVxRE69XlAUDczYpRLhSH6ybA2eO57YKiZpx1NKD8pqhIENqX
	6fI57aVUoJVbAqWbEJaCdJvgZvTXr9lgZZrjOxamjO/yvH8OjhR6GAsjrn/DWd1Qh6cP81
	68HeyEFdDHjhWdoPC0uLITdLzF1IvyA=
Date: Wed, 22 Nov 2023 16:52:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Konstantin Ryabitsev" <konstantin.ryabitsev@linux.dev>
Message-ID: <ddeefd4d0323df0948565fea2ffb55793fdcc8dc@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize
 hv_nmi_unknown()
To: "Wei Liu" <wei.liu@kernel.org>, "Uros Bizjak" <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 tools@linux.kernel.org
In-Reply-To: <ZV163ePuUQyyeKUj@liuwe-devbox-debian-v2>
References: <ZV163ePuUQyyeKUj@liuwe-devbox-debian-v2>
 <20231114170038.381634-1-ubizjak@gmail.com>
 <SN6PR02MB41570168279C428D385ADCB0D4B1A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAFULd4Z3DZh0SoEyNHfz3=DM2CkDGtNP_f1gVx64NJkzmWp-Pw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

November 21, 2023 at 10:51 PM, "Wei Liu" <wei.liu@kernel.org> wrote:
> Uros, just so you know, DKIM verification failed when I used b4 to appl=
y
> this patch. You may want to check your email setup.

This is not actually Uros's fault. Recently, Gmail started adding a force=
d expiration field to their DKIM signatures, via the x=3D field:

    DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed;
        d=3Dgmail.com; s=3D20230601; t=3D1699981249; x=3D1700586049; darn=
=3Dvger.kernel.org;
                                               ^^^^^^^^^^^^^

This gives the signature an enforced validity of only 7 days. Since the o=
riginal message was sent on November 14 and you're retrieving it on Novem=
ber 21, this causes the DKIM check to fail.

I need to figure out how to make b4 ignore the x=3D field, because it's n=
ot relevant for our purposes, but the library we're using for DKIM doesn'=
t currently have any mechanism to do so. I will open an RFE with them in =
the hopes that we can get this implemented.

Regards,
-K

