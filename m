Return-Path: <linux-hyperv+bounces-4010-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15321A3FFE8
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 20:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 366AA7AA448
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2025 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168924CEC2;
	Fri, 21 Feb 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V04PmmMF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE41EEA56;
	Fri, 21 Feb 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166970; cv=none; b=owQh4nZZoa7M4C/CCbKlywq7RFBAMQsjJioU7m13ESmekZ5c9PC3pKtl7P8/uz+3A2W3Ax2Wvc22QO/to+HLS6b4SthnJ1ouXJBKR6GWDsy+xEFH3WaUFuGgp6WaxnsxifcEHUy6xodKAf5aZhDxsRpo3Lukw6k8U0eeXpJtXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166970; c=relaxed/simple;
	bh=ZeQGnJLvyrbHbH2ocXNckvodnnnudML9glKdmDIZcpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnzfSwmluqqb8GHRpWw/lo6Vd+gvcffPuYW4zS7XbEeIbr/Bprkqe28jfLAzhtpJD47eVXVJ5VIX8VoIqWn6PL0MqGtits8pK6lY3bKgFWhiBeeuj9P1+r6+yf2npXTT3ORTdgz9OjVl/HU1pZdlGXnc3F6qSlMg5U6meonPKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V04PmmMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB982C4CED6;
	Fri, 21 Feb 2025 19:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740166970;
	bh=ZeQGnJLvyrbHbH2ocXNckvodnnnudML9glKdmDIZcpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V04PmmMFgYA3GS2c9yxHaereWrp98xgYK3/dJTc5pWh+CwFcbABn7ulhN1a/Eg8jA
	 T0J8SCo9+TnBgrtsaP2jPzUVr11VeuX+j8UVtJbyXj2U/AnuAX/N7sNrHiUAvG/2qs
	 id7y1eNwbyPQPyfq4Or2zVgAwYa0xlsZKCZPz1VeyQ0BxgqCvwMsU/juoM6IOPK2zX
	 RYwiccI+f95ZpwutMjh7IathJ/9V7HMGS4kFeyycosqmrkMeWsKwzjqlmyrgvQ6dx2
	 DLVNiGSU775zNoHhCvfo5CZMYIKPsSvmpYYpNWPjM92WnD7ESjdfMa6v+5aauZyLTA
	 LKOsqzR5lqU6A==
Date: Fri, 21 Feb 2025 19:42:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Correct a comment
Message-ID: <Z7jXOJgySICFXbVD@liuwe-devbox-debian-v2>
References: <20250207190716.89995-1-eahariha@linux.microsoft.com>
 <Z6wGdTXExwcTh051@liuwe-devbox-debian-v2>
 <20250220150957.GE1777078@rocinante>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220150957.GE1777078@rocinante>

On Fri, Feb 21, 2025 at 12:09:57AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > > The VF driver controls an endpoint attached to the pci-hyperv
> > > controller. An invalidation sent by the PF driver in the host would be
> > > delivered *to* the endpoint driver by the controller driver.
> > > 
> > > Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> > 
> > Applied. Thanks.
> 
> Would you mind if I take this via the PCI tree?

No problem. I can drop that from my tree.

Thanks,
Wei.

> 
> Thank you!
> 
> 	Krzysztof

