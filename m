Return-Path: <linux-hyperv+bounces-3049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C53697C50D
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 09:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C01B219AC
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2024 07:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD118E055;
	Thu, 19 Sep 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrFsYpbx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5C23A6;
	Thu, 19 Sep 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731960; cv=none; b=InTYMOPzPOgzJdcSlrTAqaKLy96hKI5ux6ay3YcU6OSwpBRifgU8jP2peA2mTQc5dpoV1wIbuf39o1u4Z6VHTTBzwquxVjjYgGXdhUjlu7wa3A9Y9NrKB92i2uRdizfM/UnJ8EnVUDRFIROhSuYUrnxXbnSG/glQ7ib0ZOfnER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731960; c=relaxed/simple;
	bh=qEMMGKMY3GETYdqOm3V9vI9ZoJfC7eDMAGarWiM29K0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srjoNCKNKN8yYenunSXKIkiXbnZY15e/ojWo111s8UYQhbsbZ4iDvGuAyAlQCFGbegvKTCd9b4iNIkX/MIpseEdBh2/MQpjv417sayoAl9D0QtraqsswOhRQejpDtrtbdvYMJWXEWbpjpNLuXLn1AIbyoh1twErt8VRaQRQdiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrFsYpbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CE3C4CEC4;
	Thu, 19 Sep 2024 07:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726731959;
	bh=qEMMGKMY3GETYdqOm3V9vI9ZoJfC7eDMAGarWiM29K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IrFsYpbxMy35Es+LTwzPeFkyDIKQDOdt/OXY31hQbpdLFUjFb+ctXB7lpotvh6XwO
	 0w0KBhgdIfVoGWksf6+T6/Ir+8cbFslQ52gqKckjrH81M8zVCoN6YFz8spLBeOdhY6
	 eBkbMHfs0/CxTUMUWCjQTOgpBuuUaXakWrffOcqVyhKC/6NARq4gQs5jwxDFYasQLx
	 rekX1hcOgQPZieCIZESLlXdzQcaS/Ken9/eXLHs08mgCTwKvVfB9omdGgMLx+GKPeO
	 M9ySPvzTLNDFZBMaKae5lkfBcRzUu+EFx/xStfFTs+sUjikqW5wx+cmXKaiIHC0t56
	 Ogv/O1zvWR2Fw==
Date: Thu, 19 Sep 2024 09:45:53 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "shradhagupta@linux.microsoft.com"
 <shradhagupta@linux.microsoft.com>, "ahmed.zaki@intel.com"
 <ahmed.zaki@intel.com>, "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mana: Add get_link and get_link_ksettings in
 ethtool
Message-ID: <20240919094553.1ee7776c@kernel.org>
In-Reply-To: <PH7PR21MB32606C49F796ED9E7AD0E5ABCA612@PH7PR21MB3260.namprd21.prod.outlook.com>
References: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
	<20240913202347.2b74f75e@kernel.org>
	<PH7PR21MB3260F88970A04FDB9C0ACCC4CA612@PH7PR21MB3260.namprd21.prod.outlook.com>
	<20240917170406.6a9d6e27@kernel.org>
	<PH7PR21MB32606C49F796ED9E7AD0E5ABCA612@PH7PR21MB3260.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 20:34:40 +0000 Haiyang Zhang wrote:
> > Unless I'm misreading I don't see the answer to the "why?" in your
> > reply.
> > 
> > What benefit does reporting duplex on a virtual device bring?
> > What kind of SW need this current patch?
> > etc.  
> 
> I'm not aware of any SW has such requirement either.
> We just want the "ethtool <nic>" cmd can output something we already know.
> Is this acceptable?

Yeah, that's fine, I was just curious. 

