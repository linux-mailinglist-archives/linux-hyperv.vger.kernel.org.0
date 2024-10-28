Return-Path: <linux-hyperv+bounces-3196-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BD79B345B
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2818D1F2220A
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Oct 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137831DE2AB;
	Mon, 28 Oct 2024 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="OBfHl+zu";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="TFLBDk5O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AA154433;
	Mon, 28 Oct 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127925; cv=pass; b=ghiCbu7d3goh2PBJULEJDhnrghr/0KpdhWdtirx6Rl148GdpH4FcmUUUI1EVIlyu3mp20gWPWV51Alwkm2QbvJwncXwVDiO77HPtwPlY+T+Exahf2tOm01YDGM8TZLBnHmrtCd2Uga4YTi/Iu0O2d0K9li2gJQhOL1R438BmOT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127925; c=relaxed/simple;
	bh=Tg/ENkGX8p53hQXFDkCabS4nEr6BmjBRliwxrZXu2Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5XMQpJoYzhE3JeW838kclwNscntUystyqTMPChgrIywTPb2H2KLYTHSesrpf/TS0udzANr3Qo541hkP2QdrVvZadbcvWzCMoIc4+oCCBxxNI1xj0hwC+PyysigpAwNZs39CRTp8noa9PThCJL2E8Boi+Y5C4GEmVvgzeGksJ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=OBfHl+zu; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=TFLBDk5O; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1730127726; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=B/Eh86wjFcOK4FQOV8TuQudzfuZgCWeyd9lcamMwo8oLZay1l/b6YgKBcqleS1neA7
    lIHLw2YXO4dCvvm7lETAlr2D11j/S10Tt2MteZx7gADJUTHc4jHUo+qdf85eajLCWbxr
    EGgpLoYt/BFQuUvNMRAFE6NeF7Y2VLa4ArbitRGzMCuB1yC+yQrfpwHZa8FswijYwr22
    eCQx/XS94MIB/kJpCXgCGy7zwnDtpLP3vV/HfKU8aMhtIfoSd8adKYf/3VtNTSrYqSPL
    lOhPMQZqAibXaW2ME6JwiJRKwhOoL1IShyV9NR5K6EOXcaFHQa8de7jj1mMN2p2Dt+0C
    KigA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1730127726;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Tg/ENkGX8p53hQXFDkCabS4nEr6BmjBRliwxrZXu2Z0=;
    b=hRprZ5pxcq9qd+/LHbDyiwEGdVUKDa1qEtxj/abbXBbjI24oIUB2WXYDQ8jJN4QoSe
    87mKNoWMct55WF3LeR4r8fodT15z/44sh7SNBG/LezxOBGJPWAJVz0al5mTVIvG2z7NW
    pFY8xOndixBL5gsXNfeN4Vms8qfBWfs1/1zf8HwlKu6qYKTjY+E9iQzcwv9fCsCdbFZ/
    lusACqkNnjrPoF3j3SHf0g96GhzT9W42HPVLAhwpcL+QDvNlrlWu+o+FKYiBiLQ56Aq2
    yeM1UXUcAbyxVJLduePQmIa9qznNq068dZ7KRulk6jQcGub+3yEXurbmyQx41RQJwcrI
    vyyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1730127726;
    s=strato-dkim-0002; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Tg/ENkGX8p53hQXFDkCabS4nEr6BmjBRliwxrZXu2Z0=;
    b=OBfHl+zu5oCyXW97qRXzX2qYStZUXMJQPOT4k7bQYlnnytMmT+UV+qFVLGMXL2J2y4
    gAHM3VrmpHPkEb4NoTMYPXfo31jO3SDwN0T9VWDsu6soWdbm8kXLdw8sI7T5IAcvbZXD
    CaG9pvdjfb+YhKjBPMjCmDzxNS1FTv8zGTLfNN8bfs7g/yvAlliaVkwTfpA9zs8wgXZx
    73DUT8J1nZPi0VddSU3+5MPpfCv1LGHxHTAkI+f4Y+rlYyvJlPMsaCUXsn/bYcZ7NEtN
    vwDQGpCmBR+lUwd19DRPOLzwOoD3nBCD/OOvc0EKTVQFjFNwM+CAfXYeF5otyxiJNr7E
    30qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1730127726;
    s=strato-dkim-0003; d=aepfle.de;
    h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Tg/ENkGX8p53hQXFDkCabS4nEr6BmjBRliwxrZXu2Z0=;
    b=TFLBDk5OVe9nIxnTR67YYU47we9JJQztqcFmasfbqy+Lq6drdZg/7KUUjys4twhmld
    7NyQfKEzQRQPKmuhziAA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDX3y/OuD5rXVisR4WhSIPErsYj46j6YNLTj1Qc8innI3ISQYqcHUew=="
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd652509SF26msl
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 28 Oct 2024 16:02:06 +0100 (CET)
Date: Mon, 28 Oct 2024 16:01:56 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: terminate fcopy daemon if read from uio
 fails
