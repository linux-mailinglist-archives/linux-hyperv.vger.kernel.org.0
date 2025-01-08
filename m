Return-Path: <linux-hyperv+bounces-3605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE90A05485
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 08:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96191886E52
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 07:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75A21AA781;
	Wed,  8 Jan 2025 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGLeSjl1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDBD19F42D;
	Wed,  8 Jan 2025 07:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321291; cv=none; b=PbLX17LH2P7+U36ivARhyMiRPxp7qamBuuVVFriGzUHRwcDuoDOkN0gByZ7kI44lCoXpeUkTPtUmVubJklAgdlRuYGxYoazXkLlrqc/7Fea9AR2HnAlqN2fScfg83e64qKY5/laAbeEsR7SEmQIhplKErNsT8hdlYP+4+VMCQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321291; c=relaxed/simple;
	bh=sq39sjhcgcSmEHGAtCq92JsO0nW1JPDIncoulTUzD3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ0k0rfx1OuqghoCnUTrohqT70Utj4DD26Q/YgTQE8NcBTiQIXtv/Z6vtRB/xGSFp7cqgDAi3b5ZEcf9kAzKmWlzJO3/vPCOor5zTaPCBLIbSt5KcZCOE7Kupf8cd8a4XGfHQr02SI6CUSi7/cfcqrBxZJ+SSVOTxPsYJjGVdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGLeSjl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A2AC4CEE0;
	Wed,  8 Jan 2025 07:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736321291;
	bh=sq39sjhcgcSmEHGAtCq92JsO0nW1JPDIncoulTUzD3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGLeSjl10jbTHi91DsXXmD7sP17inzqyCpOE4n6KTJIJhoSUktIWTFyn5JY6IGXPN
	 iM5OPPBl8Mtut/Ui4L9CEHWt0kkpYo+5VKcOyVMqCXFZh3n3o+us7bEvTomFzo3Q0s
	 +M8bUHbqXK55/esxcx4qGijKHeMmbDXMP2qsHPQxG+E6b2IqceDSY6EA0F5oH+IUzW
	 HScbyDUFW5fK/96I64NUEPapoqk4nLJe1CU4VuOd7/2FEZETikYSFT3QgC7w6xUbJT
	 XrxYMlID765CwaTV5XpR5TMim2f1unjzKZNZZBFMLLnXPNoNesiv3o2t0MuDTdDwzT
	 piPEnVM8tuHaw==
Date: Wed, 8 Jan 2025 07:28:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2] uio_hv_generic: Add a check for HV_NIC for send,
 receive buffers setup
Message-ID: <Z34pCVpGzhu_u8Pu@liuwe-devbox-debian-v2>
References: <20250102145243.2088-1-namjain@linux.microsoft.com>
 <SN6PR02MB415727CA0BD7ECE337BD1E12D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415727CA0BD7ECE337BD1E12D4122@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, Jan 08, 2025 at 05:26:58AM +0000, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, January 2, 2025 6:53 AM
> > 
> > Receive and send buffer allocation was originally introduced to support
> > DPDK's networking use case. These buffer sizes were further increased to
> > meet DPDK performance requirements. However, these large buffers are
> > unnecessary for any other UIO use cases.
> > Restrict the allocation of receive and send buffers only for HV_NIC device
> > type, saving 47 MB of memory per device.
> > 
> > While at it, fix some of the syntax related issues in the touched code
> > which are reported by "--strict" option of checkpatch.
> > 
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
[...]
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

