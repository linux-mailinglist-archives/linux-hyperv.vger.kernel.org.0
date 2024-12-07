Return-Path: <linux-hyperv+bounces-3421-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F073E9E7ECC
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D657016C040
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BCB77F10;
	Sat,  7 Dec 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqZ0E/Cn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3822C6E3;
	Sat,  7 Dec 2024 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558013; cv=none; b=gfWHcXYcUaL4WpT6YODa4/+MVzq+5YInab2Sv3WOSYMSo2t+c2gGl3BqxB5rOdEarMFKq8Nd0LZdQGURa2+h4Rp4HWnBrmtvkc7w3Uf7HQxw2X94qQOZR/36FJV2JpZIRTPsQWGZ9zOvexWKcCq0eLmMsGdGGe0j077q9D4usjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558013; c=relaxed/simple;
	bh=R6+zg5qAKGaruhP4bU4MWtnLyw78DU97+vSSDL0up1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMURNnRFhYF93vfGVZRqLOy59kVMF6SRGS3by1iSnxcKAmucbelLSwakMuRoDQZPVRwB4sFAn3in2/wiSH6xyEUmnvKQiD+jCQVkNlLpwvJImodrAjqDS4TaTeYFUApqWML8OBTGtceXEohZYvfR/Hd+WA3CfDAAi7/qmTUjvkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqZ0E/Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691FBC4CECD;
	Sat,  7 Dec 2024 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733558013;
	bh=R6+zg5qAKGaruhP4bU4MWtnLyw78DU97+vSSDL0up1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqZ0E/Cnd6PQY19r1pQjMHDaNQw2nqENPPJ2mH+lQD7rNXXnfORc49mtzTezSahlB
	 jirGqI0ESf1xM/amCsKQCtSOO4OoDFIMT+JVbinxfcBEJVCjvV497VZkSJf/DKT0Z8
	 3GOK//CbyYCsO2atz0d+p+xm+TxP1hnR7Ijj0SBJK7f+yZ/uMYF4jC0m+wpd2bTS6Q
	 tg5rRNsGKoP4SdUw7cd6ggWvns2tezyu6fJFe/Cci1zsLfz7bR4Kb6n4Q0TX5y7ALs
	 VIig0kvouIM78XICtsZSIaPQyA47Q3y5DuXnGydefz1En3XrjrMZ5SfgVmjnz9+xsL
	 ZZm7EXV4/hnSA==
Date: Sat, 7 Dec 2024 07:53:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>,
	g@liuwe-devbox-debian-v2.smtp.subspace.kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] tools/hv: terminate fcopy daemon if read from uio
 fails
Message-ID: <Z1P-_H6PuXopLmnr@liuwe-devbox-debian-v2>
References: <20241105081437.15689-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105081437.15689-1-olaf@aepfle.de>

On Tue, Nov 05, 2024 at 09:14:04AM +0100, Olaf Hering wrote:
> Terminate endless loop in reading fails, to avoid flooding syslog.
> 
> This happens if the state of "Guest services" integration service
> is changed from "enabled" to "disabled" at runtime in the VM
> settings. In this case pread returns EIO.
> 
> Also handle an interrupted system call, and continue in this case.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Applied to hyperv-fixes. Thanks.

