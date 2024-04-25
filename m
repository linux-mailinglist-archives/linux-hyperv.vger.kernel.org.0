Return-Path: <linux-hyperv+bounces-2044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF68B1981
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Apr 2024 05:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84C61C20F54
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Apr 2024 03:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4D22EE5;
	Thu, 25 Apr 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmjBzoOm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B772110F;
	Thu, 25 Apr 2024 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015625; cv=none; b=cxkAZQmqvePMIA/eLFD5/HWHXwxCU+WCGvcq16yIAJoWoMaJ6SDV5z+d0hVMcfS55drivpErXrQFD5VdLylJbU+EUbh8P+rikVTyWwMclXjUPx6vNla7zvLD0JNIb8usARltrV/F5ttYpqt1/O8GfnfGcALmr4ZiButxRVW+Zm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015625; c=relaxed/simple;
	bh=My5MFhg/Ti3D+MPt/VmtN9NQVsT2BKm8TXTOezs6Y4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vs1tCr6o+XEZ+2oicUjASWhqg8Ni9Ygq48Tha7pAhoE3MYZCHV4GlJkhr5vLT4e8jb36EVRmkMxSkxnB94F3R6J9T2+vsEM7wQ5OPBwF3QgH0RsN0F83TQz31L/te1vza+nLTd2zu590QTxgkpN+rViUJh9Ap2xwQAjnIaDF2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmjBzoOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB85C113CC;
	Thu, 25 Apr 2024 03:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714015625;
	bh=My5MFhg/Ti3D+MPt/VmtN9NQVsT2BKm8TXTOezs6Y4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LmjBzoOmzmB104dVQfa8NJPB2d6PEG8tidOzXPlYVOCXAG6JZmbm3Fg0Z2qi7Cq/D
	 rQ+5LLt5b9NTo7Ahrmxg6LUxuJeTw3igz4OWgDTEx1ScbGfCa7+0eN8iq2r7EM0JF4
	 wTLEFmlqlF6e8axwzr1iZcBeYsrfNrK7qNJ4aCtthsXA/gqcpLfmdN1rgkzYGMfTDi
	 aWLI/n/EAH0ByPXpLkW7svrHtaFxgM7+UXdcXI0Ypkv1HoJAa7gmyoAtPlDbVBfuds
	 qfox/053+0paESXy1hHl493DCj919CJFySRcCBE0REB3M1aZHlpbF9FPivtZS2/Dez
	 CDlw/cIrzuz7A==
Date: Wed, 24 Apr 2024 20:27:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
 <rdunlap@infradead.org>, Johannes Berg <johannes.berg@intel.com>, Breno
 Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
 linux-hyperv@vger.kernel.org, shradhagupta@microsoft.com
Subject: Re: [PATCH net-next v2 1/2] net: Add sysfs atttributes for max_mtu
 min_mtu
Message-ID: <20240424202703.29f1b59a@kernel.org>
In-Reply-To: <1713954817-30133-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
	<1713954817-30133-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 03:33:37 -0700 Shradha Gupta wrote:
> Add sysfs attributes to read max_mtu and min_mtu value for
> network devices

Absolutely pointless. You posted v1, dumping this as a driver
specific value, even tho it's already reported by the core...
And you can't even produce a meaningful commit message longer
than one sentence.

This is not meeting the bar. Please get your patches reviewed
internally at Microsoft by someone with good understanding of
Linux networking before you post.

