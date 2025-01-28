Return-Path: <linux-hyperv+bounces-3777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D930DA20379
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 05:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFF27A295A
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 04:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E11422AB;
	Tue, 28 Jan 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4A/l86n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8099647;
	Tue, 28 Jan 2025 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738037407; cv=none; b=ZIQIwK/FS05pshW7vj2Cw0CZstqLSpbOT0tu2+vZIn8XFfdvuDpPNngXUjykd08pdav5Wi6kzrXvWvkc+i5kveHykzHf2UKvuYMKb2HpSN8r1hIrVXyF09h6KRNeTnsFeRvZzsbAT0hvqFqIsKXSsLejwm3wrBJCqTbvgD2JApw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738037407; c=relaxed/simple;
	bh=4vJKSte/E5+nOIbz8Jn8FXcwozA4oPxW0Er5Wobgohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmrhim1tyWZWE7a64N+cWSGOH70ya4fxixPrkZRQpt2ilVQeIxFXtyN2KR3rhHogOvhZVZQ5psRvS3gdD2IHbN/CVn4XLgW+tOL0nSnHtpHY93dgduZs3vcjpR3I+KEQOaFxnI5cu4E3RYhHNwGmkD7i7QzmZAkJ+D6BAnzaSX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4A/l86n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E412EC4CED3;
	Tue, 28 Jan 2025 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738037407;
	bh=4vJKSte/E5+nOIbz8Jn8FXcwozA4oPxW0Er5Wobgohc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4A/l86nU/TDFlrPpYEY8ttM+LM9DSbxQxMALQ0fessvtzAYjm7Tf8/9JHYXNYjFW
	 50BoIO+UeYcZEJKW0AkT95ROWPgZ+kXV5bCEEpQQGBhQOTGwpqWUorgbbkT5f9Cacj
	 msGkxZSLHigEaeP60oWuDWd1+E28FauUPOFxksS9NNstNDSnK4kCPlVHQ2Xe4Jor+S
	 oKthERCtlgaK0vMHbvruTk3IrBMSsg24hj/CuDNIjCZ9Lz6WTqxjTyk6/tSrQCfs2h
	 Hpq8ts6KvvIjGoywLSzFdgx+JZ0RwuoXUW3wEU0DMw89+ZmZpB6NqCYoVDXIjmk1Ev
	 v0Ryzni/ot1PQ==
Date: Tue, 28 Jan 2025 04:10:05 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Message-ID: <Z5hYnSW-3iKZxn0T@liuwe-devbox-debian-v2>
References: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157BAAEB938E7E4E849DC7CD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z5f94J7rzSC-TyIB@hm-sls2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5f94J7rzSC-TyIB@hm-sls2>

On Mon, Jan 27, 2025 at 04:42:56PM -0500, Hamza Mahfooz wrote:
> On Mon, Jan 27, 2025 at 09:02:22PM +0000, Michael Kelley wrote:
> > From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, January 27, 2025 10:10 AM
> > > 
> > > We should select PCI_HYPERV here, otherwise it's possible for devices to
> > > not show up as expected, at least not in an orderly manner.
> > 
> > The commit message needs more precision:  What does "not show up"
> > mean, and what does "not in an orderly manner" mean?  And "it's possible"
> > is vague -- can you be more specific about the conditions?  Also, avoid
> > the use of personal pronouns like "we".
> > 
> > But the commit message notwithstanding, I don't think this is change
> > that should be made. CONFIG_PCI_HYPERV refers to the VMBus device
> > driver for handling vPCI (a.k.a PCI pass-thru) devices. It's perfectly
> > possible and normal for a VM on Hyper-V to not have any such devices,
> > in which case the driver isn't needed and should not be forced to be
> > included. (See Documentation/virt/hyperv/vpci.rst for more on vPCI
> > devices.)
> 
> Ya, we ran into an issue where CONFIG_NVME_CORE=y and
> CONFIG_PCI_HYPERV=m caused the passed-through SSDs not to show up (i.e.
> they aren't visible to userspace). I guess it's cause PCI_HYPERV has
> to load in before the nvme stuff for that workload. So, I thought it was
> reasonable to select PCI_HYPERV here to prevent someone else from
> shooting themselves in the foot. Though, I guess it really it on the
> distro guys to get that right.

Does inserting the PCI_HYPERV module trigger a (re)scanning of the
(v)PCI bus? If so, the passed-through NVMe devices should show up just
fine, I suppose.

I agree with Michael that we should not select PCI_HYPERV by default. In
some environments, it is not needed at all.

Thanks,
Wei.

