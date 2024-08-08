Return-Path: <linux-hyperv+bounces-2756-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7E94C199
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3966B23EF8
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE01518F2DF;
	Thu,  8 Aug 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj/8g/8k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECB18CC0C;
	Thu,  8 Aug 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723131558; cv=none; b=Nmi01a27uo8ZRzN59xtN/BZTcxxSRLneCgbHEUkVcbXeIODFbfqNuFW9M9HiWf3ho+o84lkTMtNBMQBE2vjQm0HuK/Nb5QLbMmEG5Nd9SArLz7NGbNR5rD/UgTh1X9WVNnW7PPTK+55rgV2hQIRVja4YN5QqcZd6GLluWYSHkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723131558; c=relaxed/simple;
	bh=5I3JqUjrHphfr+mgMH0UcCmQpv//wLFfvIUXXYzw/qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebU6cGbqrwhyD8DLtx683BkdxxYsXt+HR8H6Pivlo8SP5yKzk5Y1CSOaVdLPMge7ZdCUwMIrOc1AsRF96EGu1/k4sy6DHe+6lf1Rt0SWgdSGvUgKQTJmkjwlFKlOTPKySw29I+ujhcKuuvP0IWQJ8hwFrtJgt4S1Oi8xl9OFzEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj/8g/8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3C0C32782;
	Thu,  8 Aug 2024 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723131558;
	bh=5I3JqUjrHphfr+mgMH0UcCmQpv//wLFfvIUXXYzw/qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lj/8g/8k+VjlFe29O59/UVSZDJKTawhD6gWcmEMTvlGFB1GwQ8gfwWtSaVc8gdwHv
	 QV+o3USbgnkId23gqVK3jns8giYIKyf+edjkSzmTh08u2RKSDvh7q7l2IF8wRwTX/a
	 xOQa4kaf9tu15oIP2GVlOHzQ5vjI+GIT5UzHsMdRyiw2Y4VGwWhBHqd9hcHbnNGjxB
	 MTRUW0Exd60dNbe1uKKZZWK/i6pyAHpQ4HxMlQMYesHdpzuGo3ijOj9AdMRO4x3NVm
	 ICFB9cd5YNbrA5+wcaqyyxjQS6H+jkArprBJWmuPC0O+M4HYmGyBpAntoAeTLHGgMm
	 xUf9+6udc8B1w==
Date: Thu, 8 Aug 2024 08:39:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Simon Horman <horms@kernel.org>, Konstantin Taranov
 <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Message-ID: <20240808083916.212b9b64@kernel.org>
In-Reply-To: <DM4PR21MB35367486106C04FA145495DCCEB92@DM4PR21MB3536.namprd21.prod.outlook.com>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
	<20240808075504.660a5905@kernel.org>
	<DM4PR21MB35367486106C04FA145495DCCEB92@DM4PR21MB3536.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Aug 2024 15:33:55 +0000 Long Li wrote:
> > no empty lines between trailers please  
> 
> I'm sending v3 to fix this.

I hope you don't mean you're sending it _now_, given:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