Message-ID: <20241028160156.71661aa3.olaf@aepfle.de>
In-Reply-To: <20241028090620.GA32655@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241025143009.4571-1-olaf@aepfle.de>
	<20241028090620.GA32655@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Mailer: Claws Mail (olh) 20240408T134401.7adfa8f7 hat ein Softwareproblem, kann man nichts machen.
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1QZVfo86tCaFc/YO/V3_9oz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Content-Transfer-Encoding: 7bit

--Sig_/1QZVfo86tCaFc/YO/V3_9oz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Mon, 28 Oct 2024 02:06:20 -0700 Saurabh Singh Sengar <ssengar@linux.microso=
ft.com>:

> Thanks for the patch. Changes look good to me, I will suggest to improve =
this
> log message incase the error type is EIO by suggesting that users verify =
if
> 'Guest Services' is enabled.

No error happens if the state of "Guest services" remains unchanged during
the life time of the VM (either "enabled" or "disabled"). Also no error hap=
pens
if "Guest services" changes from "disabled" to "enabled". But the error hap=
pens
if "Guest services" changes from "enabled" to "disabled". I think the actual
error "EIO" is not relevant for the commit message. Maybe you mean the seco=
nd
paragraph should read like this?

This happens if the state of "Guest services" integration service is changed
from "enabled" to "disabled" at runtime in the VM settings.



I'm probably not telling news if I say that this behavior is a regression c=
ompared
to the hv_utils based variant of fcopy. In the past one could flip the stat=
e of
"Guest services", it would always come back if state changed to "enabled" a=
gain,
because the "hv_fcopy" device node came back. With UIO the device node does=
 not
come back AFAICS. Not a big deal to reboot the VM in this case.


Olaf

--Sig_/1QZVfo86tCaFc/YO/V3_9oz
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAmcfp2QACgkQ86SN7mm1
DoBUnBAAodpywY45/t5+B5pIAiThnv/uEnQtigVQY94uBgrGOBW24ArQRE9nNuaG
gv+MxGEzzZE2FFXjye/lBUUxtR8UYBSX3/ZcVrPTzTSYxJKOOaiqJQsxORGZ0mV3
39ZRNgQNOzMoiMWh4KklvpMb90YAhJnBk2TEa0fAykNyuwLCUr4FTSkHqApFRl66
ov+QGaEAL7PLF1++lMHC/+x1m28+IASCJbAAocPkicQy9sfk8f+nx17okIgB2RuO
7Ub3GNeZag74fG/YSUu7rfKjF0HmhNnsKTjhRFnasqAYsAW6OZMWcl9M1/4KtbWg
qM/tgEVM7IlUZ4UliJwd+1Q5Yl/UIZSMZwUGZswgFWfJbIISSnezq8vAEggBARN7
g82bQJc0UFqoEkjEy34onK4O92Ki8Ye2xao2R319RgUn9PcT+hQimSQWhuCEovJc
YNZLDV/RFvhL0DtnVADxj7uXo/J9zZMwpeguB9CUSRvEsGPHylwlLgejqrIFHd2M
g7ms6GHGaxr3HB2RC4X8O6nnY18zbMNpjRK3upuYAlr52aUaOM7QVeRaZ/JJLrRR
vLC0NRjG4C1ZNRFmJfOcAV32oeMJaxY5Nyh9M+Lp5WKe/zjJWDus6+ohlQLBKYkE
UcDhSH/8w7/SC5P0oobkvdgAAlVainXNZnxdvDePCWdH2PgYofo=
=fqsp
-----END PGP SIGNATURE-----

--Sig_/1QZVfo86tCaFc/YO/V3_9oz--

