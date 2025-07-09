Return-Path: <linux-hyperv+bounces-6163-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B52AFF06F
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F57BD2EC
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 18:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430ED236A7C;
	Wed,  9 Jul 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5vsN/J2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE12367AF;
	Wed,  9 Jul 2025 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084185; cv=none; b=j0kbnrKmK6kubCo98WgsCYNtrgopzmYcNQOjqV86CeZ/ARj5vh3EsjZjy2pl7p5sxiCidRqLbHhcS9hctCUld3gre1BVdqmTrWOFQCrfAY8EBVsgTOYOCgMi5sjFUvru+/8IlkPjoXgS0M4evovfCQC1EMomDcAU6TCPbrRN1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084185; c=relaxed/simple;
	bh=9TndvRUCOVdijD5GklCz3L7QYgs6HRWEN7MjwmJ8Mdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi1gt6EHLyu18CwUEvGoysfzBBQF6iv5xUaqck5npq494p5VNL75pecnNlVvgX4T1d9s0KU4cRuBdYKfuhX+F2XZfLvx7PJC3R9qLElVGbfgmKUaF9r6nCLDhtEZApxxOgnMyehkEVXl9B1zF/HXZu/vz5ABsc5WcITD4tStAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5vsN/J2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C3C4CEEF;
	Wed,  9 Jul 2025 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084184;
	bh=9TndvRUCOVdijD5GklCz3L7QYgs6HRWEN7MjwmJ8Mdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5vsN/J2CTMmQJABDvmiiJVMbp1hW6XTgMCw2us7ifU6gfEtKU17vgXWxLyTdUK++
	 /1ctwrqKd/7YFC29ghWNKxxURnzT0c9LhAYWV3CziefxgO/bkMpR6oIIf4i3jB/eDj
	 Wj+7HrFWsb2YLa7Pt09EheZzljJ9AOohRSp4+l+/shaRW1nprVmxn80HiyLLNK7GLJ
	 bpvwDimR0vGKyE4TCPcSsM317eZ4kRMG2XXe8bvldfafHQdWlGnM+hc0sV1sE4UUfH
	 /63+RFGHZVg9+5JBeUJx5AixvmIvq/I39bA2NdEjo4k6XYjUYtmgrHJU4MsDuMP7cU
	 yUywhcQfi8/Lg==
Date: Wed, 9 Jul 2025 19:02:58 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] net: mana: fix spelling for mana_gd_deregiser_irq()
Message-ID: <20250709180258.GG721198@horms.kernel.org>
References: <1752068580-27215-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752068580-27215-1-git-send-email-shradhagupta@linux.microsoft.com>

On Wed, Jul 09, 2025 at 06:43:00AM -0700, Shradha Gupta wrote:
> Fix the typo in function name mana_gd_deregiser_irq()
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


