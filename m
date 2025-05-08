Return-Path: <linux-hyperv+bounces-5423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928CAAF083
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D294E78D0
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 May 2025 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FF3156C62;
	Thu,  8 May 2025 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvZz6x8d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA428691;
	Thu,  8 May 2025 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666655; cv=none; b=gkvuTrOKJUka24xRrYCiR+IfkRZ962B1u5fpY2OnAivDt7VrU3D4vk5U/yo6h6aH8f/HTqH1mS4FMbnaPzt98iOjglE91IH6QSCCYDk86txdiVVuX/irYo/NSEw+uvqrHPRyMnsuu5notcAiwdeveH5w8/YcZmA8UcI7r2uA/C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666655; c=relaxed/simple;
	bh=rW806LRvAv6zTtRdjNADUbkgohR7OFciphCyjLtrKkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1/49xHO/c54c104a+YZ1jpSeRy9R9ZX2JKGghOZpjfj90e/xDzZnMVxckWbQC4Pko/DPy8CB8VEjxAaovUWEsddE+QSy2fHGoadGOxO4cweMIyQ92A0WTGNkGBIrw4TYqn8+3UCu1rKgjWK2tT67aLhQO+czS8W6BL+sTdym+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvZz6x8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8066C4CEE2;
	Thu,  8 May 2025 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746666654;
	bh=rW806LRvAv6zTtRdjNADUbkgohR7OFciphCyjLtrKkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvZz6x8d+zNQDrR5i0Y4UkDJAnKEA+BKsSmXjLj1/eKbmTK8DzZfiAHBdDf2+ZKUS
	 wYuRjN/Kn9hywA6BdFaZZdH5dxf1XUfTzVXcrDfhZyz4cLmVybETnOeGgQMrglTm8Z
	 pVg2Ug4Stf8JL54DYWVUfmwgdAGdTzQLzTCBnpffeYn2MGnOlNlE50QlP/kj0j1G30
	 R2Dn5+6sx+LRsywPS27F7dHQQFc7yG8NoT/33UFgFrlPdcm8+aG8dR1jhnqa4CcxYy
	 vT+sgwvKabbXVK52ucAwbXgDC1uPc6WCrVAcShKvjeIzgbZMn3+/dC6wx4PRroCymy
	 fKq/CG9wZ8Xrw==
Date: Thu, 8 May 2025 01:10:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Roman Kisel <romank@linux.microsoft.com>, ardb@kernel.org, bp@alien8.de,
	brgerst@gmail.com, dave.hansen@linux.intel.com, decui@microsoft.com,
	dimitri.sivanich@hpe.com, gautham.shenoy@amd.com,
	haiyangz@microsoft.com, hpa@zytor.com, imran.f.khan@oracle.com,
	jacob.jun.pan@linux.intel.com, jpoimboe@kernel.org,
	justin.ernst@hpe.com, kprateek.nayak@amd.com, kyle.meyer@hpe.com,
	kys@microsoft.com, lenb@kernel.org, mhklinux@outlook.com,
	mingo@redhat.com, nikunj@amd.com, papaluri@amd.com,
	patryk.wlazlyn@linux.intel.com, peterz@infradead.org,
	russ.anderson@hpe.com, sohil.mehta@intel.com, steve.wahl@hpe.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, tiala@microsoft.com,
	wei.liu@kernel.org, yuehaibing@huawei.com,
	linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next 2/2] arch/x86: Provide the CPU number in the
 wakeup AP callback
Message-ID: <aBwEnI9BRJHGzlzG@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250507182227.7421-1-romank@linux.microsoft.com>
 <20250507182227.7421-3-romank@linux.microsoft.com>
 <CAJZ5v0jXJtVgEPg7+3-YRkntLzk0kVPkXxKkL_kQpDU_RSsZtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jXJtVgEPg7+3-YRkntLzk0kVPkXxKkL_kQpDU_RSsZtg@mail.gmail.com>

On Wed, May 07, 2025 at 10:09:46PM +0200, Rafael J. Wysocki wrote:
> On Wed, May 7, 2025 at 8:22 PM Roman Kisel <romank@linux.microsoft.com> wrote:
> >
> > When starting APs, confidential guests and paravisor guests
> > need to know the CPU number, and the pattern of using the linear
> > search has emerged in several places. With N processors that leads
> > to the O(N^2) time complexity.
> >
> > Provide the CPU number in the AP wake up callback so that one can
> > get the CPU number in constant time.
> >
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> For the ACPI bits
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and I'm assuming that the x86 folks will take care of this.
> 

Thank you Rafael. I will take this patch via the hyperv-next tree.

