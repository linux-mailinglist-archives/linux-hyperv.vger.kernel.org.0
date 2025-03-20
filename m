Return-Path: <linux-hyperv+bounces-4656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C122EA6AFFD
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F82173859
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 21:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769E1EC01E;
	Thu, 20 Mar 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUAgt+gt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF32AE6A;
	Thu, 20 Mar 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506719; cv=none; b=t7Ht1GMCk44g9JQ1DCd6I/YuuAop4s6e9nkDyHqAca4U7O+l4S/jUC22+836OtesBFc+VnBILTcF0tMfL6rmbcaHlloOXlFaQ4jdhCAcyubmIFHKX1Q2DcsFHBBUMRdHJ18AY26SZmYEy3SChpB1ANrY1jEf3Oca2EjvkfNr1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506719; c=relaxed/simple;
	bh=cz3gi+SRF276xSiDrq/mSPKMDz6ayn8/HESiEH/4Df0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSnITQxUFQ+fB+OrwaxTpGj4MUrMd+XGIZtupgfS39O7+at1UiWyK4dXBCPb/kWtIjiObRLcxbfxWAr+n6vHhdCXVxA7/o9vMsN9+kmSc96oHUpyyVPsa8SUhtVN/tcjLqA9dlNPo0UvzbFOhsLsbuV6ZH4cFhkUAtWMKQdcb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUAgt+gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E316C4CEDD;
	Thu, 20 Mar 2025 21:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506719;
	bh=cz3gi+SRF276xSiDrq/mSPKMDz6ayn8/HESiEH/4Df0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUAgt+gtsfQV2xd8bTPvGHkdgPBfxlRH5v6rKeY+8WuF0YgPquQVnY5U3G0s+dNID
	 cmqWQgJIIi/ZFD0GFCbxkLW5QotYa+34IZmnOI0hHesG12XcT/PsLkK2fL5rc5ZVMX
	 cwPGwjP4geZANM1C4E0XkEqyocxG+Nlcw2a0JN45ogs3iJsmwZCPZF3lcmEMyG08d9
	 T7Ym3mz/cBdGnTTBLVmttX67YmwhV1Zf3ujtUTgC08SVfIebmhWn2W312VTWRkQ+Jp
	 LC8ckTnE0Y2CtnIGiPOynLjzTmwJXkaRfyuGyo/ubW7kAkzjQt1TDEEnfOR1D/ELqD
	 MBDWzVZZtx6OA==
Date: Thu, 20 Mar 2025 21:38:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: Re: [PATCH] fixup! Drivers: hv: Introduce mshv_root module to expose
 /dev/mshv to VMMs
Message-ID: <Z9yK3R26oNIH5Kox@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1742492693-21960-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742492693-21960-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Mar 20, 2025 at 10:44:53AM -0700, Nuno Das Neves wrote:
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Thanks. I squashed this patch into the one that introduced the driver.

