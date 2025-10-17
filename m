Return-Path: <linux-hyperv+bounces-7259-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF84BEBE38
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 00:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC0AB353B89
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 22:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4C2D3750;
	Fri, 17 Oct 2025 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="girOaNid"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5424925F984;
	Fri, 17 Oct 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739102; cv=none; b=NU76gg+Toj5MdxEoHEIRHDVQUi/TJvDrH0NR+2IUgjRn37rbhTddHU8twn293CaO/1b4fJA4k64wL8KteLCqbJIGXCAJl5IX1hSslXgzYCUIo6uiWaXRU2EaE/xWdxqGnF7AxXUbVWp22F1Ai5GsIUocvawfHF9Yaz8ImRpo1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739102; c=relaxed/simple;
	bh=g2HrjUwo80wZqc/Ke42Z36dlvTNKp51JohZatowvxoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSlSHkSG6Bv9nnhBY/EsPex6x54+Cg3ByVuz7PVtTVO/zVqkB6Y7wOkwc9IXdKxvtcOmBTsXwUE1xkoiT28tViteD3c7Rdd8iOxjH5ay3UvjkQ2bC2qLnw+7A1XZxsjRH1fmeaK2W/8MA/Cq558GRyL/mwvEbFSsZuq3rcpk1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=girOaNid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD25C4CEE7;
	Fri, 17 Oct 2025 22:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760739101;
	bh=g2HrjUwo80wZqc/Ke42Z36dlvTNKp51JohZatowvxoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=girOaNiddH3G1/iHgXYG10kBDfdyLs3Ey1ni9yTm+I6tu5pPN05VioKFVz1I8rYzi
	 Fjfx7tVVTAjbpYXJ70XswMT7Xr0W9nLmwrQFbkkqyX/p79nYT+AnBYIja7rKL1hnsg
	 lPTLbjKZVe6r4t9Gf3I4vWoa0FTp3bnlga6lMNKtcRkc1F+mNqkl8OlSxBVV7njZGf
	 Q4oZWc54RZQ75QdZyJyoX8h5takFyy+9JDrGa0czj9XOjpnW2jMIBt2aoIEgk+lEHX
	 RJrQ7sJkTrWiZA39z/wJu/RIE0Huw75cUq17lWIj+b7a8V16Y2SUSVqQFd1h4JMPcu
	 nmt09biJDwoYA==
Date: Fri, 17 Oct 2025 22:11:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] arch/x86: mshyperv: Remove duplicate asm/msr.h
 header
Message-ID: <20251017221140.GC614927@liuwe-devbox-debian-v2.local>
References: <20251015015014.3636204-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015015014.3636204-1-jiapeng.chong@linux.alibaba.com>

On Wed, Oct 15, 2025 at 09:50:14AM +0800, Jiapeng Chong wrote:
> ./arch/x86/kernel/cpu/mshyperv.c: asm/msr.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26164
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to hyperv-next. Thanks.

