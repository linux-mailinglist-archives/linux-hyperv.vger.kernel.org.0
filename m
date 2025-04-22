Return-Path: <linux-hyperv+bounces-5047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311CFA975F1
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED51189F6E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 19:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEA284B21;
	Tue, 22 Apr 2025 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Af4OqbtN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DF7219A91;
	Tue, 22 Apr 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351319; cv=none; b=RQ7mCZMGyicm6jP5JgWDLM03GZ6eHBEdm0GRhwrKBWJNpkTdv1b7taeBa7RVnrber0F8nYT6y+uHE2VR2A/HcSMCukHoti8vmEtc6UULwhlmIMryAKDwtMQx0ax+7vTe8+t+ifHht++dcl1AdpIDrqAL/L7byACLHTiokmW+7Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351319; c=relaxed/simple;
	bh=+Kc9qy0oOaQWfmBZYMJPtaNtRt9LORMvyFTwcxkuuwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNBkfGufu9VAyKXKmXjNV7fvefUGDfmGHY31y4U/iyuNsNaWNAV7/1hODbGew7aadxeuysJ5+LpOactHpLcdUmna7AYpuo+C7rVMx+a0ii6y6UKN5nlLAlz0UjFnq4HgLcqsAXLSPDm3WWfgRngv4aXh0ChvqNlB+zjoO7LktYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Af4OqbtN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id E8851210C43D; Tue, 22 Apr 2025 12:48:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8851210C43D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745351310;
	bh=0Y0SCgk8WWvrPPxNLfgEcUoXF+2NFMMnEfNH2Dn2KVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Af4OqbtNNYqiEt/07RHpJ+Yr6wO/I0+bXaU3VfkgEdR14jCWhDRBR81bAzJr1pXsV
	 3VvF1ZU4RimHvw0zvEq4Uyz/kZNvE8LEAsDI+eRmjzpueQad+On2kIjDPknp3mJvhi
	 HkjF5oWd800voUOFFA0NTEyVLh+E04mfbHxl91f0=
Date: Tue, 22 Apr 2025 12:48:30 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org, mhklinux@outlook.com,
	pasha.tatashin@soleen.com, kent.overstreet@linux.dev,
	brett.creeley@amd.com, schakrabarti@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	rosenp@gmail.com, paulros@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250422194830.GA30207@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
 <1745217220-11468-3-git-send-email-ernis@linux.microsoft.com>
 <20250421170349.003861f2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421170349.003861f2@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 21, 2025 at 05:03:49PM -0700, Jakub Kicinski wrote:
> On Sun, 20 Apr 2025 23:33:39 -0700 Erni Sri Satya Vennela wrote:
> > This controller can offload only one HTB leaf.
> 
We selected tc-htb for our current use case because we plan to support
multiple speed classes in the future.

> This is not a reasonable use case for HTB.
> 
> If your reason not to use the shaper API is that there is no CLI
> for it perhaps you should add one to iproute2.

