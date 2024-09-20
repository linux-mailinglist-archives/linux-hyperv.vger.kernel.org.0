Return-Path: <linux-hyperv+bounces-3055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756CA97D5C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 14:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83361C209AC
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4116A943;
	Fri, 20 Sep 2024 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KNna4CDV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE29154425;
	Fri, 20 Sep 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836566; cv=none; b=Hp7df2nYDXUjItQ/1Jiu9LR6GCsdX+xbRj+dl3pa2dAIAg7kkckPDq37xEcuSVGFGYHEk7hGBgUG+XYNskr+n8q7MN5q6W1ZMScCBy6DF4yPxNLuM8YSBYLnns4WuiclOdlFxgVgMWl+UwB7Kr86Qt5rBLOij/LkCpryYmtZmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836566; c=relaxed/simple;
	bh=dz3ZOK8RweoNZJBvQ0/IcWNv0Aw1uFRQylDkziHNO5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSJC0SXKnq1ooYbsFJptN2aSo3RUjQCPKdZ2KnIP/zrx68SC0YeX25I7UCXU6M5oA/s2RV8T1QXJ7fttbP01Vc9wbwrT9MsJlOBR8pBI8LTrtsQ0qpUWAcvWuaSWKp5kFn3KpjmnNWH//PMsg7EcbPo3lA9Iktxd7/yh/zYUgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KNna4CDV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0C4EB20C0B1D; Fri, 20 Sep 2024 05:49:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C4EB20C0B1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726836565;
	bh=W5hKwvKNko6AMeYhYNpHbjM8KDfp5lpUMDns8H6KWtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KNna4CDVIVeRohC/qQ7aNKRnohIY8rILee8jTNZEZcjSyfptJAU+nO1ezTgJCmDnv
	 ZMLksbW+VWuhVrr8XmXNr6KyMF9O+nLDEk2MV8zLZVeTyaAIncwNg0dKXvV7AMg4s8
	 uvgeNtWB1CUISdMgs1ShIu0czBoElfJxEzVZTnu8=
Date: Fri, 20 Sep 2024 05:49:25 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"colin.i.king@gmail.com" <colin.i.king@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mana: Add get_link and get_link_ksettings in ethtool
Message-ID: <20240920124925.GA14863@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
 <20240913202347.2b74f75e@kernel.org>
 <PH7PR21MB3260F88970A04FDB9C0ACCC4CA612@PH7PR21MB3260.namprd21.prod.outlook.com>
 <20240917170406.6a9d6e27@kernel.org>
 <PH7PR21MB32606C49F796ED9E7AD0E5ABCA612@PH7PR21MB3260.namprd21.prod.outlook.com>
 <20240919094553.1ee7776c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919094553.1ee7776c@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Sep 19, 2024 at 09:45:53AM +0200, Jakub Kicinski wrote:
> On Tue, 17 Sep 2024 20:34:40 +0000 Haiyang Zhang wrote:
> > > Unless I'm misreading I don't see the answer to the "why?" in your
> > > reply.
> > > 
> > > What benefit does reporting duplex on a virtual device bring?
> > > What kind of SW need this current patch?
> > > etc.  
> > 
> > I'm not aware of any SW has such requirement either.
> > We just want the "ethtool <nic>" cmd can output something we already know.
> > Is this acceptable?
> 
> Yeah, that's fine, I was just curious. 
Thankyou for the feedback. I will update these changes in the next
version of the patch.

