Return-Path: <linux-hyperv+bounces-3843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4DFA29FCC
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Feb 2025 05:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A877F7A3DC3
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Feb 2025 04:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20918C034;
	Thu,  6 Feb 2025 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PRpDxkhX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A818A6A8;
	Thu,  6 Feb 2025 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738817314; cv=none; b=V8BDJujkm5nGKDR4ZldD8RgULJwC4CX9oO62LbL0F0H6BbrDC91ZJgkqPJFPFggtraU+9rSq/KLBUV/cEgHKtoMX7b891v4ajenl0QrutIZzfxl5CXbcHTT78uR2iwernphsaYhnGbLeB8h03BYR7BNMv0gZp9Y4t2zj89y9W10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738817314; c=relaxed/simple;
	bh=MNi7mcAWBRDY2SSGt0bepZ81pQN0hFOvCIGNtZNDud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO2qUVfk8p8FuKEZESOP1WV7TElRsnLBsWB9SOxmxZTJA+XhH0ORLJ6azhv087Q6vmV7j4rY+gKbGIIFH24B5Jzkzkv06B0QnfvXt95z4JDyiL0snpeGSoH6dZ8Q7X2WkRmGLJxPDHk3hVUu7jVVrd5s+jQcLHVz9qcxP7tBcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PRpDxkhX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D513F20BCAF2; Wed,  5 Feb 2025 20:48:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D513F20BCAF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738817312;
	bh=OWuupa1UaQmJt5ljiVVqvWF1YiE/WgToQRN8ScivRUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PRpDxkhXHW6UiaI19CMB9sPZjhSuXDlEzclqTsmZ7PYbwazSRRjEO8D9ljTSdtyBB
	 5gHij1UMy0QLHvEeAq3mI2IfK8orY2Y+cNBb4PGvoVOjZTzJnvNE8Xu45utJ03DN0J
	 zdSxw1oo7VLbWtY70Wdx74a9qrmjyPNdUq4GNggw=
Date: Wed, 5 Feb 2025 20:48:32 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH 2/2] hv_netvsc: Use VF's tso_max_size value when data
 path is VF
Message-ID: <20250206044832.GA3614@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1738729257-25510-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1738729316-25922-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250205184319.360d2ca0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205184319.360d2ca0@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 05, 2025 at 06:43:19PM -0800, Jakub Kicinski wrote:
> On Tue,  4 Feb 2025 20:21:55 -0800 Shradha Gupta wrote:
> > Therefore, we use netif_set_tso_max_size() to set max segment size
> 
> I think the term "segment" is used incorrectly throughout the patch ?
> Isn't the right term "superframe", "aggregate" or some such ?

Thanks Jakub, I think you are right. 'aggregate' or 'aggregated pkt'
would be a more accurate term. I'll have this incorporated in the next
version.

> -- 
> pw-bot: cr

