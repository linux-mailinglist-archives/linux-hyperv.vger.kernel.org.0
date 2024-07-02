Return-Path: <linux-hyperv+bounces-2518-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B1923A27
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 11:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2047B1C21489
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jul 2024 09:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502E1514EF;
	Tue,  2 Jul 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoI005Sm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693D14387C
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Jul 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912740; cv=none; b=UU1TKxBz/mU/E4mbOFgvJSF+OozOEs+aO9YTHearoMz+pEissbddSvtqOhYF6oYAFmODZt1sAs602RdsZpmTWHoA5DXWZgcS0ejBoLWsxnPa5Recm9Qe9pMCmY7FCwuTDxYpuGSDK9qxsPLa7phswzNoWFITJg3jCBN9zi2B9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912740; c=relaxed/simple;
	bh=1M7iu+mOsP1v1knUiiH7ZTdZ6QKmfyYXyZ2HbVn51nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IM46dAFPIybVE0jNw8secN7a2OPIpj6wC+mXX8puKO+mM7yfjHT7CYjnJkZggwT+Myu52QAaP+ygdK/9aUsB3JDtcReZdPMDdDRGBt00MkO+YuawSUagUy2QpX+p3VQLXNpy6sulpOg49WOgyamE1T81d5fw4rN3fywK+ngX3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoI005Sm; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6a3652a732fso18277836d6.3
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Jul 2024 02:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719912738; x=1720517538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZL3RfSc+IItkNLgHknT84dCchF2kfUlWQ/Ud3eQETo=;
        b=DoI005SmLBsVpFB/t4uQuhTZP3thfSFKbc06pASpsbTbH6B4bUfUJWK2JW89BWzXuk
         F2W0U/+PIS0isGSCbgh9PExwSM+Tm5iZDL+UYWjdXVIF3s/bePNLq8iRk1v9mNilOZiy
         U6N7VMLW32DUqRO+EZHYM22elHP+9dISobKa8VCZGZT71pa4Hd8o9gw6lDJzgKtDAbTl
         tqYxE0DkTaWFZ4ZgqQ3LhqSgO0N/ftLWkjDZ71Th3TG8dVimfXGbdsAMwi2HkqxBmjEC
         NGUBdCA6BRd/qAB+AR3EPWPOx/AoMzsJnfupH/BBqTCBv6KIPyIq6q+DgzMdY40YQhzo
         PiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912738; x=1720517538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZL3RfSc+IItkNLgHknT84dCchF2kfUlWQ/Ud3eQETo=;
        b=Fog6Te8aT2/O36CnovO3C486SO9GH8HfDSCOHAgRh0xnEngX5zrleUfJyuOZ5VDaFH
         FRfRr7kTHj9LgnIqhHgssm5YNub6kz5S34OeL91fJ7M2pvK71oSEPC4QPTDXP65XT2eS
         z9P4dhFmozLtj5+py31bjM8IuHmIv03Z7KXDqR7VdCIvhU3N5OD/uW7zYIpo76d4kFgG
         If84bDzfIxBAM2wKnpwhrEeg7JDCJ4xz91RKvSdUrlFF9iIJTkEBAL7ux2dDJHb/uvCp
         /jN8jkWYKArbt0GoYbs5IYXOF4qmwJDKIPo2WynDXc8yR063MJuwfHGCYWINxb/dwMCG
         RRcQ==
X-Gm-Message-State: AOJu0YzxL3iLtNfgKzJ094fF/2VW/T5zNQt+DAj2186G6r3FjVxljUFu
	pBP2wSMt1M483gK/1a34TLuYqXMwl6XQOaa/RuwnESPW6aUxlp5SNLc/UIlheMPH316efzFpO3/
	N4MbNKeuViOY1vq+QY32WpgfDRIs=
X-Google-Smtp-Source: AGHT+IHFgVYnKCHdL87MMSBjJSrc4xd8EiU+/DWAYtYdteHyuGWr8yKyPwmrzZ//xHl0pbqqM0x5pSpmviRO/pu7RwQ=
X-Received: by 2002:a05:6214:ccd:b0:6b5:4bf8:57f0 with SMTP id
 6a1803df08f44-6b5b716bfe1mr90930056d6.48.1719912737906; Tue, 02 Jul 2024
 02:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701083554.11967-1-profnandaa@gmail.com> <ZoMUVE2cuHDkcdbs@liuwe-devbox-debian-v2>
In-Reply-To: <ZoMUVE2cuHDkcdbs@liuwe-devbox-debian-v2>
From: Anthony Nandaa <profnandaa@gmail.com>
Date: Tue, 2 Jul 2024 12:32:06 +0300
Message-ID: <CAACuyFUxZS7fFna1E9rYN9T5gJt_72s9kQANDA+5cwANR7NRTg@mail.gmail.com>
Subject: Re: [PATCH] tools: hv: lsvmbus: change shebang to use python3
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, decui@microsoft.com, mhklinux@outlook.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, the script is compatible with Python3. I have tested it with the
two command options (-v, -vv) and runs okay.

Also, I have run it through the ast module [1] just to make sure that
there are no any syntax issues.

Thanks for taking a look!

[1] https://docs.python.org/3/library/ast.html

Regards,
Nandaa

On Mon, 1 Jul 2024 at 23:41, Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Jul 01, 2024 at 08:35:55AM +0000, Anthony Nandaa wrote:
> > This patch updates the shebang in the lsvmbus tool to use python3
> > instead of python. The change is necessary because Python 2 has
> > reached its end of life as of January 1, 2020, and is no longer
> > maintained[1]. Many modern systems do not have python pointing to
> > Python 2, and instead use python3.
> >
> > By explicitly using python3, we ensure compatibility with modern
> > systems since Python 2 is no longer being shipped by default.
> >
> > This change also updates the file permissions to make the script
> > executable, so that the script runs out of the box.
> > Also, similar scripts within `tools/hv` have mode `755`:
> >
> > ```
> > -rwxr-xr-x 1 labuser labuser   930 Jun 28 16:15 hv_get_dhcp_info.sh
> > -rwxr-xr-x 1 labuser labuser   622 Jun 28 16:15 hv_get_dns_info.sh
> > -rwxr-xr-x 1 labuser labuser  1888 Jun 28 16:15 hv_set_ifconfig.sh
> > ```
> >
> > Before fix, this is what you get when you attempt to run `lsvmbus`:
> > ```
> > /usr/bin/env: =E2=80=98python=E2=80=99: No such file or directory
> > ```
> >
> > [1] https://www.python.org/doc/sunset-python-2/
> >
> > Signed-off-by: Anthony Nandaa <profnandaa@gmail.com>
>
> Have you checked if the scripts are compatible with python3?
>
> Thanks,
> Wei.
>
> > ---
> >  tools/hv/lsvmbus | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  mode change 100644 =3D> 100755 tools/hv/lsvmbus
> >
> > diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
> > old mode 100644
> > new mode 100755
> > index 55e7374bade0..23dcd8e705be
> > --- a/tools/hv/lsvmbus
> > +++ b/tools/hv/lsvmbus
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/env python
> > +#!/usr/bin/env python3
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  import os
> > --
> > 2.33.8
> >
> >



--=20
___
Nandaa Anthony // nandaa.dev

