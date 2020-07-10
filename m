Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F021B24F
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2020 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGJJat (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Jul 2020 05:30:49 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:10252 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJJat (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Jul 2020 05:30:49 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2020 05:30:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1594373447;
        s=strato-dkim-0002; d=aepfle.de;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6gtHIv8UTS2QIMu+DBcnOduo7G4i7G7T+gs+Ih2xJT0=;
        b=YIxYOkciFBu/29TgpQ2trlmq3J8mJhOwq4+a2cdZ8qA7SstPu4pdLhlI1rQo7f1P17
        J8G97dJhqa2OBTKe7DLL6xkpWSUgwu3WuGktEMRqfNzQQjv/Gkli5XoF5naVkCoZ26uJ
        RqJLwFI1gHsBHIxciJ+X8jlqeV1ZhQ63WYS4uBDBmtR540bfDA2RRPArj7M3gfgLnoAh
        a4am7skG3OdjvEqGkZjMGlhLk8ndiq4anyUJwV4YsuUAMBVC1G7o13OFeOU86AP2i+f9
        RRiLymkPZYb33b+e/q0Bsomz9elck2ZGloA0X7TcGrwrQKVhfZzUQyQ1kVQAxlPUxAH0
        41aQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS3QE="
X-RZG-CLASS-ID: mo00
Received: from aepfle.de
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id m032cfw6A9Ohzku
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 10 Jul 2020 11:24:43 +0200 (CEST)
Date:   Fri, 10 Jul 2020 11:24:40 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Joseph Salisbury <joseph.salisbury@microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        mikelley@microsoft.com
Cc:     wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: Change flag to write log level in panic msg
 to false
Message-ID: <20200710092440.GA16562@aepfle.de>
References: <1593193685-74615-1-git-send-email-joseph.salisbury@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1593193685-74615-1-git-send-email-joseph.salisbury@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Jun 26, Joseph Salisbury wrote:

> When the kernel panics, one page worth of kmsg data is written to an allocated
> page.  The Hypervisor is notified of the page address trough the MSR.  This
> panic information is collected on the host.  Since we are only collecting one
> page of data, the full panic message may not be collected.

Are the people who need to work with this tiny bit of information
satisfied already, or did they already miss info even with this patch?

I'm asking because kmsg_dump_get_buffer unconditionally includes the
timestamp (unless it is enabled). I do wonder if there should be an API
addition to omit the timestamp. Then even more dmesg output can be
written into the 4k buffer.

Olaf

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl8IM9EACgkQ86SN7mm1
DoADEg/+ObaMF8Ognj2sFIxdowc2+rGVM5s81nQz7FY7IuOZJ6wKfzoPSlaune42
t0IY4ChbugrKPFuRu8WnfbMfFhSN5Y/vJnV0vt6bwN5RfeIep3W5IizRm/QMZ9Kv
1JvKvta6m0PsTfedVq2hSnqQR/2w7vbs0+vvecxu42Afz3z37Dtoweklcqc5JPOz
Y7iRPpKkR2pvIQpGXY643AthP9rzwSJoWUK2ejtZ0YVvTerEQm5u6gkv8zBfa5Wc
eCjm/STRDgsfdIBVZSNQaLcHGL/Av9yIRRsXMFCjuJsXSCFHJGff29Qkc7HRzkJZ
Q+hw2edSJ8AxUUt/dGEV0HrwZJlAFvGthwscGyl80YjQ8qygk6dDP44fyPdhtdff
rpArbS8mt7FkQpZleFHDPYLuk8cztNsxCTJdzatzkuj7hD6Xwpz9r3RzGcRTRSLq
N6EIki5cEFCG/kibknftoThJSxD+ZWvU8iym7mIUvS2z9ibmVrr3fr/U0PneyB1t
RFL2knUXSomopps2zvyX2sSl2p/3fJ2RiExBD+vnWBpU0r0Vvrbn7fhDUiB31Xsk
NHvbG5pycT/W9tHEu+5kyq8eWLA4dLAMGkXe/xu6iQAIJ28llupMG39+Abqr65fP
0FxkTXFRiX4s8YzpK9QCzE676IN1g0m4mzkP2YU1C8Kqu5qVoFQ=
=h+ud
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
