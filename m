Return-Path: <linux-hyperv+bounces-3474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34399F1458
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 18:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5795A2809CB
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 17:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6F1E8841;
	Fri, 13 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="nC9VfrgA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D196B1E572F
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734112234; cv=none; b=tuAdD+UgzWI2IoZJL4j4WnxZlUBbU1G85SXG93L+qEuAC7kV7a27ify8QxkW4DwJ73HNfVm5mwHN5rr/tA5/4m3CqaWELv2RmFfxnfe5Pjm33anhKszsDQMBUVqqvSxUnd+ADvAWb9WjXhvJIKUdlFDtj8lDDn5RhDVNE1fbBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734112234; c=relaxed/simple;
	bh=Y3Lw72vZuT13nlVwqizEU4xTOq9iG+Ko8FT1M6jDu4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AV2/bGPf+NrbZ87VY6A6w6mlzpGwp/hwzpXnBbbCAaGb07XaECQuy1A1YPToY4i59bME0GE/IbvkimY+lssDuzFNrJShpCMDeXCP6xuiu7KF4HxDObGX7fShmQsJuoyvc6x3kWhcplyAW2w9pEc50b7UVVa0KCqu4nXpO24zu7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=nC9VfrgA; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728e1799d95so2482332b3a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Dec 2024 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1734112231; x=1734717031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TowrwHHo+Z/Rbfx8dYSOWZVrv2+F8jb+aOKcTufy/9s=;
        b=nC9VfrgAQG5fNQwOWI0kYm08Xf85UI8noMzCM1xDhnuiWEWUNB0kgdRtRzK6YOWS/9
         wrWuDW+ouj2j1Nb6+hGSh8vHlq9L+9qQDhOW5vjo9l4HS5aOPEuIUzXeAiKoOWsgTydp
         pNx5EK9mKlHqu2NKseCpH4N1wVgXgHpZJINEwtWonotZbPyK+WvwoQMyx2w+V71dHbOb
         ourFCPwEaJM4/HLw4NYk4n0809g4jBSuTxDLoh6xCVLtXqJ4EXrofi+9uKpuIUVeYdVh
         g1/tEaTudrbzvJ+yZVd0S1pzuMF0FgKvAT8+MzsmCVvZXRnvqiwZgIFkKFaMvh+YT0tA
         QZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734112231; x=1734717031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TowrwHHo+Z/Rbfx8dYSOWZVrv2+F8jb+aOKcTufy/9s=;
        b=rV88WzHG5FVm5fFFMLG0zNXdw6SpCFZnr+Ewjy6I+d+HqRYV3X6dR6VB/+6Gkv8wi+
         J9FOopOQ5K4c+eXf0UTOjGiR+EVWgpLf+epzIGGPuisWwPiQYF9pa5mJ9Pf0MhzdbQQ7
         bBK6rg2Y1pJNXbYWE0eAuDSzHmp6jkXV/mpx94sM8nMM/K6OzLV0gI2xINP/28zv0avO
         e2Elq3hWBxzTkWFIlspyADD/Pjfg8pcHjBf8QwxbuDPDawvyy4sWGdQLo+3pD9kpn2Ef
         OJAlVGdqhm1wVKH2aDBmpxExJuzTmGB3vCfqaDLjEoY61vJItcEkFMjiZknvLSTqEEfy
         470A==
X-Forwarded-Encrypted: i=1; AJvYcCUHQwHwzqsC3moOLQJKXRaphA+EUA0eiwChaTPNMC2C8vp7yisDglxF+YgmsZqixB+ghJHFU3pR+KsOEGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQaWYKgQdaqGo9kWaaLmG1moBQcRgKBNt00bnCDOUaCdI78zz
	rC9Uy+J+V6MyE6AePn1teq+EOHvU2mhTZDcQWCL6jzGjLyu67dQTeYMGVG+xXSM=
X-Gm-Gg: ASbGncvgjwrgC2S2HQVPnvNgUYwbmZqLLds0KrPQfNvGb65pSUCD2kDc6KF8HkbdURr
	hI8k7cwV3n0okvhh5wF3yevPVtKj+5nPOdLVg4ST7MEgIpR9WpFvFKM17CTxpeWDhFg+QW0cIXx
	Kk+PTnRGcdB5LmMcrg9wS9ScZRhLboxHYL1MWSETMyE3GCajUtzjWaytdeR7oOa8eupxc39uJRO
	DXo80H9/zs740CF85k5r2COc9Jw2cuyWNDGPHAf3LoOolMR2zVyPyc1+6QdCKgJaed5kUHZu/uj
	KERqtJQ5fMDipnrfdiEAAFrZmbKkGHduYg==
X-Google-Smtp-Source: AGHT+IHkiY7danHaI2/4tVyIk19f+i6/bLjvhn/gEfEFpMSrj8uqnFboP56GlYXHaxZWng9GURQDkQ==
X-Received: by 2002:a05:6a00:419a:b0:725:b1df:2daa with SMTP id d2e1a72fcca58-7290c248bebmr5836996b3a.20.1734112230993;
        Fri, 13 Dec 2024 09:50:30 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac52bfsm58567b3a.26.2024.12.13.09.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 09:50:30 -0800 (PST)
Date: Fri, 13 Dec 2024 09:50:28 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: Set device flags for properly indicating
 bonding
Message-ID: <20241213095028.502bbeae@hermes.local>
In-Reply-To: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
References: <1732736570-19700-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 11:42:50 -0800
longli@linuxonhyperv.com wrote:

> hv_netvsc uses a subset of bonding features in that the master always
> has only one active slave. But it never properly setup those flags.
> 
> Other kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used
> in a master/slave setup. RDMA uses those APIs extensively when looking
> for master/slave devices.
> 
> Make hv_netvsc properly setup those flags.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Linux networking has evolved a patch work of flags to network devices
but never really standardized on a way to express linked relationships
between network devices. There are several drivers do this in slighlty
different and overlapping ways: bonding, team, failover, hyperv, bridge
and others.

The current convention is to mark the primary device as IFF_MASTER
and each secondary device with IFF_SLAVE.  But not clear what the
right combination is if stacked more than one level.  Also, not clear
if userspace and other addressing should use or not use nested devices.

It would be ideal to deprecate and use different terms than
the non-inclusive terms master/slave
but probably that would have to have been done years ago (like 2.5).

For now, it makes sense for all the nested devices to use IFF_MASTER
and IFF_SLAVE consistently. It is not a good idea to set the priv_flag
for IFF_BONDING (or any of the other bits) which should be reserved
for one driver. 

If hyperv driver needs to it could add its own flag in netdev_priv_flags,
but it looks like that is running out of bits. May need to grow to 64 bits
or do some more work to add a new field for device type. I.e. there
are combinations of flags that are impossible and having one bit per
type leads to a problem. Fixing that is non trivial but not impossible
level of effort.

My thoughts, but I don't use or work on Hyper-v anymore.


