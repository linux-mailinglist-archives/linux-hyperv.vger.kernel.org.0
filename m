Return-Path: <linux-hyperv+bounces-3879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A395A2F627
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FB73A40C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EDA255E38;
	Mon, 10 Feb 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ki8PUhMw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB10255E37;
	Mon, 10 Feb 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210275; cv=none; b=C2a9NVX3SzoQTBSmncviS7Kp8DpWemgJIhaTHhktsnI1k9ZU7I38U7YF35dct2TbSBsyHGtE85CQnHbOjLVNDphbgJDg5NMHop721zRotNHXdZKtIn1BrlAFVUBDVcJOIaMXH3v5U2VkF4hi/yBpG3J/LQB61lMdzUvvsVkYTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210275; c=relaxed/simple;
	bh=0BL+5MDrOGimiNiYxNODZoFoBzWmS8VkK+afv3AIqlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGNAi2I7qLigUtsBObCSd+8LYQjIjdELxP3FTCKNbO+YxNvc0i8x20Uq0IqM5wlQbtkIWavruiO3i0+aCTdPNkLwids8ZNTmgm2D+JOrHXzrIQtF1ZiDaP3v278A+u9E7mZnHaxgv8cC01Wn6hz9sEHr0OoweSVuQFPS6PqCE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ki8PUhMw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 3D2732053680; Mon, 10 Feb 2025 09:57:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D2732053680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739210273;
	bh=KtVE5WFO167jDDFeZ4br9fxLQI0RyYY5w6D1vKSX+qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ki8PUhMwoClTWT+UqKMXozInxfcnqSVKWObgEBWumMYE8jpjH0PsFfl9WwxnLcfnv
	 EpjruxWuFd0+O4YhG/pRlm+Hwlu1OiSawlFqnwuqTJYhd/0yg7eQ/ylMsj1E9v1e0T
	 2LJdyawx9ayevTrvqTWzDba8oSUKs/HP/0ySkqhU=
Date: Mon, 10 Feb 2025 09:57:53 -0800
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 net-next 1/2] net: mana: Allow tso_max_size to go
 up-to GSO_MAX_SIZE
Message-ID: <20250210175753.GA17857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1739162392-6356-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1739162428-6679-1-git-send-email-shradhagupta@linux.microsoft.com>
 <CANn89iJ3cT6BWLmFpdkxn6EeeLTM7rF0pwWGArq1gG8pk8orsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJ3cT6BWLmFpdkxn6EeeLTM7rF0pwWGArq1gG8pk8orsg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 10, 2025 at 04:55:54PM +0100, Eric Dumazet wrote:
> On Mon, Feb 10, 2025 at 5:40???AM Shradha Gupta
> <shradhagupta@linux.microsoft.com> wrote:
> >
> > Allow the max aggregated pkt size to go up-to GSO_MAX_SIZE for MANA NIC.
> > This patch only increases the max allowable gso/gro pkt size for MANA
> > devices and does not change the defaults.
> > Following are the perf benefits by increasing the pkt aggregate size from
> > legacy gso_max_size value(64K) to newer one(up-to 511K)
> >
> > for i in {1..10}; do netperf -t TCP_RR  -H 10.0.0.5 -p50000 -- -r80000,80000
> > -O MIN_LATENCY,P90_LATENCY,P99_LATENCY,THROUGHPUT|tail -1; done
> 
> Was this tested with IPv6 ?

Hi Eric,
yes, sanity and functional testing where performed(manually) and passed on azure
VMs with IPv6.

