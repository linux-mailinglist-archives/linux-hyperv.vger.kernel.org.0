Return-Path: <linux-hyperv+bounces-3127-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372F9912F7
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Oct 2024 01:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A611C2297C
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 23:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1686014F9EE;
	Fri,  4 Oct 2024 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCF2gfOl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606914B061;
	Fri,  4 Oct 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084337; cv=none; b=i71EfITd2dWAv0EerVIL+rEkLuwPpgqS1Y5b2f2/xSM4ggGsrxXIxD8LI0fmMnBlVXNkKWliQng5r1+V6tIE9Gz9KA4mPZTbGlUQHxHScbyRyQ9GEgzQiYV+bJbvfQTjeSG9738p0N79cuj/ONADquhT+QGWPgk0/Lmv6Z66acE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084337; c=relaxed/simple;
	bh=X7bWUrGAoeaYj2qQvBNE13pGmp5s9+vQp85qGbVkxVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HumaJOGLYa+WW4M9R4s800NUWG3rk+2AqA/BYPt/CrGXkJHgQ6wx+RGPGV6MnZIOzkuedw2qjuHV5A1B5qmRwvBMReRV+60VLwETRJMAhp9eWaMeM+DDb01hSLOon8s9W2k7/GGdhWj9WJQXomIieoFdKDvD9WvCcI0rrfaOi0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCF2gfOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84734C4CEC6;
	Fri,  4 Oct 2024 23:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084336;
	bh=X7bWUrGAoeaYj2qQvBNE13pGmp5s9+vQp85qGbVkxVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bCF2gfOl2Mw7Y9W7WEsisqwK2avnJ2PwAMpC/FvVODMYmKB0o+SU331CYDrg2hdNB
	 iGPtD9zL2/36KOOVmvMyR82BKpYmY/wY+EGAQ2NNs2XcNGv7f5gtut29jJlh08b9Db
	 wwZI8nsc13ZE+ghKXc5IEsr8kY2D8PB0ecm89f1GuUeEwwMnL0/PkAqfhSTkal2r2j
	 Z0u9drqnNVCZ5ovsA7LzfvqD1Jw461zxihIOTzM/dNeiQ21Gm5dtMp4XnUDPCUdAzM
	 RNTu4WqXkwdJBIS2OnmYE+o/PpywXJfsCqtoY7XDHSQ1+cDef9s+IECgDyewf7Sn/e
	 uJbFrzZf6MGSQ==
Date: Fri, 4 Oct 2024 16:25:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: patchwork-bot+netdevbpf@kernel.org
Cc: Michael Kelley <mhkelley58@gmail.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 iommu@lists.linux.dev, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/5] hyper-v: Don't assume cpu_possible_mask is dense
Message-ID: <20241004162534.6680f91b@kernel.org>
In-Reply-To: <172808404024.2772330.2975585273609596688.git-patchwork-notify@kernel.org>
References: <20241003035333.49261-1-mhklinux@outlook.com>
	<172808404024.2772330.2975585273609596688.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 23:20:40 +0000 patchwork-bot+netdevbpf@kernel.org
wrote:
>   - [net-next,5/5] hv_netvsc: Don't assume cpu_possible_mask is dense
>     https://git.kernel.org/netdev/net-next/c/c86ab60b92d1

On reflection I probably should have asked you for a fixes tag and
applied it to net :S  Oh well.

