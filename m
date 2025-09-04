Return-Path: <linux-hyperv+bounces-6738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B001B44A3F
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 01:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374211C83660
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 23:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272222EE262;
	Thu,  4 Sep 2025 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqQpLC5g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA162EDD74;
	Thu,  4 Sep 2025 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027402; cv=none; b=FOtcUrqAk3y0xOZ274oLWyKv8zASWhihX5hCiVvn18kJtuhYLMle5bUN4QYXQxn5oiWpwcg8x39eH9buX/60WDEYtt8ByPojz1TLU+Zqi05rh2vc8C2ZoMYy/ZxR74wS1cVbmuthJYyz4sARo02bMf02JHx5yVb1h7tGK347e6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027402; c=relaxed/simple;
	bh=nRXYhdvV9X7pGCfmYVRPVRuRkgA/vzwdfCJZ+7uzFf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTiv1Fz+sWp1ZqiBVVEaX8lnDj7IKzKi+norcUjAjsWETCS+z/zuXbFyCNbugkG+iK5EyTKHL73g6V/Wpvqy1FsyWp3/OBMnHLdP+KGx5omDkCxENxFlpj++JTsoznq10HxUK8lGwos4O4YQdN/X2aP0YnEdvlSGY1vPE+spSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqQpLC5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAB2C4CEF0;
	Thu,  4 Sep 2025 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757027401;
	bh=nRXYhdvV9X7pGCfmYVRPVRuRkgA/vzwdfCJZ+7uzFf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqQpLC5g7kZmmh+ivfeE38jsBcwOxfj89VuT6yEawWyET7Mbd6IOrre1Zm2CA3paW
	 Qbzn3hOZxzUL1Hh9eQNE4icUm7UmjEIIgoEH8+V//UB+oTg7E58Rr8OXO2UrYBlWag
	 RZ1zAiROpjsdHXvycYOCaH+Ycmq7WnclPPLqC+HWZoOKIVM5qq+z9gw4p/JYlXHkuS
	 4ZD3V2ZfBF+vAdxOwB++R54R/EOM16AmzKqRY+r5e1efCiFtVqUYBMdR/D0E0iyNif
	 /YLGFnqxKyrF0BDJHOIwM/dGZS6bVAHuxGFSFhppdX/QUoVZKuHNr2smUmK5pBWTyk
	 L1rYeWwqmxcXQ==
Date: Thu, 4 Sep 2025 23:10:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
Cc: abhitiwari@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com
Subject: Re: [PATCH v2] Drivers: hv: util: Cosmetic changes for
 hv_utils_transport.c
Message-ID: <aLocSEnPCCiNLaTj@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1756728000-8324-1-git-send-email-abhitiwari@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756728000-8324-1-git-send-email-abhitiwari@linux.microsoft.com>

On Mon, Sep 01, 2025 at 05:00:00AM -0700, Abhishek Tiwari wrote:
> Fix issues reported by checkpatch.pl script for hv_utils_transport.c file 
> - Update pr_warn() calls to use __func__ for consistent logging context. 
> - else should follow close brace '}'
> 
> No functional changes intended.
> 
> Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Applied. Thanks.

