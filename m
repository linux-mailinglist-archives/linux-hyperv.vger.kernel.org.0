Return-Path: <linux-hyperv+bounces-7355-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90651C11E9C
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 23:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635853B9689
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B82F692C;
	Mon, 27 Oct 2025 22:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hs81Q2Fa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FEF2DA767;
	Mon, 27 Oct 2025 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605554; cv=none; b=uaIpQlb2xIh5oWcz4MOnJVCpdWXAmRdi0Wg7BFFsh4mNBA3t6o8Ovhxexpg5ab+I9MKIJ8His87/23JNR+u29hkxIhm7RWyX9PwOl/+J/ELiOmjVPgC8Rtv2xrWhcCyta7/ggBRBudy/BnxqKrcaSBPeiRsivJDjlaNAkFzSa9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605554; c=relaxed/simple;
	bh=yrCHsA4FE0DQZIKmxjTVqcgChi8qj2604NHLFRRakwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPlENOGV8H9vId4EP8D9/s5UCa2oMwfNjW3nEZBIL80hjoi1W4+eM+bqlTQ7Z3LDVgfkBGvLs22DKfOrHUNlgL20mRalBQ/g3Ds0M7jyqa9u8C7R5VP+j1mMyitMZntXATF4nEegpSlO1Kc4Ah3mbeC4SpJhTzc0OSJf1HAx6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hs81Q2Fa; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C261640E019D;
	Mon, 27 Oct 2025 22:52:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wxK6XUZyRoym; Mon, 27 Oct 2025 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761605545; bh=7v/WPSjOch5oe5tgxg1RBNsrwNHRci6/At81V+V11Wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hs81Q2Fas0n2vUs1TVVjyyupw+LiKeWwyK+fzb8MPgZMVG2yl7vRLlTbXUJz+noVg
	 MUpddT3gyY534UKpCr5yvjme+iIFcpsyA1PXP2DbAg/s4G3BrBHJrTDlq3oT/LAYf7
	 1G2LMrUqrw/wkhamIsq4Xh6baOwcvrkTcW3oaR6PpA28O3nGvmLrJlPC6KqTprw5zP
	 xdQYZzJj4x1e+PJXO43kpKyWgVAEKu/Q0f9HwiRb+tEjkLbB8OL8kpzRZxo8zDt4To
	 LlaIuULxhvN8bKC+uPGTwSzOmpl3Q4FBkPh2JwLd1I5NjmXOr6d4S+qkelEQ/J7ONX
	 Z4KJ6r+48i30rllGNMGA1Q057+KX0TEXM7x+G0sR4ckWhPvqnojCKw7E9/b8SJlV9+
	 uCy3jiKbapkjZnwf0LAnAipZsxmeEXABHDBiCXpUGJPp3pk6298fe6ZNoKpiztdxS0
	 lN3/MQSJHLKVEVukXwHIkiRVCJbbZs9BYC0Dapm0BD/idLZzrGgFnbYBXZrdmEaXJx
	 idIN5o3a5mRsdT3fCF4MfZHhQ4iwc/L46Pz2R8NsJ4jga4WkQHbnEWwzHnceBqy63k
	 rmEQQtmgJRDF8KbDCBqZHPzpThDmpYtB4jM77UdPi3wjBHNcvpWR7EDf92iogTP0JP
	 SwsXVt1PziPHyFzyoYvGS5RI=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 104B940E01A5;
	Mon, 27 Oct 2025 22:52:04 +0000 (UTC)
Date: Mon, 27 Oct 2025 23:51:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v6 03/10] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20251027225157.GEaP_3jeX5SgNwshus@fat_crate.local>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-3-40435fb9305e@linux.intel.com>
 <20251027142244.GZaP-ANLSidOxk0R_W@fat_crate.local>
 <20251027204538.GA14161@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027204538.GA14161@ranerica-svr.sc.intel.com>

On Mon, Oct 27, 2025 at 01:45:38PM -0700, Ricardo Neri wrote:
> Agreed. They are in the "To:" field of my submission. Rob has reviewed the
> patchset.

Oh, sorry, I missed that one - must be blind. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

