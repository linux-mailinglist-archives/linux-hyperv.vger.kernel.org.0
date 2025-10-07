Return-Path: <linux-hyperv+bounces-7132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C1BC20AA
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Oct 2025 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4813AF413
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Oct 2025 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3D2D8DD6;
	Tue,  7 Oct 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKbHJeii"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF892147E5;
	Tue,  7 Oct 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759853319; cv=none; b=FDLuNkdcR4HmO/ldXr4ODLAaoxVzoejq79S8E6otPX5cJ5jFiKu38EZRgYQtMXcYZmKvRxkuYwSv2V9nMpU1t7xNovmMUWCuHoy6+MiamblsrQVEZt/RZCl4hC4kW0gmEeDVCKjUXq3lRq6CVJzETNN+Ld3UcsU4Za1WdtD5AF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759853319; c=relaxed/simple;
	bh=ha4yd/PzlsONNNw76JVJvpp0LSNcQKRVyRq6UrVlPQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s15zDK83u4w1r8dN8FyYACg+i/IVE05kaqY3uG3XdUyWcYy/dwScst/ucskuny5uwErc6qOUu8c1zOy50HaF+1+WlH2Lo2EgGITOsl7cKNzVe2h0yp3DBVo3hMXzQGH4Lj782ryzo4c0vkDJ+PWhu/CpbRgZBLlbFMezmirpSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKbHJeii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA2C4CEF1;
	Tue,  7 Oct 2025 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759853319;
	bh=ha4yd/PzlsONNNw76JVJvpp0LSNcQKRVyRq6UrVlPQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKbHJeiiKCYE3Tlksh9FJcjsVxlz3puWpQVLGXnihmyv2mt+R36cGSTYEBY/32qf9
	 pED7bevQ9oGN006cFUUbGRxdF8yrtVyTueP+X+TEyOA364pF6B1stGuL1zgkAkJFvx
	 TW6Byn3OZDthCImOkXelbF0ZM78K7ww74/StZrIzufeDmVd16Rgr89lG/pAXRr6ESq
	 H7voZjVeBblQ1MuB4lbT0RoZ78cxYctH9ZnT70ZrmLbE09pl9B17ZR1VOeioSGCBCM
	 wo6lGMIwRswY6SHSEqGbqyTlMh/U2H2KMIzohPEfpcbnoGbmBFcaQomWmGUzB/1Jv7
	 ASRD0YQACJyGg==
Date: Tue, 7 Oct 2025 16:08:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Drivers: hv: Use better errno matches for HV_STATUS
 values
Message-ID: <20251007160835.GA2225925@liuwe-devbox-debian-v2.local>
References: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006230821.275642-1-easwar.hariharan@linux.microsoft.com>

On Mon, Oct 06, 2025 at 11:08:08PM +0000, Easwar Hariharan wrote:
> Use a better mapping of hypervisor status codes to errno values and
> disambiguate the catch-all -EIO value. While here, remove the duplicate
> INVALID_LP_INDEX and INVALID_REGISTER_VALUES hypervisor status entries.
> 
> Fixes: 3817854ba89201 ("hyperv: Log hypercall status codes as strings")
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

The idea looks fine. I will defer to Nuno.

Wei

