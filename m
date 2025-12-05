Return-Path: <linux-hyperv+bounces-7986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D18B8CA9A31
	for <lists+linux-hyperv@lfdr.de>; Sat, 06 Dec 2025 00:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970D13185EC6
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5330147D;
	Fri,  5 Dec 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql/7zHp6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4312FFDD8;
	Fri,  5 Dec 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976955; cv=none; b=CjxetjAm3jFhYIDZuwGt5ZJwH0wiz49PhytV64yNtUVmfOVjn8S67XUMhw/9fRxDA9fpWrO47AjP8HgMZLVpfMiVd16PbVSaKrWM+IcDdHCjuw4XBj2/BT2mt1vhtjV1JaYB0Q5/iH4byrLr1UplNAYbGUtC+Dl75nuaynEXR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976955; c=relaxed/simple;
	bh=BbPF06EF2VWNt4vKAGYK3xTUvZ9MRrVxa+qHpYnp2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imEvtCPZxsrL8qSngQpKTOqXS5RgX1dQjzi/sSAY7Sx5I+2fLZEiwMR44ocCZqA1Qj6B/RBkpQyUs9JLr3opQu9TKwUFbr2ApTsdqGeNUvH4X+FhILfFvihluU9PlI6f7XuGZtgsA700I5z2hhVEYHBlmskDXgCQezwiaMqpG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql/7zHp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40109C4CEF1;
	Fri,  5 Dec 2025 23:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764976955;
	bh=BbPF06EF2VWNt4vKAGYK3xTUvZ9MRrVxa+qHpYnp2DE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ql/7zHp6oU3QgIyoHP4GcRdNrzwDCLLEbvmUf8cKtvPMI9n9drC5MBAgWeLb3jb8V
	 in611jWMzhxmeLnZHGGMW0Y02+0PjSvzeBuIr+/5aGTI+kbutwRUMyZsCQO9n5a1BA
	 OFPrnkW282O8JekvmpEN8ts+GakabzmsFtNpU5ohdFFohnr6FGTSUBPdNRVFbpsIb1
	 6rcJISPUDbwW2ChPUszvxoolWDKlPt6l4bNaX9TYy6XEfJdvYZYClXh8cWw7+4RNGq
	 PMuBjkOOWPGG7KHaJ/1wAtAY1bmkgyIqyvpaYidLqn2rZRNZkBG+vE04fFJFxsRRne
	 GS+rHFoBgdf9g==
Date: Fri, 5 Dec 2025 23:22:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/6] Introduce movable pages for Hyper-V guests
Message-ID: <20251205232233.GD1942423@liuwe-devbox-debian-v2.local>
References: <176479772384.304819.9168337792948347657.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176479772384.304819.9168337792948347657.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Wed, Dec 03, 2025 at 09:40:33PM +0000, Stanislav Kinsburskii wrote:
[...]
> 
> Stanislav Kinsburskii (6):
>       Drivers: hv: Refactor and rename memory region handling functions
>       Drivers: hv: Centralize guest memory region destruction
>       Drivers: hv: Move region management to mshv_regions.c
>       Drivers: hv: Fix huge page handling in memory region traversal
>       Drivers: hv: Add refcount and locking to mem regions
>       Drivers: hv: Add support for movable memory regions

Queued. I changed the prefix to mshv and drop a not needed paragraph
from the commit message for the add refcount patch.

Wei

