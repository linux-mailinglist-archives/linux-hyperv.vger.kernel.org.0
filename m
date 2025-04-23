Return-Path: <linux-hyperv+bounces-5075-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E80A99B08
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 23:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C365A66D9
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Apr 2025 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9A1FC7D2;
	Wed, 23 Apr 2025 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee4pCpT4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2562701D4;
	Wed, 23 Apr 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745445445; cv=none; b=tHBQ8ucj98GhjKapOsnnqQOyH0b06IKGUh/wMddEKUTj/pBq/Xj2YTyIGVfRfy8B46AmUrjF8TPVPUR21Vpfj7mA/pr3OjNLlu9b0OFkCNbSsle298vsbLpCGYibKUHMY17wgF3bJF/WQUmfU4M/Fh+ufqY9naoLOiekAYRUIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745445445; c=relaxed/simple;
	bh=LTR2hs5byCKEFUsgJ7ZJqVPMvJGrhL4/fkSVIHm6vY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRWkDGGUDYXVYdvvUfB/sVM1BivetuQYANEZG5lP2FrkkQyKjun2b4YlLKdK7yGcBglTZk1vKw2FJD8zAxXWnbcbnObOunB2mqOvNwcoy4GaZeePpYBR/wtQyP0t8vEHBZwXGgu0K5peVz7J6+X8mWQ++p+bS8B18IgPurGpcEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee4pCpT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9781C4CEE2;
	Wed, 23 Apr 2025 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745445444;
	bh=LTR2hs5byCKEFUsgJ7ZJqVPMvJGrhL4/fkSVIHm6vY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ee4pCpT4JI6TxES3sauuCCzIWPDS+jtUV/VUeo6DUX5gr+IAFrQU0MHeA/J00Qp7W
	 YIbhEDp8MMN/t8t/NIgvn+35BqbkG1pKEfHG9Oacz+BU5W7wj3LWUf5SrqwFH/mboh
	 gG5ysWBFZYNfJHus3EinC5422Lq45C68v/Sfoo08zSE1QoTa6LEIQOQzOcYUrBd0eL
	 334qA8IvSZ8CrbhGoUHFsc7jXsdh3HAUT9MVPYBSCqKagjqbD+PBAf62LSTHfkkgOW
	 8LvAlLyYBrFb4xaS7AViTiHzLVnfOXEHtMFGLpx8DtPz1+Q3Opnp3MLnngpdK7y/S3
	 K7o8oHgj6JCPg==
Date: Wed, 23 Apr 2025 14:57:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
 <longli@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
 "horms@kernel.org" <horms@kernel.org>, "mhklinux@outlook.com"
 <mhklinux@outlook.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, "kent.overstreet@linux.dev"
 <kent.overstreet@linux.dev>, "brett.creeley@amd.com"
 <brett.creeley@amd.com>, "schakrabarti@linux.microsoft.com"
 <schakrabarti@linux.microsoft.com>, "shradhagupta@linux.microsoft.com"
 <shradhagupta@linux.microsoft.com>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "rosenp@gmail.com" <rosenp@gmail.com>, Paul
 Rosswurm <paulros@microsoft.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/3] net: mana: Add sched HTB offload
 support
Message-ID: <20250423145723.7ff12e1a@kernel.org>
In-Reply-To: <MN0PR21MB3437359D91F059D83AF929F0CABA2@MN0PR21MB3437.namprd21.prod.outlook.com>
References: <1745217220-11468-1-git-send-email-ernis@linux.microsoft.com>
	<1745217220-11468-3-git-send-email-ernis@linux.microsoft.com>
	<20250421170349.003861f2@kernel.org>
	<20250422194830.GA30207@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20250422171846.433d620d@kernel.org>
	<MN0PR21MB3437359D91F059D83AF929F0CABA2@MN0PR21MB3437.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 15:27:16 +0000 Haiyang Zhang wrote:
> > > We selected tc-htb for our current use case because we plan to support
> > > multiple speed classes in the future.  
> > 
> > Which net-shapers also support.  
> 
> Thanks for pointing that out...
> But for easier usage with existing tc tool for customers, can we still
> use tc-htb offload? Does using tc-htb offload for speed clamping break
> any coding convention or API specs?

The only spec here is that the offloaded version is supposed to look
like the non-offloaded one. I really don't see how you can claim that
static single class HTB is a accurate offload of HTB.

