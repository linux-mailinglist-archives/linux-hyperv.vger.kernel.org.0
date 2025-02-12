Return-Path: <linux-hyperv+bounces-3920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FC4A31BED
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 03:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A13A7D8B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B661AD3E1;
	Wed, 12 Feb 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnqUsNzw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB718D65E;
	Wed, 12 Feb 2025 02:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327095; cv=none; b=AcehvUSZei8Djrq32Nv0CLZ70XEiy9WkqLgMtdlyoPgAF9KjvLe1sIQwd47+FuJCW1WYl5/nTi0INvHx5IUsINJnl4inqouav1f70SyBerrgCxN26AYEnI8Rkd+iRcgymFZi36d5CtlOiWSIabi4ln2ebfIRa/9bZO6E7GyK2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327095; c=relaxed/simple;
	bh=E3/R8jTQ7LvAndJhpbaTvwy+/a8I2I7YwVNB1IRmwFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNTth4q9WRyf4pfK0JPRGLDVsIHfRuV3pvhQEOXP8LZT3XTv25kcyRrjIS4yw4E9BAJMm4TLROh5RkTCA51gf+m0Bsl/7TC4tiAOpDgWaYpZyk8l8MjGoXDMkcLuajhYRG2Yxtz60drH3+GqNoe0msPZWUm+VMEhJAvRefyOnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnqUsNzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720C8C4CEDD;
	Wed, 12 Feb 2025 02:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739327094;
	bh=E3/R8jTQ7LvAndJhpbaTvwy+/a8I2I7YwVNB1IRmwFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnqUsNzwpYGqb5/3l7RV98d3P4cTsue3AsFvpqDIKyF4GM25+UQMS/MgoQQracU6Z
	 ZsFCG1YcjIwKGda9GO/HyTmgNeT/Nn/3Uc5Yb9fSfIVx9ef++5ZhTTkacC5JJJa84D
	 WxC9+ordzwn+h6nPqbXE2liM28llk+QjYb6wUQ7eDkxqBMkAKQkJ6yznmoIUt3Q6Dd
	 J/Jtxkwo607RGl49A4w8MHWXV4xxeooTbdvw9p8H7E/u6Yq6bndETd+fIPimf0Ta93
	 pbj/fcXoBVyA5xUnc6r3DmML8ChW6x3vfh62tal7fFU6Og2uRLwZWs+Wgvv2+cxhYC
	 gYN4lXjaXQSyg==
Date: Wed, 12 Feb 2025 02:24:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
	g@liuwe-devbox-debian-v2.smtp.subspace.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Hyper-V/Azure@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	CORE@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	AND@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	DRIVERS@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	status: Supported@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	PCI@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	NATIVE@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	HOST@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	BRIDGE@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	ENDPOINT@liuwe-devbox-debian-v2.smtp.subspace.kernel.org,
	SUBSYSTEM@liuwe-devbox-debian-v2.smtp.subspace.kernel.org;
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <Z6wGdTXExwcTh051@liuwe-devbox-debian-v2>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207190716.89995-1-eahariha@linux.microsoft.com>

On Fri, Feb 07, 2025 at 07:07:15PM +0000, Easwar Hariharan wrote:
> The VF driver controls an endpoint attached to the pci-hyperv
> controller. An invalidation sent by the PF driver in the host would be
> delivered *to* the endpoint driver by the controller driver.
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Applied. Thanks.

