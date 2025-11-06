Return-Path: <linux-hyperv+bounces-7422-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D8C3AA42
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1816C502374
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94130E85F;
	Thu,  6 Nov 2025 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SILAAAiD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF8284663
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429059; cv=none; b=SROp3Exd6AdZ4JM4EzTtc8VkXZnhFiIXOrj2P1mQFPWH4HM6ogH9AhaRWEy3+OjW62r3CXtX375qFOP/5MFXez+k+6ifLnBGzTNJ3ge5OYvaB5lSOZgEWNj6CjIki7FaBS+LsSA/se4EoJuwbN1hpGiHGciLKnN/kDXXioORLJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429059; c=relaxed/simple;
	bh=ialkjfXPUU6X8FC+SzJ3KVgS8vsqr4ixyFVj95i+7Cs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rk7rSfq31sdSqmMjfMKzSfpoXFai6Uenhdm+DQ+3SdQ3NboBgvkh11oB6OTN+irbHgsh0TTjMHRq1nKkCJDtmAo2y8paBeY1jRe4ZAkiY4OmNUMkxAXbDu/wMjudfGRK8nPkGqgdj1ayb2LKvd0cmqEaz/AgWfMnn+X+vnEomtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SILAAAiD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso746612b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762429058; x=1763033858; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjvib5l1jl7c+bMGrAcG+xXz8naE9IfiWdK2rk+q+nw=;
        b=SILAAAiD+95xMYc54QFUI6fvZAdTk06zkyBQ2wIUcrPya65Z3mNG2TTpDwP5/UNK//
         P/2RJKa92xrEFGSLaxi2WxEEDXpnxCVU2vmgrL2E48rEALOgu3reC0J7NV63KKZIJOcK
         Q/fWZI94mR8LZRJIWf2a9+6cSlcc90hVfpv/pBJ5x+VT5uKT5ieQfhtaAjsZMRRUy/vB
         h9GIc08m7gZyxoRC/78Mwjy+x/CXfbkAenbBMaiqua//DJEGNOZKFuGXgTI0F5Mz1roJ
         kmhkGMTtJ24egsIeNGFNTKc3rjFqbL44si/EhWr/g639ZTg4RwAKjs1EBqeLDKjF/Akk
         MM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429058; x=1763033858;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hjvib5l1jl7c+bMGrAcG+xXz8naE9IfiWdK2rk+q+nw=;
        b=Y2q2ymuHKr3l0BWspErlxM59T/wRP099w6Dx2KVGtydIIPTIrF/xiXjrvzN8m9faCp
         emApfNEXuFu1gC6cRiL5llXqKPXV9f14kWX4+KjmV98cHCT5TgX4E/s8oksLF8EDgipu
         igzQc+yn92EF/VQmScc/tW9UTXfMe/CstHudZ1uP+qMO1SDIv6sU96VdCZ0vl0M4z6A5
         y21djRTGm9thgySACqj0rR+MGjzJjI2zRJC2nvo1ZrP0RuwyYydWCKRzUt91Th5XdURV
         /OIqwSGFiju1uFpZq3X9566R3sexEEJsJGRw2VoO6WnOMQ/kz0iVuwh0O5UTMXFoUjx9
         KVNg==
X-Forwarded-Encrypted: i=1; AJvYcCXis9SzQfkTegfhjGQw4Q8wYCsFQGplcJ+8GZ3N59Qkd5Jo4ZMa155GYad3rSwVES+lPZqGhKZvshnsbAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+OA+PrnDhC0IPoSi1Uym36CJ7Yk8EPIqll+fRSplWLsa69iO3
	ZxWK5N064CeTf3dxn18VuvjG5tATrj+RjsdTPpYflIDgrn/KnmzJHiq4
X-Gm-Gg: ASbGnctZWJzaV4RRUzjKKA1uZJ5TiKxPMRnIU2prjqIILAsXX/M4bsh0IUST0+UHvp0
	u31LrFWcX4/eJ18JfRGwKUgmLqdZu8s0fiunzC6n5FglnmBK2VkmrSN1Jh649yYGYfBiZqVMh9v
	a3prWRl6qttbX5zdgXU+/uziaTSG2YOA4vcq2BB7tnII2nIUAWD47RAIcaasRKDE4PdnCtrzLvy
	coq4mif7MAr71wBYNVA+FZJO6bgdk+TnDXCNGxEbJom6ywDVUls1AJjRpNA28CinbcBKtMAJdWn
	znIzkPmwZjU3SgQPq7EjDBtqSmVEwSN+ktJ+zodGsJxJtCogjv50AT4izod6eAcq4Avu5E3MaS5
	0e4/GkA5MqtezYueRmo95UP7KrXvOqeT3W/HISMy3LoQs6U10kzm9fFUqK5EOeenKvr8r7q3nmH
	w/d4mYr73PKXUls2EOh4TszmprLgkP1WIlcEx/ozcZTvl1hvaL
X-Google-Smtp-Source: AGHT+IE49q3UoW4OFpWbNglvInQNVRlN+yhDQFQFunxA5RskR8zFPZ2d8CXgzPfWY0cjgsF/X3MOtg==
X-Received: by 2002:a05:6a00:4601:b0:7a2:74e5:a4a4 with SMTP id d2e1a72fcca58-7ae1eda0949mr8034636b3a.19.1762429057535;
        Thu, 06 Nov 2025 03:37:37 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:5041:b658:601d:5d75? ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af826f9520sm2452518b3a.56.2025.11.06.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:37:37 -0800 (PST)
Message-ID: <f3c89a9182387cd0df012726fc30841aae8d330d.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] net: ethernet: fix uninitialized
 pointers with free attr
From: ally heev <allyheev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Nguyen, Anthony
 L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang	
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "Cui, Dexuan"	
 <decui@microsoft.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
 "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	 <linux-hyperv@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 06 Nov 2025 17:07:29 +0530
In-Reply-To: <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v2-1-048da0c5d6b6@gmail.com>
	 <DS4PPF7551E6552E6053CC02144D0987191E5C2A@DS4PPF7551E6552.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 10:18 +0000, Loktionov, Aleksandr wrote:
[..]
> Code style:
> The new declaration + initializer is good, but please ensure both hunks s=
tay within ~80 columns in drivers/net/*.
> Wrapping like this is fine:
>=20
> struct ice_flow_prof_params *params __free(kfree) =3D
>         kzalloc(sizeof(*params), GFP_KERNEL);

I ran checkpatch with `$max_line_length` set to 80. It didn't throw any err=
ors/warnings

Regards,
Ally


