Return-Path: <linux-hyperv+bounces-3676-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE89A0C130
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2025 20:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469011699A1
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2025 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC031C9DCB;
	Mon, 13 Jan 2025 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZgZk39y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50E51C9B97;
	Mon, 13 Jan 2025 19:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795906; cv=none; b=DhyigZ1KO/f3mQOS05Tlm2EdE0RYKZjKEVThlaRCkzIeTVpdTtmS5CKA7XQQRzt0RjJs40hBECXPd6OlIShwL/N8DlkPMOqHEtrTV1LRovWvnbOlqJnES5HcF98qZhPclysFY/hsR4s2e0NNhlTC3bZ91hnTNLGnOJJYUogh0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795906; c=relaxed/simple;
	bh=/12xZhIIcLGXOrRG6HkfBilOf+iRadWhSHWPa0NRy2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BB28v0+nm9/C/AeVu7jrJBu7z6Y2DGR3E1hzc6pY4IB1XfNGvsqWFFssjCoVmnkDWFVnubbh1Rzfg45hAOMv2BxcDYaKVuz/GsxTowGP+kxypip+d3ygjqw9BQc0qa3/RW5y5l1fO5iEHMY96tZhkIVu+qlwbBqXm1rgoGRKVXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZgZk39y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F0EC4CED6;
	Mon, 13 Jan 2025 19:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736795906;
	bh=/12xZhIIcLGXOrRG6HkfBilOf+iRadWhSHWPa0NRy2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZgZk39yMc5XYYe53Lhx8NytpGIDl0W3sb7FlwT2+GbRxDQTZxqYd3hAP4rKUTPAn
	 ooY1qo1UTKIBCI3u3nYvaFNClYMAidmDx3drxjPKDtmjPCGPg7zgPPiYlpA6RuVlOj
	 hYwbq39DeJrHyvmItOqBBsHLJyG+0rw0tRI9kj5+N4IGVdR9t8dQmQRKbvA6yiD4e7
	 qZWnYqP2lRGaD69+pqonbB2MuVb6EtP1N1H/KiykXatlgaq7XrLkZ/1XKtvYxpe3Rt
	 +AIsbWKJxy9cDHa0hun799Agc1p116XGs7/652nJQYj6V25XiteOjnuR/ddyBJGWcw
	 BblEDVoUkyfhw==
Date: Mon, 13 Jan 2025 19:18:25 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	kys@microsoft.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
Message-ID: <Z4VnAdkDYCGKQwvX@liuwe-devbox-debian-v2>
References: <20250113145645.1320942-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113145645.1320942-1-mhklinux@outlook.com>

On Mon, Jan 13, 2025 at 06:56:45AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Add documentation on how hibernation works in a guest VM on Hyper-V.
> Describe how VMBus devices and the VMBus itself are hibernated and
> resumed, along with various limitations.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.

Wei.

